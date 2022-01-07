import 'package:cash_collector/composants/app_bar_content.dart';
import 'package:cash_collector/composants/card_photo_pick.dart';
import 'package:cash_collector/composants/block_button.dart';
import 'package:cash_collector/composants/block_select.dart';
import 'package:cash_collector/pages/encaissement.dart';
import 'package:cash_collector/pages/home.dart';
import 'package:cash_collector/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:here_sdk/core.dart';
import 'package:here_sdk/core.errors.dart';
import 'package:here_sdk/search.dart';
import 'package:im_stepper/stepper.dart';
import 'package:image_picker/image_picker.dart';

class CreationClient extends StatefulWidget {
  const CreationClient({Key? key}) : super(key: key);

  @override
  CreationClientState createState() => CreationClientState();
}

class CreationClientState extends State<CreationClient> {

  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  final snackBar = SnackBar(content: Text("veuillez sélectionner des jours et des heures de visite"));
  bool workStatus = true;
  int activeStep = 0;
  int upperBound = 4;
  String nbreDePassage = "1";
  String noms = "";
  String prenoms = "";
  String secteur = "Agroalimentaire";
  int telephone = 0;
  TextEditingController adressLocationController = TextEditingController();
  SearchEngine? _searchEngine;
  GeoCoordinates? currentCoords;

