//
//  JSPatchBridging.m
//  YFSMM
//
//  Created by Alvin on 2017/8/12.
//  Copyright © 2017年 Alvin. All rights reserved.
//

#import "JSPatchBridging.h"
#import "YFSMM-Swift.h"
#import <JSPatchPlatform/JSPatch.h>
@implementation JSPatchBridging

- (void)startJSPatch {
    /*  [JSPatch startWithAppKey:@"978525671e6694c0"];
     [JSPatch setupRSAPublicKey:@"-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDGDh0LlYfqxiwi7VFV6/S6M1KW\n8FBN/T8+wFCOxIuFj48ACpYbw3v6QuSn4qi8aOUThbiXhK29PrgxtVm57vablux7\nGieVi93wS+mS0N+zjAP5R3vzoaF7xm/v2OAwYkWjEdB9LMeYtY4n9VuTNgdBRveq\nGfp31VwYZKkdyu3eWQIDAQAB\n-----END PUBLIC KEY-----"];
     [JSPatch sync];*/
    [JSPatch setupCallback:^(JPCallbackType type, NSDictionary *data, NSError *error) {
        if (type == JPCallbackTypeJSException) {
            NSAssert(NO, data[@"msg"]);
        }
    }];
    [JSPatch testScriptInBundle];
}
@end

