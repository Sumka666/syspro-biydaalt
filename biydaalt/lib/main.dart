import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Биедаалт №1',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    LoginPage(),
    HobbyPage(),
    ExtraPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Colors.blueAccent,
        items: const [
          TabItem(icon: Icons.login, title: 'Нэвтрэх'),
          TabItem(icon: Icons.favorite, title: 'Хобби'),
          TabItem(icon: Icons.auto_awesome, title: 'Шинэ'),
        ],
        initialActiveIndex: _selectedIndex,
        onTap: (int i) {
          setState(() {
            _selectedIndex = i;
          });
        },
      ),
    );
  }
}

//
// -------------- 1-р хуудас: НЭВТРЭХ ХУУДАС -----------------
//
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.blue.shade200,
                    child: const Icon(Icons.person, size: 50, color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Системд нэвтрэх",
                    style: GoogleFonts.poppins(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: "Имэйл",
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Нууц үг",
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Тавтай морил, ${emailController.text}!"),
                      ));
                    },
                    icon: const Icon(Icons.login),
                    label: const Text("Нэвтрэх"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// -------------- 2-r huudas -----------------
class HobbyPage extends StatelessWidget {
  const HobbyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Миний Хобби"),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Hero(
              tag: "profile",
              child: CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/profile.png'),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              "Сумъяабазар Даваахүү",
              style:
                  GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            RichText(
              text: TextSpan(
                style: GoogleFonts.poppins(fontSize: 16, color: Colors.black87),
                children: const [
                  TextSpan(text: "Миний хобби бол "),
                  TextSpan(
                      text: "Хөгжим сонсох, код бичих, шүлэг эсвэл толгой доторхоо бичих, алхах ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: "юм. Мандах МТС их сургуулийн 3р курсэд суралцдаг."),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Flexible(
                  child: Card(
                    child: Column(
                      children: [
                        Image.asset('assets/hobby1.jpeg', fit: BoxFit.cover, height: 390, width: 500, ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(  "Би чөлөөт цагаараа сагс тоглох дуртай мөн би NBA буюу АНУ үндэсний сагсны лигийг үзэх маш их дуртай."),
                        ),
                        
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Card(
                    child: Column(
                      children: [
                        Image.asset('assets/hobby2.jpeg', fit: BoxFit.cover, height: 390, width: 500,),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Яагаад ч юм яварваа нэгэн толгойд орхоор юм бичмээр санагддаг магадгүй өөрөө байнга ишлэл уншдаг болохоор байх."),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// -------------- 3-r huudas -----------------
class ExtraPage extends StatelessWidget {
  const ExtraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text("Шинэлэг хуудас"),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Lottie.asset('assets/animation.json', height: 200),
            const SizedBox(height: 20),
            SelectableText(
              "Энэ бол Lottie animation, Hero, InteractiveViewer ашигласан шинэлэг хуудас юм!",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: InteractiveViewer(
                panEnabled: true,
                minScale: 0.8,
                maxScale: 3,
                child: Image.asset('assets/nature.webp'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
