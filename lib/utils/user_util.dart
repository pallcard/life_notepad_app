import 'package:life_notepad_app/model/User.dart';
import 'package:life_notepad_app/utils/sp_util.dart';

class UserUtil {
  // 用户信息
  static const String SP_USER = "sp_user";

  // 用户登陆
  static const String SP_USER_LOGIN = "sp_user_login";

  static User saveUserInfo(User? data) {
    if (data != null) {
      SpUtil.putObject(SP_USER, data);
      SpUtil.putBool(SP_USER_LOGIN, true);
    }
    return User();
  }

  static User updateNickName(String? nickname) {
    if (nickname != null) {
      var user = User.fromJson(SpUtil.getObject(SP_USER));
      user.nickName = nickname;
      SpUtil.putObject(SP_USER, user);
      return user;
    }
    return User();
  }

  static User updateAvatar(String? avatar) {
    if (avatar != null) {
      var user = User.fromJson(SpUtil.getObject(SP_USER));
      user.avatar = avatar;
      SpUtil.putObject(SP_USER, user);
      return user;
    }
    return User();
  }

  static User updateDescription(String? description) {
    if (description != null) {
      var user = User.fromJson(SpUtil.getObject(SP_USER));
      user.description = description;
      SpUtil.putObject(SP_USER, user);
      return user;
    }
    return User();
  }

  static User updateUserNickName(String? nickname) {
    if (nickname != null) {
      var user = User.fromJson(SpUtil.getObject(SP_USER));
      user.nickName = nickname;
      SpUtil.putObject(SP_USER, user);
      return user;
    }
    return User();
  }

  // 获取用户信息
  static User getUserInfo() {
    bool isLogin = SpUtil.getBool(SP_USER_LOGIN);
    if (!isLogin) {
      return User();
    }
    return User.fromJson(SpUtil.getObject(SP_USER));
  }

  // 判断用户是否登录
  static bool isLogin() {
    bool b = SpUtil.getBool(SP_USER_LOGIN);
    return b;
  }

  //logOut
  static logOut() {
    SpUtil.putBool(SP_USER_LOGIN, false);
    SpUtil.putObject(SP_USER, "");
  }
}
