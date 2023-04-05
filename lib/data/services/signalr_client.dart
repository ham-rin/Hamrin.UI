import 'package:hamrin_app/core/constants/app_constants.dart';
import 'package:hamrin_app/data/models/locations/point.dart';
import 'package:hamrin_app/data/services/token_service.dart';
import 'package:signalr_netcore/signalr_client.dart';

class SignalRClient {
  final _tokenService = TokenService();

  late HubConnection _hubConnection;

  SignalRClient() {
    _hubConnection = HubConnectionBuilder().withUrl(
        "${AppConstants.baseUrl}/waiting",
        options: HttpConnectionOptions(
          accessTokenFactory: () async {
            var token = await _tokenService.token;
            return Future.value(token);
          },
        )).build();
  }

  Future<void> startConnection() async {
    await _hubConnection.start();
    _hubConnection.onclose(({error}) => print(error));
  }

  void addHamrinFoundHandler(Function(dynamic) handler) {
    _hubConnection.on('HamrinFound', handler);
  }

  void createGroup(Point location) {
    _hubConnection.invoke('CreateGroup', args: [location]);
  }
}
