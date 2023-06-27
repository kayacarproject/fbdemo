import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/loclization/language_bloc.dart';
import '../../bloc/loclization/language_event.dart';
import '../../bloc/loclization/language_state.dart';
import '../../model/language_model.dart';
import '../../model/locale_model.dart';
import '../../util/localizations.dart';
import '../home/homepage.dart';

class LangScreen extends StatefulWidget {
  const LangScreen({Key? key}) : super(key: key);

  @override
  State<LangScreen> createState() => _LangScreenState();
}



class _LangScreenState extends State<LangScreen> {
  int selLang = 0;

  @override
  Widget build(BuildContext context) {
    // Use this model to get the List of all supported words
    // LocaleModel st = AppLocalizations.of(context)!.value();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          // Using LocaleModel here
          AppLocalizations.of(context)!.text('language'),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              //
              // Directly calling Value using key
              AppLocalizations.of(context)!.text('please_choose_your_language'),

              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
          ),
          ListView.builder(
            itemCount: Languages.languages.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return BlocBuilder<LanguageBloc, LanguageState>(
                builder: (context, state) {
                  return Container(
                    height: 40,
                    margin: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 20,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      border: Border.all(
                        color: (selLang == index)
                            ? Colors.deepPurple
                            : Colors.black,
                        width: 1,
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        context.read<LanguageBloc>().add(
                            ToggleLanguageEvent(Languages.languages[index]));
                        setState(() {
                          selLang = index;
                        });
                        print(selLang.toString() + "==" + index.toString());
                      },
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          if(selLang == index)
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child:  Image.asset(
                                "assets/images/select_right_circle.png",
                                color: Colors.deepPurple,
                                height: 20,
                              ),
                            ),
                          Center(
                            child: Text(
                              Languages.languages[index].value,
                              style: TextStyle(
                                color: (selLang == index)
                                    ? Colors.deepPurple
                                    : Colors.black,
                                fontWeight: (selLang == index)
                                    ? FontWeight.bold
                                    : FontWeight.w400,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 10,
              right: 10,
              top: 40,
              bottom: 20,
            ),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.all(10) //content padding inside button
                  ),
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                child: Text(
                  AppLocalizations.of(context)!.text('submit'),
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
