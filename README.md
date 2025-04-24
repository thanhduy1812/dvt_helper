<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

# GTD Helper

A comprehensive Flutter utility package providing a wide range of helper functions, extensions, and UI components to streamline development.

## Features

### Error Handling

- **GtdError**: Comprehensive error handling with different error types and detailed error information.
- **GtdErrorConstant**: Predefined error constants for standardized error handling.

### Logging

- **Logger**: Flexible logging system with different severity levels (VERBOSE, DEBUG, INFO, WARN, ERROR, WTF).
- Colored console output for better readability.
- Configurable log level filtering.

### State Management

- **AppBlocObserver**: BLoC pattern observer for monitoring state changes, errors, and lifecycle events.

### Caching

- **AppSharedPreferences**: Simplified interface for SharedPreferences with type-specific getters and setters.
- **CacheHelper**: Advanced caching utilities with JSON object serialization/deserialization.

### Resource Loading

- **GtdResourceLoader**: Utilities for loading string resources from assets and packages.
- Support for loading content from specific packages with custom paths.

### Utility Functions

- **GlobalFunctions**:
  - HMAC SHA256 encryption and verification
  - Positional utilities for UI widgets
  - JSON parsing and serialization

### Result Pattern

- **Result<S, E>**: Implementation of the Result pattern for handling success/error responses.
- **Unit**: Utility class representing a void or empty response.

### UI Components

- **GtdButton**: Customizable button with various states and appearances.
- **GtdPresentViewHelper**: Helper for presenting modal views.
- **GtdStickyHeader**: Sticky header implementation for lists.
- **GtdHtmlView**: HTML content rendering.
- **GtdExpansionView**: Customizable expansion panel.
- **GtdGradientIcon**: Icon with gradient color.
- **GtdDashBorder**: Border with customizable dash patterns.
- **GtdLunarCalendar**: Calendar with lunar date support and customizable colors.

### Extensions

#### UI Extensions
- **BuildContextExtension**: Convenient extensions for BuildContext.
- **ColorsExtension**: Color manipulation (darken, lighten, avg).
- **MaterialStateExtension**: Utilities for MaterialState properties.
- **ImageExtension**: Image handling utilities.

#### Data Type Extensions
- **StringExtension**: String manipulation and validation.
- **DateTimeExtension**: Date formatting, comparison, and manipulation.
- **NumberExtension**: Number formatting and conversion.
- **IterableExtension**: Collection utilities.

#### Navigation Extensions
- **GoRouterExtension**: Simplified navigation with GoRouter.

#### List View Extensions
- **LoadMoreListExtension**: Infinite scrolling list implementation.
- **GtdPagingScrollPhysics**: Custom scroll physics for paged lists.

### Network Utilities

- **GtdJsonParser**: Safe JSON parsing with error handling.
- **HttpService**: HTTP client with standardized request/response handling.

## Usage

### Error Handling

```dart
try {
  // Some operation
} catch (e) {
  final error = GtdError.custom("Custom error message");
  Logger.e(error.message);
}
```

### Logging

```dart
// Set log level
Logger.setLogLevel(Logger.INFO);

// Log messages
Logger.v("Verbose message");
Logger.d("Debug message");
Logger.i("Info message");
Logger.w("Warning message");
Logger.e("Error message");
```

### Resource Loading

```dart
// Load string from asset
final content = await GtdResourceLoader.loadContentFromResource(
  pathResource: "assets/text/terms.txt"
);

// Load string from package
final htmlContent = await GtdResourceLoader.loadFromPackage(
  packageName: "my_package",
  filePath: "assets/templates/template.html"
);
```

### Caching

```dart
// Initialize cache
await AppSharedPreferences.init();

// Save and retrieve data
AppSharedPreferences.putString("key", "value");
final value = AppSharedPreferences.getString("key");
```

### UI Components

#### Lunar Calendar

```dart
GtdLunarCalendar(
  startDate: DateTime.now(),
  mainColor: Colors.blue,
  accentColor: Colors.orange,
  lunarDateMode: GtdLunarDateMode.range,
  bottomBuilder: (context, {startDate, endDate, resetSink}) {
    // Build bottom UI
  },
)
```

#### Gradient Icon

```dart
GtdGradientIcon(
  Icons.star,
  24.0,
  LinearGradient(
    colors: [Colors.red, Colors.amber],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
)
```

### Extensions

```dart
// String extensions
final isValidEmail = "user@example.com".isValidEmail();
final maskedText = "1234567890".maskString(2, 2);

// DateTime extensions
final formattedDate = DateTime.now().localDate("dd/MM/yyyy");
final tomorrow = DateTime.now().addDay(1);

// Color extensions
final darkerColor = Colors.blue.darken(20);
final lighterColor = Colors.red.lighten(30);
```

## Installation

Add this to your package's pubspec.yaml file:

```yaml
dependencies:
  gtd_helper: ^1.0.11
```

## Requirements

- Flutter: >=3.13.0
- Dart: >=3.3.3 <4.0.0

## Additional Information

For more examples, check the example project.