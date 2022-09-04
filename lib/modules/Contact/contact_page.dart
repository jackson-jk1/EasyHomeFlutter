import 'package:easy_home/modules/Dev_data/dev_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({Key? key}) : super(key: key);

  static const String _title = 'Dados da equipe';

  @override
  Widget build(context) {

  // Instantiate your class using Get.put() to make it available for all "child" routes there.
  final DevDataController c = Get.put(DevDataController());

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Feedback'), backgroundColor: Color(0xff131629)),
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
                              decoration: const InputDecoration(labelText: 'Nome'),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            TextFormField(
                                decoration:
                                const InputDecoration(labelText: 'E-mail'),
                                obscureText: true,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                  TextFormField(
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder()
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
            title: const Text('Mensagem enviada com sucesso!'),
            content: const Text('Obrigado por enviar seu feedback!'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
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