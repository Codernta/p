import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ipix_mt/Models/data_service_model.dart';

class DataServices {
  static Future<Welcome?> dataServices() async {
    Welcome? welcome;
    //  petOwnerSideServiceListModel = null;
    try {
      Response userData = await Dio().get(
        "https://run.mocky.io/v3/b91498e7-c7fd-48bc-b16a-5cb970a3af8a",
      );
      try {
        welcome = Welcome.fromJson(userData.data);
        // print(
        //     "|||||||||||||||||||||Owner Side Service List Data||||||||||||||||");
        // print(userData.restaurants[] != null);
        // if (userData.data['status']) {
        //   if (userData.data['data'] != null) {
        //     // SharedPreferences mPref = await SharedPreferences.getInstance();
        //     // mPref.setInt(Common.ownerProfileCompleted,
        //     //     userData.data['data']['status'] ?? 0);
        //     welcome =
        //         Welcome.fromJson(userData.data);
        //   } else {
        //     welcome = null;
        //   }
        // } else {
        //   print(
        //       "||||||||||||||Data on status true else else section|||||||||||||||||||||");
        //   welcome = null;
        //   return welcome;
        // }
        return welcome;
      } catch (e) {
        print("||||||||||||||Data on catch case|||||||||||||||||||||");
        print(e.toString());
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        print('Error sending request!');
        print(e.message);
      }
      Fluttertoast.showToast(
          gravity: ToastGravity.BOTTOM,
          msg: '\u26A0 Error Response : ${e.error}',
          backgroundColor: Colors.black,
          textColor: Colors.white);
      return welcome;
    }
    return welcome;
  }
}
