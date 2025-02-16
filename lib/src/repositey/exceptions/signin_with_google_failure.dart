class SignInWithGoogleFailure {
  final String message;

  const SignInWithGoogleFailure([this.message = "An unknown error occurred"]);

  factory SignInWithGoogleFailure.code(String code) {
    switch (code) {
      case 'account-exists-with-different-credential':
        return const SignInWithGoogleFailure(
          'An account already exists with a different credential. Please sign in using the correct provider.',
        );
      case 'invalid-credential':
        return const SignInWithGoogleFailure(
          'The provided credential is malformed or has expired. Try again.',
        );
      case 'operation-not-allowed':
        return const SignInWithGoogleFailure(
          'Google sign-in is not enabled for this project. Enable it in the Firebase console.',
        );
      case 'user-disabled':
        return const SignInWithGoogleFailure(
          'This user account has been disabled. Please contact support.',
        );
      case 'user-not-found':
        return const SignInWithGoogleFailure(
          'No user found for the given credentials. Try signing up first.',
        );
      case 'wrong-password':
        return const SignInWithGoogleFailure(
          'Incorrect password entered. Try again or reset your password.',
        );
      case 'invalid-verification-code':
        return const SignInWithGoogleFailure(
          'Invalid verification code entered. Please check and try again.',
        );
      case 'invalid-verification-id':
        return const SignInWithGoogleFailure(
          'Invalid verification ID. Please try again with the correct details.',
        );
      case 'network-request-failed':
        return const SignInWithGoogleFailure(
          'A network error occurred. Please check your internet connection and try again.',
        );
      case 'sign_in_canceled':
        return const SignInWithGoogleFailure(
          'Sign-in process was canceled by the user.',
        );
      case 'popup-closed-by-user':
        return const SignInWithGoogleFailure(
          'The sign-in popup was closed before completion. Try again.',
        );
      case 'quota-exceeded':
        return const SignInWithGoogleFailure(
          'Quota exceeded for Google sign-in requests. Try again later.',
        );
      case 'too-many-requests':
        return const SignInWithGoogleFailure(
          'Too many sign-in attempts. Please try again later.',
        );
      default:
        return const SignInWithGoogleFailure();
    }
  }
}