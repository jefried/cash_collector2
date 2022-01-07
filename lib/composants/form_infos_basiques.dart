import 'package:cash_collector/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:here_sdk/core.dart';
import 'package:here_sdk/core.errors.dart';
import 'package:here_sdk/search.dart';

class FormInfosBasiques extends StatefulWidget {
  const FormInfosBasiques({Key? key}) : super(key: key);

  @override
  FormInfosBasiquesState createState() => FormInfosBasiquesState();
}

class FormInfosBasiquesState extends State<FormInfosBasiques> {

  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  String noms = "";
  String prenoms = "";
  String secteur = "Agroalimentaire";
  int telephone = 0;
  String? adressLocation;
  SearchEngine? _searchEngine;
  GeoCoordinates? currentCoords;

  GlobalKey<FormState> infosBasiqueFormKey = GlobalKey<FormState>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    try {
      _searchEngine = SearchEngine();
    } on InstantiationException {
      throw Exception("Initialization of SearchEngine failed.");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Form(
        key: infosBasiqueFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              keyboardType: TextInputType.text,
              initialValue: noms,
              decoration: const InputDecoration(
                label: Text('Noms', style: TextStyle(fontSize: 14, color: Colors.black),),
              ),
              onSaved: (String? value) {
                if (value!=null) {
                  noms = value;
                }
              },
              validator: (String? value) {
                return (value !=null && value.length<1) ? 'veuillez renseigner un nom' : null;
              },
            ),
            const SizedBox(height: 20,),
            TextFormField(
              keyboardType: TextInputType.text,
              initialValue: prenoms,
              decoration: const InputDecoration(
                label: Text('Prénoms', style: TextStyle(fontSize: 14, color: Colors.black),),
              ),
              onSaved: (String? value) {
                if (value!=null) {
                  prenoms = value;
                }
              },
              validator: (String? value) {
                return (value !=null && value.length<1) ? 'veuillez renseigner un prénom' : null;
              },
            ),
            const SizedBox(height: 40,),
            /*TextFormField(
              keyboardType: TextInputType.text,
              initialValue: secteur,
              decoration: const InputDecoration(
                label: Text('Secteur d\'activité', style: TextStyle(fontSize: 14, color: Colors.black),),
              ),
              onSaved: (String? value) {
                if (value!=null) {
                  secteur = value;
                }
              },
              validator: (String? value) {
                return (value !=null && value.length<1) ? 'Veuillez renseigner le secteur d\'activité' : null;
              },
            ),*/
            Text("Secteur d'activité"),
            DropdownButton<String>(
              value: secteur,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down, size: 28,),
              elevation: 16,
              style: const TextStyle(color: Colors.black, fontSize: 14),
              underline: Container(
                height: 1,
                color: textColorGrey,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  secteur = newValue!;
                });
              },
              items: <String>["Agroalimentaire", "Commerce", "Hébergement", "Santé", "Restauration"]
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 20,),
            TextFormField(
              keyboardType: TextInputType.number,
              initialValue: (telephone != 0)?telephone.toString(): "",
              decoration: const InputDecoration(
                label: Text('Téléphone', style: TextStyle(fontSize: 14, color: Colors.black),),
              ),
              onSaved: (String? value) {
                if (value!=null) {
                  telephone = int.parse(value);
                }
              },
              validator: (String? value) {
                return (value != null && value.length != 9) ? 'le numéro doit avoir 9 chiffres' : null;
              },
            ),
            const SizedBox(height: 20,),
            TextFormField(
              keyboardType: TextInputType.text,
              initialValue: adressLocation ?? "",
              decoration: const InputDecoration(
                  label: Text('Localisation', style: TextStyle(fontSize: 14, color: Colors.black),)
              ),
            ),

          ],
        )
    );
  }

  Future<void> _setAddressForCoordinates() async {
    Position currentPosition = await _geolocatorPlatform.getCurrentPosition();
    setState(() {
      currentCoords = GeoCoordinates(currentPosition.latitude, currentPosition.longitude);
    });
    int maxItems = 1;
    SearchOptions reverseGeocodingOptions = SearchOptions(LanguageCode.frFr, maxItems);

    _searchEngine?.searchByCoordinates(currentCoords!, reverseGeocodingOptions,
      (SearchError? searchError, List<Place>? list) async {
      if (searchError != null) {
        // _showDialog("Reverse geocoding", "Error: " + searchError.toString());
        return;
      }
      setState(() {
        adressLocation = list!.first.address.addressText;
      });

    });
  }
}
