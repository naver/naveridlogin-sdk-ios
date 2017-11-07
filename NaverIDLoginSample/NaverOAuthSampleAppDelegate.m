//
//  NaverOAuthSampleAppDelegate.m
//  NaverOAuthSample
//
//  Created by suejinv on 12. 3. 28..
//  Modified by TY Kim on 14. 8. 20..
//  Copyright 2014 Naver Corp. All rights reserved.
//

#import "NaverOAuthSampleAppDelegate.h"
#import "SampleOAuthViewController.h"
#import <NaverThirdPartyLogin/NaverThirdPartyLogin.h>

@implementation NaverOAuthSampleAppDelegate

@synthesize window;
@synthesize viewController;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NaverThirdPartyLoginConnection *thirdConn = [NaverThirdPartyLoginConnection getSharedInstance];
//    [thirdConn setOnlyPortraitSupportInIphone:YES];
    
    [thirdConn setServiceUrlScheme:kServiceAppUrlScheme];
    [thirdConn setConsumerKey:kConsumerKey];
    [thirdConn setConsumerSecret:kConsumerSecret];
    [thirdConn setAppName:kServiceAppName];
    
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.viewController = [[SampleOAuthViewController alloc] init];
    self.window.rootViewController = viewController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

//iOS 9.0 미만일때 구현
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [[NaverThirdPartyLoginConnection getSharedInstance] application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
}

//iOS 9.0 이상일 때 구현
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    return [[NaverThirdPartyLoginConnection getSharedInstance] application:app openURL:url options:options];
}

@end
