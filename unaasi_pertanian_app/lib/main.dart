import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(UnaasiPertanianApp());
}

class UnaasiPertanianApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final baseTheme = ThemeData(
      primarySwatch: Colors.green,
      textTheme: GoogleFonts.openSansTextTheme(
        Theme.of(context).textTheme,
      ),
      scaffoldBackgroundColor: Colors.grey[50],
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.green[700],
        elevation: 4,
        titleTextStyle: GoogleFonts.openSans(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      cardTheme: CardTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: Colors.green[800],
        unselectedItemColor: Colors.grey[600],
        backgroundColor: Colors.white,
        elevation: 8,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
      ),
    );

    return MaterialApp(
      title: 'Pertanian Kelurahan Unaasi',
      theme: baseTheme,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    OverviewScreen(),
    CropManagementScreen(),
    WeatherScreen(),
    FarmerContactScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pertanian Kelurahan Unaasi'),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green[700],
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Overview',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.agriculture),
            label: 'Crops',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud),
            label: 'Weather',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_phone),
            label: 'Farmers',
          ),
        ],
      ),
    );
  }
}

class OverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Welcome to Pertanian Kelurahan Unaasi App',
        style: TextStyle(fontSize: 20),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class CropManagementScreen extends StatefulWidget {
  @override
  _CropManagementScreenState createState() => _CropManagementScreenState();
}

class _CropManagementScreenState extends State<CropManagementScreen> {
  final List<String> _crops = ['Padi', 'Jagung', 'Kedelai'];
  final TextEditingController _controller = TextEditingController();

  void _addCrop() {
    final String newCrop = _controller.text.trim();
    if (newCrop.isNotEmpty) {
      setState(() {
        _crops.add(newCrop);
      });
      _controller.clear();
    }
  }

  void _removeCrop(int index) {
    setState(() {
      _crops.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            'Daftar Tanaman',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: 'Tambah Tanaman Baru',
              suffixIcon: IconButton(
                icon: Icon(Icons.add, color: Colors.green[700]),
                onPressed: _addCrop,
              ),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: _crops.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(_crops[index]),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    _removeCrop(index);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Tanaman "${_crops[index]}" dihapus')),
                    );
                  },
                  background: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    margin: EdgeInsets.symmetric(vertical: 4),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                    child: ListTile(
                      title: Text(_crops[index]),
                      leading: Icon(Icons.agriculture, color: Colors.green[700]),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class WeatherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.cloud, size: 64, color: Colors.blueGrey),
                SizedBox(height: 16),
                Text(
                  'Cuaca Hari Ini',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Data cuaca akan ditampilkan di sini.',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FarmerContactScreen extends StatelessWidget {
  final List<Map<String, String>> farmers = [
    {'name': 'Pak Budi', 'phone': '081234567890'},
    {'name': 'Bu Sari', 'phone': '082345678901'},
    {'name': 'Pak Agus', 'phone': '083456789012'},
  ];

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            'Kontak Petani',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: farmers.length,
              itemBuilder: (context, index) {
                final farmer = farmers[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                  margin: EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    leading: Icon(Icons.person, color: Colors.green[700]),
                    title: Text(farmer['name']!),
                    subtitle: Text(farmer['phone']!),
                    trailing: Icon(Icons.phone, color: Colors.green[700]),
                    onTap: () {
                      _makePhoneCall(farmer['phone']!);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
