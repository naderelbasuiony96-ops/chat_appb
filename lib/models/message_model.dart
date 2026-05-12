import 'package:chat_appb/constants.dart';

class MessageModel {
  final String message;
  final String id;
  MessageModel(this.message, this.id);

  factory MessageModel.fromJason(jsondata) {
    return MessageModel(jsondata[KMessage], jsondata['id']);
  }
}
