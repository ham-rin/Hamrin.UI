import 'package:hamrin_app/core/constants/app_constants.dart';
import 'package:hamrin_app/data/models/locations/point.dart';
import 'package:hamrin_app/data/services/token_service.dart';
import 'package:signalr_netcore/signalr_client.dart';

class SignalRClient {
  final _tokenService = TokenService();

  late HubConnection _hubConnection;

  SignalRClient() {
    _hubConnection = HubConnectionBuilder()
        .withUrl("${AppConstants.baseUrl}/waiting",
            options: HttpConnectionOptions(
          accessTokenFactory: () async {
            var token = await _tokenService.token;
            return Future.value(token);
          },
        ))
        .withAutomaticReconnect()
        .build();
  }

  Future<void> startConnection() async {
    await _hubConnection.start();
    _hubConnection.onclose(({error}) => connectionClosed(error));
  }

  void addHamrinFoundHandler(Function(dynamic) handler) {
    _hubConnection.on('HamrinFound', handler);
  }

  void addHamrinLeftHandler(Function(dynamic) handler) {
    _hubConnection.on('HamrinLeft', handler);
  }

  void addInvitationReceivedHandler(Function(dynamic) handler) {
    _hubConnection.on('InvitationReceived', handler);
  }

  Future createGroup(Point location) async {
    await _hubConnection.invoke('CreateGroup', args: [location]);
  }

  Future inviteHamrin(String userId, Point location) async {
    await _hubConnection.invoke('InviteHamrin', args: [userId, location]);
  }

  Future<void> acceptInvitation(String targetUserId, Point location) async {
    await _hubConnection.invoke('AcceptInvitation', args: [targetUserId, location]);
  }

  Future<void> declineInvitation(String targetUserId) async {
    await _hubConnection.invoke('DeclineInvitation', args: [targetUserId]);
  }

  void addInvitationAcceptedResultReceivedMethod(Function(dynamic) handler) {
    _hubConnection.on('AcceptedInvitationResultReceived', handler);
  }

  void addDeclinedInvitationResultReceivedMethod(Function(dynamic) handler) {
    _hubConnection.on('DeclinedInvitationResultReceived', handler);
  }

  Future connectionClosed(error) async {
    //await _hubConnection.invoke("HamrinDisconnected");
    print("connection disconnected");
    print(error);
  }
}
