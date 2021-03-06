
import 'package:cash_collector/helpers/colors.dart';
import 'package:cash_collector/models/widget_pin_client.dart';
import 'package:cash_collector/pages/details_compte.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:here_sdk/core.dart';
import 'package:here_sdk/core.errors.dart';
import 'package:here_sdk/mapview.dart';
import 'package:here_sdk/routing.dart';
import 'package:here_sdk/routing.dart' as here;
import 'package:speech_balloon/speech_balloon.dart';

class MapDisplayer {
  HereMapController _hereMapController;
  MapCamera _camera;
  List<WidgetPinClient> _mapWidgetMarkerList = [];
  List<MapPolyline> _mapPolylines = [];
  WidgetPinClient? _selectedWidgetClient;
  List<Map<String, dynamic>> _clientsInfos;
  BuildContext context;
  late RoutingEngine _routingEngine;
  Anchor2D anchor2D = Anchor2D.withHorizontalAndVertical(0.5, 1);
  GeoCoordinates _currentCoordinate;
  List<GeoCoordinates>? geoCoordinates;

  MapDisplayer(HereMapController hereMapController, List<Map<String, dynamic>> clientsInfos, BuildContext ctx, Position? position):
      _camera = hereMapController.camera,
      _clientsInfos = clientsInfos,
      context = ctx,
      _currentCoordinate = GeoCoordinates(position!.latitude, position.longitude),
      _hereMapController = hereMapController {

    List<GeoCoordinates> geoCoordinateList = _clientsInfos.map(
      (clientInf) {
        GeoCoordinates geoCoordinate = GeoCoordinates(clientInf['latitude'], clientInf['longitude']);
        _addMapMarker(geoCoordinate, clientInf['id']);
        return geoCoordinate;
      }
    ).toList();
    geoCoordinateList.add(_currentCoordinate);
    geoCoordinates = geoCoordinateList;
    _hereMapController.pinWidget(
      const Icon(
        Icons.gps_fixed_rounded,
        size: 30,
        color: routeColor,
      ),
      _currentCoordinate,
    )!;
    GeoBox target = GeoBox.containingGeoCoordinates(geoCoordinateList)!;
    _camera.lookAtAreaWithGeoOrientation(target, GeoOrientationUpdate(20, 0));
    try {
      _routingEngine = RoutingEngine();
    } on InstantiationException {
      throw ("Initialization of RoutingEngine failed.");
    }
  }

  replaceCamera(){
    GeoBox target = GeoBox.containingGeoCoordinates(geoCoordinates!)!;
    _camera.lookAtAreaWithGeoOrientation(target, GeoOrientationUpdate(20, 0));
  }

  int? getSelectedClientId(){
    return _selectedWidgetClient?.clientId;
  }

  Future<void> setClientAsSelected(int clientId, String imageUrl, String name, clientName) async{
    if (_selectedWidgetClient != null){
      if (_selectedWidgetClient?.clientId == clientId){
        return;
      }
      replaceCamera();
      WidgetPinClient lastSelectedPinClient = _selectedWidgetClient!;
      lastSelectedPinClient.widgetPin.unpin();
      _mapWidgetMarkerList.remove(lastSelectedPinClient);
      _addMapMarker(lastSelectedPinClient.widgetPin.coordinates, lastSelectedPinClient.clientId);
    }
    WidgetPinClient widgetPinClient = _mapWidgetMarkerList.firstWhere(
      (WidgetPinClient element) => element.clientId == clientId
    );

    WidgetPin widgetPin = widgetPinClient.widgetPin;
    widgetPin.unpin();
    _mapWidgetMarkerList.remove(widgetPinClient);
    await _addWidgetMapMarkerOnSelected(widgetPinClient.widgetPin.coordinates, clientId, imageUrl, name, clientName);
  }

  void _addMapMarker(GeoCoordinates? geoCoordinates, int idClient) {
    WidgetPin widgetPin = _hereMapController.pinWidget(
      const Icon(
        Icons.location_on,
        size: 40,
        color: Color(0xFFA2A2A2),
      ),
      geoCoordinates!,
      anchor: anchor2D
    )!;
    _mapWidgetMarkerList.add(WidgetPinClient(widgetPin, idClient));
  }


  _showRouteOnMap(here.Route route) {
    // Show route as polyline.
    GeoPolyline routeGeoPolyline = GeoPolyline(route.polyline);

    double widthInPixels = 5;
    MapPolyline routeMapPolyline = MapPolyline(routeGeoPolyline, widthInPixels, namePresentColor);

    _hereMapController.mapScene.addMapPolyline(routeMapPolyline);
    _mapPolylines.add(routeMapPolyline);

  }


  void clearMap() {
    for (var mapPolyline in _mapPolylines) {
      _hereMapController.mapScene.removeMapPolyline(mapPolyline);
    }
    _mapPolylines.clear();
  }


  Future<void> _addRoute(GeoCoordinates startGeoCoordinates, GeoCoordinates destGeoCoordinates) async {

    Waypoint startWaypoint = Waypoint.withDefaults(startGeoCoordinates);
    Waypoint destinationWaypoint = Waypoint.withDefaults(destGeoCoordinates);

    List<Waypoint> waypoints = [startWaypoint, destinationWaypoint];

    _routingEngine.calculateCarRoute(waypoints, CarOptions.withDefaults(),
      (RoutingError? routingError, List<here.Route>? routeList) async {
        if (routingError == null) {
          // When error is null, then the list guaranteed to be not null.
          here.Route route = routeList!.first;
          _showRouteOnMap(route);
        } else {
          var error = routingError.toString();
          // _showDialog('Error', 'Error while calculating a route: $error');
        }
      });
  }

  Future<void> _addWidgetMapMarkerOnSelected(GeoCoordinates? geoCoordinates, int idClient, String imageUrl, String name, String clientName) async {
    WidgetPin widgetPin = _hereMapController.pinWidget(
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: (){
                Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context) =>
                    DetailCompte(
                      noms: clientName,
                      localisation: name,
                      geoCoordinates: geoCoordinates!,
                      profilImgPath: imageUrl,
                    )
                  )
                );
              },
              child: SpeechBalloon(
                nipHeight: 15,
                width: 120,
                height: 105,
                borderRadius: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        height: 70,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(topRight: Radius.circular(5), topLeft: Radius.circular(5)),
                          image: DecorationImage(
                            image: AssetImage(imageUrl),
                            fit: BoxFit.cover
                          )
                        ),
                      ),
                    ),
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: 'Poppins Light',
                        fontSize: 11,
                        color: infosColor1
                      ),
                    )
                  ],
                )
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Icon(
              Icons.location_on,
              size: 40,
              color: namePresentColor,
            ),
          ],
        ),
        geoCoordinates!,
        anchor: anchor2D
    )!;
    _selectedWidgetClient = WidgetPinClient(widgetPin, idClient);
    _mapWidgetMarkerList.add(_selectedWidgetClient!);
    clearMap();
    await _addRoute(_currentCoordinate, geoCoordinates);
  }

}