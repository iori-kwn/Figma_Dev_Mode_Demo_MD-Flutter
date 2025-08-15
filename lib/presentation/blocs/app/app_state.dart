part of 'app_bloc.dart';

class AppState extends Equatable {
  const AppState({
    this.themeMode = ThemeMode.system,
    this.locale = const Locale('ja', 'JP'),
  });

  final ThemeMode themeMode;
  final Locale locale;

  AppState copyWith({
    ThemeMode? themeMode,
    Locale? locale,
  }) {
    return AppState(
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
    );
  }

  @override
  List<Object?> get props => [themeMode, locale];
}
