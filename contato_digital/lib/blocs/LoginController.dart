import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:contato_digital/models/usuario.dart';
import 'package:rxdart/rxdart.dart';

class LoginController extends BlocBase {
  var _loginController = BehaviorSubject<Usuario>.seeded(new Usuario());
  
  Stream<Usuario> get outLogin => _loginController.stream;
  Sink<Usuario> get inLogin => _loginController.sink;
  
  
  @override
  void dispose() {
    _loginController.close();
    super.dispose();
  }
}
