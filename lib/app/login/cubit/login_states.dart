abstract class LoginStates{}

class LoginInitialState extends LoginStates{}
class LoginLoadingState extends LoginStates{}
class LoginSuccessState extends LoginStates{
  String token ;
  LoginSuccessState(this.token);
}
class LoginErrorState extends LoginStates{
  String message ;
  LoginErrorState(this.message);
}