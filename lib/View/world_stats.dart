import 'package:covid_19_tracker/Models/WorldStatsModel.dart';
import 'package:covid_19_tracker/Services/States_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import 'countries_list.dart';

class WorldStatsScreen extends StatefulWidget {
  const WorldStatsScreen({Key? key}) : super(key: key);

  @override
  State<WorldStatsScreen> createState() => _WorldStatsScreenState();
}

class _WorldStatsScreenState extends State<WorldStatsScreen> with TickerProviderStateMixin {
  late final AnimationController _controller =AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this)..repeat();
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
  final colorList =<Color> [
 const Color(0xff4285f4),
  const Color(0xff1aa260),
  const Color(0xffde5246),
  ];
  @override
  Widget build(BuildContext context) {
     StatesService  statesServices=StatesService();
    return Scaffold(
      body:SafeArea(
        child:Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
             SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
              FutureBuilder(
                  future: statesServices.fetchWorldStatsRecords(),
                  builder: (context,AsyncSnapshot<WorldStatsModel>snapshot){
                if(!snapshot.hasData){
                  return Expanded(flex: 1,
                  child: SpinKitFadingCircle(
                    color: Colors.white,
                    size: 50,
                    controller: _controller,
                  ),);

                }else{
                  return Column(
                    children: [
                      PieChart(dataMap: {
                        "Total":double.parse(snapshot.data!.cases.toString()),
                        "Recovered":double.parse(snapshot.data!.recovered.toString()),
                        "Deaths":double.parse(snapshot.data!.deaths.toString()) ,
                      },
                        chartValuesOptions: const  ChartValuesOptions(
                          showChartValuesInPercentage: true,
                        ),
                        chartRadius: MediaQuery.of(context).size.width/3.2,
                        legendOptions:  const LegendOptions(
                          legendPosition: LegendPosition.left,
                        ),
                        animationDuration:const Duration(milliseconds: 1200),
                        chartType: ChartType.ring,
                        colorList: colorList,),

                      Padding(
                        padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.05),

                        child: Card(
                          child: Column(
                            children: [
                              ReusableRow(title: 'Total', value: snapshot.data!.cases.toString()),
                              ReusableRow(title: 'Recovered', value: snapshot.data!.recovered.toString()),
                              ReusableRow(title: 'Deaths', value: snapshot.data!.deaths.toString()),

                              ReusableRow(title: 'Today Deaths', value: snapshot.data!.todayDeaths.toString()),
                              ReusableRow(title: 'Today Recovered', value: snapshot.data!.todayRecovered.toString()),

                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap:(){
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => CountriesList(),));
                        } ,
                        child: Container(
                          height: 50,
                          decoration:BoxDecoration(
                              color: const Color(0xff1aa260),
                              borderRadius: BorderRadius.circular(10)
                          ) ,
                          child:  const Center(
                            child: Text(
                              'Track Countries',
                            ),
                          ),
                        ),
                      )

                    ],
                  );
                  
                }
              }),



            ],
          ),
        )
            
            
      )
    );
  }
}
class ReusableRow extends StatelessWidget {
  String title,value;
   ReusableRow({Key? key, required this.title,required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:10,right: 10,top: 10,bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(height: 5,),
          Divider(),
        ],
      ),
    );
  }
}

