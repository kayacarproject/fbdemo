import 'package:carousel_slider/carousel_slider.dart';
import 'package:fbdemo/model/banner_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../bloc/home/app_blocs.dart';
import '../../bloc/home/app_events.dart';
import '../../bloc/home/app_states.dart';
import '../../model/tbl_model.dart';
import '../../repo/repositories.dart';
import '../../util/localizations.dart';
import '../video/video_screen.dart';

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
  bool isErrorShow = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("initState");
    // _scrollController.addListener(_scrollListener);
    // UserBloc(UserRepository(),)..add(LoadTblEvent());
  }

  // ScrollController _scrollController = ScrollController();
  // List<TblModel> userList = [];
  // int LIMIT_PER_PAGE = 5000;
  //
  // late TblBloc tblBloc;

  @override
  void dispose() {
    // _scrollController.removeListener(_scrollListener);
    // _scrollController.dispose();
    super.dispose();
  }

  /*void _scrollListener() {
    if (_scrollController.position.atEdge && _scrollController.position.pixels != 0) {

      print("next page call......");
      callLoadTblEventAgain();
    }
  }

  void callLoadTblEventAgain() {
    print("next page call......callLoadTblEventAgain");
    tblBloc.add(LoadTblEvent(limit: LIMIT_PER_PAGE, list: userList));
    print("next page call......DONE");
  }*/

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (BuildContext context) =>
              UserBloc(UserRepository())..add(LoadUserEvent()),
        ),
        BlocProvider<TblBloc>(
          create: (BuildContext context) =>
              TblBloc(UserRepository())..add(LoadTblEvent()),
        ),
        /* BlocProvider<TblBloc>(
          create: (BuildContext context) {
            tblBloc = TblBloc(UserRepository());
            tblBloc.add(LoadTblEvent(limit: LIMIT_PER_PAGE, list: []));
            return tblBloc;
          },
        ),*/
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          leading: InkWell(
            hoverColor: Colors.black12,
            child: Container(
              color: Colors.transparent,
              child: const Icon(
                Icons.menu_outlined,
                size: 30,
                color: Colors.white,
              ),
            ),
            onTap: () {},
          ),
          title: const Text(
            'Firebase Demo',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              splashColor: Colors.deepOrangeAccent,
              highlightColor: Colors.black12,
              hoverColor: Colors.black12,
              icon: const Icon(
                Icons.share_sharp,
                size: 30,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: blocBody(),
      ),
    );
  }

  /* Widget blocBody() {
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
                        enlargeCenterPage: true,
                        autoPlay: true,
                        aspectRatio: 16 / 9,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                        viewportFraction: 0.92,
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
        BlocBuilder<TblBloc, TblState>(
          builder: (context, state) {
            if (state is TblLoadingState) {
              print("TblLoadingState CircularProgressIndicator");
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is TblLoadedState) {
              userList = state.tblData;
              print("tblData length =--=>" + userList.length.toString());
              return Expanded(
                child: ListView.builder(
                    controller: _scrollController,
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
              return Center(
                child: Text("Error" + state.error.toString()),
              );
            }

            return Container();
          },
        ),
      ],
    );
  }*/

  Widget blocBody() {
    return isErrorShow
        ? noDataAdd()
        : SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 220.0,
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
                                // height: 220.0,
                                //220
                                enlargeCenterPage: true,
                                autoPlay: true,
                                aspectRatio: 16 / 9,
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enableInfiniteScroll: true,
                                autoPlayAnimationDuration:
                                    const Duration(milliseconds: 1000),
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
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    VideoPage(item)),
                                            // MaterialPageRoute(builder: (context) => YoutubePlayerDemoApp()),
                                          );
                                        },
                                        child: Card(
                                          margin: const EdgeInsets.only(
                                            top: 10.0,
                                            bottom: 10.0,
                                          ),
                                          elevation: 3.0,
                                          // shadowColor: Colors.redAccent,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(30.0),
                                            ),
                                            child: Image.network(
                                              item.imgUrl.toString(),
                                              fit: BoxFit.fill,
                                              width: double.infinity,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return Container(
                                                  width: double.infinity,
                                                  height: 200,
                                                  color: Colors.grey,
                                                  child: Icon(
                                                    Icons.error,
                                                    color: Colors.red,
                                                  ),
                                                );
                                              },
                                            ),
                                            /*Image(
                                              image: NetworkImage(
                                                item.imgUrl.toString(),
                                              ),
                                            ),*/
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
                        print("errr=-=->" + state.error);
                        // setState(() {
                        //   isErrorShow = true;
                        // });
                        return Container();
                      }

                      return Container(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
                BlocBuilder<TblBloc, TblState>(
                  builder: (context, state) {
                    if (state is TblLoadingState) {
                      print("TblLoadingState CircularProgressIndicator");

                      // EasyLoading.show();
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is TblLoadedState) {
                      // EasyLoading.dismiss();
                      List<TblModel> userList = state.tblData;
                      print("tblData length =--=>" +
                          userList.length.toString());
                      return ListView.builder(
                          itemCount: userList.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (_, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 8),
                              child: Card(
                                color: Theme.of(context).primaryColor,
                                child: ListTile(
                                  title: Text(
                                    '${userList[index].title} ',
                                    style: const TextStyle(
                                        color: Colors.white),
                                  ),
                                  subtitle: Text(
                                    '${userList[index].date_time}',
                                    style: const TextStyle(
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            );
                          });
                    }
                    if (state is TblErrorState) {
                      // EasyLoading.dismiss();
                      print("errr" + state.error);
                      // setState(() {
                      //   isErrorShow = true;
                      // });
                      return Container();
                    }

                    return Container();
                  },
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 10,
                    left: 10,
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.text('connect_with_us'),
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  Widget noDataAdd() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 0),
        child: Image.asset(
          "assets/images/Emptyimages.png",
        ),
      ),
    );
  }
}
