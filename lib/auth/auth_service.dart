import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ---------------- CREATE ACCOUNT ----------------
  Future<User?> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      log("User created: ${cred.user?.email}");
      return cred.user;
    } on FirebaseAuthException catch (e) {
      log("FirebaseAuth Error: ${e.message}");
      return null;
    } catch (e) {
      log("Unexpected Error: $e");
      return null;
    }
  }

  // ---------------- LOGIN ----------------
  Future<User?> loginUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      log("User logged in: ${cred.user?.email}");
      return cred.user;
    } on FirebaseAuthException catch (e) {
      log("FirebaseAuth Error: ${e.message}");
      return null;
    } catch (e) {
      log("Unexpected Error: $e");
      return null;
    }
  }

  // ---------------- LOGOUT ----------------
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      log("User signed out successfully");
    } catch (e) {
      log("Error signing out: $e");
    }
  }

  // ---------------- CHANGE PASSWORD (requires current password) ----------------
  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final user = _auth.currentUser;
      if (user == null || user.email == null) {
        log("No user is currently logged in");
        return false;
      }

      // Re-authenticate before changing password
      AuthCredential credential = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );

      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword);
      log("Password updated successfully in Firebase Auth ✅");
      return true;
    } on FirebaseAuthException catch (e) {
      log("FirebaseAuth Error (changePassword): ${e.message}");
      return false;
    } catch (e) {
      log("Unexpected Error (changePassword): $e");
      return false;
    }
  }

  // ---------------- RESET PASSWORD BY EMAIL ----------------
  Future<bool> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      log("Password reset email sent to $email");
      return true;
    } on FirebaseAuthException catch (e) {
      log("FirebaseAuth Error (sendPasswordResetEmail): ${e.message}");
      return false;
    } catch (e) {
      log("Unexpected Error (sendPasswordResetEmail): $e");
      return false;
    }
  }

  // ---------------- RESET PASSWORD DIRECTLY (no current password needed) ----------------
  Future<bool> resetPasswordWithoutCurrent({
    required String email,
    required String newPassword,
  }) async {
    try {
      // First, sign in the user anonymously or send a temporary OTP verification
      // For now, we assume the user is verified via OTP
      // So we can fetch the user by email
      final user = _auth.currentUser;

      if (user != null && user.email == email) {
        // If the user is logged in (rare case after OTP), update directly
        await user.updatePassword(newPassword);
        log("Password updated successfully for $email ✅");
        return true;
      } else {
        // If not logged in, we can only send reset email (Firebase restriction)
        await _auth.sendPasswordResetEmail(email: email);
        log("Password reset email sent to $email");
        return true;
      }
    } catch (e) {
      log("Reset Password Error: $e");
      return false;
    }
  }
}
