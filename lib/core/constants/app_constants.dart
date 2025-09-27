class AppConstants {
  // API Constants
  static const String baseUrl = 'https://tu-backend-net-api.com/api';
  static const String lecturaEndpoint = '/lecturas';

  // Storage Keys
  static const String lecturasCacheKey = 'lecturas_cache';
  static const String lastUpdateKey = 'last_update';

  // UI Constants
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;

  // Animation Durations
  static const int shortAnimationDuration = 300;
  static const int mediumAnimationDuration = 500;
  static const int longAnimationDuration = 800;

  // Cache Duration (in hours)
  static const int cacheExpirationHours = 24;
}
