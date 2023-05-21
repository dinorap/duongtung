import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, required this.email}) : super(key: key);

  final String email;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}
User user = User(name: "User");
class _ProfilePageState extends State<ProfilePage> {
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {

    // lấy thông tin cá nhân của người dùng và hiển thị lên form
    nameController.text = user.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name'),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: "Enter your name"
              ),
            ),
            SizedBox(height: 16),
            Text('Email'),
            TextFormField(
              readOnly: true,
              initialValue: widget.email,

            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // lưu thông tin cá nhân sau khi người dùng chỉnh sửa
                user.name = nameController.text;
                setState(() {});
                FocusScope.of(context).unfocus();
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

class User {
  String name;

  User({required this.name});
}
