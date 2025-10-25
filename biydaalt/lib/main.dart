import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:introduction_screen/introduction_screen.dart';

void main() {
  runApp(const MyApp());
}
class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Сайн байна уу!",
          body: "Энэ бол миний Flutter апп танилцуулга хуудас.",
          image: Center(child: Image.asset('assets/intro.jpg', height: 200)),
          decoration: const PageDecoration(
            titleTextStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            bodyTextStyle: TextStyle(fontSize: 18),
          ),
        ),
        PageViewModel(
          title: "Хобби болон мэдээ",
          body: "Миний хобби болон бусад мэдээллийг эндээс харах боломжтой.",
          image: Center(child: Image.asset('assets/intro.jpg', height: 200)),
        ),
        PageViewModel(
          title: "Эцсийн хуудас",
          body: "Нэвтрэх товчийг дарж системд орно уу.",
          image: Center(child: Image.asset('assets/intro.jpg', height: 200)),
        ),
      ],
      onDone: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainPage()),
        );
      },
      onSkip: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainPage()),
        );
      },
      showSkipButton: true,
      skip: const Text("Алгасах"),
      next: const Icon(Icons.arrow_forward),
      done: const Text("Эхлэх", style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: const DotsDecorator(
        activeColor: Colors.blueAccent,
      ),
    );
  }
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Бие даалт №1',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const IntroPage(),
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

// -------------- 1r huudas -----------------
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.blue.shade200,
                    child: const Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Системд нэвтрэх",
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  const SizedBox(height: 20),
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
                      final name = emailController.text.trim();
                      if (name.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Имэйлээ оруулна уу!"),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Тавтай морил, $name!")),
                        );
                      }
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

// -------------- 2r huudas -----------------
class HobbyPage extends StatelessWidget {
  const HobbyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Миний хобби"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: const AssetImage('assets/profile.png'),
            ),
            const SizedBox(height: 15),
            Text(
              "Сумъяабазар Даваахүү",
              style: GoogleFonts.poppins(
                  fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "Мандах МТС — 3-р курсийн оюутан. Миний хобби бол хипхоп хөгжим сонсох, код бичих, шүлэг бичих, алхах юм.",
              style: GoogleFonts.poppins(fontSize: 16),
              textAlign: TextAlign.center,

            ),
        
            const SizedBox(height: 25),
            Row(
              children: [
                Expanded(
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12)),
                          child: Image.asset(
                            'assets/hobby1.jpeg',
                            fit: BoxFit.cover,
                            height: 200,
                            width: double.infinity,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            "Сагсан бөмбөг үзэх, тоглох дуртай. NBA үзэх маш их дуртай.",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12)),
                          child: Image.asset(
                            'assets/hobby2.jpeg',
                            fit: BoxFit.cover,
                            height: 200,
                            width: double.infinity,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            "Толгойдоо орж ирсэн санаагаа бичих дуртай. Энэ нь надад амар тайван мэдрэмж төрүүлдэг.",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// -------------- 3r huudas -----------------
class ExtraPage extends StatelessWidget {
  const ExtraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text("3-р хуудас"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              SizedBox(
                height: 200,
                child: Lottie.asset('assets/animation.json'),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SelectableText(
                  "Энэ хуудсанд Lottie animation болон InteractiveViewer ашиглав.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 300, 
                child: InteractiveViewer(
                  panEnabled: true,
                  minScale: 0.8,
                  maxScale: 3,
                  child: Image.asset('assets/nature.webp'),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}


