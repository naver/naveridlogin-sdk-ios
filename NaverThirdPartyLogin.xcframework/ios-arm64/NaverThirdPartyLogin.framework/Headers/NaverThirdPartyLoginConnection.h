//
//  NaverThirdPartyLoginConnection.h
//  NaverOAuthSample
//
//  Created by TY Kim on 2014. 2. 3..
//  Copyright 2014 Naver Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "NaverThirdPartyConstantsForApp.h"

@protocol NaverThirdPartyLoginConnectionDelegate;
@interface NaverThirdPartyLoginConnection : NSObject <UIAlertViewDelegate, UIApplicationDelegate>
@property (nonatomic, weak) id<NaverThirdPartyLoginConnectionDelegate> delegate;

@property (nonatomic) BOOL isNaverAppOauthEnable;
@property (nonatomic) BOOL isInAppOauthEnable;

@property (nonatomic, strong) NSString *consumerKey;
@property (nonatomic, strong) NSString *consumerSecret;
@property (nonatomic, strong) NSString *appName;
@property (nonatomic, strong) NSString *serviceUrlScheme;

@property (nonatomic, strong) NSString *accessToken;
@property (nonatomic, strong) NSDate   *accessTokenExpireDate;
@property (nonatomic, strong) NSString *refreshToken;
@property (nonatomic, strong) NSString *tokenType;

+ (NaverThirdPartyLoginConnection *)getSharedInstance;

- (NSString *)getVersion;

- (OAuthLoginState)state;

- (void)requestThirdPartyLogin;
- (void)requestAccessTokenWithRefreshToken;
- (void)requestDeleteToken;

- (BOOL)isValidAccessTokenExpireTimeNow;

- (THIRDPARTYLOGIN_RECEIVE_TYPE)receiveAccessToken:(NSURL *)url;
- (void)resetToken;

- (void)setOnlyPortraitSupportInIphone:(BOOL)flag;

- (BOOL)isOnlyPortraitSupportedInIphone;

- (NSString *)userAgentForThirdPartyLogin;

- (void)removeNaverLoginCookie;

- (BOOL)isPossibleToOpenNaverApp;
- (void)openAppStoreForNaverApp;

+ (CGSize)sizeWithText:(NSString *)originText withFont:(UIFont *)textFont;

+ (void)scene:(UIScene *)scene openURLContexts:(NSSet<UIOpenURLContext *> *)URLContexts API_AVAILABLE(ios(13.0));

@end

@protocol NaverThirdPartyLoginConnectionDelegate <NSObject>
- (void)oauth20ConnectionDidFinishRequestACTokenWithAuthCode;
- (void)oauth20ConnectionDidFinishRequestACTokenWithRefreshToken;
- (void)oauth20ConnectionDidFinishDeleteToken;
- (void)oauth20Connection:(NaverThirdPartyLoginConnection *)oauthConnection didFailWithError:(NSError *)error;
@optional
- (void)oauth20Connection:(NaverThirdPartyLoginConnection *)oauthConnection didFailAuthorizationWithRecieveType:(THIRDPARTYLOGIN_RECEIVE_TYPE)recieveType;
- (void)oauth20Connection:(NaverThirdPartyLoginConnection *)oauthConnection didFinishAuthorizationWithResult:(THIRDPARTYLOGIN_RECEIVE_TYPE)recieveType;
@end

