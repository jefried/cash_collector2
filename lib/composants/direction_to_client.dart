import 'package:cash_collector/composants/button_transport.dart';
import 'package:cash_collector/helpers/colors.dart';
import 'package:cash_collector/helpers/map_details_account_displayer.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:here_sdk/core.dart';
import 'package:here_sdk/core.errors.dart';
import 'package:here_sdk/mapview.dart';
import 'package:here_sdk/routing.dart';
import 'package:intl/intl.dart';
import 'package:here_sdk/routing.dart' as here;
import 'package:speech_balloon/speech_balloon.dart';

class DirectionToClient extends StatefulWidget {
  final String clientName;
  final GeoCoordinates clientCoords;
  const DirectionToClient({
    Key? key,
    required this.clientName,
    required this.clientCoords
  }) : super(key: key);

  @override
  _DirectionToClientState createState() => _DirectionToClientState();
}

class _DirectionToClientState extends State<DirectionToClient> {

  bool isMapLoaded = false;
  String activeTypeRoute = "car";
  HereMapController? _hereMapController;
  RoutingEngine? _routingEngine;
  String? timeAtFoot;
  String? distanceAtFoot;
  String? timeWithCar;
  String? distanceWithCar;
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  List<MapPolyline> _mapPolylines = [];
  Anchor2D _anchor2D = Anchor2D.withHorizontalAndVertical(0.5, 1);
  GeoCoordinates? _currentCoordinates;
  WidgetPin? _ownWidgetLocation;

  void _onMapCreated(HereMapController hereMapController) {
    hereMapController.mapScene.loadSceneForMapScheme(MapScheme.normalDay, (MapError? error) async {
      if (error == null) {
        Position currentPosition = await _geolocatorPlatform.getCurrentPosition();
        setState(() {
          _hereMapController = hereMapController;
          _currentCoordinates = GeoCoordinates(currentPosition.latitude, currentPosition.longitude);
        });
        GeoBox target = GeoBox.containingGeoCoordinates([widget.clientCoords, _currentCoordinates!])!;
        _hereMapController?.camera.lookAtAreaWithGeoOrientation(target, GeoOrientationUpdate(20, 0));

        _addWidgetMapMarkerOwn(_currentCoordinates!);
        _addWidgetMapMarkerClient();
        _addCarRoute();
        _addPedestrianRoute();
      } else {
        print("Map scene not loaded. MapError: " + error.toString());
      }
    });

  }

  _showRouteOnMap(here.Route route, Color roadColor) {
    // Show route as polyline.
    GeoPolyline routeGeoPolyline = GeoPolyline(route.polyline);

    double widthInPixels = 5;
    MapPolyline routeMapPolyline = MapPolyline(routeGeoPolyline, widthInPixels, roadColor);

    _hereMapController?.mapScene.addMapPolyline(routeMapPolyline);
    _mapPolylines.add(routeMapPolyline);

  }

  void _setCarRouteDetails(here.Route route) {
    int estimatedTravelTimeInSeconds = route.durationInSeconds;
    int lengthInMeters = route.lengthInMeters;
    setState(() {
      timeWithCar = _formatTime(estimatedTravelTimeInSeconds);
      distanceWithCar = _formatLength(lengthInMeters);
    });
  }

  void _setPedestrianRouteDetails(here.Route route) {
    int estimatedTravelTimeInSeconds = route.durationInSeconds;
    int lengthInMeters = route.lengthInMeters;
    setState(() {
      timeAtFoot = _formatTime(estimatedTravelTimeInSeconds);
      distanceAtFoot = _formatLength(lengthInMeters);
    });
  }

  String _formatTime(int sec) {
    NumberFormat formatter = NumberFormat("00");
    int hours = sec ~/ 3600;
    int minutes = (sec % 3600) ~/ 60;
    if (hours == 0){
      return '${formatter.format(minutes)} min';
    }
    return '${formatter.format(hours)}:${formatter.format(minutes)} min';
  }

  String _formatLength(int meters) {
    int kilometers = meters ~/ 1000;
    int remainingMeters = meters % 1000;

    return '$kilometers, $remainingMeters km';
  }


  void _logRouteViolations(here.Route route) {
    for (var section in route.sections) {
      for (var notice in section.sectionNotices) {
        print("This route contains the following warning: " + notice.code.toString());
      }
    }
  }

  void _removeRoute() {
    for (var mapPolyline in _mapPolylines) {
      _hereMapController?.mapScene.removeMapPolyline(mapPolyline);
    }
    _mapPolylines.clear();
  }


