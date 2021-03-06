/*
 * 项目名:    snp
 * 包名       
 * 文件名:    apis
 * 创建时间:  2020/8/25 on 4:58 PM
 * 描述:     
 *
 * @author   Dino
 */
class API {
  static final String verifyUser = 'api/v1/user/import';
  static final String register = 'api/v1/user/register';
  static final String updateUserInfo = 'api/v1/user/updating';
  static final String userInfo = 'api/v1/user/info';
  static final String userList = 'api/v1/user/list';
  static final String myAlliances = 'api/v1/league/owner';

  static final String allianceList = 'api/v1/league/list';
  static final String canCreateAlliance = 'api/v1/league/verify/create';
  static final String createAlliance = 'api/v1/league/create';
  static final String allianceBioEdit = 'api/v1/league/up/bio';
  static final String getInviteCode = 'api/v1/league/invite';
  static final String allianceBrief = 'api/v1/league/bulletin';
  static final String allianceMineMessage = 'api/v1/league/mine';
  static final String isInAlliance = 'api/v1/league/verify/join';
  static final String allianceInfo = 'api/v1/league/header';
  static final String allianceApply = 'api/v1/league/manager';
  static final String allianceStake = 'api/v1/league/stimulate';
  static final String myCapacityInAlliance = 'api/v1/league/capacity';
  static final String doStake = 'api/v1/league/stimulate/stake';
  static final String doVote = 'api/v1/league/manager/vote';

  static final String isInLevelTow = 'api/v1/league/verify/level2';
  static final String applyJoinToAlliance = 'api/v1/league/join';

  static final String wallet = 'api/v1/wallet/list';

  static final String postContent = 'api/v1/league/dynamic/push';
  static final String postComment = 'api/v1/league/dynamic/comment';
  static final String newestContent = 'api/v1/league/dynamic/news';
  static final String topContent = 'api/v1/league/dynamic/tops';
  static final String contentLine = 'api/v1/league/dynamic/dialog/tree';
  static final String comments = 'api/v1/league/dynamic/dialog/comment';
  static final String mineContent = 'api/v1/league/dynamic/mine';
}
