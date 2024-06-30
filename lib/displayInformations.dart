import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DisplayInformations extends StatelessWidget{
  const DisplayInformations({super.key});
  final String fullName    = 'Jeanne Doe';
  final String jobFunction = 'Founder, CEO';
  final String companyName = 'Google.Inc';
  final String phoneNumber = '+261340512978';
  final String courriel    = 'monadresse@gmail.com';
  final String adresse     = 'Fianarantsoa';
  final String siteWeb     = 'https://www.youtube.com';

  @override
  Widget build(BuildContext context) {
    const String appTitle = 'Flutter layout demo';

    return Scaffold(

      body: Center(
        child: Column (
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
              Container(
                      width: double.infinity,
                      height: 260,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.only(bottomRight: Radius.elliptical(150, 60) ,bottomLeft: Radius.elliptical(150, 60)),
                      ),
                      child: Column (
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            color: Colors.transparent,
                            width: 250,
                            height: 80,
                            margin: EdgeInsets.only(top:40),
                          ),
                          Container(
                            width: double.infinity,
                            height: 120,
                            child: Column(

                              children: [
                                Text(
                                  fullName,
                                  style: const TextStyle(
                                      fontSize: 30,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500
                                  ),
                                ),
                                Text(
                                    jobFunction,
                                    style: const TextStyle(
                                        fontSize: 18
                                    )
                                ),
                                Text(
                                    companyName,
                                    style: const TextStyle(
                                        fontSize: 18
                                    )
                                )
                              ],
                            ),
                          )

                        ],
                      )
                  ),
               Container(
                 margin: EdgeInsets.only(left:5,top:32),
                 child:  IconButton(
                   onPressed: () { Navigator.pop(context);},
                   icon: const Icon(Icons.arrow_back_ios_rounded),
                   iconSize: 33,
                 ),
               )

              ],
            ),

            Container(
              child:
              Text("Lorem ipsum dolor sit amet, "
                  "consectetur adipiscing elit, "
                  "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
                  "Nec ullamcorper sit amet risus nullam eget.",
                  style: const TextStyle(
                    fontSize: 16
                  ),
                textAlign: TextAlign.justify,
              ),
              margin: const EdgeInsets.symmetric(vertical: 0,horizontal: 20),
              padding: const EdgeInsets.all(28),
            ),
            Container(
              width: double.infinity,
              height: 350,
              margin: const EdgeInsets.only(left: 22, right: 22, bottom: 20),
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                border: Border.all(
                  width: 1,
                  color: Colors.black26
                )
              ),
              child: Column(
                children: [
                  InformationContainer(Icons.call,phoneNumber, 'Téléphone'),
                  InformationContainer(Icons.mail_rounded,courriel,'Courriel'),
                  InformationContainer(Icons.location_on_rounded, adresse, 'Adresse'),
                  InformationContainer(Icons.language_rounded, siteWeb, 'Site')
                ],
              )
            ),
          ],
        )
      )

    );
  }

}
class InformationContainer extends StatelessWidget{
  IconData iconLabel;
  String info = "Aucun site web à afficher";
  String infoLabel = "Label";

  InformationContainer(this.iconLabel,this.info,this.infoLabel);

  @override
  Widget build(BuildContext context) {
    return Container(
        height:75,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: IconButton(
                  iconSize: 32,
                  icon: Icon(this.iconLabel),
                  onPressed: () {
                    switch(this.infoLabel){
                      case "Téléphone" : launchDialer(this.info);break;
                      case "Site"  : launchSite(this.info);break;
                    }
                  },
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    this.infoLabel,
                    style: const TextStyle(
                      color: Colors.black54,
                    )

                  ),
                  SelectableText(
                    this.info,
                      style: const TextStyle(
                        fontSize: 18,
                      )
                  ),

                ],
              )
            ]
        )
    );

  }
  void launchDialer(String phoneNumber) async {
    Uri url = Uri.parse('tel:$phoneNumber');
    if( await canLaunchUrl(url)) {
      await launchUrl(url);
    }else{
      throw 'Unable to dial number';
    }
  }
  void launchSite(String website) async {
    Uri url = Uri.parse(website);
    if( await canLaunchUrl(url)) {
      await launchUrl(url);
    }else{
      throw 'Unable to launch website';
    }
  }

}