import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:target_app/l10n/app_localizations.dart';
import '../../../core/stores/theme/theme_store.dart';
import '../../../core/widgets/tab_selector.dart';
import '../../../core/widgets/language_selector.dart';
import '../../../core/stores/translate/locale_store.dart';
import '../../../core/utils/constants.dart';
import '../viewmodels/login_viewmodel.dart';
import '../widgets/login_form.dart';
import '../widgets/register_form.dart';
import '../widgets/error_message.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late final LoginViewModel _viewModel;
  late final LocaleStore _localeStore;
  late final AnimationController _animationController;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;
  final _formKey = GlobalKey<FormState>();
  bool _isLoginMode = true;

  @override
  void initState() {
    super.initState();
    _viewModel = Modular.get<LoginViewModel>();
    _localeStore = Modular.get<LocaleStore>();

    final themeStore = Modular.get<ThemeStore>();
    themeStore.resetToDefault();
    _localeStore.resetToDefault();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: const Interval(0.2, 1.0, curve: Curves.easeOutCubic),
          ),
        );

    _animationController.forward();
  }

  void _toggleMode() {
    setState(() {
      _isLoginMode = !_isLoginMode;
      _viewModel.reset();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(actions: [LanguageSelector(localeStore: _localeStore)]),
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Image.asset(
                        AppConstants.logoPath,
                        height: 120,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 48),

                    TabSelector(
                      leftLabel: l10n.loginTitle,
                      rightLabel: l10n.register,
                      isLeftSelected: _isLoginMode,
                      onLeftTap: _toggleMode,
                      onRightTap: _toggleMode,
                    ),
                    const SizedBox(height: 32),

                    ErrorMessage(viewModel: _viewModel),

                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                            final offsetAnimation =
                                Tween<Offset>(
                                  begin: const Offset(0.3, 0),
                                  end: Offset.zero,
                                ).animate(
                                  CurvedAnimation(
                                    parent: animation,
                                    curve: Curves.easeInOut,
                                  ),
                                );

                            return SlideTransition(
                              position: offsetAnimation,
                              child: FadeTransition(
                                opacity: animation,
                                child: child,
                              ),
                            );
                          },
                      child: _isLoginMode
                          ? LoginForm(
                              viewModel: _viewModel,
                              onSubmit: _handleLogin,
                            )
                          : RegisterForm(
                              viewModel: _viewModel,
                              onSubmit: _handleRegister,
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleLogin() async {
    final success = await _viewModel.login();
    if (success && mounted) {
      Modular.to.navigate('/home/');
    }
  }

  Future<void> _handleRegister() async {
    final success = await _viewModel.register();
    if (success && mounted) {
      Modular.to.navigate('/home/');
    }
  }
}
