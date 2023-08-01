import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Afet Mobil Uygulaması',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: LoginPage.routeName,
      routes: {
        LoginPage.routeName: (context) => LoginPage(),
        HomePage.routeName: (context) => HomePage(),
      },
    );
  }
}

class LoginPage extends StatefulWidget {
  static const String routeName = '/login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  String _errorMessage = '';

  void _login() {
    if (_formKey.currentState!.validate()) {
      String username = _usernameController.text;
      Navigator.pushNamed(context, HomePage.routeName, arguments: username);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Kullanıcı Girişi')),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 180.0),
                child: Column(
                  children: [
                    Icon(
                      Icons.person,
                      color: Colors.black,
                      size: 124.0,
                    ),
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: 'Kullanıcı Adı',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Kullanıcı adı boş olamaz';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Şifre',
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Şifre boş olamaz';
                  } else if (value.length < 6) {
                    return 'Şifre 6 karakterden küçük olamaz';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: ElevatedButton(
                  onPressed: _login,
                  child: Text('Giriş'),
                ),
              ),
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    final username = ModalRoute.of(context)!.settings.arguments as String;

    void _logout() {
      Navigator.popUntil(context, ModalRoute.withName(LoginPage.routeName));
    }

    return Scaffold(
      drawer: Menu(),
      appBar: AppBar(
        title: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Ana Sayfa'),
            Text('$username'),
          ],
        )),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: Center(
          child: Container(
        child: Text(
          "ANASAYFA",
          style: TextStyle(fontStyle: FontStyle.italic, fontSize: 50),
        ),
      )),
    );
  }
}

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text("ARAMA KURTARMA UYGULAMASI"), centerTitle: true),
      body: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.cyan),
              accountName: Text(
                "Kerem Özer",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              accountEmail: Text(
                "GEDAK ARAMA KURTARMA",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              currentAccountPicture: Container(
                height: 5,
                width: 5,
                child: Image.asset(
                  "resimler/a.png",
                  alignment: Alignment.center,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.home,
                    ),
                    title: Text("ANASAYFA"),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => HomePage()));
                    },
                  ),
                  ListTile(
                      leading: Icon(Icons.fiber_new_sharp),
                      title: Text("ACİL DURUMLAR"),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => HomePage()));
                      }),
                  ListTile(
                      leading: Icon(Icons.article),
                      title: Text("EKİP BİLDİRİ"),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => HomePage()));
                      }),
                  ListTile(
                      leading: Icon(Icons.location_searching),
                      title: Text(
                        "HARİTA",
                      ),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => HomePage()));
                      }),
                  AboutListTile(
                    applicationName:
                        "BU UYGULAMA KEREM TARAFINDAN LİSANSLANMIŞTIR",
                    applicationIcon: Icon(Icons.save),
                    applicationVersion: "Version 1.0",
                    child: Text("UYGULAMA HAKKINDA"),
                    icon: Icon(Icons.save),
                    applicationLegalese: null,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
