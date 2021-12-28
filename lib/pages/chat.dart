import 'dart:async';

import 'package:cash_collector/composants/app_bar_content.dart';
import 'package:cash_collector/composants/circular_button.dart';
import 'package:cash_collector/composants/own_message_card.dart';
import 'package:cash_collector/composants/reply_message_card.dart';
import 'package:cash_collector/models/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_size/flutter_keyboard_size.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  ChatState createState() => ChatState();
}

class ChatState extends State<Chat> {
  bool workStatus = true;
  bool sendButton = false;
  TextEditingController messageController = TextEditingController();
  ScrollController _scrollController = ScrollController();

  List<Message> messages = [
    Message(message: "Hello There! 😜", date: "12.05", me:false),
    Message(message: "Oh Hi", date: "12.05", me: true),
    Message(message: "Your package will arrive soon! just prepare", date: "12.05", me: false),
    Message(message: "Hello There! 😜", date: "12.05", me:false),
    Message(message: "Your package will arrive soon! just prepare", date: "12.05", me: true),
    Message(message: "Your package will arrive soon! just prepare", date: "12.05", me: false),
    Message(message: "Hello There! 😜", date: "12.05", me:false),
    Message(message: "Your package will arrive soon! just prepare", date: "12.05", me: true),
    Message(message: "Your package will arrive soon! just prepare", date: "12.05", me: false),
    Message(message: "Hello There! 😜", date: "12.05", me:false),
    Message(message: "Oh Hi", date: "12.05", me: true),
    Message(message: "Your package will arrive soon! just prepare", date: "12.05", me: false),
    Message(message: "Hello There! 😜", date: "12.05", me:false),
    Message(message: "Your package will arrive soon! just prepareYour package will arrive soon! just prepare", date: "12.05", me: true),
    Message(message: "Your package will arrive soon! just prepare", date: "12.05", me: false),
  ];

  @override
  void dispose() {
    // TODO: implement dispose
    messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardSizeProvider(
      smallSize: 500,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(57),
          child: AppBarContent(
            title: "Chat",
            icon: Icons.arrow_back_ios,
            onPressBtnMenu: (){Navigator.pop(context);},
          ),
        ),
        body: Consumer<ScreenHeight>(
          builder: (context, _res, child) {
            return Center(
              child: SingleChildScrollView(
                child: Container(
                    color: const Color(0xFFF3F3FF),
                    height: MediaQuery.of(context).size.height - 81 - _res.keyboardHeight,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: ListView.builder(
                                shrinkWrap: true,
                                controller: _scrollController,
                                itemCount: messages.length +1,
                                itemBuilder: (context, index) {
                                  if(index == 0) {
                                    return Container();
                                  }
                                  if(messages[messages.length-index].me == true) {
                                    return OwnMessageCard(message: messages[messages.length-index].message, date: messages[messages.length-index].date);
                                  } else {
                                    return ReplyMessageCard(message: messages[messages.length-index].message, date: messages[messages.length-index].date);
                                  }
                                }
                            ),
                          ),
                        ),

                        Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                children: [
                                  //const CircularButton(icon: Icons.emoji_emotions_outlined,size: 35, sizeIcon: 22,),
                                  //const SizedBox(width: 6,),
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.only(bottom: 0, left: 2, top: 0),
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(25)),
                                        color: Colors.white,
                                      ),
                                      child: TextFormField(
                                        controller: messageController,
                                        textAlignVertical: TextAlignVertical.center,
                                        keyboardType: TextInputType.multiline,
                                        maxLines: 5,
                                        minLines: 1,
                                        onChanged: (value){
                                          if(value.length>0){
                                            setState(() {
                                              sendButton = true;
                                            });
                                          }
                                          else {
                                            setState(() {
                                              sendButton = false;
                                            });
                                          }
                                        },
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Type a message",
                                          contentPadding: EdgeInsets.all(15),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 6,),
                                  InkWell(
                                    onTap: (){
                                      if(messageController.text.isNotEmpty) {
                                        setState(() {
                                          messages.insert(0,Message(message: messageController.text, date: "now", me: true));
                                          messageController.clear();
                                        });
                                        Timer(Duration(milliseconds: 500), () {
                                          _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                                        });
                                      }
                                    },
                                    child: const CircularButton(icon: Icons.send,size: 35, sizeIcon: 22,),
                                  )
                                  //const SizedBox(width: 6,),
                                  //const CircularButton(icon: Icons.photo_camera,size: 35, sizeIcon: 22,),
                                ],
                              ),
                            )
                        )
                      ],
                    )
                ),
              ),
            );
          },
        )
      ),
    );
  }
}