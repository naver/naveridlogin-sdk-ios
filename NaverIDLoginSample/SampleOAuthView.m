//
//  SampleOAuthView.m
//  NaverOAuthSample
//
//  Created by suejinv on 12. 3. 28..
//  Modified by TY Kim on 14. 8. 20..
//  Copyright 2014 Naver Corp. All rights reserved.
//

#import "SampleOAuthView.h"

#define kScreenWidth    UIScreen.mainScreen.bounds.size.width
#define kScreenHeight   UIScreen.mainScreen.bounds.size.height

#define tagConsumerKey 100
#define tagConsumerSecret 200
#define tagAppName 300

#define kScreenTitleBarHeight 46

@implementation SampleOAuthView
@synthesize delegate;
@synthesize ckeyTextField, cSecretTextField, appNameTextField;

- (id)initWithFrame:(CGRect)frame
{
    int topMargin = 0;
#ifdef __IPHONE_7_0
    if (NO == [[UIApplication sharedApplication] isStatusBarHidden]) {
        topMargin = 20;
    }
#endif

    self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight + topMargin)];
    self.backgroundColor = [UIColor whiteColor];
    _thirdPartyLoginConn = [NaverThirdPartyLoginConnection getSharedInstance];
    if (self) {
        _mainView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, topMargin, kScreenWidth, kScreenHeight)];
        _mainView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_mainView];
        
        [self initWithView];
    }
    return self;
}

