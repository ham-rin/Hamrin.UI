import 'package:hamrin_app/core/constants/app_constants.dart';
import 'package:hamrin_app/data/models/locations/point.dart';
import 'package:hamrin_app/data/services/token_service.dart';
import 'package:signalr_netcore/signalr_client.dart';

class LocationHubClient {
  final _tokenService = TokenService();

  static late HubConnection _hubConnection;

  LocationHubClient() {
    _hubConnection = HubConnectionBuilder()
        .withUrl("${AppConstants.baseUrl}/location",
            options: HttpConnectionOptions(
          accessTokenFactory: () async {
            var token = await _tokenService.token;
            return Future.value(token);
          },
        ))
        .withAutomaticReconnect()
        .build();
  }

  Future startConnection() async {
    await _hubConnection.start();
    _hubConnection.onclose(({error}) => connectionClosed(error));
  }

  void addLocationUpdatedHandler(Function(dynamic) handler) {
    _hubConnection.on("LocationUpdated", handler);
  }

  Future updateLocation(Point location) async {
    await _hubConnection.invoke("UpdateLocation", args: [location]);
  }

  Future connectionClosed(error) async {
    //await _hubConnection.invoke("HamrinDisconnected");
    print("connection disconnected");
    print(error);
  }
}
