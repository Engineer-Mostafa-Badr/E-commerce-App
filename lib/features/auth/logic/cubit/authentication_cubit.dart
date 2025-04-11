import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../data/models/user_models.dart';
import 'package:flutter/widgets.dart';
import 'package:bloc/bloc.dart';
import 'dart:developer';
part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationCubitInitial());

  SupabaseClient client = Supabase.instance.client;

  Future<void> signIn({required String email, required String password}) async {
    emit(LoginLoading());
    try {
      await client.auth.signInWithPassword(email: email, password: password);
      await getUserData();
      emit(LoginSuccess());
    } on AuthException catch (e) {
      log(e.toString());

      emit(LoginError(e.message));
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    emit(SignUpLoading());
    try {
      await client.auth.signUp(email: email, password: password, phone: phone);
      await addUserData(name: name, email: email, phone: phone);
      await getUserData();
      emit(SignUpSuccess());
    } on AuthException catch (e) {
      emit(SignUpError(e.message));
    } catch (e) {
      emit(SignUpError(e.toString()));
    }
  }

  GoogleSignInAccount? googleUser;
  Future<AuthResponse> googleSignIn() async {
    emit(GoogleSignInLoading());
    const webClientId =
        '151871968623-gd3r1g36q79jcocl0tveonm0v9gqptmq.apps.googleusercontent.com';

    final GoogleSignIn googleSignIn = GoogleSignIn(serverClientId: webClientId);
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      emit(GoogleSignInError('Google Sign In failed'));
      return AuthResponse();
    }
    final googleAuth = await googleUser.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null || idToken == null) {
      emit(GoogleSignInError('Google Sign In failed'));
      return AuthResponse();
    }

    AuthResponse response = await client.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
    await getUserData();
    await addUserData(name: googleUser.displayName!, email: googleUser.email);
    emit(GoogleSignInSuccess());
    log(response.toString());
    return response;
  }

  Future<void> logOut() async {
    emit(LogOutLoading());
    try {
      await client.auth.signOut();

      emit(LogOutSuccess());
      log('User logged out successfully');
    } catch (e) {
      emit(LogOutError(e.toString()));
    }
  }

  Future<void> resetPassword({required String email}) async {
    emit(ResetPasswordLoading());
    try {
      await client.auth.resetPasswordForEmail(email);
      emit(ResetPasswordSuccess());
    } catch (e) {
      emit(ResetPasswordError(e.toString()));
    }
  }

  Future<void> addUserData({
    required String name,
    required String email,
    String? phone,
  }) async {
    emit(UserDataAddedLoading());
    try {
      await client.from('users').upsert({
        'user_id': client.auth.currentUser?.id,
        'name': name,
        'email': email,
        'phone': phone,
      });
      emit(UserDataAddedSuccess());
      log('User data added successfully');
    } catch (e) {
      emit(UserDataAddedError(e.toString()));
    }
  }

  UserDataModel? userDataModel;
  Future<void> getUserData() async {
    emit(GetUserDataLoading());
    try {
      final List<Map<String, dynamic>> data = await client
          .from('users')
          .select()
          .eq('user_id', client.auth.currentUser!.id);

      userDataModel = UserDataModel(
        userID: data[0]['user_id'] ?? '',
        name: data[0]['name'] ?? '',
        email: data[0]['email'] ?? '',
        phone: data[0]['phone'] ?? '',
      );

      emit(GetUserDataSuccess());
      log(data.toString());
    } catch (e) {
      emit(GetUserDataError(e.toString()));
      log(e.toString());
    }
  }
}
