// live

const String baseUrl = 'https://production.nftwist.io:3001/api';
const WebLink='https://production.nftwist.io/';
const String imageBaseUrl = 'https://nftwistproduction.s3.me-central-1.amazonaws.com/uploads/images/original/';
const String videoBaseUrl = 'https://nftwistproduction.s3.me-central-1.amazonaws.com/uploads/video/';
const String gifBaseUrl = 'https://nftwistproduction.s3.me-central-1.amazonaws.com/uploads/gif/';

// staging
// const String baseUrl = 'https://staging.nftwist.io:3001/api';
// const String imageBaseUrl = 'https://nftwiststaging.s3.me-central-1.amazonaws.com/uploads/images/original/';

const String logOutUrl = "/user/logout";
const String signUpUrl = "/user/signUp";
const String loginInUrl = '/user/login';
const String getTokenUrl= '/user/email/verify';
const String getNewTokenUrl = '/user/token';
const String profileUrl = '/user/profile';
const String userPersonalInfo = "/user/personal-info";
const String editProfileUrl = "/user/profile";
const String getStateUrl = '/user/states?countryShortName=';
const String getCountryUrl = '/user/countries';
const String getBusinessUrl = '/user/line-of-business';
const String getCityUrl = '/user/cities';
const String getStaticDataUrl = '/user/static_page';

const postImageUrl='/upload';

const String getFollowersUrl = '/user/followers';
const String getFollowingUrl = '/user/followings';

const String resendOTpUrl = '/user/resend/phone';
const String resendEmailOtpUrl = '/user/resend/email';
const String helpCenterUrl = '/user/raise/support-ticket';

const String twoFAresendOTpUrl="/user/two-way-authentication/resend/phone";
const String twoFAresendEmailOtpUrl="/user/two-way-authentication/resend/email";
const String twoFAresendOtpUrl ="/user/resendLoginTwoFa";

const String giftNftPartnerUrl="/gift/nft-by-email";
const String giftNftUserUrl="/gift/nft-by-users";

const String nftCollectionUrl="/nft/collections";

//login verify otp for 2FA
const String twoFAVerifyOTp="/user/two-way-authentication/verify/login";

const String forgetPassUrl = '/user/forgot-password';
const String otpChangePassUrl = '/user/change-password';
const String otpVerifyUrl = '/user/verify/reset-password-otp';
const String changePass = '/user/reset-password';
const String emailVerifyDeviceUrl = '/user/email/verify';
const String twoWayAuthenticationUrl = '/user/two-way-authentication';
const String phoneVerifyUrl = '/user/phone/verify';
const String socialLoginUrl = '/user/social/login';
const String followUrl="/user/follow";
const String faqUrl="/user/faqs";
const String updatePasswordUrl="/user/change-password/device";

const String usdValueUrl="/user/refresh-balance";
const String activePartnerUrl="/top-partners";

///homeModelApis
const String partnersUrl = '/partners';
const String homeScreenUrl = '/homepage/data';

const String searchScreen = '/home-screen';

const String newsfeedurl = '/nft/news-feed';
const String partnerNftUrl = '/partner-nfts';
const String nftsUrl = '/nfts';
const String nftUrl = '/nft?nft_id';
const String likeNftUrl = '/nft/like';
const String requestPartner = '/user/become-partner/request';

const String setPartnerRulesUrl="/user/rules";
const String getPartnerRulesUrl="/user/getPartnerRules";
const String addNftRuleUrl="/user/addNftToRule";

const String otherUserprofile = '/user/other-user-profile';
const String otherPartnerNfts = '/partner-nfts?_id=';

const String onGoingCampaignsUrl='/campaigns';

const String userOwnedNftsUrl='/nfts/owned';
const String nftCommentUrl='/nft/comment';
const String userCreatedNftsUrl='/nfts/created';
const String userActivities='/activities?user_id=';

const String reportUserUrl='/user/report';
const String reportNFtUrl ='/nft/report';
const String userCommunityUrl="/user/community/people";
const String otherUserCommunityUrl="/user/community/partner/";
const String hideCommunityUrl="/user/community/hide";

const String partnerNotification="/user/partner/notification";
const String userNotification="/user/notification";

const String giftHistoryUrl="/user/gift/history";
const String hotProjectUrl="/collections/all";