import 'package:here_sdk/mapview.dart';

class WidgetPinClient {
  final WidgetPin _widgetPin;
  final int _clientId;

  WidgetPinClient(WidgetPin? widgetPin, int clientId) :
      _widgetPin = widgetPin!,
      _clientId = clientId
  ;

  WidgetPin get widgetPin {
    return _widgetPin;
  }

  int get clientId {
    return _clientId;
  }
}