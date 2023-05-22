
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_weather_app_v2/components/weather_item.dart';
import 'package:flutter_weather_app_v2/constants.dart';
import 'package:flutter_weather_app_v2/ui/detail_page.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../login/auth_controller.dart';
import '../login/chatgpt_api.dart';
import '../login/model.dart';
import 'ChangePasswordPage.dart';
import 'ProfilePage.dart';



class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}



class _ChatPageState extends State<ChatPage> {
  final _textController = TextEditingController();
  final _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  late bool isLoading;
  final ChatGPTApi chatGPTApi = ChatGPTApi(
      apiKey: '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'); // Tạo

  @override
  void initState() {
    super.initState();
    isLoading = false;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0x95ddc6b6),
      appBar: AppBar(
        toolbarHeight: 100,
        titleSpacing: 0,
        title: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: const Color(0xffddc6b6),
                radius: 35,
                child: ClipOval(
                  child: Image.asset(
                    'assets/chatlogo.png',
                  ),
                ),
              ),

              const SizedBox(width: 85), // căn chữ
              const Text(
                "CHAT BOT",
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFddc6b6),
                ),
              ),


            ],
          ),
        ),
        backgroundColor: const Color(0xFF262223),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
              AuthController.instance.logout();
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: _buildBody(context),
    );
  }



  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [


          Expanded(
            child: _buildList(),
          ),
          Visibility(
            visible: isLoading,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(
                color: Color(0xff262223),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                _buildInput(),
                const SizedBox(width: 5),
                _buildSubmit(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmit() {
    return Visibility(
      visible: !isLoading,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xffddc6b6), // phần nút gửi
          borderRadius: BorderRadius.circular(
            6,
          ),
        ),
        child: IconButton(
          icon: const Icon(
            Icons.send_rounded,
            color: Color(0xff262223),
          ),
          onPressed: () async {
            setState(
                  () {
                _messages.add(
                  ChatMessage(
                    text: _textController.text,
                    chatMessageType: ChatMessageType.user,
                  ),
                );
                isLoading = true;
              },
            );
            final input = _textController.text;
            _textController.clear();
            Future.delayed(const Duration(milliseconds: 50))
                .then((_) => _scrollDown());
            chatGPTApi.complete(input).then((value) {
              setState(() {
                isLoading = false;
                _messages.add(
                  ChatMessage(
                    text: value,
                    chatMessageType: ChatMessageType.bot,
                  ),
                );
              });
            }).catchError((error) {
              setState(
                    () {
                  final snackBar = SnackBar(
                    content: Text(error.toString()),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  isLoading = false;
                },
              );
            });
          },
        ),
      ),
    );
  }

  Expanded _buildInput() {
    return Expanded(
      child: TextField(
        textCapitalization: TextCapitalization.sentences,
        minLines: 1,
        maxLines: 9,
        controller: _textController,
        decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xffddc6b6),
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
    );
  }


  Widget _buildList() { // phần chính giữa
    if (_messages.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xffddc6b6),
            radius: 55
            ,
            child: ClipOval(
              child: Image.asset(
                'assets/chatlogo.png',
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
            child: Text(
              'XIN CHÀO, BẠN CẦN GIÚP GÌ?',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Color(0xff262223)
                ,fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      controller: _scrollController,
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        var message = _messages[index];
        return ChatMessageWidget(
          text: message.text,
          chatMessageType: message.chatMessageType,
        );
      },
    );
  }

  void _scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}

class ChatMessageWidget extends StatelessWidget {
  const ChatMessageWidget(
      {super.key, required this.text, required this.chatMessageType});

  final String text;
  final ChatMessageType chatMessageType;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0), // dãn dòng
      padding: const EdgeInsets.all(5), // căn góc
      color: chatMessageType == ChatMessageType.bot
          ? const Color(0x80262223) // màu thanh chat khi gửi
          : Color(0x80262223), // màu thanh chat khi gửi
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          chatMessageType == ChatMessageType.bot
              ? Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundColor: const Color(0xff10a37f),
              child: ClipOval(
                child: Image.asset(
                  'assets/chatlogo.png',
                ),
              ),
            ),
          )
              : Container(
            margin: const EdgeInsets.only(right: 16.0), // căn lề
            child: const CircleAvatar(
              child: Icon(
                Icons.person,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: Text(
                    text,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: chatMessageType == ChatMessageType.bot
                          ? Colors.white
                          : Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}





