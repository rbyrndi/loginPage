import 'package:flutter/material.dart';
import 'package:loginpage/home_page.dart'; // Ganti dengan nama project Anda
import 'package:loginpage/signup_page.dart'; // Ganti dengan nama project Anda

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _isLoading = false;

  // --- PALET WARNA CYBERPUNK ---
  static const Color _darkBg = Color(0xFF0A0E27); // Biru gelap sekali
  static const Color _cardColor = Color(0xFF1A1F3A); // Sedikit lebih terang dari bg
  static const Color _primaryNeon = Color(0xFF00FFFF); // Cyan / Aqua
  static const Color _secondaryNeon = Color(0xFFFF00FF); // Magenta / Pink
  static const Color _accentNeon = Color(0xFF39FF14); 

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await Future.delayed(const Duration(seconds: 2));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Background gelap
      backgroundColor: _darkBg,
      body: Stack(
        children: [
          // --- Background Grid Pattern ---
          CustomPaint(
            size: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
            painter: GridPainter(),
          ),
          // --- Konten Utama ---
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Container(
                  // --- Kartu dengan Efek Neon ---
                  decoration: BoxDecoration(
                    color: _cardColor,
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(
                      color: _primaryNeon.withOpacity(0.5),
                      width: 1.5,
                    ),
                    // Membuat efek glow/blur di luar border
                    boxShadow: [
                      BoxShadow(
                        color: _primaryNeon.withOpacity(0.4),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // --- Judul dengan Efek Glitch ---
                          _buildGlitchText("SYSTEM ACCESS"),
                          const SizedBox(height: 40),

                          // --- Input Field Email ---
                          _buildCyberTextField(
                            controller: _emailController,
                            labelText: "EMAIL ID",
                            hintText: "user@cyber.net",
                            icon: Icons.person,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email ID required';
                              }
                              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                                return 'Invalid email format';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),

                          // --- Input Field Password ---
                          _buildCyberTextField(
                            controller: _passwordController,
                            labelText: "PASSKEY",
                            hintText: "Enter your passkey",
                            icon: Icons.lock,
                            obscureText: _obscurePassword,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                                color: _primaryNeon,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Passkey required';
                              }
                              if (value.length < 6) {
                                return 'Passkey must be 6+ chars';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),

                          // Tombol Lupa Password
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('INITIATING PASSWORD RECOVERY...'),
                                    backgroundColor: Colors.grey,
                                  ),
                                );
                              },
                              child: const Text(
                                'FORGOT PASSKEY?',
                                style: TextStyle(color: _secondaryNeon),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),

                          // --- Tombol Login Cyberpunk ---
                          SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _login,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent, // Background transparan
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: const BorderSide(color: _primaryNeon, width: 2),
                                ),
                              ),
                              child: Ink(
                                decoration: BoxDecoration(
                                  color: _primaryNeon.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Container(
                                  constraints: const BoxConstraints(minWidth: double.infinity, minHeight: 55),
                                  alignment: Alignment.center,
                                  child: _isLoading
                                      ? const CircularProgressIndicator(color: _primaryNeon)
                                      : const Text(
                                          'LOGIN',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: _primaryNeon,
                                            letterSpacing: 2,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Link ke Halaman Sign Up
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'NEW USER?',
                                style: TextStyle(color: Colors.white70),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const SignupPage()),
                                  );
                                },
                                child: const Text(
                                  'REGISTER',
                                  style: TextStyle(
                                    color: _accentNeon,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Widget untuk Membuat Teks Glitch ---
  Widget _buildGlitchText(String text) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Lapisan teks utama (Cyan)
        Text(
          text,
          // Jika Anda menambah font Orbitron, gunakan ini:
          // style: TextStyle(fontFamily: 'Orbitron', ...),
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: _primaryNeon,
            letterSpacing: 3,
          ),
        ),
        // Lapisan glitch 1 (Magenta, sedikit offset)
        Transform.translate(
          offset: const Offset(2, 2),
          child: Opacity(
            opacity: 0.6,
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: _secondaryNeon,
                letterSpacing: 3,
              ),
            ),
          ),
        ),
        // Lapisan glitch 2 (Hijau, sedikit offset)
        Transform.translate(
          offset: const Offset(-2, -2),
          child: Opacity(
            opacity: 0.4,
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: _accentNeon,
                letterSpacing: 3,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // --- Widget untuk Input Field Cyberpunk ---
  Widget _buildCyberTextField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    required IconData icon,
    bool obscureText = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        hintStyle: TextStyle(color: _primaryNeon.withOpacity(0.5)),
        labelStyle: const TextStyle(color: _primaryNeon),
        prefixIcon: Icon(icon, color: _primaryNeon),
        suffixIcon: suffixIcon,
        // Border saat tidak fokus
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: _primaryNeon, width: 1.0),
        ),
        // Border saat fokus
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: _accentNeon, width: 2.0),
        ),
        // Border saat error
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.redAccent, width: 2.0),
        ),
        errorStyle: const TextStyle(color: Colors.redAccent),
      ),
    );
  }
}

// --- Custom Painter untuk Background Grid ---
class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF00FFFF).withOpacity(0.05) // Warna cyan sangat transparan
      ..strokeWidth = 0.5;

    // Menggambar garis vertikal
    for (double i = 0; i < size.width; i += 30) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }

    // Menggambar garis horizontal
    for (double i = 0; i < size.height; i += 30) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
