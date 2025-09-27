import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/injection_container.dart';
import 'features/lectura_temporal/presentation/pages/lectura_temporal_page.dart';
import 'features/barcode_scanner/presentation/pages/barcode_scanner_page.dart';
import 'features/barcode_scanner/presentation/bloc/barcode_scanner_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Configurar inyección de dependencias
  await configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lectura Temporal',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const LecturaTemporalPage(),
    BarcodeScannerPageWrapper(),
    const ConfiguracionPage(),
    const PerfilPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Lecturas'),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: 'Escáner',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configuración',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}

// Páginas de placeholder para el menú
class ConfiguracionPage extends StatelessWidget {
  const ConfiguracionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.settings, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Página de Configuración',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Aquí podrás configurar las preferencias\nde tu app de lectura temporal',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Tu Perfil',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Información de tu cuenta\ny estadísticas de lectura',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class BarcodeScannerPageWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<BarcodeScannerBloc>(),
      child: const BarcodeScannerPage(),
    );
  }
}
