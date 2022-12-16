import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_home_app/models/Immobile_model.dart';
import 'package:easy_home_app/models/user_model.dart';
import 'package:easy_home_app/pages/immobiles/view_models/immobile_view_model.dart';
import 'package:easy_home_app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;


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
  @override
  void initState() {
    tap();
    getinterested = widget.controller.getinterested(widget.imm.id);
    super.initState();
  }
   Future<void> tap() async {
    var response = await widget.controller.checkList(widget.imm.id);
    dev.log(response.toString());
    setState(() => status =  response);

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
      backgroundColor: AppColors.primary,
      title: const Text("")),
      backgroundColor: AppColors.background,
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
                              child: Icon(Icons.arrow_back_rounded,color: AppColors.yellow,),
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
                            backgroundColor : MaterialStateProperty.all(AppColors.yellow)
                          ),
                          onPressed: (){
                            showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                    height: 350,
                                    color: AppColors.yellow,
                                    child: Center(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            StatefulBuilder(builder: (context, setStateSB)
                                            {
                                              return
                                                FutureBuilder<List<User>>(
                                                    future: getinterested,
                                                    builder: (context, snapshot){
                                                      if(snapshot.hasError){
                                                        return Scaffold(
                                                          appBar: AppBar(
                                                            title: Text("Error"),
                                                          ),
                                                          body: Center(
                                                            child: Text("${snapshot.error}"),
                                                          ),
                                                        );
                                                      }
                                                      return ListView.builder(
                                                          scrollDirection: Axis.vertical,
                                                          shrinkWrap: true,
                                                          itemCount: snapshot.data?.length,
                                                          itemBuilder: (context, index){
                                                            if(snapshot.data != null) {
                                                              List<User> lista = snapshot.data!;
                                                              User i = lista[index];
                                                              return Padding(
                                                                  padding: const EdgeInsets.all(0),
                                                                  child: Column(
                                                                    children: [
                                                                      Container(
                                                                        decoration: const BoxDecoration(
                                                                            border: Border(
                                                                              bottom: BorderSide(
                                                                                  width: 8, color: Colors.black12),
                                                                            )),
                                                                        margin: const EdgeInsets.symmetric(horizontal: 2),
                                                                        child: Padding(
                                                                          padding: const EdgeInsets.all(10.0),
                                                                          child: Row(
                                                                            children: [
                                                                              Expanded(
                                                                                  flex: 1,
                                                                                  child: Column(
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    children: [
                                                                                      ClipRRect(
                                                                                          borderRadius: BorderRadius.circular(10.0),
                                                                                          child:Image.network(
                                                                                            i.image,
                                                                                            width: 80,
                                                                                            height: 80,
                                                                                            fit:BoxFit.fill,
                                                                                            errorBuilder:
                                                                                                (context, error, stackTrace) {
                                                                                              return Image.asset(
                                                                                                'imagens/sem_imagem.png',
                                                                                                width: 80,
                                                                                                height: 80,
                                                                                                fit:BoxFit.fill,

                                                                                              );
                                                                                            },
                                                                                          )
                                                                                      ),
                                                                                    ],
                                                                                  )),
                                                                              const SizedBox(
                                                                                width: 10,
                                                                              ),
                                                                              Expanded(
                                                                                  flex: 1,
                                                                                  child: Column(
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    children: [
                                                                                      Text(
                                                                                        i.name.trimLeft(),
                                                                                        textAlign: TextAlign.left,
                                                                                        style: TextStyle(color: Colors.white),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        height: 8,
                                                                                      ),
                                                                                      Text(
                                                                                        i.cellPhone.toString(),
                                                                                        textAlign: TextAlign.left,
                                                                                        style: TextStyle(color: Colors.white),
                                                                                      )
                                                                                    ],
                                                                                  ))
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                );
                                                            }
                                                            return ListTile(
                                                                title: Text("Sem interessados no momento")
                                                            );
                                                          }
                                                      );
                                                    }
                                                );
                                              }
                                            ),
                                          ],
                                        )
                                    )
                                );
                              },
                            );
                          }, child: Text(
                          "Ver lista de interessado",
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
                            "R\$: " + widget.imm.price.toString(),
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
                    bottom: 30 * 4,
                  ),
                  child: Text(
                    widget.imm.desc,
                    style: TextStyle(
                      color: Colors.white,
                      height: 1.5,
                    ),
                  ),
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