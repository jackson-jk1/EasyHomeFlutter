import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_home_app/models/Immobile_model.dart';
import 'package:easy_home_app/models/user_model.dart';
import 'package:easy_home_app/pages/favorites/view_models/favorite_view_model.dart';
import 'package:easy_home_app/pages/immobiles/view_models/immobile_view_model.dart';
import 'package:easy_home_app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:developer' as dev;

import '../../menu_layout.dart';
import '../../widgets/web_view.dart';


class DetailsFavoriteScreen extends StatefulWidget {

  Immobile imm;
  final FavoriteViewModel controller;
  DetailsFavoriteScreen({Key? key, required this.imm, required this.controller}) : super(key: key);
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsFavoriteScreen> {
  late bool status = false;
  late Future<List<User>> getinterested;


   Future<void> tap() async {
    var response = await widget.controller.checkList(widget.imm.id);
    setState(() => status =  response);

  }

  @override
  void initState() {
    tap();
    getinterested = widget.controller.getinterested(widget.imm.id);
    super.initState();
  }


  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: MenuDashboardPage(),
      appBar: AppBar(
      backgroundColor: AppColors.background,
      title: const Text("Detalhes")),
      backgroundColor: AppColors.pages,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
              Stack(
                children: [
                  Container(
                  child: CarouselSlider(
                  options: CarouselOptions(),
                  items: widget.imm.images
                      .map((item) =>
                        Image.network(
                            item.toString(),
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'imagens/sem_imagem.png',
                              width: double.infinity,
                              fit: BoxFit.cover,
                            );
                          },
                        )
                  )
                      .toList(),
                  )),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 30,
                      right: 30,
                      top: 30 ,
                    ),
                    child: Container(
                      height: size.height * 0.1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.yellow.withOpacity(0.4), width:2,),
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child:
                              Icon(Icons.arrow_back_rounded,color: AppColors.yellow,),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
              child: ListView(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              children: [
                Container(
                    padding: const EdgeInsets.only(
                      left: 30,
                      right: 30,
                      top: 30 ,
                      bottom: 30,
                    ),

                    child: Center(
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor : MaterialStateProperty.all(AppColors.yellow)
                          ),
                          onPressed: (){
                            showModalBottomSheet<void>(
                                context: context,
                                builder: (context) {
                                  Size size = MediaQuery.of(context).size;
                                  return SingleChildScrollView(
                                    padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context).viewInsets.bottom),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                      Container(
                                       decoration: BoxDecoration(
                                        color: AppColors.yellow
                                         ),
                                      padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                                      child:
                                           FutureBuilder<List<User>>(
                                              future: getinterested,
                                              builder: (context, snapshot){
                                                if(snapshot.hasError){
                                                   return ListTile(
                                                    leading: ClipOval(
                                                      child: Image.asset(
                                                        'imagens/User.png',
                                                        width: 40,
                                                        height: 40,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    title: const Text(
                                                        'Sem interessados no momento',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20

                                                      ),
                                                    ),
                                                  );
                                                }
                                                if(snapshot.data?.isEmpty == false){
                                                  dev.log(snapshot.data.toString());
                                                  return
                                                    Expanded(
                                                     child: ListView.builder(
                                                      shrinkWrap: true,
                                                      itemCount: snapshot.data?.length,
                                                      itemBuilder: (context, index){
                                                          List<User> lista = snapshot.data!;
                                                          User u = lista[index];
                                                          return ListTile(
                                                            leading: ClipOval(
                                                              child: Image.network(
                                                                u.image,
                                                                width: 40,
                                                                height: 40,
                                                                fit: BoxFit.cover,
                                                                errorBuilder: (context, error, stackTrace) {
                                                                  return Image.asset(
                                                                    'imagens/sem_imagem.png',
                                                                    width: 40,
                                                                    height: 40,
                                                                    fit: BoxFit.cover,
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                            title:  Text(
                                                              //"Telefone: " + u.cellPhone,
                                                              u.name,
                                                              style: TextStyle(
                                                                  color: Colors.white,
                                                                  fontSize: 20

                                                              ),
                                                            ),
                                                            trailing:
                                                            IconButton(
                                                            iconSize: 22,
                                                            icon: Icon(Icons.chat_bubble_outline , color: AppColors.white),
                                                                onPressed: () async {
                                                                  var contact = "+55" + u.cellPhone;
                                                                  var androidUrl = "whatsapp://send?phone=$contact";
                                                                  await launchUrl(Uri.parse(androidUrl));
                                                             },
                                                           )
                                                          );
                                                      }
                                                    ));
                                                }
                                                return ListTile(
                                                  leading: ClipOval(
                                                    child: Image.asset(
                                                      'imagens/User.png',
                                                      width: 40,
                                                      height: 40,
                                                      fit: BoxFit.cover,
                                                      errorBuilder: (context, error, stackTrace) {
                                                        return Image.asset(
                                                          'imagens/sem_imagem.png',
                                                          width: 40,
                                                          height: 40,
                                                          fit: BoxFit.cover,
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  title: const Text(
                                                    'Sem interessados no momento',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20
                                                    ),
                                                  ),
                                                );
                                              }
                                          ),
                                       )
                                     ]
                                    )
                                  );
                                }
                             );
                          }, child: Text(
                          "Ver lista de interessados",
                          style: TextStyle(color: AppColors.white, fontSize: 25))
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 30,
                    left: 30,
                    right: 30,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "R\$ " + widget.imm.price.toString(),
                            style: TextStyle(
                              fontSize: 28,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            widget.imm.address.trim().replaceAll(",", "\n"),
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(left: 30, bottom: 30),
                  child: Text(
                    'Detalhes do imóvel:',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  height: 130,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: 30,
                          bottom: 30,
                        ),
                        child: Container(
                          width: 100,
                          decoration: BoxDecoration(
                              color: AppColors.menuBar,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                width: 3,
                                color: Colors.white,
                              )),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.imm.rooms.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Quartos',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 30,
                    right: 30,
                    bottom: 30,
                  ),
                  child: Text(
                    widget.imm.desc,
                    style: TextStyle(
                      color: Colors.white,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(
                      left: 30,
                      right: 30,
                      bottom: 30 * 4,
                    ),
                    child:
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor : MaterialStateProperty.all(AppColors.yellow)
                      ),
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WebViewScreen(
                              url: widget.imm.siteUrl,
                            ),
                          ),
                        );
                      },
                      child: const Text("Ver na Fonte"),
                    )
                )
              ],
            ),
            ),
            ],
          ),
        ],
      ),
    );
  }
}