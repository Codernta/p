import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ipix_mt/Common/common.dart';
import 'package:ipix_mt/Providers/data_provider.dart';
import 'package:ipix_mt/Services/data_services.dart';
import 'package:ipix_mt/Utils/widgets/rating_widget.dart';
import 'package:ipix_mt/View/detailPage/detail_page.dart';
import 'package:ipix_mt/View/loginPage/login_page.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<DataProvider>(context, listen: false)
        .dataProviders(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: homePageBody(),
    );
  }

  AppBar appBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 20,
      centerTitle: false,
      leading: null,
      toolbarHeight: 90,
      backgroundColor: Color(0xffFF8c23),
      title: Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Text(
          'RESTAURANTS',
          style: GoogleFonts.roboto(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700),
        ),
      ),
      actions: [
        ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                elevation: 0, primary: Color(0xffFF8c23)),
            onPressed: () {
              deleteData().then(
                (value) => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPage())),
              );
            },
            icon: const Icon(
              Icons.logout_outlined,
              color: Colors.white,
            ),
            label: Text(
              'Log out',
              style: GoogleFonts.roboto(color: Colors.white),
            ))
      ],
    );
  }

  homePageBody() {
    var checkbool = Provider.of<DataProvider>(context);
    final size = MediaQuery.of(context).size;
    return checkbool.loading
        ? loading()
        : Consumer<DataProvider>(builder: (context, provider, child) {
            print('|||||||||| list length |||||||||||');
            print(provider.welcome!.restaurants!.length);
            return SingleChildScrollView(
                child: Container(
              height: size.height,
              width: size.width,
              child: Column(
                children: [
                  Container(
                     height: size.height*0.89,
                    width: size.width,
                    child: ListView.builder(
                        itemCount: provider.welcome!.restaurants!.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailPage(
                                          id: provider
                                              .welcome!.restaurants![index].id)));
                            },
                            child: Card(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    provider.welcome!.restaurants![index]
                                        .photograph, // Replace with the image URL from your data
                                    fit: BoxFit.cover,
                                    height: 200.0,
                                    width: double.infinity,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  titleRow(provider, index),
                                  SizedBox(
                                    height: size.height * 0.015,
                                  ),
                                  cuisineType(provider, index),
                                  SizedBox(
                                    height: size.height * 0.011,
                                  ),
                                  place(provider, index),
                                  SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                  SizedBox(
                    height: 100,
                  )
                ],
              ),
            ));
          });
  }

  titleRow(DataProvider provider, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            provider.welcome!.restaurants![index]
                .name, // Replace with the title from your data
            style: GoogleFonts.roboto(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          RatingWidget(rating: '3.7'),
        ],
      ),
    );
  }

  place(DataProvider provider, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Text(
        provider.welcome!.restaurants![index].address,
        style: GoogleFonts.roboto(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  cuisineType(DataProvider provider, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: [
          CircleAvatar(
              radius: 10,
              backgroundColor: Colors.grey,
              child: Icon(
                Icons.local_restaurant_rounded,
                color: Colors.white,
                size: 13,
              )),
          SizedBox(
            width: 10,
          ),
          Text(
            provider.welcome!.restaurants![index]
                .cuisineType, // Replace with the title from your data
            style: GoogleFonts.roboto(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  loading() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: LoadingAnimationWidget.twistingDots(
          leftDotColor: Colors.orange,
          rightDotColor: Colors.orange,
          size: 100,
        ),
      ),
    );
  }

  // void getPrefData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.getString(
  //     Common.name,
  //   );
  //   prefs.setString(Common.password);
  // }

  Future deleteData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
