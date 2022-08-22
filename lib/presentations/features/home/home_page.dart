import 'package:flutter/material.dart';
import 'package:flutter_weather_06072022/data/model/climate.dart';
import 'package:flutter_weather_06072022/data/remote/api/api_service.dart';
import 'package:flutter_weather_06072022/data/repository/climate_repository.dart';
import 'package:flutter_weather_06072022/presentations/features/home/home_controller.dart';
import 'package:flutter_weather_06072022/presentations/features/home/home_event.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => ApiService()),
        ProxyProvider<ApiService, ClimateRepository>(
            update: (context, apiService, climateRepository) {
          climateRepository ??= ClimateRepository();
          climateRepository.updateClimateRepository(apiService: apiService);
          return climateRepository;
        }),
        ProxyProvider<ClimateRepository, HomeController>(
            create: (context) => HomeController(),
            update: (context, repository, controller) {
              controller ??= HomeController();
              controller.updateClimateRepository(climateRepository: repository);
              return controller;
            })
      ],
      child: HomeWeather(),
    );
  }
}

class HomeWeather extends StatelessWidget {
  const HomeWeather({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/backgroundhome.png"),
              fit: BoxFit.cover),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    "Hà Nội",
                    style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w400,
                        color: Colors.white
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    "19°",
                    style: TextStyle(
                        fontSize: 96,
                        fontWeight: FontWeight.w200,
                        color: Colors.white
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    "Mostly Clear",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(235, 235, 245, 06),
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    "H:24°   L:18°",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  width: 390,
                  height: 390,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/House.png"),
                        fit: BoxFit.contain
                    ),
                  ),
                )
              ],
            ),
            Positioned(
              left: 0,
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 260,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/Rectangle.png"),
                      fit: BoxFit.cover
                  ),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(44),
                      topRight: Radius.circular(44)
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.fromLTRB(0, 8, 0, 4),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color.fromRGBO(255, 255, 255, 0.3)
                          )
                        )
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 48,
                            height: 5,
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color.fromRGBO(0, 0, 0, 0.3),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Wrap(
                              alignment: WrapAlignment.spaceAround,
                              children: [
                                Text(
                                  "Hourly Forecast",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromRGBO(235, 235, 245, 0.6)
                                  ),
                                ),
                                Text(
                                  "Weekly Forecast",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Color.fromRGBO(235, 235, 245, 0.6)
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 146,
                      decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(
                                  color: Color.fromRGBO(0, 0, 0, 0.3)
                              )
                          )
                      ),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Container(
                            width: 60,
                            color: Colors.purple[600],
                            child: const Center(child: Text('Item 1', style: TextStyle(fontSize: 18, color: Colors.white),)),
                          ),
                          Container(
                            width: 60,
                            color: Colors.purple[500],
                            child: const Center(child: Text('Item 2', style: TextStyle(fontSize: 18, color: Colors.white),)),
                          ),
                          Container(
                            width: 60,
                            color: Colors.purple[400],
                            child: const Center(child: Text('Item 3', style: TextStyle(fontSize: 18, color: Colors.white),)),
                          ),
                          Container(
                            width: 60,
                            color: Colors.purple[300],
                            child: const Center(child: Text('Item 4', style: TextStyle(fontSize: 18, color: Colors.white),)),
                          ),
                          Container(
                            width: 60,
                            color: Colors.purple[300],
                            child: const Center(child: Text('Item 4', style: TextStyle(fontSize: 18, color: Colors.white),)),
                          ),
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
    );
  }
}

class HomeDemo extends StatefulWidget {
  const HomeDemo({Key? key}) : super(key: key);

  @override
  State<HomeDemo> createState() => _HomeDemoState();
}

class _HomeDemoState extends State<HomeDemo> {
  late HomeController homeController;

  @override
  void initState() {
    super.initState();
    homeController = context.read();
    homeController.eventSink.add(CallDefaultWeatherEvent(cityName: "Hanoi"));
  }

  @override
  Widget build(BuildContext context) {
    print("Build");
    return Scaffold(
        body: Stack(
      alignment: Alignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  homeController.eventSink
                      .add(CallDefaultWeatherEvent(cityName: "London"));
                },
                child: Text("Change")),
            Center(
                child: StreamBuilder<Climate>(
              initialData: null,
              stream: homeController.climateStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                return Text(snapshot.data?.name ?? "");
              },
            )),
          ],
        ),
        StreamBuilder<bool>(
          initialData: false,
          stream: homeController.loadingStream,
          builder: (context, snapshot) {
            if (snapshot.data != null && snapshot.data == true) {
              return CircularProgressIndicator();
            }
            return Container();
          },
        ),
      ],
    ));
  }
}
