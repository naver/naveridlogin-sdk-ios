//
//  NaverThirdPartyLoginUrlConnection.h
//  NaverSearch
//
//  Created by 백 승필 on 12. 6. 2..
//  Modified by TY Kim on 14. 8. 20..
//  Copyright 2014 Naver Corp. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum NSUInteger {
    NaverThirdPartyLoginRequestKeyACWithCode = 1,
    NaverThirdPartyLoginRequestKeyACWithRefreshToken,
    NaverThirdPartyLoginRequestLogoutAndRevokeToken,
    NaverThirdPartyLoginRequestRemoveNaverLoginCookie
} NaverThirdPartyLoginRequestKey;

@interface NaverThirdPartyLoginUrlConnection : NSURLConnection {
    NaverThirdPartyLoginRequestKey _requestKey;
}

@property (nonatomic) NaverThirdPartyLoginRequestKey requestKey;

- (id) initWithRequest:(NSString *)requestUrl delegate:(id)delegate requestKey:(NaverThirdPartyLoginRequestKey)key;
@end


@interface NSError(NaverThirdPartyLoginUrlConnection)
+ (NSError *) errorWithErrorInfo:(NSString *)errorInfo;
@end