  String nomsAContacter = "";
  String prenomsAContacter = "";
  int telephoneAContacter = 0;
  int numeroCNI = 0;
  XFile? photoCNIRecto;
  XFile? photoCNIVerso;
  XFile? photoGerant;
  XFile? photoLieu;
  GlobalKey<FormState> infosBasiqueKey = GlobalKey<FormState>();
  GlobalKey<FormState> personneAContacterKey = GlobalKey<FormState>();
  GlobalKey<FormState> photosKey = GlobalKey<FormState>();
  GlobalKey<CardPhotoPickState> photoCNIRectoKey = GlobalKey<CardPhotoPickState>();
  GlobalKey<CardPhotoPickState> photoCNIVersoKey = GlobalKey<CardPhotoPickState>();
  GlobalKey<CardPhotoPickState> photoGerantKey = GlobalKey<CardPhotoPickState>();
  GlobalKey<CardPhotoPickState> photoLieuKey = GlobalKey<CardPhotoPickState>();
  GlobalKey<BlockSelectedState> lundiKey = GlobalKey<BlockSelectedState>();
  GlobalKey<BlockSelectedState> mardiKey = GlobalKey<BlockSelectedState>();
  GlobalKey<BlockSelectedState> mercrediKey = GlobalKey<BlockSelectedState>();
  GlobalKey<BlockSelectedState> jeudiKey = GlobalKey<BlockSelectedState>();
  GlobalKey<BlockSelectedState> vendrediKey = GlobalKey<BlockSelectedState>();
  GlobalKey<BlockSelectedState> samediKey = GlobalKey<BlockSelectedState>();
  GlobalKey<BlockSelectedState> dimancheKey = GlobalKey<BlockSelectedState>();
  GlobalKey<BlockSelectedState> huitKey = GlobalKey<BlockSelectedState>();
  GlobalKey<BlockSelectedState> neufKey = GlobalKey<BlockSelectedState>();
  GlobalKey<BlockSelectedState> dixKey = GlobalKey<BlockSelectedState>();
  GlobalKey<BlockSelectedState> onzeKey = GlobalKey<BlockSelectedState>();
  GlobalKey<BlockSelectedState> douzeKey = GlobalKey<BlockSelectedState>();
  GlobalKey<BlockSelectedState> treizeKey = GlobalKey<BlockSelectedState>();
  GlobalKey<BlockSelectedState> quatorzeKey = GlobalKey<BlockSelectedState>();
  GlobalKey<BlockSelectedState> quinzeKey = GlobalKey<BlockSelectedState>();
  GlobalKey<BlockSelectedState> seizeKey = GlobalKey<BlockSelectedState>();
  GlobalKey<BlockSelectedState> dixSeptKey = GlobalKey<BlockSelectedState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    try {
      _searchEngine = SearchEngine();
    } on InstantiationException {
      throw Exception("Initialization of SearchEngine failed.");
    }
    _setAddressForCoordinates();
  }

  @override
  Widget build(BuildContext context) {
    double appBarSize = 85;
    return Scaffold(
      resizeToAvoidBottomInset: true,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(57),
          child: AppBarContent(
            title: "Clients",
            icon: Icons.arrow_back_ios,
            onPressBtnMenu: (){Navigator.pop(context);},
          ),
        ),
      body: Container(
        height: MediaQuery.of(context).size.height - 72,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(29), topLeft: Radius.circular(29)),
            color: fontgrey
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20,),
              const Text("Création de compte client", style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),),
              const SizedBox(height: 20,),
              NumberStepper(
                enableStepTapping: false,
                stepRadius: 12,
                stepColor: const Color(0xFFBCE0FD),
                activeStepColor: stepperColor,
                activeStepBorderColor: Colors.white,
                activeStepBorderWidth: 3,
                activeStepBorderPadding: 0,
                lineColor: const Color(0xFFBCE0FD),
                numberStyle: const TextStyle(color: Colors.white),
                enableNextPreviousButtons: false,
                numbers: const [1,2,3,4,5,],

                // activeStep property set to activeStep variable defined above.
                activeStep: activeStep,

                // This ensures step-tapping updates the activeStep.
                onStepReached: (index) {
                  setState(() {
                    activeStep = index;
                  });
                },
              ),
              const SizedBox(height: 10,),
              header(),
              const Divider(),
              const SizedBox(height: 20,),
              content(),
              const SizedBox(height: 40,),
              (activeStep < 4)?const Divider():const SizedBox(),
              (activeStep < 4)?Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: (){
                      if (activeStep > 0) {
                        setState(() {
                          activeStep--;
                        });
                      }
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.arrow_back_ios, size: 17, color: stepperColor,),
                        SizedBox(width: 10,),
                        Text("Retour", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: stepperColor),)
                      ],
                    )
                  ),
                  InkWell(
                    onTap: (){
                      if (activeStep < upperBound) {
                        switch(activeStep) {
                          case 0 : {
                            if(infosBasiqueKey.currentState!.validate()){
                              print(infosBasiqueKey.currentState!.validate());
                              infosBasiqueKey.currentState!.save();
                              setState(() {
                                activeStep++;
                              });
                            } else {
                              print(infosBasiqueKey.currentState!.validate());
                            }
                          } break;
                          case 1 : {
                            if(personneAContacterKey.currentState!.validate()) {
                              personneAContacterKey.currentState!.save();
                              setState((){
                                activeStep++;
                              });
                            }
                          } break;
                          case 2 : {
                            if(photosKey.currentState!.validate()) {
                              photosKey.currentState!.save();
                              setState((){
                                activeStep++;
                              });
                            }
                          } break;
                          case 3 : {
                            //jours
                            List jours = [];
                            if(lundiKey.currentState!.check) jours.add("lundi");
                            if(mardiKey.currentState!.check) jours.add("mardi");
                            if(mercrediKey.currentState!.check) jours.add("mercredi");
                            if(jeudiKey.currentState!.check) jours.add("jeudi");
                            if(vendrediKey.currentState!.check) jours.add("vendredi");
                            if(samediKey.currentState!.check) jours.add("samedi");
                            if(dimancheKey.currentState!.check) jours.add("dimanche");
                            //heures
                            List heures = [];
                            if(huitKey.currentState!.check) heures.add(8);
                            if(neufKey.currentState!.check) heures.add(9);
                            if(dixKey.currentState!.check) heures.add(10);
                            if(onzeKey.currentState!.check) heures.add(11);
                            if(douzeKey.currentState!.check) heures.add(12);
                            if(treizeKey.currentState!.check) heures.add(13);
                            if(quatorzeKey.currentState!.check) heures.add(14);
                            if(quinzeKey.currentState!.check) heures.add(15);
                            if(seizeKey.currentState!.check) heures.add(16);
                            if(dixSeptKey.currentState!.check) heures.add(17);

                            //checking
                            if(jours.isEmpty || heures.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            } else {
                              setState((){
                                activeStep++;
                              });
                            }
                          }
                        }
                      }
                    },
                    child: const BlockButton(text: "Suivant", linear: true, foregroundColor: Colors.white),
                  ),
                ],
              ):Container(),
              const SizedBox(height: 50,)
            ],
          ),
        )
      )
    );
  }

  Widget header() {
    return (activeStep < 4)?Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Text(
        headerText(),
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
      ),
    ): Center(child: Container( height: 120, width: 120, child: Image(image: AssetImage("assets/encaissement/check.png"),)));
  }

  // Returns the header text based on the activeStep.
  String headerText() {
    switch (activeStep) {
      case 0:
        return 'Infos basiques';
      case 1:
        return 'Personne à contacter';

      case 2:
        return 'Photos';

      case 3:
        return 'Fréquence de visite';

      case 4:
        return '';

      default:
        return '';
    }
  }

  Widget content() {
    switch (activeStep) {
      case 0:
        return formInfoBasique();

      case 1:
        return formPersonneAContacter();

      case 2:
        return formPhotos();

      case 3:
        return formFrequenceVisite();

      case 4:
        return formEnd();

      default:
        return Container();
    }
  }

  Future<void> _setAddressForCoordinates() async {
    Position currentPosition = await _geolocatorPlatform.getCurrentPosition();
    setState(() {
      currentCoords = GeoCoordinates(currentPosition.latitude, currentPosition.longitude);
    });
    int maxItems = 1;
    SearchOptions reverseGeocodingOptions = SearchOptions(LanguageCode.enGb, maxItems);

    _searchEngine?.searchByCoordinates(
        currentCoords!, reverseGeocodingOptions,
      (SearchError? searchError, List<Place>? list) async {
      if (searchError != null) {
        // _showDialog("Reverse geocoding", "Error: " + searchError.toString());
        return;
      }
      adressLocationController.text = list!.first.address.addressText;
    });
  }

  Widget formInfoBasique() {

    return Form(
      key: infosBasiqueKey,
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
              return (value !=null && value.length!=9) ? 'le numéro doit avoir 9 chiffres' : null;
            },
          ),
          const SizedBox(height: 20,),
          TextFormField(
            enabled: false,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
                label: Text(
                  'Localisation',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                )
            ),
            controller: adressLocationController,
          )
        ],
      )
    );
  }

  Widget formPersonneAContacter() {

    return Form(
        key: personneAContacterKey,
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.text,
              initialValue: nomsAContacter,
              decoration: const InputDecoration(
                label: Text('Noms', style: TextStyle(fontSize: 14, color: Colors.black),),
              ),
              onSaved: (String? value) {
                if (value!=null) {
                  nomsAContacter = value;
                }
              },
              validator: (String? value) {
                return (value !=null && value.length<1) ? 'veuillez renseigner un nom' : null;
              },
            ),
            const SizedBox(height: 20,),
            TextFormField(
              keyboardType: TextInputType.text,
              initialValue: prenomsAContacter,
              decoration: const InputDecoration(
                label: Text('Prénoms', style: TextStyle(fontSize: 14, color: Colors.black),),
              ),
              onSaved: (String? value) {
                if (value!=null) {
                  prenomsAContacter = value;
                }
              },
              validator: (String? value) {
                return (value !=null && value.length<1) ? 'veuillez renseigner un prénom' : null;
              },
            ),
            const SizedBox(height: 20,),
            TextFormField(
              keyboardType: TextInputType.number,
              initialValue: (telephoneAContacter != 0)?telephoneAContacter.toString(): "",
              decoration: const InputDecoration(
                label: Text('Téléphone', style: TextStyle(fontSize: 14, color: Colors.black),),
              ),
              onSaved: (String? value) {
                if (value!=null) {
                  telephoneAContacter = int.parse(value);
                }
              },
              validator: (String? value) {
                return (value !=null && value.length!=9) ? 'le numéro doit avoir 9 chiffres' : null;
              },
            ),
          ],
        )
    );
  }

  Widget formPhotos() {
    return Form(
        key: photosKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              keyboardType: TextInputType.number,
              initialValue: (numeroCNI != 0)?numeroCNI.toString(): "",
              decoration: const InputDecoration(
                label: Text('Numéro CNI', style: TextStyle(fontSize: 14, color: Colors.black),),
              ),
              onSaved: (String? value) {
                if (value!=null) {
                  numeroCNI = int.parse(value);
                }
              },
              validator: (String? value) {
                return (value !=null && value.length<8) ? 'le numéro de la CNI doit avoir au moins 8 chiffres' : null;
              },
            ),
            const SizedBox(height: 30,),
            const Text('Photos de la CNI (recto)', style: TextStyle(fontSize: 14, color: Colors.black),),
            const SizedBox(height: 20,),
            CardPhotoPick(
              key: photoCNIRectoKey,
              width: MediaQuery.of(context).size.width - 40,
              initialPhoto: photoCNIRecto,
              fonc: (XFile file){
                setState(() {
                  photoCNIRecto = file;
                });
              },
            ),
            const SizedBox(height: 30,),
            const Text('Photos de la CNI (verso)', style: TextStyle(fontSize: 14, color: Colors.black),),
            const SizedBox(height: 20,),
            CardPhotoPick(
              key: photoCNIVersoKey,
              width: MediaQuery.of(context).size.width - 40,
              initialPhoto: photoCNIVerso,
              fonc: (XFile file){
                setState(() {
                  photoCNIVerso = file;
                });
              },
            ),
            const SizedBox(height: 30,),
            const Text('Photos du gérant', style: TextStyle(fontSize: 14, color: Colors.black),),
            const SizedBox(height: 20,),
            CardPhotoPick(
              key: photoGerantKey,
              width: MediaQuery.of(context).size.width - 40,
              initialPhoto: photoGerant,
              fonc: (XFile file){
                setState(() {
                  photoGerant = file;
                });
              },
            ),
            const SizedBox(height: 30,),
            const Text('Photos du lieu', style: TextStyle(fontSize: 14, color: Colors.black),),
            const SizedBox(height: 20,),
            CardPhotoPick(
              key: photoLieuKey,
              width: MediaQuery.of(context).size.width - 40,
              initialPhoto: photoLieu,
              fonc: (XFile file){
                setState(() {
                  photoLieu = file;
                });
              },
            ),
          ],
        )
    );
  }

  Widget formEnd() {
    return Column(
      children: [
        const Text("Nouveau client crée avec succès", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
        const SizedBox(height: 30,),
        Center(
          child: InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Encaissement(noms: noms + prenoms)));
            },
            child: _encaissementBouton(),
          )
        ),
        const SizedBox(height: 30,),
        Center(
          child: InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
            },
            child: _accueilButton(),
          ),
        )
      ],
    );
  }

  Widget formFrequenceVisite() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Jours", style: TextStyle(color: textColorGrey,fontSize: 15, fontWeight: FontWeight.bold),),
        const SizedBox(height: 20,),
        Container(
          padding: const EdgeInsets.all(14),
          height: 235,
          decoration: BoxDecoration(
            color: const Color(0xFFF3F3FF),//Colors.white,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  BlockSelected(key: lundiKey, texte: "Lundi", width: 118,),
                  SizedBox(height: 20,),
                  BlockSelected(key: mardiKey, texte: "Mardi", width: 118,),
                  SizedBox(height: 20,),
                  BlockSelected(key: mercrediKey, texte: "Mercredi", width: 118,),
                  SizedBox(height: 20,),
                  BlockSelected(key: jeudiKey, texte: "Jeudi", width: 118,),
                ],
              ),
              Column(
                children:  [
                  BlockSelected(key: vendrediKey, texte: "Vendredi", width: 118,),
                  SizedBox(height: 20,),
                  BlockSelected(key: samediKey, texte: "Samedi", width: 118,),
                  SizedBox(height: 20,),
                  BlockSelected(key: dimancheKey, texte: "Dimanche", width: 118,),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 30,),
        const Text("Nombre de passage", style: TextStyle(color: textColorGrey,fontSize: 15, fontWeight: FontWeight.bold),),
        const SizedBox(height: 30,),
        Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: MediaQuery.of(context).size.width - 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24)
          ),
          child: DropdownButton<String>(
            value: nbreDePassage,
            isExpanded: true,
            icon: const Icon(Icons.keyboard_arrow_down, size: 28,),
            elevation: 16,
            style: const TextStyle(color: textColorGrey, fontSize: 16),
            underline: Container(
              height: 2,
              color: Colors.transparent,
            ),
            onChanged: (String? newValue) {
              setState(() {
                nbreDePassage = newValue!;
              });
            },
            items: <String>['1', '2', '3', '4', '5','6']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 45,),
        const Text("Heure de passage", style: TextStyle(color: textColorGrey,fontSize: 15, fontWeight: FontWeight.bold),),
        const SizedBox(height: 20,),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 14),
          height: 370,
          decoration: BoxDecoration(
              color: const Color(0xFFF3F3FF),//Colors.white,
              borderRadius: BorderRadius.circular(10)
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children:  [
                    BlockSelected(key: huitKey, texte: "08h-9h", width: 100,),
                    SizedBox(height: 20,),
                    BlockSelected(key: neufKey,texte: "09h-10h", width: 100,),
                    SizedBox(height: 20,),
                    BlockSelected(key: dixKey,texte: "10h-11h", width: 100,),
                    SizedBox(height: 20,),
                    BlockSelected(key: onzeKey,texte: "11h-12h", width: 100,),
                    SizedBox(height: 20,),
                    BlockSelected(key: douzeKey,texte: "12h-13h", width: 100,),
                  ],
                ),
                Column(
                  children:  [
                    BlockSelected(key: treizeKey,texte: "13h-14h", width: 100,),
                    SizedBox(height: 20,),
                    BlockSelected(key: quatorzeKey,texte: "14h-15h", width: 100,),
                    SizedBox(height: 20,),
                    BlockSelected(key: quinzeKey,texte: "15h-16h", width: 100,),
                    SizedBox(height: 20,),
                    BlockSelected(key: seizeKey,texte: "16h-17h", width: 100,),
                    SizedBox(height: 20,),
                    BlockSelected(key: dixSeptKey,texte: "17h-18h", width: 100,),
                  ],
                ),
              ],
            ),
          )
        ),

      ],
    );
  }

  Widget _accueilButton() {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: const Color(0xFFDEDEDE),
        ),
        width: 104,
        height: 48,
        child: const Center(child: Text("Accueil", style: TextStyle(color: Colors.black),),),
    );
  }

  Widget _encaissementBouton() {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: const Color(0xFFC24644),
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[
                Color(0xFFC24644),
                Color(0xFF8F1716)
              ], // red to yellow
              tileMode: TileMode.repeated, // repeats the gradient over the canvas
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0xFFBEBEBE),
                blurRadius: 7,
                offset: Offset(0,3),
              )
            ]
        ),
        width: 231,
        height: 48,
        child: const Center(child: Text("Démarrer un encaissement", style: TextStyle(color: Colors.white),),)
    );
  }

}