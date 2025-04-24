## 1.0.11

- Added color customization parameters to GtdLunarCalendar:
  - mainColor: Used for selected day borders and highlights
  - lightMainColor: Used for date range highlighting 
  - accentColor: Used for day labels
  - Added text color customization options
- Updated GtdCalendarHelper to support color customization

## 1.0.10

- Fixed color extension implementation by:
  - Separated GtdColors into a standalone class for static color constants
  - Created ColorExtension extension on Color class for color manipulation methods
  - Fixed implementation of darken(), lighten(), and avg() methods

## 1.0.9

- Added `decryptHmacSha256` method to GlobalFunctions to decode base64 encoded HMAC-SHA256 hash values
- Added `verifyHmacSha256` method to GlobalFunctions to verify HMAC-SHA256 encrypted values

## 1.0.8

- Added `loadFromPackage` method to GtdResourceLoader to load string resources from packages

## 1.0.7

- Removed deprecated files (gtd_error.dart, gtd_json_parser.dart)
- Now directly importing GtdError and GtdJsonParser from gtd_network package

## 1.0.6

- Replaced GtdUtilError with GtdError from gtd_network package
- Replaced JsonParser with GtdJsonParser from gtd_network package

## 1.0.5

- Updated packages to latest major versions:
  - flutter_bloc: ^9.1.0
  - go_router: ^15.1.1
  - intl: ^0.20.2
  - flutter_lints: ^5.0.0
- Updated Flutter SDK constraint to ">=3.13.0"

## 1.0.4

- Update support platforms.
- Update new package
