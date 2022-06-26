import 'package:flutter/material.dart';
import 'package:notes_app_flutter/api/app-state.dart';
import 'package:notes_app_flutter/constants.dart';
import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class OnlineSyncScreen extends StatefulWidget {
  const OnlineSyncScreen({Key? key}) : super(key: key);

  @override
  _OnlineSyncScreenState createState() => _OnlineSyncScreenState();
}

class _OnlineSyncScreenState extends State<OnlineSyncScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // late final SharedPreferences prefs;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<AppState>(
          builder: (context, appState, child) => Scaffold(
                appBar: AppBar(
                  backgroundColor: kAppBarColor,
                  elevation: 0,
                  leading: const BackButton(
                    color: kDarkThemeBackgroundColor,
                  ),
                ),
                body: Center(
                  child: Container(
                    height: 400,
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: appState.userEmail == kDefaultEmail
                        ? Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  "Авторизация".toUpperCase(),
                                  style: kCapitalTextsTextStyle,
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                    'Введите email и пароль. Это позволит синхронизировать заметки между устройствами.'),
                                const SizedBox(
                                  height: 25,
                                ),
                                TextFormField(
                                  controller: emailController,
                                  decoration: kInputFieldDecoration.copyWith(
                                    labelText: "Email",
                                    labelStyle: const TextStyle(
                                        color: Colors.black54,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black45),
                                    ),
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    value = value!.toLowerCase().trim();
                                    if (value.isEmpty) {
                                      return "Пожалуйста, введите свой email.";
                                    }
                                    if (value == kDefaultEmail) {
                                      return "Введенный email неправилен.";
                                    } else if (!RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(value)) {
                                      return "Введенный email не является корректным";
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  controller: passwordController,
                                  style: const TextStyle(fontSize: 18),
                                  decoration: kInputFieldDecoration.copyWith(
                                    labelText: "Пароль",
                                    labelStyle: const TextStyle(
                                        color: Colors.black54,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black45),
                                    ),
                                  ),
                                  // keyboardType: TextInputType.o,
                                  obscureText: true,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Пожалуйста, свой введите пароль.";
                                    } else if (value.length < 6) {
                                      return "Пароль состоит как минимум из 6 символов.";
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(kPurpleButtonColor),
                                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                                      EdgeInsets.symmetric(vertical: 16),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      print("Valid data entered for login.");
                                      Provider.of<AppState>(context, listen: false)
                                          .loginUser(
                                              email: emailController.text,
                                              password: passwordController.text)
                                          .then((value) {
                                        if (value == kLoginCodesEnum.unknownError) {
                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                              content: Text("Возникла неизвестная ошибка.")));
                                        } else if (value == kLoginCodesEnum.wrong_password) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(content: Text("Введен неверный пароль.")));
                                        } else if (value == kLoginCodesEnum.weak_password) {
                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                              content:
                                                  Text("Firebase считает введенный пароль слабым.")));
                                        } else if (value == kLoginCodesEnum.successful) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(content: Text("Успешный вход.")));
                                          Navigator.of(context).pop();
                                        }
                                      });
                                    }
                                  },
                                  child: const Text(
                                    "Синхронизировать",
                                    style: TextStyle(fontSize: 18, letterSpacing: 0.75),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          )
                        : const AlreadySyncingWidget(),
                  ),
                ),
              )),
    );
  }
}

class AlreadySyncingWidget extends StatelessWidget {
  const AlreadySyncingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Woohoo".toUpperCase(), style: kCapitalTextsTextStyle),
        SizedBox(
          height: 20,
        ),
        Text(
          "Looks like you are already enjoying the benefits of online sync!",
        ),
        SizedBox(
          height: 20,
        ),
        ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(kPurpleButtonColor),
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.symmetric(vertical: 16),
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "Great. I want to note something now!",
              style: TextStyle(
                fontSize: 16,
                letterSpacing: 0.75,
              ),
            ))
      ],
    );
  }
}
