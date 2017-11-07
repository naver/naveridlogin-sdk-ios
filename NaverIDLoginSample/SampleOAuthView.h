//
//  SampleOAuthView.h
//  NaverOAuthSample
//
//  Created by suejinv on 12. 3. 28..
//  Modified by TY Kim on 14. 8. 20..
//  Copyright 2014 Naver Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <NaverThirdPartyLogin/NaverThirdPartyLogin.h>

@protocol SampleOAuthViewDelegate;
@interface SampleOAuthView : UIView <UITextFieldDelegate> {
    id<SampleOAuthViewDelegate> __weak delegate;

    UIScrollView *_mainView;
    UIButton *thirdPartyLoginBtn;
    UILabel *resultLabel;
    
    UITextField *ckeyTextField;
    UITextField *cSecretTextField;
    UITextField *appNameTextField;
    
    NaverThirdPartyLoginConnection *_thirdPartyLoginConn;
    
}

@property (nonatomic, weak) id<SampleOAuthViewDelegate> delegate;
@property (nonatomic, strong) UITextField *ckeyTextField;
@property (nonatomic, strong) UITextField *cSecretTextField;
@property (nonatomic, strong) UITextField *appNameTextField;

- (void)setThirdButtonText:(NSString *)text;
- (void)setResultLabelText:(NSString *)text;

@end


@protocol SampleOAuthViewDelegate <NSObject>
@optional
- (void)didClickApiSendGetMethodBtn:(SampleOAuthView *)view;
- (void)didClickAuthenticateBtn:(SampleOAuthView *)view;
- (void)didClickShowOAuthStatusBtn:(SampleOAuthView *)view;
- (void)didClickCheckNidTokenBtn:(SampleOAuthView *)view;
- (void)didClickGetUserProfileBtn:(SampleOAuthView *)view;
- (void)didClickGetACTokenWithRefreshTokenBtn:(SampleOAuthView *)view;
- (void)didClickGetResetBtn:(SampleOAuthView *)view;
- (void)didClickLogoutBtn:(SampleOAuthView *)view;
- (void)didClickLoginCheckBtn:(SampleOAuthView *)view;
@end
