// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Target App';

  @override
  String get loginTitle => 'Login';

  @override
  String get username => 'Usuário';

  @override
  String get password => 'Senha';

  @override
  String get login => 'Entrar';

  @override
  String get developmentFeature => 'Funcionalidade em desenvolvimento';

  @override
  String get testCredentials => 'Para testar, use:';

  @override
  String get logout => 'Sair';

  @override
  String get lightMode => 'Modo Claro';

  @override
  String get darkMode => 'Modo Escuro';

  @override
  String get loginSuccess => 'Login realizado com sucesso!';

  @override
  String get welcomeMessage => 'Bem-vindo ao aplicativo';

  @override
  String invalidUsername(int min) {
    return 'Usuário deve ter no mínimo $min caracteres';
  }

  @override
  String invalidPassword(int min) {
    return 'Senha deve ter no mínimo $min caracteres';
  }

  @override
  String get fillFieldsCorrectly =>
      'Por favor, preencha os campos corretamente';

  @override
  String get logoutError => 'Erro ao fazer logout';

  @override
  String get invalidCredentials => 'Usuário ou senha inválidos';

  @override
  String get register => 'Cadastro';

  @override
  String get name => 'Nome';

  @override
  String get confirmPassword => 'Confirmar Senha';

  @override
  String get createAccount => 'Criar Conta';

  @override
  String get alreadyHaveAccount => 'Já tem uma conta?';

  @override
  String get dontHaveAccount => 'Não tem uma conta?';

  @override
  String get registerNow => 'Cadastre-se';

  @override
  String invalidName(int min) {
    return 'Nome deve ter no mínimo $min caracteres';
  }

  @override
  String get passwordsDoNotMatch => 'As senhas não coincidem';

  @override
  String get registerSuccess => 'Cadastro realizado com sucesso!';

  @override
  String get userAlreadyExists => 'Usuário já existe';

  @override
  String get storageError => 'Erro ao acessar armazenamento';

  @override
  String get unknownError => 'Erro desconhecido. Tente novamente';

  @override
  String get weakPassword =>
      'Senha fraca. Use maiúsculas, minúsculas, números e caracteres especiais';

  @override
  String get strongPassword => 'Senha forte';

  @override
  String get passwordStrength => 'Força da senha';

  @override
  String get passwordRequirements => 'Requisitos da senha:';

  @override
  String get requirementUppercase => 'Pelo menos uma letra maiúscula';

  @override
  String get requirementLowercase => 'Pelo menos uma letra minúscula';

  @override
  String get requirementNumber => 'Pelo menos um número';

  @override
  String get requirementSpecialChar =>
      'Pelo menos um caractere especial (!@#\$%^&*)';

  @override
  String requirementMinLength(int min) {
    return 'Mínimo de $min caracteres';
  }

  @override
  String get noItemsYet =>
      'Nenhum item ainda. \nAdicione novos itens para aparecer aqui!';

  @override
  String get newItem => 'Novo item';

  @override
  String get add => 'Adicionar';

  @override
  String get removeItem => 'Remover item';

  @override
  String removeItemConfirmation(String itemName) {
    return 'Deseja remover \"$itemName\"?';
  }

  @override
  String get cancel => 'Cancelar';

  @override
  String get remove => 'Remover';

  @override
  String get itemNameEmpty => 'O nome do item não pode estar vazio';

  @override
  String get edit => 'Editar';

  @override
  String get delete => 'Excluir';

  @override
  String get editItem => 'Editar item';

  @override
  String get itemName => 'Nome do item';

  @override
  String get itemDescription => 'Descrição';

  @override
  String get selectIcon => 'Selecionar ícone';

  @override
  String get save => 'Guardar';
}

/// The translations for Portuguese, as used in Brazil (`pt_BR`).
class AppLocalizationsPtBr extends AppLocalizationsPt {
  AppLocalizationsPtBr() : super('pt_BR');

  @override
  String get appTitle => 'Target App';

  @override
  String get loginTitle => 'Login';

  @override
  String get username => 'Usuário';

  @override
  String get password => 'Senha';

  @override
  String get login => 'Entrar';

  @override
  String get developmentFeature => 'Funcionalidade em desenvolvimento';

  @override
  String get testCredentials => 'Para testar, use:';

  @override
  String get logout => 'Sair';

  @override
  String get lightMode => 'Modo Claro';

  @override
  String get darkMode => 'Modo Escuro';

  @override
  String get loginSuccess => 'Login realizado com sucesso!';

  @override
  String get welcomeMessage => 'Bem-vindo ao aplicativo';

  @override
  String invalidUsername(int min) {
    return 'Usuário deve ter no mínimo $min caracteres';
  }

  @override
  String invalidPassword(int min) {
    return 'Senha deve ter no mínimo $min caracteres';
  }

  @override
  String get fillFieldsCorrectly =>
      'Por favor, preencha os campos corretamente';

  @override
  String get logoutError => 'Erro ao fazer logout';

  @override
  String get invalidCredentials => 'Usuário ou senha inválidos';

  @override
  String get register => 'Cadastro';

  @override
  String get name => 'Nome';

  @override
  String get confirmPassword => 'Confirmar Senha';

  @override
  String get createAccount => 'Criar Conta';

  @override
  String get alreadyHaveAccount => 'Já tem uma conta?';

  @override
  String get dontHaveAccount => 'Não tem uma conta?';

  @override
  String get registerNow => 'Cadastre-se';

  @override
  String invalidName(int min) {
    return 'Nome deve ter no mínimo $min caracteres';
  }

  @override
  String get passwordsDoNotMatch => 'As senhas não coincidem';

  @override
  String get registerSuccess => 'Cadastro realizado com sucesso!';

  @override
  String get userAlreadyExists => 'Usuário já existe';

  @override
  String get storageError => 'Erro ao acessar armazenamento';

  @override
  String get unknownError => 'Erro desconhecido. Tente novamente';

  @override
  String get weakPassword =>
      'Senha fraca. Use maiúsculas, minúsculas, números e caracteres especiais';

  @override
  String get strongPassword => 'Senha forte';

  @override
  String get passwordStrength => 'Força da senha';

  @override
  String get passwordRequirements => 'Requisitos da senha:';

  @override
  String get requirementUppercase => 'Pelo menos uma letra maiúscula';

  @override
  String get requirementLowercase => 'Pelo menos uma letra minúscula';

  @override
  String get requirementNumber => 'Pelo menos um número';

  @override
  String get requirementSpecialChar =>
      'Pelo menos um caractere especial (!@#\$%^&*)';

  @override
  String requirementMinLength(int min) {
    return 'Mínimo de $min caracteres';
  }

  @override
  String get noItemsYet =>
      'Nenhum item ainda. \nAdicione novos itens para aparecer aqui!';

  @override
  String get newItem => 'Novo item';

  @override
  String get add => 'Adicionar';

  @override
  String get removeItem => 'Remover item';

  @override
  String removeItemConfirmation(String itemName) {
    return 'Deseja remover \"$itemName\"?';
  }

  @override
  String get cancel => 'Cancelar';

  @override
  String get remove => 'Remover';

  @override
  String get itemNameEmpty => 'O nome do item não pode estar vazio';

  @override
  String get edit => 'Editar';

  @override
  String get delete => 'Excluir';

  @override
  String get editItem => 'Editar item';

  @override
  String get itemName => 'Nome do item';

  @override
  String get itemDescription => 'Descrição';

  @override
  String get selectIcon => 'Selecionar ícone';

  @override
  String get save => 'Salvar';
}