- (void)initWithView {

    
    UILabel *naverOAuth20Label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 30)];
    naverOAuth20Label.font = [UIFont boldSystemFontOfSize:15.0f];
    naverOAuth20Label.text = @"OAuth 2.0 라이브러리";
    [_mainView addSubview:naverOAuth20Label];
    
    UILabel *cKeyLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, 100, 30)];
    cKeyLabel.text = @"ConsumerKey";
    cKeyLabel.font = [UIFont systemFontOfSize:11.0f];
    [_mainView addSubview:cKeyLabel];
    
    ckeyTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 30, kScreenWidth - 110, 30)];
    ckeyTextField.borderStyle = UITextBorderStyleLine;
    ckeyTextField.returnKeyType = UIReturnKeyDone;
    ckeyTextField.delegate = self;
    ckeyTextField.tag = tagConsumerKey;
    ckeyTextField.clearButtonMode = UITextFieldViewModeAlways;
    ckeyTextField.text = kConsumerKey;
    ckeyTextField.font = [UIFont systemFontOfSize:11.0f];
    [_mainView addSubview:ckeyTextField];
    
    UILabel *cSecretLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, 100, 30)];
    cSecretLabel.font = [UIFont systemFontOfSize:11.0f];
    cSecretLabel.text = @"ConsumerSecret";
    [_mainView addSubview:cSecretLabel];
    
    cSecretTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 60, kScreenWidth - 110, 30)];
    cSecretTextField.borderStyle = UITextBorderStyleLine;
    cSecretTextField.font = [UIFont systemFontOfSize:11.0f];
    cSecretTextField.returnKeyType = UIReturnKeyDone;
    cSecretTextField.delegate = self;
    cSecretTextField.tag = tagConsumerSecret;
    cSecretTextField.clearButtonMode = UITextFieldViewModeAlways;
    cSecretTextField.text = kConsumerSecret;
    [_mainView addSubview:cSecretTextField];
    
    UILabel *appNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 90, 100, 30)];
    appNameLabel.font = [UIFont systemFontOfSize:11.0f];
    appNameLabel.text = @"AppName";
    [_mainView addSubview:appNameLabel];
    
    appNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 90, kScreenWidth - 110, 30)];
    appNameTextField.borderStyle = UITextBorderStyleLine;
    appNameTextField.font = [UIFont systemFontOfSize:11.0f];
    appNameTextField.returnKeyType = UIReturnKeyDone;
    appNameTextField.delegate = self;
    appNameTextField.tag = tagAppName;
    appNameTextField.clearButtonMode = UITextFieldViewModeAlways;
    appNameTextField.text = kServiceAppName;
    [_mainView addSubview:appNameTextField];
    
    resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 130, kScreenWidth - 20, 150)];
    resultLabel.textColor = [UIColor blackColor];
    resultLabel.font = [UIFont systemFontOfSize:12.0f];
    if (UIDevice.currentDevice.systemVersion.intValue > 6) {
        resultLabel.textAlignment = NSTextAlignmentLeft;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        resultLabel.textAlignment = UITextAlignmentLeft;
#pragma clang diagnostic pop
        
    }
    resultLabel.layer.borderWidth = 1;
    resultLabel.layer.borderColor = [[UIColor colorWithRed:0x25/255.0 green:0x30/255.0 blue:0x3F/255.0 alpha:1.0] CGColor];
    resultLabel.numberOfLines = 0;
    [_mainView addSubview:resultLabel];
    
    UISwitch *isNaverAppOAuthEnableSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(5, 285, 33, 33)];
    isNaverAppOAuthEnableSwitch.transform = CGAffineTransformMakeScale(0.60, 0.60);
    [isNaverAppOAuthEnableSwitch setOn:[_thirdPartyLoginConn isNaverAppOauthEnable]];
    [isNaverAppOAuthEnableSwitch addTarget:self action:@selector(switchAppOAuthAction:) forControlEvents:UIControlEventValueChanged];
    [isNaverAppOAuthEnableSwitch setTag:1];
    [_mainView addSubview:isNaverAppOAuthEnableSwitch];
    
    UILabel *naverAppOauthLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 285, 90, 30)];
    naverAppOauthLabel.font = [UIFont systemFontOfSize:12.0f];
    naverAppOauthLabel.text = @"네이버앱 인증";
    [_mainView addSubview:naverAppOauthLabel];
    
    UISwitch *isInAppOAuthEnableSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(160, 285, 33, 33)];
    isInAppOAuthEnableSwitch.transform = CGAffineTransformMakeScale(0.65, 0.65);
    [isInAppOAuthEnableSwitch setOn:[_thirdPartyLoginConn isInAppOauthEnable]];
    
    [isInAppOAuthEnableSwitch addTarget:self action:@selector(switchAppOAuthAction:) forControlEvents:UIControlEventValueChanged];
    [isInAppOAuthEnableSwitch setTag:2];
    [_mainView addSubview:isInAppOAuthEnableSwitch];
    
    UILabel *inAppOauthLabel = [[UILabel alloc] initWithFrame:CGRectMake(230, 285, 90, 30)];
    inAppOauthLabel.font = [UIFont systemFontOfSize:12.0f];
    inAppOauthLabel.text = @"인앱 인증";
    [_mainView addSubview:inAppOauthLabel];
    
    thirdPartyLoginBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    thirdPartyLoginBtn.frame = CGRectMake(45, 315, 100, 30);
    [thirdPartyLoginBtn addTarget:self action:@selector(actionThirdPartyLogin) forControlEvents:UIControlEventTouchUpInside];
    
    NSString *sStrThirdPartyLogin = @"네아로 2.0 로그인";
    
    [thirdPartyLoginBtn setTitle:sStrThirdPartyLogin forState:UIControlStateNormal];
    [[thirdPartyLoginBtn titleLabel] setFont:[UIFont systemFontOfSize:12.0f]];
    [_mainView addSubview:thirdPartyLoginBtn];
    
    UIButton *resetBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    resetBtn.frame = CGRectMake(180, 315, 100, 30);
    [resetBtn addTarget:self action:@selector(actionShowOAuthStatus) forControlEvents:UIControlEventTouchUpInside];
    [resetBtn setTitle:@"인증 상태 표시" forState:UIControlStateNormal];
    [[resetBtn titleLabel] setFont:[UIFont systemFontOfSize:12.0f]];
    [_mainView addSubview:resetBtn];
    
    UIButton *checkBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    checkBtn.frame = CGRectMake(45, 360, 100, 30);
    [checkBtn addTarget:self action:@selector(actionCheckTokenGetMethod) forControlEvents:UIControlEventTouchUpInside];
    
    [checkBtn setTitle:@"해쉬 아이디 확인" forState:UIControlStateNormal];
    [[checkBtn titleLabel] setFont:[UIFont systemFontOfSize:12.0f]];
    [_mainView addSubview:checkBtn];
    
    UIButton *userProfileBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    userProfileBtn.frame = CGRectMake(180, 360, 100, 30);
    [userProfileBtn addTarget:self action:@selector(actionUserProfileGetMethod) forControlEvents:UIControlEventTouchUpInside];
    
    [userProfileBtn setTitle:@"사용자 프로필" forState:UIControlStateNormal];
    [[userProfileBtn titleLabel] setFont:[UIFont systemFontOfSize:12.0f]];
    [_mainView addSubview:userProfileBtn];
    
    UIButton *refreshTokenBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    refreshTokenBtn.frame = CGRectMake(45, 405, 70, 30);
    [refreshTokenBtn addTarget:self action:@selector(actionRefreshTokenGetMethod) forControlEvents:UIControlEventTouchUpInside];
    
    [refreshTokenBtn setTitle:@"리프레쉬 토큰" forState:UIControlStateNormal];
    [[refreshTokenBtn titleLabel] setFont:[UIFont systemFontOfSize:12.0f]];
    [_mainView addSubview:refreshTokenBtn];

    UIButton *resetTokenBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    resetTokenBtn.frame = CGRectMake(130, 405, 70, 30);
    [resetTokenBtn addTarget:self action:@selector(actionResetTokenGetMethod) forControlEvents:UIControlEventTouchUpInside];
    
    [resetTokenBtn setTitle:@"토큰 초기화" forState:UIControlStateNormal];
    [[resetTokenBtn titleLabel] setFont:[UIFont systemFontOfSize:12.0f]];
    [_mainView addSubview:resetTokenBtn];
    
    UIButton *deleteTokenBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    deleteTokenBtn.frame = CGRectMake(210, 405, 60, 30);
    [deleteTokenBtn addTarget:self action:@selector(actionLogoutGetMethod) forControlEvents:UIControlEventTouchUpInside];
    
    [deleteTokenBtn setTitle:@"인증 해제" forState:UIControlStateNormal];
    [[deleteTokenBtn titleLabel] setFont:[UIFont systemFontOfSize:12.0f]];
    [_mainView addSubview:deleteTokenBtn];
    
    UIButton *loginCheck = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    loginCheck.frame = CGRectMake(45, 450, 60, 30);
    [loginCheck addTarget:self action:@selector(actionLoginCheckMethod) forControlEvents:UIControlEventTouchUpInside];
    
    [loginCheck setTitle:@"네이버 로그인 확인" forState:UIControlStateNormal];
    [[loginCheck titleLabel] setFont:[UIFont systemFontOfSize:12.0f]];
    [loginCheck sizeToFit];
    [_mainView addSubview:loginCheck];
}

