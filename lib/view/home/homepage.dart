import 'package:carousel_slider/carousel_slider.dart';
import 'package:fbdemo/model/banner_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../bloc/home/app_blocs.dart';
import '../../bloc/home/app_events.dart';
import '../../bloc/home/app_states.dart';
import '../../model/tbl_model.dart';
import '../../repo/repositories.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  // final String title;

  @override
  State<HomePage> createState() => MyHomePageState1();
}

class MyHomePageState1 extends State<HomePage> {
// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

  int _currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("initState");

    // UserBloc(UserRepository(),)..add(LoadTblEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (BuildContext context) => UserBloc(UserRepository()),
        ),
        BlocProvider<TblBloc>(
          create: (BuildContext context) => TblBloc(UserRepository()),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: const Text('The BloC App')),
        body: blocBody(),
      ),
    );
  }

  Widget blocBody() {
    return Column(
      children: [
        BlocProvider(
          create: (context) => UserBloc(
            UserRepository(),
          )..add(LoadUserEvent()),
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is UserLoadedState) {
                return Stack(
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
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        viewportFraction: 0.92,
                        //0.8
                        // enlargeCenterPage: true,
                        //scrollDirection: Axis.vertical,
                        onPageChanged: (index, reason) {
                          _currentIndex = index;
                          setState(() {});
                        },
                      ),
                      items: state.users
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
                        children: state.users.map((urlOfItem) {
                          int index = state.users.indexOf(urlOfItem);
                          return Container(
                            width: 10.0,
                            height: 10.0,
                            margin: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 2.0),
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
                );
              }
              if (state is UserErrorState) {
                return const Center(
                  child: Text("Error"),
                );
              }

              return Container(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
        BlocProvider(
          create: (context) => TblBloc(
            UserRepository(),
          )..add(LoadTblEvent()),
          child: BlocBuilder<TblBloc, TblState>(
            builder: (context, state) {
              if (state is TblLoadingState) {
                print("TblLoadingState CircularProgressIndicator");

                // EasyLoading.show();
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is TblLoadedState) {
                // EasyLoading.dismiss();
                List<TblModel> userList = state.tblData;
                print("tblData length =--=>" + userList.length.toString());
                return Expanded(
                  child: ListView.builder(
                      itemCount: userList.length,
                      itemBuilder: (_, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8),
                          child: Card(
                            color: Theme.of(context).primaryColor,
                            child: ListTile(
                              title: Text(
                                '${userList[index].title} ',
                                style: const TextStyle(color: Colors.white),
                              ),
                              subtitle: Text(
                                '${userList[index].date_time}',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        );
                      }),
                );
              }
              if (state is TblErrorState) {
                // EasyLoading.dismiss();
                return const Center(
                  child: Text("Error"),
                );
              }

              return Container();
            },
          ),
        ),
      ],
    );
  }
}
