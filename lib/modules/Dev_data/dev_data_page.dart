import 'package:easy_home/modules/Dev_data/dev_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_home/theme/AppColors.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../menu_layout.dart';

class DevDataPage extends StatelessWidget {
  const DevDataPage({Key? key}) : super(key: key);

  static const String _title = 'Dados da equipe';

  @override
  Widget build(context) {

  // Instantiate your class using Get.put() to make it available for all "child" routes there.
  final DevDataController c = Get.put(DevDataController());

  return MaterialApp(
    title: _title,
    home: Scaffold(
      drawer: MenuDashboardPage(),
      appBar: AppBar(title: const Text(_title), backgroundColor: AppColors.background,),
      body: const MyStatelessWidget(),
    ),
  );
  }

}
class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body:Column( children: [
        Card(
        elevation: 8,
        margin: const EdgeInsets.all(10),
        child:Container(
          height: 150,
          color: Color.fromRGBO(33, 39, 74,1.0),
          child: Row(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Expanded(
                      flex:2 ,
                      child:CircleAvatar(
                        backgroundImage: AssetImage('images/pagoto.jpg'),
                        radius: 50,
                      )
                  ),
                ),
              ),
              Expanded(
                flex:8 ,
                child:Container(
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: [
                      const Expanded(
                        flex: 5,
                        child: ListTile(
                          title: Text("Gabriel Felipe Pagoto", style: TextStyle(color: Colors.white),),
                          subtitle: Text("Estudante de TADS na UFPR.", style: TextStyle(color: Colors.white),),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              hoverColor: Colors.transparent,
                              child: TextButton(onPressed: () => _linkedin("https://www.linkedin.com/in/gabrielpagoto/"),
                              child: Text('LinkedIn'),
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                             Text("Última atualização em: 31/08/2022", style: TextStyle(color: Colors.white),)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
        Card(
          elevation: 8,
          margin: const EdgeInsets.all(10),
          child:Container(
            height: 150,
            color: Color.fromRGBO(33, 39, 74,1.0),
            child: Row(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Expanded(
                        flex:2 ,
                        child:CircleAvatar(
                          backgroundImage: AssetImage('images/jackson.jpg'),
                          radius: 50,
                        )
                    ),
                  ),
                ),
                Expanded(
                  flex:8 ,
                  child:Container(
                    alignment: Alignment.topLeft,
                    child: Column(
                      children: [
                        const Expanded(
                          flex: 5,
                          child: ListTile(
                            title: Text("Jackson Longo dos Santos", style: TextStyle(color: Colors.white),),
                            subtitle: Text("Estudante de TADS na UFPR.", style: TextStyle(color: Colors.white),),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                hoverColor: Colors.transparent,
                                child: TextButton(onPressed: () => _linkedin("https://www.linkedin.com/in/jackson-longo-6351b2193/"),
                                  child: Text('LinkedIn'),
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const [
                              Text("Última atualização em: 31/08/2022", style: TextStyle(color: Colors.white),)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Card(
          elevation: 8,
          margin: const EdgeInsets.all(10),
          child:Container(
            height: 150,
            color: Color.fromRGBO(33, 39, 74,1.0),
            child: Row(
              children: [
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Expanded(
                      flex:2 ,
                      child:CircleAvatar(
                        backgroundImage: AssetImage('images/jose.jpg'),
                        radius: 50,
                      )
                    ),
                  ),
                ),
                Expanded(
                  flex:8 ,
                  child:Container(
                    alignment: Alignment.topLeft,
                    child: Column(
                      children: [
                        const Expanded(
                          flex: 5,
                          child: ListTile(
                            title: Text("José Adilson de Paula Cardoso", style: TextStyle(color: Colors.white),),
                            subtitle: Text("Estudante de TADS na UFPR.", style: TextStyle(color: Colors.white),),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                hoverColor: Colors.transparent,
                                child: TextButton(onPressed: () => _linkedin("https://www.linkedin.com/in/josé-adilson-de-paula-cardoso-50b2b9196/"),
                                  child: Text('LinkedIn'),
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const [
                              Text("Última atualização em: 31/08/2022", style: TextStyle(color: Colors.white),)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]
      )
    );
  }
}
_linkedin(String url) async {
  if (await canLaunchUrlString(url)) {
    await launchUrlString(url);
  } else {
    throw 'Could not launch $url';
  }
}