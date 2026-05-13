import 'package:chat_appb/constants.dart';
import 'package:chat_appb/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  CollectionReference messages = FirebaseFirestore.instance.collection(
    KMessagesCollection,
  );
  void sendMessage({required String message, required String email}) {
    try {
      messages.add({
        KMessage: message,
        KCreatedAt: DateTime.now(),
        'id': email,
      });
    } on Exception catch (e) {}
  }

  void getMessage() {
    messages.orderBy(KCreatedAt, descending: true).snapshots().listen((event) {
      List<MessageModel> messagesList = [];
      for (var doc in event.docs) {
        messagesList.add(MessageModel.fromJason(doc));
      }
      emit(ChatSuccess(messagesList: messagesList));
    });
  }
}
