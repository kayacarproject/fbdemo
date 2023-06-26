import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fbdemo/model/banner_model.dart';
import 'package:fbdemo/util/localizations.dart';
import 'package:fbdemo/view/home/homepage.dart';
import 'package:fbdemo/view/localization/lang_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'bloc/loclization/language_bloc.dart';
import 'bloc/loclization/language_state.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
        providers: [
          //
          //  Language Bloc
          //
          BlocProvider(
            create: (context) => LanguageBloc(),
          )
        ],
        child: BlocBuilder<LanguageBloc, LanguageState>(
          // Condition for rebuilding of the widgets
          buildWhen: (previousState, currentState) =>
          previousState != currentState,

          builder: (_, state) {
            return MaterialApp(
              localizationsDelegates: const [
                AppLocalizationsDelegate(),
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: const [Locale('en', 'IN'), Locale('ar', "AE")],
              localeResolutionCallback:
                  (Locale? locale, Iterable<Locale> supportedLocales) {
                for (Locale supportedLocale in supportedLocales) {
                  if (supportedLocale.languageCode == locale!.languageCode ||
                      supportedLocale.countryCode == locale.countryCode) {
                    return supportedLocale;
                  }
                }
                return supportedLocales.first;
              },
              locale: Locale(state.locale.code, state.locale.value),
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              builder: EasyLoading.init(),
              // home: MyHomePage1(title: 'FB Demo'),
              // home:   HomePage(),
              // home:   LangScreen(),
              home:  LangScreen(),
            );
          },
        ),
    );

  }
}

/*class MyHomePage1 extends StatefulWidget {
  const MyHomePage1({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage1> createState() => _MyHomePageState1();
}

class _MyHomePageState1 extends State<MyHomePage1> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // List<Map<String, dynamic>> documents = [];
  List<BannerModel> bannerList = [];
  int _currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      firestore.collection('tblBanner').snapshots().listen((event) {
        // print("=-=->${event.docs.length}");
        bannerList.clear();
        for (var element in event.docs) {
          BannerModel model = BannerModel.fromJson(element.data());
          // print("model.imgUrl=-=->${model.imgUrl}");
          setState(() {
            if (model.isDeleted == "false") bannerList.add(model);
          });
        }
      });
    } catch (e) {
      // print('Error retrieving data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('FB Demo'),
        ),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 220.0,
                //220
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                viewportFraction: 0.92, //0.8
                // enlargeCenterPage: true,
                //scrollDirection: Axis.vertical,
                onPageChanged: (index, reason) {
                  setState(
                    () {
                      _currentIndex = index;
                    },
                  );
                },
              ),
              items: bannerList
                  .map(
                    (item) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        margin: const EdgeInsets.only(
                          top: 10.0,
                          bottom: 10.0,
                        ),
                        elevation: 3.0,
                        // shadowColor: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(30.0),
                          ),
                          child: Image.network(
                            item.imgUrl.toString(),
                            fit: BoxFit.fill,
                            width: double.infinity,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: bannerList.map((urlOfItem) {
                  int index = bannerList.indexOf(urlOfItem);
                  return Container(
                    width: 10.0,
                    height: 10.0,
                    margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentIndex == index
                          ? Colors.white
                          : Colors.black26,
                    ),
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}*/


