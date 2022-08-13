// ignore_for_file: non_constant_identifier_names

class AppStrings {
  AppStrings._();

  static String get APP_NAME => 'Price Tracker';
  static String get APP_API_HOST => "wss://ws.binaryws.com/websockets/v3?app_id=1089";
}

class MessageType{
  MessageType._();
  static String get ACTIVE_SYMBOL => 'active_symbols';
  static String get TICK => 'tick';
}