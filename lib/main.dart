import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Input',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.deepPurple),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.normal,
          ),
        ),
        colorScheme:
        ColorScheme.fromSeed(seedColor: Colors.deepPurple).copyWith(
          primary: Colors.deepPurple,
          surface: Colors.white,
        ),
        useMaterial3: true,
      ),
      home: UserInput(),
    );
  }
}

class UserInput extends StatefulWidget {
  @override
  _UserInputState createState() => _UserInputState();
}

class _UserInputState extends State<UserInput> {
  final TextEditingController _textEditingController = TextEditingController();

  String _errorText = '';

  void _userinput() async{
    String inputTeks = _textEditingController.text.trim();
  }

  String _validateInput(String inputText) {
    if (inputText.isEmpty) {
      return 'Masukkan tidak boleh kosong';
    } else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(inputText)) {
      return 'Hanya huruf alfabet diperbolehkan';
    }
    return ''; // Input valid
  }

  void _onSubmit() {
    String inputText = _textEditingController.text;
    String errorMessage = _validateInput(inputText);

    if (errorMessage.isNotEmpty) {
      // Tampilkan pesan kesalahan di bawah TextField
      setState(() {
        _errorMessage = errorMessage;
      });
    } else {
      // Input valid, lakukan tindakan selanjutnya
      print('Input valid: $inputText');
    }
  }

  void _clearInput() {
    _textEditingController.clear();
    setState(() {
      _errorMessage = '';
    });
  }

  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Input'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                labelText: 'Masukkan teks',
                border: OutlineInputBorder(),
                errorText: _errorMessage,
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: _clearInput,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _errorMessage = ''; // Reset pesan kesalahan saat pengguna mengubah input
                });
              },
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity, // Membuat tombol melebar sesuai lebar parent
              child: ElevatedButton(
                onPressed: _onSubmit,
                child: Text('Kirim'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
