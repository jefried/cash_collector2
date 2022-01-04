import 'dart:async';

import 'package:cash_collector/helpers/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:here_sdk/core.dart';
import 'package:here_sdk/core.errors.dart';
import 'package:here_sdk/mapview.dart';
import 'package:here_sdk/routing.dart';
import 'package:here_sdk/routing.dart' as here;
import 'package:intl/intl.dart';
import 'package:speech_balloon/speech_balloon.dart';

class MapDetailsAccountDisplayer {

  HereMapController _hereMapController;
  List<MapPolyline> _mapPolylines = [];
  Anchor2D anchor2D = Anchor2D.withHorizontalAndVertical(0.5, 1);
  String _clientName;
  GeoCoordinates ownCoordinate;
  GeoCoordinates clientCoords;
  WidgetPin? _ownWidgetLocation;


  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  StreamSubscription<Position>? _positionStreamSubscription;

  MapDetailsAccountDisplayer(HereMapController hereMapController, String clientName, GeoCoordinates clientCoords, GeoCoordinates ownCoords) :
      _hereMapController = hereMapController,
      ownCoordinate = ownCoords,
      _clientName = clientName,
      clientCoords = clientCoords {
    GeoBox target = GeoBox.containingGeoCoordinates([clientCoords, ownCoords])!;
    _hereMapController.camera.lookAtAreaWithGeoOrientation(target, GeoOrientationUpdate(20, 0));

    _addWidgetMapMarkerOwn(ownCoords);
    _addWidgetMapMarkerClient();

  }

  void _listenPosition() {
    if (_positionStreamSubscription == null) {
      final positionStream = _geolocatorPlatform.getPositionStream();
      _positionStreamSubscription = positionStream.handleError((error) {
        _positionStreamSubscription?.cancel();
        _positionStreamSubscription = null;
      }).listen(
        (position) {
           _addWidgetMapMarkerOwn(GeoCoordinates(position.latitude, position.longitude));
        }
      );
      _positionStreamSubscription?.pause();
    }

  }

  // void addCarRoute(){
  //   _addCarRoute(ownCoordinate, clientCoords);
  // }
  //
  // void addPedestrianRoute(){
  //   _addPedestrianRoute(ownCoordinate, clientCoords);
  // }

   void _addWidgetMapMarkerClient() {
     WidgetPin widgetPin = _hereMapController.pinWidget(
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
                 _clientName,
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
       clientCoords,
       anchor: anchor2D
     )!;
   }


    void _addWidgetMapMarkerOwn(GeoCoordinates geoCoordinates)  {
      ownCoordinate = geoCoordinates;
      if (_ownWidgetLocation != null){
        _ownWidgetLocation?.unpin();
      }
      WidgetPin widgetPin = _hereMapController.pinWidget(
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
        ownCoordinate,
        anchor: anchor2D
    )!;
    _ownWidgetLocation = widgetPin;
  }



}