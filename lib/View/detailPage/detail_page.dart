import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ipix_mt/Providers/data_provider.dart';
import 'package:ipix_mt/Utils/widgets/rating_and_review_card.dart';
import 'package:ipix_mt/Utils/widgets/rating_widget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatefulWidget {
  final int id;

  const DetailPage({super.key, required this.id});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  double latitude = 0.0;
  double longitude = 0.0;

  late List<String> workingDateList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<DataProvider>(context, listen: false)
        .dataProviders(context: context)
        .then((value)async  {
      print('|||||||||| value |||||||||||');
      print(value);
      String mondayValue =
          'Monday : ' + value!.restaurants![widget.id - 1].operatingHours.monday;
      String tuesdayValue =
          'Tuesday : ' + value!.restaurants![widget.id - 1].operatingHours.monday;
      String wednesdayValue = 'Wednesday : ' +
          value!.restaurants![widget.id - 1].operatingHours.monday;
      String thursdayValue = 'Thursday : ' +
          value!.restaurants![widget.id - 1].operatingHours.monday;
      String fridayValue =
          'Friday : ' + value!.restaurants![widget.id - 1].operatingHours.monday;
      String saturdayValue = 'Saturday : ' +
          value!.restaurants![widget.id - 1].operatingHours.monday;
      String sundayValue =
          'Sunday : ' + value!.restaurants![widget.id - 1].operatingHours.monday;
      print(mondayValue);
      workingDateList.addAll([
        mondayValue,
        tuesdayValue,
        wednesdayValue,
        thursdayValue,
        fridayValue,
        saturdayValue,
        sundayValue
      ]);
      print('|||||||||| working hour list ||||||||||||');
      print(workingDateList);
    });
  }

  @override
  Widget build(BuildContext context) {
    latitude = Provider.of<DataProvider>(context, listen: false)
        .welcome!
        .restaurants![widget.id - 1]
        .latlng
        .lat;
    longitude = Provider.of<DataProvider>(context, listen: false)
        .welcome!
        .restaurants![widget.id - 1]
        .latlng
        .lng;
    return Scaffold(
      body: detailPageBody(),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: const Color(0xffFF8c23),
        onPressed: () {
          // openMap(latitude,longitude);
          // launchURL();
          MapsLauncher.launchCoordinates(latitude, longitude);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.directions,
              color: Colors.white,
            ),
            Text(
              'GO',
              style: GoogleFonts.roboto(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }

  detailPageBody() {
    var checkBool = Provider.of<DataProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;
    return  checkBool.welcome == null
        ? loading()
        : Consumer<DataProvider>(builder: (context, provider, child) {
            return SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Container(
                height: size.height *1.1,
                width: size.width,
                child: Column(
                  children: [topImage(provider), otherItems(provider)],
                ),
              ),
            );
          });
  }

  topImage(DataProvider provider) {
    return Image.network(
      provider.welcome!.restaurants![widget.id - 1]
          .photograph, // Replace with the image URL from your data
      fit: BoxFit.cover,
      height: 300.0,
      width: double.infinity,
    );
  }

  otherItems(DataProvider provider) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: size.height * 0.03,
          ),
          titleRow(provider),
          SizedBox(
            height: size.height * 0.015,
          ),
          place(provider),
          SizedBox(
            height: size.height * 0.01,
          ),
          cuisineType(provider),
          SizedBox(
            height: size.height * 0.01,
          ),
          location(provider),
          SizedBox(
            height: size.height * 0.01,
          ),
          timeRow(provider),
          SizedBox(
            height: size.height * 0.03,
          ),
          ratingAndReviewTitle(),
          SizedBox(
            height: size.height * 0.01,
          ),
          ratingList(provider)
        ],
      ),
    );
  }

  titleRow(DataProvider provider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          provider.welcome!.restaurants![widget.id - 1]
              .name, // Replace with the title from your data
          style: GoogleFonts.roboto(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const RatingWidget(rating: '3.7'),
      ],
    );
  }

  place(DataProvider provider) {
    return Text(
      provider.welcome!.restaurants![widget.id - 1].neighborhood.toString(),
      style: GoogleFonts.roboto(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  cuisineType(DataProvider provider) {
    return Row(
      children: [
        const CircleAvatar(
            radius: 10,
            backgroundColor: Colors.grey,
            child: Icon(
              Icons.local_restaurant_rounded,
              color: Colors.white,
              size: 13,
            )),
        const SizedBox(
          width: 10,
        ),
        Text(
          provider.welcome!.restaurants![widget.id - 1]
              .cuisineType, // Replace with the title from your data
          style: GoogleFonts.roboto(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  location(DataProvider provider) {
    return Row(
      children: [
        const Icon(
          Icons.location_pin,
          color: Colors.grey,
          size: 24,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          provider.welcome!.restaurants![widget.id - 1]
              .address, // Replace with the title from your data
          style: GoogleFonts.roboto(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  timeRow(DataProvider provider) {
    late String? dropdownValue = workingDateList.first ?? '';
    return Row(
      children: [
        const Icon(
          Icons.timer,
          color: Colors.grey,
          size: 24,
        ),
        const SizedBox(
          width: 10,
        ),
        DropdownButton<String>(
          value: dropdownValue,
          icon: const Icon(Icons.keyboard_arrow_down),
          elevation: 10,
          style: GoogleFonts.roboto(
    fontSize: 17.0,
    fontWeight: FontWeight.bold,
            color: Colors.black
    ),
          underline: Container(),
          onChanged: (String? value) {
            // This is called when the user selects an item.
            setState(() {
              dropdownValue = value!;
            });
          },
          items: workingDateList.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        /*Text(
          'Wednesday: 5:30 pm - 12:00 am', // Replace with the title from your data
          style: GoogleFonts.roboto(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),*/
      ],
    );
  }

  ratingAndReviewTitle() {
    return Text(
      'Rating & Reviews', // Replace with the title from your data
      style: GoogleFonts.roboto(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  ratingList(DataProvider provider) {
    return SizedBox(
        height: 350,
        child: ListView.separated(
            separatorBuilder: (context, index) => const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Divider(
                    height: 2,
                    color: Colors.grey,
                  ),
                ),
            itemCount:
                provider.welcome!.restaurants![widget.id - 1].reviews.length,
            itemBuilder: (context, index) {
              return RatingAndReviewCard(
                date: provider
                    .welcome!.restaurants![widget.id - 1].reviews[index].date
                    .toString(),
                ratings: provider
                    .welcome!.restaurants![widget.id - 1].reviews[index].rating
                    .toString(),
                review: provider.welcome!.restaurants![widget.id - 1]
                    .reviews[index].comments,
                userName: provider
                    .welcome!.restaurants![widget.id - 1].reviews[index].name,
              );
            }));
  }

  loading() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: LoadingAnimationWidget.twistingDots(
          leftDotColor: const Color(0xFF1A1A3F),
          rightDotColor: const Color(0xFFEA3799),
          size: 200,
        ),
      ),
    );
  }

  /* static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }*/

  launchURL() async {
    final String googleMapslocationUrl =
        "https://www.google.com/maps/search/?api=1&query=${latitude},${longitude}";

    final String encodedURl = Uri.encodeFull(googleMapslocationUrl);

    if (await canLaunch(encodedURl)) {
      await launch(encodedURl);
    } else {
      print('Could not launch $encodedURl');
      throw 'Could not launch $encodedURl';
    }
  }
}
