import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qlct/common/app_scaffold_widget.dart';
import 'package:qlct/common/load_image/load_image.dart';
import 'package:qlct/generated/assets.dart';
import 'package:qlct/generated/l10n.dart';
import 'package:qlct/presentation/cubit/auth/auth_cubit.dart';
import 'package:qlct/presentation/cubit/auth/auth_state.dart';
import 'package:qlct/presentation/screens/home/home_screen.dart';
import 'package:qlct/presentation/screens/register/register_screen.dart';
import 'package:qlct/utilities/style/style.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
        if (state is AuthSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Đăng nhập thành công!")),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        }
      },
      builder: (context, state) {
        return AppScaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    _logoApp(),
                    const SizedBox(height: 52),
                    _btnEnterUserAndPass(emailController, S.current.loginName,
                        Assets.iconsIcUser),
                    const SizedBox(height: 20),
                    _btnEnterUserAndPass(passwordController, S.current.passWord,
                        Assets.iconsIcPass),
                    const SizedBox(height: 24),
                    _btnLogin(context),
                    SizedBox(
                      height: 36,
                    ),
                    _forgotPass(context),
                    SizedBox(height: 24,),
                    _loginWithGoogleOrApple(context,S.current.google,  Assets.iconsIcGg),
                    SizedBox(height: 24,),
                    _loginWithGoogleOrApple(context,S.current.apple,  Assets.iconsIcApple),
                    SizedBox(height: 28,),
                    _dontAccountSignUp(),
                    SizedBox(height: 30,)
                  ],
                ),
              ),
              if (state is AuthLoading)
                const Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        );
      },
    );
  }

  _logoApp() {
    return Padding(
      padding: const EdgeInsets.only(top: 60),
      child: Center(
        child: Column(
          children: [
            LoadImage(
              url: Assets.imagesImgLogoApp,
              height: 88,
              width: 88,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              S.current.titleApp,
              style: theme.font.text32bold,
            )
          ],
        ),
      ),
    );
  }

  _btnEnterUserAndPass(
      TextEditingController controller, String hint, String imagePath,
      {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: StatefulBuilder(
        builder: (context, setState) {
          controller.addListener(() {
            setState(() {});
          });
          return TextField(
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(
              labelText: hint,
              labelStyle: TextStyle(
                color: controller.text.isEmpty
                    ? const Color(0xFF9BA1A8)
                    : const Color(0xFF242D35),
              ),
              floatingLabelStyle: const TextStyle(
                color: Color(0xFF242D35),
              ),
              filled: true,
              fillColor: const Color(0xFFF5F6F7),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 16, right: 8),
                child: LoadImage(
                  url: imagePath,
                  width: 24,
                  height: 24,
                  boxFit: BoxFit.contain,
                ),
              ),
              prefixIconConstraints:
                  const BoxConstraints(minWidth: 40, minHeight: 20),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFDCDDE3)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFDCDDE3)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    const BorderSide(color: Color(0xFFDCDDE3), width: 2),
              ),
            ),
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF333333),
            ),
          );
        },
      ),
    );
  }

  _btnLogin(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<AuthCubit>().signIn(
              emailController.text.trim(),
              passwordController.text.trim(),
            );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 56,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.centerLeft,
              colors: [
                Color(0xFF2FDAFF),
                Color(0xFF0E33F3),
              ],
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFF000000),
              width: 1,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            S.current.login,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  _forgotPass(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
            child: Text(
              S.current.forgotPass,
              style: theme.font.text14w6B7580,
            )),
        SizedBox(
          height: 20,
        ),
        Text(
          S.current.or,
          style: theme.font.text16or242D35,
        )
      ],
    );
  }

  _loginWithGoogleOrApple(BuildContext context, String hint, String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFFB0B8BF),
            width: 1,
          ),
        ),
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(left: 16,top: 16,bottom: 16),
          child: Row(
            children: [
              LoadImage(url: imagePath,height: 22,width: 22,),
              SizedBox(width: 24,),
              Text(hint,style: theme.font.text16or242D35bold,)
            ],
          ),
        ),
      ),
    );
  }


  _dontAccountSignUp(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      Text(S.current.dontAccount,style: theme.font.text16or242D35,),
        SizedBox(width: 6,),
        Text(S.current.signUp,style: theme.font.text14or0E33F3,),
      ],
    );
  }

}
