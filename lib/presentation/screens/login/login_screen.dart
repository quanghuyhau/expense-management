import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qlct/presentation/cubit/auth/auth_cubit.dart';
import 'package:qlct/presentation/cubit/auth/auth_state.dart';
import 'package:qlct/presentation/screens/home/home_screen.dart';
import 'package:qlct/presentation/screens/register/register_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Đăng nhập",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(height: 10),
              const Text(
                "Chào mừng trở lại! Quản lý chi tiêu hiệu quả ngay hôm nay.",
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              _buildTextField(emailController, "Email", Icons.email),
              const SizedBox(height: 15),
              _buildTextField(passwordController, "Mật khẩu", Icons.lock, obscureText: true),
              const SizedBox(height: 30),

              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
                  }
                  if (state is AuthSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Đăng nhập thành công!")),
                    );
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));

                  }
                },
                builder: (context, state) {
                  return Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          context.read<AuthCubit>().signIn(emailController.text.trim(), passwordController.text.trim());
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          backgroundColor: Colors.blueAccent,
                        ),
                        child: state is AuthLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text("Đăng nhập", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                      ),
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen()));
                        },
                        child: const Text(
                          "Chưa có tài khoản? Đăng ký ngay",
                          style: TextStyle(fontSize: 16, color: Colors.blueAccent),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, IconData icon, {bool obscureText = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: hint,
        prefixIcon: Icon(icon, color: Colors.blueAccent),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.grey[200],
      ),
      obscureText: obscureText,
    );
  }
}
