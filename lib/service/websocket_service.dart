import 'package:web_socket_channel/web_socket_channel.dart';

class WebsocketService {
  WebSocketChannel? channel;

  void connect(String url) {
    channel = WebSocketChannel.connect(Uri.parse(url));
  }

  void send(String message) {
    channel!.sink.add(message);
  }

  void close() {
    channel!.sink.close();
  }
}