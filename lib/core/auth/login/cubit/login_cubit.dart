import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebaseAuth;
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authenticationRepository) : super(const LoginState());

  final AuthenticationRepository _authenticationRepository;

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([email, state.password]),
    ));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([state.email, password]),
    ));
  }

  Future<void> logInWithCredentials() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _authenticationRepository.logInWithEmailAndPassword(
        email: state.email.value,
        password: state.password.value,
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on LogInWithEmailAndPasswordFailure catch (e) {
      emit(state.copyWith(
        errorMessage: e.message,
        status: FormzStatus.submissionFailure,
      ));
    } catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  Future<void> logInWithGoogle() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _authenticationRepository.logInWithGoogle();
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on LogInWithGoogleFailure catch (e) {
      emit(state.copyWith(
        errorMessage: e.message,
        status: FormzStatus.submissionFailure,
      ));
    } catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  Future<void> logInWithFacebook() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _authenticationRepository.logInWithFacebook();
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on LogInWithFacebookFailure catch (e) {
      emit(state.copyWith(
        errorMessage: e.message,
        status: FormzStatus.submissionFailure,
      ));
    } catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  Future<void> logInWithPhoneNumber(
      firebaseAuth.PhoneAuthCredential credential) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      var user = await _authenticationRepository
          .logInWithPhoneNumber(credential)
          .then((value) => _authenticationRepository.currentUser);
      emit(state.copyWith(
        status: FormzStatus.submissionSuccess,
        user: user,
      ));
    } on LogInWithPhoneNumberFailure catch (e) {
      emit(state.copyWith(
        errorMessage: e.message,
        status: FormzStatus.submissionFailure,
      ));
    } catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
