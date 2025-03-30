import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qlct/presentation/cubit/auth/auth_cubit.dart';
import 'package:qlct/presentation/cubit/auth/auth_state.dart';
import 'package:qlct/presentation/screens/login/login_screen.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

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
                "Đăng ký tài khoản",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(height: 10),
              const Text(
                "Tạo tài khoản mới để quản lý chi tiêu dễ dàng!",
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              _buildTextField(emailController, "Email", Icons.email),
              const SizedBox(height: 15),
              _buildTextField(passwordController, "Mật khẩu", Icons.lock, obscureText: true),
              const SizedBox(height: 15),
              _buildTextField(confirmPasswordController, "Xác nhận mật khẩu", Icons.lock, obscureText: true),
              const SizedBox(height: 30),

              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
                  }
                  if (state is AuthSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Đăng ký thành công!")),
                    );
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                  }
                },
                builder: (context, state) {
                  return Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (passwordController.text != confirmPasswordController.text) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Mật khẩu không khớp")));
                            return;
                          }
                          context.read<AuthCubit>().signUp(emailController.text.trim(), passwordController.text.trim());
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          backgroundColor: Colors.blueAccent,
                        ),
                        child: state is AuthLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text("Đăng ký", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                      ),
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Đã có tài khoản? Đăng nhập",
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
