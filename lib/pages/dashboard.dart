import 'package:cash_collector/composants/app_bar_content.dart';
import 'package:cash_collector/composants/block_button.dart';
import 'package:cash_collector/style/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> with SingleTickerProviderStateMixin{
  final List<charts.Series<LinearSales, int>> seriesList = _createSampleData();
  List<charts.Series<Task, String>> _seriesPieData = [];
  final bool animate = true;
  final double solde = 540000;
  final String dateJour = "09 Dec 2021";
  final String dateSemaine = "09-14 Dec 2021";
  final String dateMois = "Dec 2021";
  final double montantCollecteJour = 540000;
  final double montantCollecteSemaine = 2500000;
  final double montantCollecteMois = 9000000;
  final double resteACollecterJour = 120000;
  final double resteACollecterSemaine = 600000;
  final double resteACollecterMois = 2400000;
  final nbreCollecteJour = 35;
  final nbreCollecteSemaine = 100;
  final nbreCollecteMois = 400;
  final List<Collecte> collectes = [
    Collecte(noms: "Ondua Jacqueline", montant: 10000, modePayment: "MTN Mobile Money"),
    Collecte(noms: "Ondua Jacqueline", montant: 10000, modePayment: "MTN Mobile Money"),
    Collecte(noms: "Ondua Jacqueline", montant: 10000, modePayment: "MTN Mobile Money"),
    Collecte(noms: "Ondua Jacqueline", montant: 10000, modePayment: "MTN Mobile Money"),
    Collecte(noms: "Ondua Jacqueline", montant: 10000, modePayment: "MTN Mobile Money"),
    Collecte(noms: "Ondua Jacqueline", montant: 10000, modePayment: "MTN Mobile Money"),
    Collecte(noms: "Ondua Jacqueline", montant: 10000, modePayment: "MTN Mobile Money"),
    Collecte(noms: "Ondua Jacqueline", montant: 10000, modePayment: "MTN Mobile Money"),
    Collecte(noms: "Ondua Jacqueline", montant: 10000, modePayment: "MTN Mobile Money"),
    Collecte(noms: "Ondua Jacqueline", montant: 10000, modePayment: "MTN Mobile Money"),
  ];

  _generateData() {
    List<Task> mydata = <Task>[
      Task("45%", 45, "0xFFEF5350", "Agroalimentaire"),
      Task("5%", 5, "0xFF707070", "Commerce"),
      Task("3%", 3, "0xFF8F1716", "H??bergement"),
      Task("18%", 27, "0xFF35CC3F", "Sant??"),
      Task("20%", 20, "0xFF2699FB", "Restauration"),

    ];
    _seriesPieData = <charts.Series<Task, String>>[];
    _seriesPieData.add(
      charts.Series(
        domainFn: (Task task, _) => task.taskTitle,
        measureFn: (Task task, _) => task.taskVal,
        colorFn: (Task task, _) => charts.ColorUtil.fromDartColor(Color(int.parse(task.colorVal))),
        id: 'tasks',
        data: mydata,
        labelAccessorFn: (Task row, _) => "${row.taskDetails}"
      ),
    );
  }

  bool workStatus = true;
  late TabController tabController;
  int currentIndex = 0;

  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final desktopSalesData = [
      LinearSales(0, 5),
      LinearSales(1, 25),
      LinearSales(20, 100),
      LinearSales(23, 75),
    ];

    final tableSalesData = [
      LinearSales(0, 10),
      LinearSales(13, 50),
      LinearSales(20, 200),
      LinearSales(24, 150),
    ];

    return [
      charts.Series<LinearSales, int>(
        id: 'Collecte',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: desktopSalesData,
      ),
      charts.Series<LinearSales, int>(
        id: 'ResteACollecter',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: tableSalesData,
      ),
    ];
  }
  @override
  void initState() {
    super.initState();
    _generateData();
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      setState(() {
        currentIndex = tabController.index;
      });
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(57),
        child: AppBarContent(
          title: "Dashboard",
          icon: Icons.arrow_back_ios,
          onPressBtnMenu: (){Navigator.pop(context);},
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height - 72,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            color: Color(0xFFF3F3FF),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(29),
              topRight: Radius.circular(29),
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20,),
                    Row(
                      children: [
                        const SizedBox(width: 20,),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Votre solde", style: TextStyle(color: textColorGreyAccent, fontSize: 14),),
                              Text("XAF ${solde.toString()}", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),)
                            ],
                          ),
                        ),
                        const BlockButton(text: "Transf??rer", linear: true, foregroundColor: Colors.white,),
                        const SizedBox(width: 20,),
                      ],
                    ),
                    const SizedBox(height: 15,),
                    const Divider(indent: 20, endIndent: 20,),
                    const SizedBox(height: 15,),
                    const Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text("Activit??s", style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.w400),),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      height: 1270,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(topRight: Radius.circular(29), topLeft: Radius.circular(29))
                      ),
                      child: DefaultTabController(
                          length: 3,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 8,),
                              TabBar(
                                labelColor: textColorGrey,
                                unselectedLabelColor: textColorGreyAccent,
                                controller: tabController,
                                indicator: const UnderlineTabIndicator(
                                    borderSide: BorderSide(width: 3.0, color: Color(0xFF075BD5)),
                                    insets: EdgeInsets.symmetric(horizontal: 40.0)
                                ),
                                tabs: const [
                                  Tab(text: "Jour",),
                                  Tab(text: "Semaine",),
                                  Tab(text: "Mois",),
                                ],
                              ),
                              Expanded(
                                child: TabBarView(
                                  controller: tabController,
                                  children: [
                                    _jour(),
                                    _semaine(),
                                    _mois(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                      ),

                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _jour() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(width: 15,),
              Text(nbreCollecteJour.toString(), style: TextStyle(color: Color(0xFFFFC700), fontSize: 25),),
              SizedBox(width: 5,),
              Text("Collectes", style: TextStyle(fontSize: 16, color: textColorGrey),),
              Expanded(child: SizedBox(),),
              Text(dateJour.toString(), style: TextStyle(fontSize: 16, color: textColorGrey),),
              SizedBox(width: 15,),
            ],
          ),
          const SizedBox(height: 15,),
          Container(
            height: 444,
            width: MediaQuery.of(context).size.width - 10,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xFFBEBEBE),
                    blurRadius: 6,
                    offset: Offset(0,3),
                  )
                ]
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15,),
                Row(
                  children: [
                    SizedBox(width: 10,),
                    _block(Color(0xFF7BB1FF),"Collect??", montantCollecteJour.toString(), Icons.arrow_circle_down),
                    Expanded(child: Container()),
                    _block(Color(0xFFF86B6D),"Reste ?? Collecter", resteACollecterJour.toString(), Icons.arrow_circle_up),
                    SizedBox(width: 10,),
                  ],
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: charts.NumericComboChart(seriesList,
                        animate: animate,
                        // Configure the default renderer as a line renderer. This will be used
                        // for any series that does not define a rendererIdKey.
                        defaultRenderer: new charts.LineRendererConfig(),
                        // Custom renderer configuration for the point series.
                        customSeriesRenderers: [
                          charts.PointRendererConfig(
                            // ID used to link series to this renderer.
                              customRendererId: 'customPoint')
                        ]),
                  )
                )
              ],
            ),
          ),
          const SizedBox(height: 30,),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text("Taux de collecte par secteur", style: TextStyle(fontSize: 20),),
          ),
          const SizedBox(height: 20,),
          Container(
            height: 420,
            width: MediaQuery.of(context).size.width - 10,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xFFBEBEBE),
                    blurRadius: 6,
                    offset: Offset(0,3),
                  )
                ]
            ),
            child: charts.PieChart<String>(_seriesPieData,
                animate: animate,
                animationDuration: Duration(seconds: 1),
                behaviors: [
                  charts.DatumLegend(
                    outsideJustification:
                      charts.OutsideJustification.endDrawArea,
                    horizontalFirst: false,
                    desiredMaxRows: 3,
                    cellPadding: const EdgeInsets.only(right: 35.0, bottom: 4.0, top: 10.0),
                    entryTextStyle: const charts.TextStyleSpec(
                      color: charts.MaterialPalette.black,
                      fontFamily: 'Georgia',
                      fontSize: 12,
                    )
                  )
                ],
                // Configure the width of the pie slices to 60px. The remaining space in
                // the chart will be left as a hole in the center.
                defaultRenderer: charts.ArcRendererConfig(
                  arcWidth: 30,
                  arcRendererDecorators: [
                    charts.ArcLabelDecorator(
                      labelPosition: charts.ArcLabelPosition.inside
                    )
                  ]
                )),
          ),
          SizedBox(height: 30,),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              "Collectes r??centes",
              style: TextStyle(
                fontSize: 20
              ),
            ),
          ),
          SizedBox(height: 20,),
          Container(
            height: 90,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: collectes.length,
                itemBuilder: (BuildContext context,int index){
                  return _collecte(collectes[index]);
                }
            ),
          )
        ],
      ),
    );
  }

  Widget _semaine() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(width: 15,),
              Text(nbreCollecteSemaine.toString(), style: TextStyle(color: Color(0xFFFFC700), fontSize: 25),),
              SizedBox(width: 5,),
              Text("Collectes", style: TextStyle(fontSize: 16, color: textColorGrey),),
              Expanded(child: SizedBox(),),
              Text(dateSemaine.toString(), style: TextStyle(fontSize: 16, color: textColorGrey),),
              SizedBox(width: 15,),
            ],
          ),
          const SizedBox(height: 15,),
          Container(
            height: 444,
            width: MediaQuery.of(context).size.width - 10,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xFFBEBEBE),
                    blurRadius: 6,
                    offset: Offset(0,3),
                  )
                ]
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15,),
                Row(
                  children: [
                    SizedBox(width: 10,),
                    _block(Color(0xFF7BB1FF),"Collect??", montantCollecteSemaine.toString(), Icons.arrow_circle_down),
                    Expanded(child: Container()),
                    _block(Color(0xFFF86B6D),"Reste ?? Collecter", resteACollecterSemaine.toString(), Icons.arrow_circle_up),
                    SizedBox(width: 10,),
                  ],
                ),
                Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: charts.NumericComboChart(seriesList,
                          animate: animate,
                          // Configure the default renderer as a line renderer. This will be used
                          // for any series that does not define a rendererIdKey.
                          defaultRenderer: new charts.LineRendererConfig(),
                          // Custom renderer configuration for the point series.
                          customSeriesRenderers: [
                            charts.PointRendererConfig(
                              // ID used to link series to this renderer.
                                customRendererId: 'customPoint')
                          ]),
                    )
                )
              ],
            ),
          ),
          const SizedBox(height: 30,),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text("Taux de collecte par secteur", style: TextStyle(fontSize: 20),),
          ),
          const SizedBox(height: 20,),
          Container(
            height: 420,
            width: MediaQuery.of(context).size.width - 10,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xFFBEBEBE),
                    blurRadius: 6,
                    offset: Offset(0,3),
                  )
                ]
            ),
            child: charts.PieChart<String>(_seriesPieData,
                animate: animate,
                animationDuration: Duration(seconds: 1),
                behaviors: [
                  charts.DatumLegend(
                      outsideJustification:
                      charts.OutsideJustification.endDrawArea,
                      horizontalFirst: false,
                      desiredMaxRows: 3,
                      cellPadding: const EdgeInsets.only(right: 35.0, bottom: 4.0, top: 10.0),
                      entryTextStyle: const charts.TextStyleSpec(
                          color: charts.MaterialPalette.black,
                          fontFamily: 'Georgia',
                          fontSize: 12
                      )
                  )
                ],
                // Configure the width of the pie slices to 60px. The remaining space in
                // the chart will be left as a hole in the center.
                defaultRenderer: charts.ArcRendererConfig(
                    arcWidth: 30,
                    arcRendererDecorators: [
                      charts.ArcLabelDecorator(
                          labelPosition: charts.ArcLabelPosition.inside
                      )
                    ]
                )),
          ),
          SizedBox(height: 30,),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              "Collectes r??centes",
              style: TextStyle(
                  fontSize: 20
              ),
            ),
          ),
          SizedBox(height: 20,),
          Container(
            height: 90,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: collectes.length,
                itemBuilder: (BuildContext context,int index){
                  return _collecte(collectes[index]);
                }
            ),
          )
        ],
      ),
    );
  }

  Widget _mois() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(width: 15,),
              Text(nbreCollecteMois.toString(), style: TextStyle(color: Color(0xFFFFC700), fontSize: 25),),
              SizedBox(width: 5,),
              Text("Collectes", style: TextStyle(fontSize: 16, color: textColorGrey),),
              Expanded(child: SizedBox(),),
              Text(dateMois.toString(), style: TextStyle(fontSize: 16, color: textColorGrey),),
              SizedBox(width: 15,),
            ],
          ),
          const SizedBox(height: 15,),
          Container(
            height: 444,
            width: MediaQuery.of(context).size.width - 10,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xFFBEBEBE),
                    blurRadius: 6,
                    offset: Offset(0,3),
                  )
                ]
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15,),
                Row(
                  children: [
                    SizedBox(width: 10,),
                    _block(Color(0xFF7BB1FF),"Collect??", montantCollecteMois.toString(), Icons.arrow_circle_down),
                    Expanded(child: Container()),
                    _block(Color(0xFFF86B6D),"Reste ?? Collecter", resteACollecterMois.toString(), Icons.arrow_circle_up),
                    SizedBox(width: 10,),
                  ],
                ),
                Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: charts.NumericComboChart(seriesList,
                          animate: animate,
                          // Configure the default renderer as a line renderer. This will be used
                          // for any series that does not define a rendererIdKey.
                          defaultRenderer: new charts.LineRendererConfig(),
                          // Custom renderer configuration for the point series.
                          customSeriesRenderers: [
                            charts.PointRendererConfig(
                              // ID used to link series to this renderer.
                                customRendererId: 'customPoint')
                          ]),
                    )
                )
              ],
            ),
          ),
          const SizedBox(height: 30,),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text("Taux de collecte par secteur", style: TextStyle(fontSize: 20),),
          ),
          const SizedBox(height: 20,),
          Container(
            height: 420,
            width: MediaQuery.of(context).size.width - 10,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xFFBEBEBE),
                    blurRadius: 6,
                    offset: Offset(0,3),
                  )
                ]
            ),
            child: charts.PieChart<String>(_seriesPieData,
                animate: animate,
                animationDuration: Duration(seconds: 1),
                behaviors: [
                  charts.DatumLegend(
                      outsideJustification:
                      charts.OutsideJustification.endDrawArea,
                      horizontalFirst: false,
                      desiredMaxRows: 3,
                      cellPadding: const EdgeInsets.only(right: 35.0, bottom: 4.0, top: 10.0),
                      entryTextStyle: const charts.TextStyleSpec(
                          color: charts.MaterialPalette.black,
                          fontFamily: 'Georgia',
                          fontSize: 12
                      )
                  )
                ],
                // Configure the width of the pie slices to 60px. The remaining space in
                // the chart will be left as a hole in the center.
                defaultRenderer: charts.ArcRendererConfig(
                    arcWidth: 30,
                    arcRendererDecorators: [
                      charts.ArcLabelDecorator(
                          labelPosition: charts.ArcLabelPosition.inside
                      )
                    ]
                )),
          ),
          SizedBox(height: 30,),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              "Collectes r??centes",
              style: TextStyle(
                  fontSize: 20
              ),
            ),
          ),
          SizedBox(height: 20,),
          Container(
            height: 90,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: collectes.length,
                itemBuilder: (BuildContext context,int index){
                  return _collecte(collectes[index]);
                }
            ),
          )
        ],
      ),
    );
  }

  Widget _block(Color color, String title, String montant, IconData icon) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 40,),
        SizedBox(width: 5,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(color: textColorGreyAccent), overflow: TextOverflow.ellipsis,),
            SizedBox(height: 3,),
            Text("XAF  " + montant, style: TextStyle(color: textColorGrey), overflow: TextOverflow.ellipsis,),
          ],
        )
      ],
    );
  }

  Widget _collecte(Collecte collecte) {
    return Container(
      width: 235,
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Color(0xFFBEBEBE),
              blurRadius: 6,
              offset: Offset(0,3),
            )
          ]
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 67,
            width: 67,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(17)),
              image: DecorationImage(
                image: AssetImage("assets/details_compte/profil.jpg"),
                fit: BoxFit.cover
              )
            ),
          ),
          SizedBox(width: 10,),
          SizedBox(
            width: 145,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  collecte.noms!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: stepperColor,
                  ),
                ),
                SizedBox(height: 3,),
                Text(
                  "XAF" + collecte.montant!.toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: textColorGreyAccent,
                  ),
                ),
                SizedBox(height: 3,),
                Text(
                  collecte.modePayment!.toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: textColorGreyAccent,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}

class Task {
  final int taskVal;
  final String taskDetails;
  final String colorVal;
  final String taskTitle;
  Task(this.taskDetails, this.taskVal, this.colorVal, this.taskTitle);

  Task.fromMap(Map<String, dynamic> map)
    : assert(map['taskdetails'] != null),
      assert(map['taskVal'] != null),
      assert(map['colorVal'] != null),
      assert(map['taskTitle'] != null),
      taskDetails = map['taskdetails'],
      taskVal = map['taskVal'],
      colorVal = map['colorVal'],
      taskTitle = map['taskTitle'];

  @override
  String toString() {
    // TODO: implement toString
    return "Record<$taskVal:$taskDetails>";
  }
}

class Collecte {
  String? noms;
  double? montant;
  String? modePayment;

  Collecte({this.noms, this.montant, this.modePayment});
}