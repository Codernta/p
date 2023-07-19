import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ipix_mt/Common/common.dart';
import 'package:ipix_mt/Utils/widgets/textfields.dart';
import 'package:ipix_mt/View/homePage/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isChecked = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height:size.height ,
          width: size.width,
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              headerImage(),
              const SizedBox(height: 20.0),
              loginTitleText(),
              const SizedBox(height: 20.0),
              LoginTextField(
                labelText: 'Username',
                controller: nameController,
              ),
              const SizedBox(height: 20.0),
              LoginTextField(
                labelText: 'Password',
                controller: passwordController,
              ),
              const SizedBox(height: 10.0),
              checkboxRow(),
              const SizedBox(
                height: 40,
              ),
              loginButton(context)
            ],
          ),
        ),
      ),
    );
  }

  headerImage() {
    return SvgPicture.asset(
      'assets/images/login_page_header.svg',
      height: 200.0,
      width: 300,
    );
  }

  loginTitleText() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Text(
          'Log in \nyour account',
          textAlign: TextAlign.start,
          style: GoogleFonts.roboto(
              color: const Color(0xff3D3E48),
              fontSize: 24,
              fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  loginButton(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return ElevatedButton(
      onPressed: () {
        if (nameController.text == '') {
          Fluttertoast.showToast(
              gravity: ToastGravity.BOTTOM,
              msg: 'Please enter username',
              backgroundColor: Colors.black,
              textColor: Colors.white);
        } else if (passwordController.text == '') {
          Fluttertoast.showToast(
              gravity: ToastGravity.BOTTOM,
              msg: 'Enter password',
              backgroundColor: Colors.black,
              textColor: Colors.white);
        } else {
          saveData().then((_) => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const HomePage())));
        }
        // Perform login action
      },
      style: ElevatedButton.styleFrom(
          primary: const Color(0xffFF8c23),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          fixedSize: Size(size.width * 0.8, size.height * 0.06)),
      child: Text(
        'Login',
        style: GoogleFonts.roboto(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
      ),
    );
  }

  checkboxRow() {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.85,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Checkbox(
            value: _isChecked,
            onChanged: (bool? newValue) {
              setState(() {
                _isChecked = newValue!;
              });
              // Handle checkbox value change here
              // You can perform additional logic or update other parts of your UI
            },
          ),
          Text('Remember me',
              style: GoogleFonts.roboto(
                  color: const Color(0xff3d3e48),
                  fontSize: 14,
                  fontWeight: FontWeight.w400)),
          const Spacer(),
          TextButton(
            onPressed: () {
              // Handle text button press here
            },
            child: Text('Forgot password?',
                style: GoogleFonts.roboto(
                    color: const Color(0xff023b69),
                    fontSize: 14,
                    fontWeight: FontWeight.w400)),
          ),
        ],
      ),
    );
  }

  saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(Common.name, nameController.text);
    prefs.setString(Common.password, passwordController.text);
  }
}
