import 'package:easy_home/modules/Dev_data/dev_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_home/theme/AppColors.dart';
import '../../menu_layout.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({Key? key}) : super(key: key);

  static const String _title = 'Dados da equipe';

  @override
  Widget build(context) {

  // Instantiate your class using Get.put() to make it available for all "child" routes there.
  final DevDataController c = Get.put(DevDataController());

    return MaterialApp(
      home: Scaffold(
        backgroundColor: AppColors.background,
        drawer: MenuDashboardPage(),
        appBar: AppBar(title: const Text('Feedback'), backgroundColor: AppColors.background,),
        body: SingleChildScrollView(
              reverse: true,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32,vertical: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    Form(
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                filled: true, //<-- SEE HERE
                                fillColor: Color.fromRGBO(33, 39, 74,1.0),
                                labelText: 'Nome',
                                labelStyle: TextStyle(color: Colors.white),
                                border:OutlineInputBorder(
                                  borderSide: const BorderSide(color: Color.fromRGBO(61, 59, 59,1.0), width: 0.5),
                                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                ),
                                enabledBorder:OutlineInputBorder(
                                  borderSide: const BorderSide(color: Color.fromRGBO(61, 59, 59,1.0), width: 0.5),
                                  borderRadius: BorderRadius.all(Radius.circular(50.0)),

                                ),
                                focusedBorder:OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.white, width: 1.0),
                                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                )
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            TextFormField(
                                decoration:
                                const InputDecoration(
                                    filled: true, //<-- SEE HERE
                                    fillColor: Color.fromRGBO(33, 39, 74,1.0),
                                    labelText: 'E-mail',
                                    labelStyle: TextStyle(color: Colors.white),
                                    border:OutlineInputBorder(
                                      borderSide: const BorderSide(color: Color.fromRGBO(61, 59, 59,1.0), width: 0.5),
                                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                    ),
                                    enabledBorder:OutlineInputBorder(
                                      borderSide: const BorderSide(color: Color.fromRGBO(61, 59, 59,1.0), width: 0.5),
                                      borderRadius: BorderRadius.all(Radius.circular(50.0)),

                                    ),
                                    focusedBorder:OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.white, width: 1.0),
                                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                    )),
                                obscureText: true,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                  TextFormField(
                                    decoration: const InputDecoration(
                                        filled: true, //<-- SEE HERE
                                        fillColor: Color.fromRGBO(33, 39, 74,1.0),
                                        labelStyle: TextStyle(color: Colors.white),
                                        border:OutlineInputBorder(
                                          borderSide: const BorderSide(color: Color.fromRGBO(61, 59, 59,1.0), width: 0.5),
                                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                                        ),
                                        enabledBorder:OutlineInputBorder(
                                          borderSide: const BorderSide(color: Color.fromRGBO(61, 59, 59,1.0), width: 0.5),
                                          borderRadius: BorderRadius.all(Radius.circular(25.0)),

                                        ),
                                        focusedBorder:OutlineInputBorder(
                                          borderSide: const BorderSide(color: Colors.white, width: 1.0),
                                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                                        )
                                    ),
                                    maxLines: 8,
                                ),

                            const SizedBox(
                              height: 36,
                            ),
                            DialogExample()
                          ],
                        ))
                  ],
                ),
              ),
         ),
      ),
    );
  }
  }

  class DialogExample extends StatelessWidget {
    const DialogExample({super.key});

    @override
    Widget build(BuildContext context) {
      return TextButton(
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            backgroundColor: AppColors.background,
            title: const Text('Mensagem enviada com sucesso!', style: TextStyle(color: Colors.white)),
            content: const Text('Obrigado por enviar seu feedback!', style: TextStyle(color: Colors.white)),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
        style: TextButton.styleFrom(
          primary: Colors.white,
          backgroundColor: Colors.blue,
          onSurface: Colors.grey,
        ),
        child: const Text('Enviar'),
      );
    }
  }