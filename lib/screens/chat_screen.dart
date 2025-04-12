import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:uuid/uuid.dart';

class ChatScreen extends StatefulWidget {
  final String menteeId;
  final String mentorId;

  const ChatScreen({
    super.key,
    required this.menteeId,
    required this.mentorId,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<types.Message> _messages = [];
  late final types.User _currentUser;

  @override
  void initState() {
    super.initState();
    _currentUser = types.User(id: widget.menteeId);
  }

  void _onSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _currentUser,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );

    setState(() {
      _messages.insert(0, textMessage);
    });

    // TODO: send to Firebase or your backend
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat with Mentor')),
      body: Chat(
        messages: _messages,
        onSendPressed: _onSendPressed,
        user: _currentUser,
        theme: DefaultChatTheme(
          backgroundColor: Colors.orange.shade50,
          inputBackgroundColor: Colors.white,
          inputTextColor: Colors.black,
          inputBorderRadius: BorderRadius.circular(16),
          inputTextStyle: const TextStyle(fontSize: 16),
          primaryColor: Colors.orange.shade400,
          sentMessageBodyTextStyle: const TextStyle(color: Colors.white),
          receivedMessageBodyTextStyle: const TextStyle(color: Colors.black87),
        ),
      ),
    );
  }
}
