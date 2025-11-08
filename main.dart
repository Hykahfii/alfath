import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/// Simple theme/colors used across the app
const Color primaryColor = Color(0xFF2B7A78);
const Color accentColor = Color(0xFF2C7AEB);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tugas UTS - Mobile Progamming',
      theme: ThemeData(
        primaryColor: primaryColor,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: accentColor),
        scaffoldBackgroundColor: Colors.grey[100],
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryColor,
          elevation: 0,
          centerTitle: true,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}

/// ---------------------------
/// Login Page
/// ---------------------------
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _usernameCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState?.validate() ?? false) {
      // For demo, pass entered username to Dashboard
      final username = _usernameCtrl.text.trim();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => DashboardPage(username: username.isEmpty ? 'Andi' : username),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top spacing + logo
              Row(
                children: [
                  // Try to load local asset; fallback to network image
                  SizedBox(
                    width: 64,
                    height: 64,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Image.network(
                          'https://via.placeholder.com/150',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Selamat Datang', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text('Aplikasi demo untuk tugas UI — simpel & rapi', style: TextStyle(fontSize: 13, color: Colors.black54)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Card containing form
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Title
                      const Align(alignment: Alignment.centerLeft, child: Text('Masuk', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
                      const SizedBox(height: 12),

                      // Username / Email field with icon
                      TextFormField(
                        controller: _usernameCtrl,
                        decoration: const InputDecoration(
                          hintText: 'Email atau Username',
                          prefixIcon: Icon(Icons.person),
                        ),
                        validator: (v) => (v == null || v.trim().isEmpty) ? 'Masukkan username/email' : null,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 12),

                      // Password field with lock icon
                      TextFormField(
                        controller: _passwordCtrl,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
                            onPressed: () => setState(() => _obscure = !_obscure),
                          ),
                        ),
                        obscureText: _obscure,
                        validator: (v) => (v == null || v.isEmpty) ? 'Masukkan password' : null,
                      ),
                      const SizedBox(height: 18),

                      // Login button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: const Text('Login', style: TextStyle(fontSize: 16)),
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Small note
                      TextButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Lupa password? fitur demo')));
                        },
                        child: const Text('Lupa password?', style: TextStyle(color: Colors.black54)),
                      )
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // Footer / hint
              const Center(
                child: Text('Atau lanjutkan sebagai guest', style: TextStyle(color: Colors.black54)),
              ),
              const SizedBox(height: 12),

              // Guest quick button
              Center(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const DashboardPage(username: 'Tamu')));
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 28),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Masuk sebagai Guest'),
                ),
              ),

              SizedBox(height: media.height * 0.08),
              const Center(child: Text('— dibuat untuk tugas UI Flutter —', style: TextStyle(color: Colors.black45, fontSize: 12))),
            ],
          ),
        ),
      ),
    );
  }
}

/// ---------------------------
/// Dashboard Page
/// ---------------------------
class DashboardPage extends StatelessWidget {
  final String username;
  const DashboardPage({Key? key, required this.username}) : super(key: key);

  // Menu item model
  Widget _menuItem(BuildContext context, IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8)],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 28, color: primaryColor),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Example banner source: try local asset first, fallback to network
    final banner = Image.asset(
      'assets/images/banner.jpg',
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => Image.network(
        'https://via.placeholder.com/800x200',
        fit: BoxFit.cover,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Aplikasi Demo'),
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Notifikasi kosong (demo)')));
            },
            icon: const Icon(Icons.notifications),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header greeting + avatar
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Halo, $username', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      const Text('Selamat datang di dashboard aplikasi.', style: TextStyle(color: Colors.black54)),
                    ],
                  ),
                ),
                // small avatar (local or network fallback)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/images/avatar.png',
                    width: 56,
                    height: 56,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Image.network('https://via.placeholder.com/100', width: 56, height: 56, fit: BoxFit.cover),
                  ),
                )
              ],
            ),
            const SizedBox(height: 14),

            // Banner
            Container(
              height: 150,
              width: double.infinity,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
              child: banner,
            ),
            const SizedBox(height: 16),

            // Menu grid (3 items min)
            const Text('Menu Cepat', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.9,
              children: [
                _menuItem(context, Icons.person, 'Profil', () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => ProfilePage(
                    name: username,
                    id: '12345678',
                    email: '${username.toLowerCase()}@mail.com',
                    prodi: 'Informatika',
                    semester: '4',
                  )));
                }),
                _menuItem(context, Icons.list_alt, 'Data', () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Menu Data (demo)')));
                }),
                _menuItem(context, Icons.settings, 'Pengaturan', () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Menu Pengaturan (demo)')));
                }),
                // Extra items to show flexibility
                _menuItem(context, Icons.history, 'Riwayat', () {}),
                _menuItem(context, Icons.chat, 'Chat', () {}),
                _menuItem(context, Icons.card_giftcard, 'Promo', () {}),
              ],
            ),

            const SizedBox(height: 18),

            // Sample card with some info
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Info Singkat', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('Ini adalah halaman dashboard sederhana yang memenuhi spesifikasi tugas.'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ---------------------------
/// Profile Page
/// ---------------------------
class ProfilePage extends StatelessWidget {
  final String name;
  final String id;
  final String email;
  final String prodi;
  final String semester;

  const ProfilePage({
    Key? key,
    required this.name,
    required this.id,
    required this.email,
    required this.prodi,
    required this.semester,
  }) : super(key: key);

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.w600)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Avatar with fallback
    final avatar = Image.asset(
      'assets/images/avatar.png',
      width: 110,
      height: 110,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => Image.network('https://via.placeholder.com/110', width: 110, height: 110, fit: BoxFit.cover),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Avatar + basic info card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
              child: Column(
                children: [
                  ClipRRect(borderRadius: BorderRadius.circular(60), child: avatar),
                  const SizedBox(height: 12),
                  Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Text(email, style: const TextStyle(color: Colors.black54)),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Detailed info
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Detail', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  _infoRow('Nama', name),
                  _infoRow('NIM / ID', id),
                  _infoRow('Email', email),

                  const SizedBox(height: 8),

                  // Small row for Prodi - Semester
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Prodi', style: TextStyle(fontSize: 12, color: Colors.black54)),
                              const SizedBox(height: 6),
                              Text(prodi, style: const TextStyle(fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Semester', style: TextStyle(fontSize: 12, color: Colors.black54)),
                              const SizedBox(height: 6),
                              Text(semester, style: const TextStyle(fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  // Back button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('Kembali ke Dashboard'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
