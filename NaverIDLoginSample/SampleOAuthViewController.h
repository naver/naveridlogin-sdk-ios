//
//  SampleOAuthViewController.h
//  NaverOAuthSample
//
//  Created by suejinv on 12. 3. 28..
//  Modified by TY Kim on 14. 8. 20..
//  Copyright 2014 Naver Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SampleOAuthView.h"
#import <NaverThirdPartyLogin/NaverThirdPartyLogin.h>

@interface SampleOAuthViewController : UIViewController <SampleOAuthViewDelegate, NaverThirdPartyLoginConnectionDelegate>
{
    NaverThirdPartyLoginConnection *_thirdPartyLoginConn;
    
    SampleOAuthView *_mainView;
}

@property (nonatomic, strong) SampleOAuthView *mainView;
@end
