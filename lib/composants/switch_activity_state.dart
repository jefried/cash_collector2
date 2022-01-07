import 'package:cash_collector/composants/time_counter.dart';
import 'package:cash_collector/helpers/colors.dart';
import 'package:cash_collector/provider/app_bar_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';

class SwitchActivity extends StatefulWidget {
  const SwitchActivity({Key? key}) : super(key: key);

  @override
  _SwitchActivityStateState createState() => _SwitchActivityStateState();
}

class _SwitchActivityStateState extends State<SwitchActivity> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppBarModel appBarModel = Provider.of<AppBarModel>(context);
    bool isToggleOn = appBarModel.startedActivity;

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        children: [
          SizedBox(
            child: FlutterSwitch(
              height: 22,
              width: 54,
              padding: 3,
              valueFontSize: 13,
              toggleSize: 16,
              value: isToggleOn,
              onToggle: (value) {
                  if (value){
                    appBarModel.setStartedActivity(value);
                  }
                  else{
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          contentPadding: const EdgeInsets.fromLTRB(6, 4, 6, 0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14)
                          ),
                          title: const Text(
                            'Clôture de la journée',
                            textAlign: TextAlign.left,

                          ),
                          titlePadding: const EdgeInsets.only(top: 16, left: 18),
                          titleTextStyle: const TextStyle(
                            fontFamily: 'Poppins Light',
                            fontSize: 16,
                            color: infosColor1,
                          ),
                          content: SizedBox(
                            height: 100,
                            child: Column(
                              children: [
                                Divider(
                                  color: infosColor1.withOpacity(0.5),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                  child: Text(
                                    'Voulez-vous vraiment clôturer la journée ?',
                                    style: const TextStyle(
                                        fontFamily: 'Poppins Medium',
                                        fontSize: 14.5,
                                        color: colorText1
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            Container(
                              height: 45,
                              width: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  border: Border.all(
                                      color: infosColor1
                                  )
                              ),
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24)
                                ),
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true).pop();
                                },
                                child: Center(
                                  child: Text(
                                    'Annuler',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontFamily: 'Poppins Light',
                                        fontSize: 12.5,
                                        color: infosColor1
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 45,
                              width: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  gradient: const LinearGradient(
                                      colors: [
                                        secondaryColor,
                                        principalColor
                                      ]
                                  )
                              ),
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24)
                                ),
                                onPressed: () {
                                  appBarModel.stopTimer();
                                  Navigator.of(context, rootNavigator: true).pop();
                                },
                                child: Center(
                                  child: Text(
                                    'Clôturer',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontFamily: 'Poppins Light',
                                        fontSize: 12.5,
                                        color: Colors.white
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                          actionsAlignment: MainAxisAlignment.end,
                          actionsPadding: const EdgeInsets.only(bottom: 16, right: 16),
                        );
                      }
                    );
                  }
              },
              showOnOff: true,
              // inactiveToggleColor: Colors.grey,
              // activeToggleColor: const Color(0xFF35CC3F),
              activeColor: const Color(0xFF0EAE18),
            ),
          ),
          TimeCounter()
        ],
      ),
    );
  }
}
