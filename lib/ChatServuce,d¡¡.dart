class ChatService {
  static final ChatService _instance = ChatService._internal();
  List<String> _messages = [];

  factory ChatService() => _instance;

  ChatService._internal() {}

  void addMessage(String message, String username) {
    _messages.add("$username: $message");
  }

  List<String> getMessages() {
    return _messages;
  }
}
