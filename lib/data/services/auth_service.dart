import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:snap_trip/data/models/profile_model.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  // 현재 사용자 가져오기
  User? get currentUser => _supabase.auth.currentUser;

  // 인증 상태 스트림
  Stream<AuthState> get authStateChanges => _supabase.auth.onAuthStateChange;

  // 이메일 & 비밀번호로 로그인
  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      if (kDebugMode) {
        print('로그인 오류: $e');
      }
      rethrow;
    }
  }

  // 이메일 & 비밀번호로 회원가입
  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required String username,
    String? fullName,
  }) async {
    try {
      // 회원가입만 수행 (프로필은 트리거로 자동 생성됨)
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
      );

      // 프로필 정보 업데이트 (트리거가 기본 프로필을 이미 생성함)
      if (response.user != null) {
        // 트리거 처리 완료 대기
        await Future.delayed(const Duration(seconds: 1));

        // 프로필 정보 업데이트
        await _supabase.from('profiles').update({
          'username': username,
          'full_name': fullName,
          'updated_at': DateTime.now().toIso8601String(),
        }).eq('id', response.user!.id);
      }
    } catch (e) {
      if (kDebugMode) {
        print('회원가입 오류: $e');
      }
      rethrow;
    }
  }

  // 로그아웃
  Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
    } catch (e) {
      if (kDebugMode) {
        print('로그아웃 오류: $e');
      }
      rethrow;
    }
  }

  // 비밀번호 재설정 이메일 발송
  Future<void> resetPassword(String email) async {
    try {
      await _supabase.auth.resetPasswordForEmail(email);
    } catch (e) {
      if (kDebugMode) {
        print('비밀번호 재설정 오류: $e');
      }
      rethrow;
    }
  }

  // 사용자 프로필 가져오기
  Future<ProfileModel?> getUserProfile() async {
    try {
      if (currentUser == null) return null;

      final response = await _supabase
          .from('profiles')
          .select()
          .eq('id', currentUser!.id)
          .single();

      return ProfileModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('프로필 조회 오류: $e');
      }
      return null;
    }
  }

  // 프로필 업데이트
  Future<ProfileModel?> updateUserProfile({
    String? username,
    String? fullName,
    String? bio,
    String? avatarUrl,
  }) async {
    try {
      if (currentUser == null) return null;

      final updates = {
        if (username != null) 'username': username,
        if (fullName != null) 'full_name': fullName,
        if (bio != null) 'bio': bio,
        if (avatarUrl != null) 'avatar_url': avatarUrl,
        'updated_at': DateTime.now().toIso8601String(),
      };

      await _supabase
          .from('profiles')
          .update(updates)
          .eq('id', currentUser!.id);

      return getUserProfile();
    } catch (e) {
      if (kDebugMode) {
        print('프로필 업데이트 오류: $e');
      }
      rethrow;
    }
  }
}
