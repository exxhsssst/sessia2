
class SignUpWithEmailAndPasswordFailure implements Exception{
  final String message;

  const SignUpWithEmailAndPasswordFailure([this.message = "An Unknown error occurred."]);

  factory SignUpWithEmailAndPasswordFailure.code(String code){
    switch(code){
      case 'weak-password':
        return const SignUpWithEmailAndPasswordFailure('Пожалуйста, введите более надежный пароль.');
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure('Электронная почта недействительна или неправильно отформатирована.');
      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailure('Учетная запись уже существует для этой электронной почты.');
      case 'user-disabled':
        return const SignUpWithEmailAndPasswordFailure('Этот пользователь отключен. Обратитесь в службу поддержки за помощью.');
      case 'too-many-requests':
        return const SignUpWithEmailAndPasswordFailure('Слишком много запросов, служба временно заблокирована.');
      case 'invalid-argument':
        return const SignUpWithEmailAndPasswordFailure('Недопустимый аргумент был предоставлен методу аутентификации.');
      case 'invalid-password':
        return const SignUpWithEmailAndPasswordFailure('Неверный пароль, пожалуйста, попробуйте еще раз.');
      case 'invalid-phone-number':
        return const SignUpWithEmailAndPasswordFailure('Предоставленный номер телефона недействителен.');
      case 'operation-not-allowed':
        return const SignUpWithEmailAndPasswordFailure('Предоставленный поставщик входа отключен для вашего проекта Firebase.');
      case 'session-cookie-expired':
        return const SignUpWithEmailAndPasswordFailure('Предоставленная сессионная кука Firebase истекла.');
      case 'uid-already-exists':
        return const SignUpWithEmailAndPasswordFailure('Предоставленный UID уже используется существующим пользователем.');
      default:
        return const SignUpWithEmailAndPasswordFailure();

    }
  }
}
