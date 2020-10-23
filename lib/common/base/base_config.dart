/*
 * 项目名:    snp
 * 包名       base
 * 文件名:    base_config
 * 创建时间:  2020/8/25 on 10:07 AM
 * 描述:     
 *
 * @author   Dino
 */

class Config {
//  static const String baseUrl = 'http://www.mocky.io/v2/';
//  static const String baseUrl = 'https://snp.koar.cn/';
  static const String baseUrl = 'https://api.tpy.pub/';
  static const bool isDebug = true;
  static const bool printHttp = true;
  static const int listPageSize = 10;
  static const double allianceImageRatio = 60 / 44;
  static const String defaultAvatar = 'https://oss.tpy.pub/logo.jpg';

  static const String wxAppId = 'wx6d801472061d2284';

  static const String sp_key_client_id = 'SP_KEY_CLIENT_ID';
  static const String sp_key_token = 'SP_KEY_TOKEN';
  static const String sp_key_private_key = 'SP_KEY_PRIVATE_KEY';
  static const String sp_key_auto_login = 'SP_KEY_AUTO_LOGIN';
  static const String sp_key_login_user = 'SP_KEY_LOGIN_USER';
  static const String sp_key_alliance_id = 'SP_KEY_ALLIANCE_ID';

  static const String oss_bucket = 'snptest';
  // static const String oss_sts_server = 'https://spot.koar.cn/sign';
  static const String oss_sts_server = 'https://a.tpy.pub/sign';
  static const String oss_crypt_key = '27X2DX27X9CX8CXFAX35XA0X';
  static const String oss_endpoint = 'https://oss-cn-hangzhou.aliyuncs.com';
  static const String oss_remote_dir_avatar = 'avatar/';
  static const String oss_remote_dir_alliance = 'alliance/';
  static const String oss_remote_dir_content = 'content/';
  static const String oss_remote_dir_apply = 'apply/';
  static const String oss_style_org = '_org';
  static const String oss_style_thumb = '_thumb';

  static const String event_bus_switch_alliance = 'event_bus_switch_alliance';
  static const String event_bus_posted_content = 'event_bus_posted_content';
}
