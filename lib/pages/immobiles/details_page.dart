import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_home_app/models/Immobile_model.dart';
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
  late Future<bool> favorite;

  @override
  void initState() {
    favorite = widget.controller.checkList(widget.imm.id);
    super.initState();
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
                            width: 1000,
                            fit:BoxFit.cover,
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
                          FutureBuilder<bool>(
                              future: favorite,
                              builder: (context, snapshot){
                                return InkWell(
                                    onTap: (){
                                      if(snapshot.data == false){
                                        dev.log("funciona");
                                      }
                                      dev.log(snapshot.data.toString());
                                    },
                                    child:
                                     Column(
                                       children: [
                                       Visibility(
                                       visible:snapshot.data!,
                                       child:
                                       Container(
                                           height: 50,
                                           width: 50,
                                           decoration: BoxDecoration(
                                             border: Border.all(color: AppColors.yellow.withOpacity(0.4), width:2),
                                             borderRadius: BorderRadius.circular(15),
                                           ),
                                           child: Icon(Icons.favorite_border_rounded,color: AppColors.yellow)
                                           ),
                                         ),
                                         Visibility(
                                           visible:!snapshot.data!,
                                           child:
                                           Container(
                                               height: 50,
                                               width: 50,
                                               decoration: BoxDecoration(
                                                 border: Border.all(color: AppColors.yellow.withOpacity(0.4), width:2),
                                                 borderRadius: BorderRadius.circular(15),
                                               ),
                                               child: Icon(Icons.favorite,color: AppColors.yellow)
                                           ),
                                         )
                                       ],
                                     )

                                );
                              }
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