- (void)switchAppOAuthAction:(UISwitch *)appEnableSwitch {
    if (appEnableSwitch.tag == 1) {
        [_thirdPartyLoginConn setIsNaverAppOauthEnable:appEnableSwitch.on];
    } else if (appEnableSwitch.tag == 2) {
        [_thirdPartyLoginConn setIsInAppOauthEnable:appEnableSwitch.on];
    }
}

- (void)setThirdButtonText:(NSString *)text
{
    [thirdPartyLoginBtn setTitle:text forState:UIControlStateNormal];
}

- (void)actionApiSendGetMethod {
    if ([delegate respondsToSelector:@selector(didClickApiSendGetMethodBtn:)]) {
        [delegate didClickApiSendGetMethodBtn:self];
    }
}

- (void)setResultLabelText:(NSString *)text {
    resultLabel.text = text;
}

- (void)actionThirdPartyLogin {
    if ([delegate respondsToSelector:@selector(didClickAuthenticateBtn:)]) {
        [delegate didClickAuthenticateBtn:self];
    }
}

- (void)actionShowOAuthStatus {
    if ([delegate respondsToSelector:@selector(didClickShowOAuthStatusBtn:)]) {
        [delegate didClickShowOAuthStatusBtn:self];
    }
}

- (void)actionCheckTokenGetMethod {
    if ([delegate respondsToSelector:@selector(didClickCheckNidTokenBtn:)]) {
        [delegate didClickCheckNidTokenBtn:self];
    }
}

- (void)actionUserProfileGetMethod {
    if ([delegate respondsToSelector:@selector(didClickGetUserProfileBtn:)]) {
        [delegate didClickGetUserProfileBtn:self];
    }
}

- (void)actionRefreshTokenGetMethod {
    if ([delegate respondsToSelector:@selector(didClickGetACTokenWithRefreshTokenBtn:)]) {
        [delegate didClickGetACTokenWithRefreshTokenBtn:self];
    }
}

- (void)actionResetTokenGetMethod {
    if ([delegate respondsToSelector:@selector(didClickGetResetBtn:)]) {
        [delegate didClickGetResetBtn:self];
    }
}

- (void)actionLogoutGetMethod {
    if ([delegate respondsToSelector:@selector(didClickLogoutBtn:)]) {
        [delegate didClickLogoutBtn:self];
    }
}

- (void)actionLoginCheckMethod
{
    if ([delegate respondsToSelector:@selector(didClickLoginCheckBtn:)]) {
        [delegate didClickLoginCheckBtn:self];
    }
}

#pragma mark    
#pragma mark UITextField delegate -
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return [textField resignFirstResponder];
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    [textField setText:@""];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.tag == tagConsumerKey) {
        [_thirdPartyLoginConn setConsumerKey:textField.text];
    } else if (textField.tag == tagConsumerSecret) {
        [_thirdPartyLoginConn setConsumerSecret:textField.text];
    } else if (textField.tag == tagAppName) {
        [_thirdPartyLoginConn setAppName:textField.text];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField.tag == tagConsumerKey) {
        [_thirdPartyLoginConn setConsumerKey:textField.text];
    } else if (textField.tag == tagConsumerSecret) {
        [_thirdPartyLoginConn setConsumerSecret:textField.text];
    } else if (textField.tag == tagAppName) {
        [_thirdPartyLoginConn setAppName:textField.text];
    }
    return YES;
}

- (void)layoutSubviews  {
    int topMargin = 0;
#ifdef __IPHONE_7_0
    if (NO == [[UIApplication sharedApplication] isStatusBarHidden]) {
        topMargin = 20;
    }
#endif
    _mainView.frame = CGRectMake(0, topMargin, kScreenWidth, kScreenHeight);
    
    int mainViewSizeHeight = kScreenHeight;
    if (mainViewSizeHeight <= 460) {
        mainViewSizeHeight = 460;
    }
    [_mainView setContentSize:CGSizeMake(kScreenWidth, mainViewSizeHeight)];

}

- (void)dealloc
{
    resultLabel = nil;
    
}

@end
