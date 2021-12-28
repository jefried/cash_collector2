import 'package:cash_collector/pages/details_compte.dart';
import 'package:cash_collector/pages/home.dart';
import 'package:flutter/material.dart';

class Connexion extends StatefulWidget {
  const Connexion({Key? key}) : super(key: key);

  @override
  ConnexionState createState() => ConnexionState();

}

class ConnexionState extends State<Connexion> {
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  String number = '';
  String mdp = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 150,
              child: Stack(
                children: [
                  Positioned(
                    top: -65,
                    right: -2,
                    child: Image(image: const AssetImage('assets/connexion/ellipse.png'), fit: BoxFit.cover, height: 234, width: MediaQuery.of(context).size.width +20,),
                  ),

                ],
              ),
            ),
            const SizedBox(height: 37,),
            Container(
              padding: const EdgeInsets.only(left: 24, right: 25),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Connexion", style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),),
                  const Text("Connectez vous et démarrez votre activité", style: TextStyle(fontSize: 12),),
                  Divider(thickness: 2, indent: 0, endIndent: MediaQuery.of(context).size.width-85, color: const Color(0xFFC24644),),
                  const SizedBox(height: 20,),
                  Form(
                    key: loginFormKey,
                    child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.phone, size: 20, color: Colors.grey),
                          label: Text('Numéro de téléphone', style: TextStyle(fontSize: 14, color: Colors.black),),
                        ),
                        onSaved: (String? value) {
                          if (value!=null) {
                            number = value;
                          }
                        },
                        validator: (String? value) {
                          return (value !=null && value.length<9) ? 'le numéro doit avoir au moins 9 chiffres' : null;
                        },
                      ),
                      const SizedBox(height: 20,),
                      TextFormField(
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.lock, size: 20, color: Colors.grey),
                          label: Text('Mot de passe', style: TextStyle(fontSize: 14, color: Colors.black),),
                          focusColor: Color(0xFFC24644),
                        ),
                        onSaved: (String? value) {
                          if (value!=null) {
                            mdp = value;
                          }
                        },
                        validator: (String? value) {
                          return (value!= null && value.length <6) ? 'Le mot de passe doit avoir au moins ' : null;
                        },
                      ),
                    ],
                  ))
                ],
              ),
            ),
            const SizedBox(height: 50,),
            InkWell(
              onTap: () {
                if(loginFormKey.currentState!.validate()){
                  loginFormKey.currentState!.save();
                }
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Home()), (route)=>false);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFFC24644),
                ),
                width: 207,
                height: 43,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("Continuer", style: TextStyle(color: Colors.white),),
                    SizedBox(width: 10,),
                    Icon(Icons.arrow_forward,size: 18, color: Colors.white,),
                  ],
                ),
              ),
            ),
            Container(
              height: 315,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/connexion/forêt.png'),
                )
              ),
            )
          ],
        )
      )
    );
  }

}