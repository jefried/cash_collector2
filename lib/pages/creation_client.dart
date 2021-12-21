import 'package:cash_collector/composants/app_bar_content.dart';
import 'package:cash_collector/composants/card_photo_pick.dart';
import 'package:cash_collector/composants/block_button.dart';
import 'package:cash_collector/composants/block_select.dart';
import 'package:cash_collector/composants/circular_button.dart';
import 'package:cash_collector/pages/encaissement.dart';
import 'package:cash_collector/pages/home.dart';
import 'package:cash_collector/pages/mon_compte.dart';
import 'package:cash_collector/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';

class CreationClient extends StatefulWidget {
  const CreationClient({Key? key}) : super(key: key);

  @override
  CreationClientState createState() => CreationClientState();
}

class CreationClientState extends State<CreationClient> {
  bool workStatus = true;
  int activeStep = 0;
  int upperBound = 4;
  String nbreDePassage = "1";

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
                        setState(() {
                          activeStep++;
                        });
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
    ): Center(child: Image(image: AssetImage("assets/encaissement/check.png"),));
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

  Widget formInfoBasique() {
    return Form(
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                label: Text('Noms', style: TextStyle(fontSize: 14, color: Colors.black),),
              ),
              onSaved: (String? value) {
                if (value!=null) {
                }
              },
              validator: (String? value) {
                return (value !=null && value.length<9) ? 'le numéro doit avoir au moins 9 chiffres' : null;
              },
            ),
            const SizedBox(height: 20,),
            TextFormField(
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                label: Text('Prénoms', style: TextStyle(fontSize: 14, color: Colors.black),),
              ),
              onSaved: (String? value) {
                if (value!=null) {
                }
              },
              validator: (String? value) {
                return (value !=null && value.length<9) ? 'le numéro doit avoir au moins 9 chiffres' : null;
              },
            ),
            const SizedBox(height: 20,),
            TextFormField(
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                label: Text('Secteur d\'activité', style: TextStyle(fontSize: 14, color: Colors.black),),
              ),
              onSaved: (String? value) {
                if (value!=null) {
                }
              },
              validator: (String? value) {
                return (value !=null && value.length<9) ? 'le numéro doit avoir au moins 9 chiffres' : null;
              },
            ),
            const SizedBox(height: 20,),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                label: Text('Téléphone', style: TextStyle(fontSize: 14, color: Colors.black),),
              ),
              onSaved: (String? value) {
                if (value!=null) {
                }
              },
              validator: (String? value) {
                return (value !=null && value.length<9) ? 'le numéro doit avoir au moins 9 chiffres' : null;
              },
            ),
            const SizedBox(height: 20,),
            SizedBox(
              height: 70,
              child: Stack(
                children: [
                  Positioned(
                      top: 0,
                      left: 0,
                      child: SizedBox(
                        height: 80,
                        width: MediaQuery.of(context).size.height - 40,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          enabled: false,
                          decoration: const InputDecoration(
                            label: Text('Localisation', style: TextStyle(fontSize: 14, color: Colors.black),),
                          ),
                          onSaved: (String? value) {
                            if (value!=null) {
                            }
                          },
                          validator: (String? value) {
                            return (value !=null && value.length<9) ? 'le numéro doit avoir au moins 9 chiffres' : null;
                          },
                        ),
                      )
                  ),
                  Positioned(
                    top: 15,
                    right: 0,
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> MonCompte()));
                      },
                      child: const CircularButton(icon: Icons.my_location, size: 32, sizeIcon: 20, foregroundColor: Colors.black,),
                    )
                  )
                ],
              ),
            )
          ],
        )
    );
  }

  Widget formPersonneAContacter() {
    return Form(
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                label: Text('Noms', style: TextStyle(fontSize: 14, color: Colors.black),),
              ),
              onSaved: (String? value) {
                if (value!=null) {
                }
              },
              validator: (String? value) {
                return (value !=null && value.length<9) ? 'le numéro doit avoir au moins 9 chiffres' : null;
              },
            ),
            const SizedBox(height: 20,),
            TextFormField(
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                label: Text('Prénoms', style: TextStyle(fontSize: 14, color: Colors.black),),
              ),
              onSaved: (String? value) {
                if (value!=null) {
                }
              },
              validator: (String? value) {
                return (value !=null && value.length<9) ? 'le numéro doit avoir au moins 9 chiffres' : null;
              },
            ),
            const SizedBox(height: 20,),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                label: Text('Téléphone', style: TextStyle(fontSize: 14, color: Colors.black),),
              ),
              onSaved: (String? value) {
                if (value!=null) {
                }
              },
              validator: (String? value) {
                return (value !=null && value.length<9) ? 'le numéro doit avoir au moins 9 chiffres' : null;
              },
            ),
          ],
        )
    );
  }

  Widget formPhotos() {
    return Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                label: Text('Numéro CNI', style: TextStyle(fontSize: 14, color: Colors.black),),
              ),
              onSaved: (String? value) {
                if (value!=null) {
                }
              },
              validator: (String? value) {
                return (value !=null && value.length<9) ? 'le numéro doit avoir au moins 9 chiffres' : null;
              },
            ),
            const SizedBox(height: 30,),
            const Text('Photos de la CNI (recto)', style: TextStyle(fontSize: 14, color: Colors.black),),
            const SizedBox(height: 20,),
            CardPhotoPick(width: MediaQuery.of(context).size.width - 40,),
            const SizedBox(height: 30,),
            const Text('Photos de la CNI (verso)', style: TextStyle(fontSize: 14, color: Colors.black),),
            const SizedBox(height: 20,),
            CardPhotoPick(width: MediaQuery.of(context).size.width - 40,),
            const SizedBox(height: 30,),
            const Text('Photos du gérant', style: TextStyle(fontSize: 14, color: Colors.black),),
            const SizedBox(height: 20,),
            CardPhotoPick(width: MediaQuery.of(context).size.width - 40,),
            const SizedBox(height: 30,),
            const Text('Photos du lieu', style: TextStyle(fontSize: 14, color: Colors.black),),
            const SizedBox(height: 20,),
            CardPhotoPick(width: MediaQuery.of(context).size.width - 40,),
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => Encaissement()));
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
                children: const [
                  BlockSelected(texte: "Lundi", width: 118,),
                  SizedBox(height: 20,),
                  BlockSelected(texte: "Mardi", width: 118,),
                  SizedBox(height: 20,),
                  BlockSelected(texte: "Mercredi", width: 118,),
                  SizedBox(height: 20,),
                  BlockSelected(texte: "Jeudi", width: 118,),
                ],
              ),
              Column(
                children: const [
                  BlockSelected(texte: "Vendredi", width: 118,),
                  SizedBox(height: 20,),
                  BlockSelected(texte: "Samedi", width: 118,),
                  SizedBox(height: 20,),
                  BlockSelected(texte: "Dimanche", width: 118,),
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
                  children: const [
                    BlockSelected(texte: "08h-9h", width: 100,),
                    SizedBox(height: 20,),
                    BlockSelected(texte: "09h-10h", width: 100,),
                    SizedBox(height: 20,),
                    BlockSelected(texte: "10h-11h", width: 100,),
                    SizedBox(height: 20,),
                    BlockSelected(texte: "11h-12h", width: 100,),
                    SizedBox(height: 20,),
                    BlockSelected(texte: "12h-13h", width: 100,),
                    SizedBox(height: 20,),
                    BlockSelected(texte: "13h-14h", width: 100,),
                  ],
                ),
                Column(
                  children: const [
                    BlockSelected(texte: "14h-15h", width: 100,),
                    SizedBox(height: 20,),
                    BlockSelected(texte: "15h-16h", width: 100,),
                    SizedBox(height: 20,),
                    BlockSelected(texte: "16h-17h", width: 100,),
                    SizedBox(height: 20,),
                    BlockSelected(texte: "17h-18h", width: 100,),
                    SizedBox(height: 20,),
                    BlockSelected(texte: "18h-19h", width: 100,),
                    SizedBox(height: 20,),
                    BlockSelected(texte: "19h-20h", width: 100,),
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