  Future<void> _addCarRoute() async {

    Waypoint startWaypoint = Waypoint.withDefaults(_currentCoordinates!);
    Waypoint destinationWaypoint = Waypoint.withDefaults(widget.clientCoords);

    List<Waypoint> waypoints = [startWaypoint, destinationWaypoint];

    _routingEngine?.calculateCarRoute(waypoints, CarOptions.withDefaults(),
            (RoutingError? routingError, List<here.Route>? routeList) async {
          if (routingError == null) {
            // When error is null, then the list guaranteed to be not null.
            here.Route route = routeList!.first;
            _removeRoute();
            _setCarRouteDetails(route);
            _showRouteOnMap(route, routeColor);
            _logRouteViolations(route);
          } else {
            var error = routingError.toString();
            // _showDialog('Error', 'Error while calculating a route: $error');
          }
        });

  }

  Future<void> _addPedestrianRoute() async {

    Waypoint startWaypoint = Waypoint.withDefaults(_currentCoordinates!);
    Waypoint destinationWaypoint = Waypoint.withDefaults(widget.clientCoords);

    List<Waypoint> waypoints = [startWaypoint, destinationWaypoint];

    _routingEngine?.calculatePedestrianRoute(waypoints, PedestrianOptions.withDefaults(),
            (RoutingError? routingError, List<here.Route>? routeList) async {
          if (routingError == null) {
            // When error is null, then the list guaranteed to be not null.
            here.Route route = routeList!.first;
            _removeRoute();
            _setPedestrianRouteDetails(route);
            _showRouteOnMap(route, routeColor);
            _logRouteViolations(route);
          } else {
            var error = routingError.toString();
            // _showDialog('Error', 'Error while calculating a route: $error');
          }
        });

  }

  void _addWidgetMapMarkerClient() {
    WidgetPin? widgetPin = _hereMapController?.pinWidget(
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SpeechBalloon(
                nipHeight: 15,
                width: 120,
                height: 30,
                borderRadius: 5,
                child: Center(
                  child: Text(
                    widget.clientName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontFamily: 'Poppins Light',
                        fontSize: 11,
                        color: infosColor1
                    ),
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
        widget.clientCoords,
        anchor: _anchor2D
    )!;
  }


  void _addWidgetMapMarkerOwn(GeoCoordinates geoCoordinates)  {
    setState(() {
      _currentCoordinates = geoCoordinates;
    });
    if (_ownWidgetLocation != null){
      _ownWidgetLocation?.unpin();
    }
    WidgetPin? widgetPin = _hereMapController?.pinWidget(
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SpeechBalloon(
                nipHeight: 15,
                width: 120,
                height: 30,
                borderRadius: 5,
                child: Center(
                  child: Text(
                    'Vous êtes ici !',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontFamily: 'Poppins Light',
                        fontSize: 11,
                        color: infosColor1
                    ),
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
        _currentCoordinates!,
        anchor: _anchor2D
    );
    _ownWidgetLocation = widgetPin;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    try {
      _routingEngine = RoutingEngine();
    } on InstantiationException {
      throw ("Initialization of RoutingEngine failed.");
    }
  }

  @override
  Widget build(BuildContext context) {

    return SizedBox(
        height: MediaQuery.of(context).size.height - 217,
        width: double.infinity,
        child: Stack(
          children: [
            HereMap(
              onMapCreated: _onMapCreated,
            ),
            Positioned(
              left: 0,
              bottom: 15,
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ButtonTransport(
                          isActive: activeTypeRoute == 'car',
                          icon: Icons.directions_car,
                          onClicked: (){
                            if (activeTypeRoute != 'car'){
                              _addCarRoute();
                              setState(() {
                                activeTypeRoute = 'car';
                              });
                            }
                          },
                          mode: "en voiture",
                          time: timeWithCar,
                          distance: distanceWithCar,
                        ),
                        const SizedBox(width: 10,),
                        ButtonTransport(
                          isActive: activeTypeRoute == 'pedestrian',
                          icon: Icons.directions_walk,
                          mode: "à pied",
                          onClicked: (){
                            if (activeTypeRoute != 'pedestrian'){
                              _addPedestrianRoute();
                              setState(() {
                                activeTypeRoute = 'pedestrian';
                              });
                            }
                          },
                          time: timeAtFoot,
                          distance: distanceAtFoot,
                        ),
                      ],
                    ),
                  )
              ),
            )
          ],
        )
    );
  }
}
