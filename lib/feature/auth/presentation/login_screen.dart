import 'package:counter/feature/auth/logic/auth_cubit.dart';
import 'package:counter/feature/auth/presentation/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:counter/feature/home/presentation/onboard1.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../home/presentation/home_screen.dart';

class CustomSocialButton extends StatelessWidget {
  final String label;
  final String iconPath;
  final VoidCallback onPressed;

  const CustomSocialButton({
    super.key,
    required this.label,
    required this.iconPath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.grey.shade400),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(iconPath, height: 24),
            SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}

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
                  TextButton(
                    onPressed: () {
                      // Navigate to the Forget Password screen or implement reset logic
                    },
                    child: Text(
                      "                       Forgot Password?",
                      style: TextStyle(color: Colors.black, fontSize: 15),
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
                  CustomSocialButton(
                    label: "Continue with Google",
                    iconPath: "assets/google.svg", // Your Google logo SVG
                    onPressed: () {
                      // Handle Google Sign-In logic
                    },
                  ),

                  SizedBox(height: 16),

                  // Facebook Login Button
                  CustomSocialButton(
                    label: "Continue with Facebook",
                    iconPath: "assets/facebook.svg", // Your Facebook logo SVG
                    onPressed: () {
                      // Handle Facebook Sign-In logic
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(color: Colors.black, fontSize: 15),
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
