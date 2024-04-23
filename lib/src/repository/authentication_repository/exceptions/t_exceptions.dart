class TExceptions implements Exception {

  final String message;


  const TExceptions([this.message = 'Ошибка, попробуйте снова']);


  factory TExceptions.fromCode(String code) {
    switch (code) {
      case 'email-already-in-use':
        return const TExceptions('Электронная почта уже существует');
      case 'invalid-email':
        return const TExceptions('Электронная почта недействительна или неправильно отформатирована.');
      case 'weak-password':
        return const TExceptions('Пожалуйста, введите более надежный пароль.');
      case 'user-disabled':
        return const TExceptions('Этот пользователь отключен. Обратитесь в службу поддержки за помощью.');
      case 'user-not-found':
        return const TExceptions('Неверные данные, пожалуйста, создайте учетную запись.');
      case 'wrong-password':
        return const TExceptions('Неверный пароль, пожалуйста, попробуйте еще раз.');
      case 'too-many-requests':
        return const TExceptions('Слишком много запросов, служба временно заблокирована.');
      case 'invalid-argument':
        return const TExceptions('Недопустимый аргумент был предоставлен методу аутентификации.');
      case 'invalid-password':
        return const TExceptions('Неверный пароль, пожалуйста, попробуйте еще раз.');
      case 'invalid-phone-number':
        return const TExceptions('Предоставленный номер телефона недействителен.');
      case 'operation-not-allowed':
        return const TExceptions(
            'Предоставленный поставщик входа отключен для вашего проекта Firebase.');
      case 'session-cookie-expired':
        return const TExceptions('Предоставленная сессионная кука Firebase истекла.');
      case 'uid-already-exists':
        return const TExceptions('Предоставленный UID уже используется существующим пользователем.');
      default:
        return const TExceptions();
    }
  }
}
