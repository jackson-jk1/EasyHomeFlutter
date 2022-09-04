import 'package:flutter/material.dart';
import 'package:another_carousel_pro/another_carousel_pro.dart';

class DetailsScreen extends StatefulWidget {


  const DetailsScreen({Key? key}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
              Stack(
                children: [
                  Container(
                  height: size.height * 0.35,
                    child: Carousel(
                      dotSize: 5,
                      dotBgColor: Colors.transparent,
                      autoplay: false,
                      images: [
                        AssetImage("images/casa.jpg",),
                      ],
                    ),
                  ),
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
                                  border: Border.all(color: Colors.white.withOpacity(0.4)),
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: Icon(Icons.arrow_back_rounded,color: Colors.white,),
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white.withOpacity(0.4)),
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child: Icon(Icons.favorite_border_rounded,color: Colors.white,),
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
                    'R\$ 13.000,00',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'rua tal bairro tal',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black.withOpacity(0.4),
                      fontWeight: FontWeight.w600,
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.black.withOpacity(0.4),
                      )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '400',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'M²',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 30,
                  bottom: 30,
                ),
                child: Container(
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.black.withOpacity(0.4),
                      )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '4',
                        style: TextStyle(
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
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 30,
                  bottom: 30,
                ),
                child: Container(
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.black.withOpacity(0.4),
                      )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '2',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Banheiros',
                        style: TextStyle(
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
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras rutrum mollis sapien, quis lacinia leo pretium et. Quisque sit amet interdum mi. Aliquam maximus imperdiet pulvinar. Aenean ultrices nisi id risus elementum fringilla. Cras a magna gravida, dignissim elit quis, cursus lectus. In dapibus lacus tortor, ac rhoncus nibh finibus vel. Nulla facilisi. Cras et dictum turpis. Donec rhoncus efficitur tortor quis condimentum. Curabitur leo quam, scelerisque eget fermentum in, rutrum eu ante. Donec sed turpis lacinia, eleifend nulla eu, suscipit leo. Nam id lorem vel erat vehicula facilisis vel eu metus. Integer posuere egestas faucibus. Maecenas dictum turpis enim, ut egestas mauris mattis sit amet. Praesent sagittis mauris eu sem sollicitudin lobortis. Nulla facilisi.Curabitur semper bibendum nisi, eget imperdiet diam accumsan et. In eget suscipit nisl. Nullam metus diam, consequat nec imperdiet ac, placerat luctus elit. Sed at turpis vitae tellus iaculis molestie vel ac quam. Morbi mattis tellus eget rutrum congue. Integer et dignissim quam, vitae aliquet lectus. Nulla nec eros lacus. Etiam non egestas leo, a rhoncus enim. Aliquam vel hendrerit lectus, non fringilla lacus. Cras molestie rutrum porta. Sed a mi lacus. Aenean mattis nulla vitae imperdiet vehicula. Maecenas eget nisl in eros porttitor ornare. Aliquam ac orci dignissim, lobortis ante vitae, sagittis neque. Praesent lacinia suscipit risus in mattis.Sed quis purus id ante congue dapibus ac id eros. Aliquam leo erat, convallis eget sem ut, consectetur egestas lacus. Aenean non urna sodales, sodales massa eu, posuere leo. Sed non varius orci, et volutpat turpis. Curabitur fermentum enim ut augue lobortis, vitae venenatis sapien hendrerit. Ut fermentum nibh non odio ultrices, eget egestas est pharetra. Phasellus vel ante eget ante molestie ullamcorper. Quisque a libero ut nulla ornare euismod. Nunc quis dolor consequat sapien tristique gravida in sed ligula. Donec ut dolor quis mi suscipit porttitor.',
            style: TextStyle(
              color: Colors.black.withOpacity(0.4),
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