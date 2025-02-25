import 'package:counter/feature/auth/logic/auth_cubit.dart';
import 'package:counter/feature/auth/presentation/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../home/presentation/home_screen.dart';
import 'package:counter/core/widgets/custom_social_buttom.dart';
import 'package:counter/feature/auth/presentation/forget_screen.dart';
import 'package:counter/feature/auth/presentation/register_screen.dart';
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthLoginLoading) {
              showDialog(
                  context: context,
                  builder: (context) =>
                      Center(child: CircularProgressIndicator()));
            }

            if (state is AuthLoginSuccess) {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Success Login"),
              ));
            }

            if (state is AuthLoginFailure) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.message),
              ));
            }
          },
          builder: (context, state) {
            return SafeArea(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24),
                  Text(
                    "Login to your \naccount.",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 24),
                  CustomTextInput(
                    hintText: 'Enter Your Username',
                    labelText: 'Username',
                    controller: userNameController,
                  ),
                  SizedBox(height: 24),
                  CustomTextInput(
                    hintText: 'Enter Your Password',
                    labelText: 'Password',
                    controller: passwordController,
                    isPassword: true,
                  ),
                  SizedBox(height: 14),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) => PassModal(),
                      );
                    },
                    child: Text(
                      "                           Forget Password?",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black, // Change to match your design
                      ),
                    ),
                  ),

                  SizedBox(height: 15),

                  CustomButton(
                      label: 'Login',
                      onPressed: () {
                        context.read<AuthCubit>().login(
                            userNameController.text, passwordController.text);
                      }),
                  SizedBox(height: 20),
                  Text("  _____________ or continue with _____________", style: TextStyle(fontSize: 15 , color: Colors.grey)),
                  SizedBox(height: 36),
                  CustomSocialButton(
                    label: "Continue with Google",
                    iconPath: "assets/google.svg",
                    onPressed: () {
                      // Handle Google Sign-In logic
                    },
                  ),

                  SizedBox(height: 16),
                  CustomSocialButton(
                    label: "Continue with Facebook",
                    iconPath: "assets/facebook.svg",
                    onPressed: () {
                    },
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterScreen()));
                        },
                        child: Text(
                          "Register",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ])
                ],
              ),
            ));
          },
        ),
      ),
    );
  }
}
