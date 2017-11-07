//
//  NaverOAuthSampleAppDelegate.h
//  NaverOAuthSample
//
//  Created by suejinv on 12. 3. 28..
//  Modified by TY Kim on 14. 8. 20..
//  Copyright 2014 Naver Corp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SampleOAuthViewController;
@interface NaverOAuthSampleAppDelegate : NSObject <UIApplicationDelegate>
{
    UIWindow *window;
    SampleOAuthViewController *viewController;
}

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) SampleOAuthViewController *viewController;

@end
