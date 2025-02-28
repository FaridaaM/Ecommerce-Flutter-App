import 'package:counter/feature/auth/logic/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:counter/core/widgets/custom_social_buttom.dart';

import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_input.dart';
import 'login_screen.dart';
import 'package:counter/feature/auth/presentation/login_screen.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthRegisterLoading) {
              showDialog(
                  context: context,
                  builder: (context) =>
                      Center(child: CircularProgressIndicator()));
            }

            if (state is AuthRegisterSuccess) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Success Registeration"),
              ));
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return LoginScreen();
              }));
            }

            if (state is AuthRegisterFailure) {
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
                    "Create your new  \naccount",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 24),
                  CustomTextInput(
                    hintText: 'Email address',
                    labelText: 'Email Address',
                    controller: emailController,
                  ),
                  SizedBox(height: 10),
                  CustomTextInput(
                    hintText: 'Password',
                    labelText: 'Password',
                    controller: passwordController,
                    isPassword: true,
                  ),
                  SizedBox(height: 10),
                  CustomTextInput(
                    hintText: 'Password',
                    labelText: 'Confirm Password',
                    controller: passwordController,
                    isPassword: true,
                  ),
                  SizedBox(height: 24),
                  CustomButton(
                      label: 'Register',
                      onPressed: () {
                        context.read<AuthCubit>().register(
                            userNameController.text,
                            passwordController.text,
                            emailController.text,
                            phoneController.text);
                      }),
                  SizedBox(height: 24),
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
