import 'package:cash_collector/helpers/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:here_sdk/core.dart';
import 'package:here_sdk/core.errors.dart';
import 'package:here_sdk/mapview.dart';
import 'package:here_sdk/routing.dart';
import 'package:here_sdk/routing.dart' as here;
import 'package:speech_balloon/speech_balloon.dart';

class MapDetailsAccountDisplayer {

  HereMapController _hereMapController;
  List<MapPolyline> _mapPolylines = [];
  RoutingEngine? _routingEngine;
  Anchor2D anchor2D = Anchor2D.withHorizontalAndVertical(0.5, 1);
  String _clientName;
  GeoCoordinates _ownCoordinate;
  GeoCoordinates _clientCoords;

  MapDetailsAccountDisplayer(HereMapController hereMapController, String clientName, GeoCoordinates clientCoords, GeoCoordinates ownCoords) :
      _hereMapController = hereMapController,
      _ownCoordinate = ownCoords,
      _clientName = clientName,
      _clientCoords = clientCoords {

    GeoBox target = GeoBox.containingGeoCoordinates([clientCoords, ownCoords])!;
    _hereMapController.camera.lookAtAreaWithGeoOrientation(target, GeoOrientationUpdate(20, 0));
    try {
      _routingEngine = RoutingEngine();
    } on InstantiationException {
      throw ("Initialization of RoutingEngine failed.");
    }
  }

  void _addWidgetMapMarkerOnSelected(GeoCoordinates? geoCoordinates, int idClient, String imageUrl, String name)  {
    WidgetPin widgetPin = _hereMapController.pinWidget(
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SpeechBalloon(
                  nipHeight: 15,
                  width: 120,
                  borderRadius: 5,
                  child: Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontFamily: 'Poppins Light',
                            fontSize: 11,
                            color: infosColor1
                        ),
                      )

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
  }

  _showRouteOnMap(here.Route route) {
    // Show route as polyline.
    GeoPolyline routeGeoPolyline = GeoPolyline(route.polyline);

    double widthInPixels = 5;
    MapPolyline routeMapPolyline = MapPolyline(routeGeoPolyline, widthInPixels, namePresentColor);

    _hereMapController.mapScene.addMapPolyline(routeMapPolyline);
    _mapPolylines.add(routeMapPolyline);

  }

  void _showRouteDetails(here.Route route) {
    int estimatedTravelTimeInSeconds = route.durationInSeconds;
    int lengthInMeters = route.lengthInMeters;

    String routeDetails =
        'Travel Time: ' + _formatTime(estimatedTravelTimeInSeconds) + ', Length: ' + _formatLength(lengthInMeters);
  }

  String _formatTime(int sec) {
    int hours = sec ~/ 3600;
    int minutes = (sec % 3600) ~/ 60;

    return '$hours:$minutes min';
  }

  String _formatLength(int meters) {
    int kilometers = meters ~/ 1000;
    int remainingMeters = meters % 1000;

    return '$kilometers.$remainingMeters km';
  }


  void _logRouteViolations(here.Route route) {
    for (var section in route.sections) {
      for (var notice in section.sectionNotices) {
        print("This route contains the following warning: " + notice.code.toString());
      }
    }
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

    _routingEngine?.calculateCarRoute(waypoints, CarOptions.withDefaults(),
            (RoutingError? routingError, List<here.Route>? routeList) async {
          if (routingError == null) {
            // When error is null, then the list guaranteed to be not null.
            here.Route route = routeList!.first;
            _showRouteDetails(route);
            _showRouteOnMap(route);
            _logRouteViolations(route);
          } else {
            var error = routingError.toString();
            // _showDialog('Error', 'Error while calculating a route: $error');
          }
        });
  }

}