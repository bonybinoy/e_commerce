import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class ChatAssistantPage extends StatefulWidget {
  const ChatAssistantPage({Key? key}) : super(key: key);

  @override
  _ChatAssistantPageState createState() => _ChatAssistantPageState();
}

class _ChatAssistantPageState extends State<ChatAssistantPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  final Dio _dio = Dio();
  final String openAIKey = 'YOUR_OPENAI_API_KEY'; // Make sure to replace this with your actual OpenAI API Key

  @override
  void initState() {
    super.initState();
  }

  Future<void> _sendMessage() async {
    final messageText = _controller.text.trim();
    if (messageText.isNotEmpty) {
      _addMessage("user", messageText); // Add user's message to chat

      try {
        // Sending request to OpenAI's API
        final response = await _dio.post(
          'https://api.openai.com/v1/chat/completions', // OpenAI API endpoint for chat completions
          data: {
            'model': 'gpt-3.5-turbo', // Specify the model
            'messages': [
              {'role': 'user', 'content': messageText},
            ],
          },
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $openAIKey',
            },
          ),
        );

        // Extract the assistant's response from the API response
        String assistantResponse = response.data['choices'][0]['message']['content'];
        _addMessage("assistant", assistantResponse);
      } catch (e) {
        _addMessage("assistant", "Sorry, I couldn't process your request.");
      } finally {
        _controller.clear();
      }
    }
  }

  void _addMessage(String sender, String message) {
    setState(() {
      _messages.add({"sender": sender, "message": message});
    });
  }

  Widget _buildMessageItem(Map<String, String> message) {
    final isUserMessage = message['sender'] == 'user';
    return Align(
      alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isUserMessage ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          message['message']!,
          style: TextStyle(
            color: isUserMessage ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AI Chat Assistant'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessageItem(_messages[index]);
              },
            ),
          ),
          _buildInputField(),
        ],
      ),
    );
  }

  Widget _buildInputField() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Type your message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
}