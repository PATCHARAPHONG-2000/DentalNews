import 'package:dentalnews/Widget/chat_text_form_field.dart';
import 'package:dentalnews/Widget/message_widget.dart';
import 'package:dentalnews/utils/app_const.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:line_icons/line_icons.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final GenerativeModel _model;
  late final ScrollController _scrollController;
  late final TextEditingController _textController;
  late final FocusNode _focusNode;
  late ChatSession _chatSession;
  late bool _isLoading;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _textController = TextEditingController();
    _focusNode = FocusNode();
    _isLoading = false; // Initialize _isLoading

    // setup the model
    _model = GenerativeModel(
      model: geminiModel,
      apiKey: apiKey,
    );

    // Start the chat session
    _chatSession = _model.startChat();
  }

  void _setIsLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _textController.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // ปิดแป้นพิมพ์เมื่อแตะที่หน้าจอ
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Chat Bot',
            style: GoogleFonts.k2d(
              textStyle: const TextStyle(
                fontSize: 20, // ปรับขนาดฟอนต์ตามหน้าจอ
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Theme.of(context).dividerColor,
          leading: IconButton(
            icon: const Icon(LineIcons.chevronCircleLeft),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _chatSession.history.length,
              itemBuilder: (context, index) {
                var content = _chatSession.history.toList()[index];
                final message = _getMessageFromContent(content);

                return MessageWidget(
                  isFromUser: content.role == 'user',
                  message: message,
                );
              },
            )),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Flexible(
                  flex: 3,
                  child: Form(
                    key: _formKey,
                    child: ChatTextFormField(
                      focusNode: _focusNode,
                      controller: _textController,
                      isRoadOnly: _isLoading,
                      onFieldSubmitted: _sendChatMessage,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                if (!_isLoading) ...[
                  ElevatedButton(
                    onPressed: () {
                      _sendChatMessage(_textController.text);
                    },
                    child: const Text('Send'),
                  ),
                ] else ...[
                  const CircularProgressIndicator.adaptive(),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getMessageFromContent(Content content) {
    return content.parts.whereType<TextPart>().map((e) => e.text).join('');
  }

  void _sendChatMessage(String message) async {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    _isLoading = true;

    try {
      var response = await _chatSession.sendMessage(
        Content.text(message),
      );

      final text = response.text;
      if (text == null) {
        _showError('No response was received');
        _setIsLoading(false);
      } else {
        _setIsLoading(false);
      }
    } catch (e) {
      _showError(e.toString());
      _setIsLoading(false);
    } finally {
      _textController.clear();
      _focusNode.requestFocus();
      _setIsLoading(false);
    }
  }

  void _showError(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: SingleChildScrollView(
              child: Text(message),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Ok'))
            ],
          );
        });
  }
}
