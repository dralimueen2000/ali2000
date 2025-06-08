import 'package:flutter/material.dart';

void main() {
  runApp(const TabeebiWebApp());
}

class TabeebiWebApp extends StatelessWidget {
  const TabeebiWebApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'طبيبي الذكي (Web)',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green,
      ),
      home: const ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;
    final txt = _controller.text.trim();
    final resp = _getResponse(txt);
    setState(() {
      _messages.add({'sender': 'user', 'text': txt});
      _messages.add({'sender': 'bot', 'text': resp});
    });
    _controller.clear();
  }

  String _getResponse(String input) {
    final s = input.toLowerCase();
    if (s.contains('صداع')) {
      return 'يمكن يكون إجهاد أو قلة نوم. إذا استمر نص يوم راج الطبيب.';
    } else if (s.contains('مغص') || s.contains('بطن')) {
      return 'المغص مرات يجي من أكل أو قولون. اشرب مي وارتاح، وإذا زاد راجع دكتور.';
    } else {
      return 'ما فهمت سؤالك مضبوط، أنصح تراجع طبيب إذا طولت الأعراض.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('طبيبي الذكي (Web)')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (ctx, i) {
                final msg = _messages[_messages.length - 1 - i];
                final isUser = msg['sender'] == 'user';
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.green[100] : Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(msg['text']!),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'اكتب سؤالك باللهجة العراقية...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  color: Colors.green,
                  onPressed: _sendMessage,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
