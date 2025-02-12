import 'package:final_project/theme/app_color.dart';
import 'package:final_project/view/register_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HaveAccount extends StatelessWidget {
  const HaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Column(
        children: [

           Text("Or continue with",style: Theme.of(context).textTheme.bodyMedium,),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const FaIcon(FontAwesomeIcons.google,color: AppColor.black,size: 20,),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.apple, color: AppColor.black),
                        onPressed: () {},
                      ),
                    ],
                  ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Text("Create new account? ",style: Theme.of(context).textTheme.labelSmall,),
              TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const RegisterPage()),
                          );
                        },
                        child:  Text(
                          "Sign up",
                          style:Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
            ],
          ),
        ],
      ),
    );
  }
}


               