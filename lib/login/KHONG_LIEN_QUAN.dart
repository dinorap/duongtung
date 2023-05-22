PopupMenuButton<String>(
onSelected: (String value) {
if (value == 'logout') {
showDialog(
context: context,
builder: (BuildContext context) {
return AlertDialog(
title: Text("Confirm logout"),
content: Text(
"Are you sure you want to log out?"),
actions: <Widget>[
TextButton(
child: Text("Cancel"),
onPressed: () {
Navigator.of(context).pop();
},
),
TextButton(
child: Text("Log out"),
onPressed: () {
Navigator.of(context).pop();
AuthController.instance.logout();
},
),
],
);
});
} else if (value == 'info') {
Navigator.push(
context,
MaterialPageRoute(
builder: (context) =>
ProfilePage(email: widget.email)),
);
} else if (value == 'change_password') {

}
},
itemBuilder: (BuildContext context) {
return [
PopupMenuItem<String>(
value: 'info',
child: Text('Profile'),
),
PopupMenuItem<String>(
value: 'change_password',
child: Text('Change Password'),
),
PopupMenuItem<String>(
value: 'logout',
child: Text('Log out'),
),
];
},
child: Image.asset(
"assets/menu.png",
width: 40,
height: 40,
),
),