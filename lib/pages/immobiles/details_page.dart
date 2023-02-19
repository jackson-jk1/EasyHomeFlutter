import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_home_app/models/Immobile_model.dart';
import 'package:easy_home_app/models/user_model.dart';
import 'package:easy_home_app/pages/immobiles/view_models/immobile_view_model.dart';
import 'package:easy_home_app/theme/app_colors.dart';
import 'package:flutter/material.dart';

import '../../menu_layout.dart';
import '../../widgets/web_view.dart';


class DetailsScreen extends StatefulWidget {

  Immobile imm;
  final ImmobileViewModel controller;

  DetailsScreen({Key? key, required this.imm, required this.controller}) : super(key: key);
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
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
                      .map((item) => Container(
                    child: Center(
                        child:
                        Image.network(
                            item.toString(),
                            fit: BoxFit.cover,
                            width: 1000,
                            errorBuilder:
                            (context, error, stackTrace) {
                            return Image.asset(
                            'imagens/sem_imagem.png',
                            fit:BoxFit.cover,
                            width: 1000,

                            );
                          },
                        )
                    ),
                  ))
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
                                   InkWell(
                                    onTap: (){
                                      setState(() {
                                       status = !status;
                                       widget.controller.addPreference(widget.imm.id, context, status);
                                      });
                                    },
                                    child:
                                       Container(
                                           height: 50,
                                           width: 50,
                                           decoration: BoxDecoration(
                                             border: Border.all(color: AppColors.yellow.withOpacity(0.4), width:2),
                                             borderRadius: BorderRadius.circular(15),
                                           ),
                                           child: status == false
                                           ? Icon(Icons.favorite_border_rounded,color: AppColors.yellow)
                                           : Icon(Icons.favorite,color: AppColors.yellow)
                                           ),
                                  )
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
                            backgroundColor: MaterialStateProperty.all(AppColors.yellow),
                          ),
                          onPressed: () {
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
                                          color: AppColors.yellow,
                                        ),
                                        padding:
                                        const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                                        child: FutureBuilder<List<User>>(
                                          future: getinterested,
                                          builder: (context, snapshot) {
                                            if (snapshot.hasError) {
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
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              );
                                            }
                                            if (snapshot.data?.isEmpty == false) {
                                              return ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount: snapshot.data?.length,
                                                  itemBuilder: (context, index) {
                                                    List<User> lista = snapshot.data!;
                                                    User u = lista[index];
                                                    return ListTile(
                                                      leading: ClipOval(
                                                        child: Image.network(
                                                          u.image,
                                                          width: 40,
                                                          height: 40,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      title: Text(
                                                        u.name,
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                      trailing: IconButton(
                                                        iconSize: 22,
                                                        icon: Icon(
                                                          Icons.person_add_alt_rounded,
                                                          color: AppColors.white,
                                                        ),
                                                        onPressed: () async {
                                                          widget.controller
                                                              .sendInvitation(
                                                              context, u.id);
                                                        },
                                                      ),
                                                    );
                                                  },
                                                );

                                            }
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
                                                  fontSize: 20,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Text("Ver lista de interessados",
                              style: TextStyle(color: AppColors.white, fontSize: 25)),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child:
                      Padding(
                          padding: const EdgeInsets.only(
                            bottom: 30,
                            left: 30,
                            right: 30,
                          ),
                          child:
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "R\$ : " + widget.imm.price.toString().substring(0, widget.imm.price.toString().indexOf('.')),
                                style: const TextStyle(
                                  fontSize: 28,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  widget.imm.address.trim(),
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          )
                      ),
                    ),
                   const Padding(
                      padding: EdgeInsets.only(left: 30, bottom: 30),
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
                        physics: const BouncingScrollPhysics(),
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
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
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
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
                      padding: const EdgeInsets.only(
                        left: 30,
                        right: 30,
                        bottom: 30,
                      ),
                      child: Text(
                        widget.imm.desc,
                        style: const TextStyle(
                          color: Colors.white,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Padding(
                        padding: const  EdgeInsets.only(
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