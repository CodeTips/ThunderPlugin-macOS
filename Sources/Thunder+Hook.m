//
//  NSObject+Thunder_Hook.m
//  libThunderPlugin
//
//  Copyright © 2018 CodeTips. All rights reserved.
//

#import "Thunder+Hook.h"
#import "libThunderPlugin.h"
#import "CTSwizzledHelper.h"

@implementation NSObject (Thunder)

+ (void)hookThunder
{
    ct_hookMethod(objc_getClass("XLUserInformation"), @selector(initWithUserInfo:), [self class], @selector(hook_initWithUserInfo:));
    ct_hookMethod(objc_getClass("XLUserInformation"), @selector(updateUserInfo:), [self class], @selector(hook_updateUserInfo:));
}

- (id)hook_initWithUserInfo:(id)arg1
{
    NSDictionary *vipInfo = [[arg1 objectForKey:@"vipList"] firstObject];
    NSMutableDictionary *mutableVipInfo = [vipInfo mutableCopy];
    [mutableVipInfo setValue:@"1" forKey:@"isVip"];
    [mutableVipInfo setValue:@"20990131" forKey:@"expireDate"];
    [mutableVipInfo setValue:@"4" forKey:@"vasType"];
    NSMutableDictionary *userInfo = [arg1 mutableCopy];
    [userInfo setObject:@[mutableVipInfo] forKey:@"vipList"];
    return [self hook_initWithUserInfo:userInfo];
}
- (void)hook_updateUserInfo:(id)arg1{
    NSDictionary *vipInfo = [[arg1 objectForKey:@"vipList"] firstObject];
    NSMutableDictionary *mutableVipInfo = [vipInfo mutableCopy];
    [mutableVipInfo setValue:@"1" forKey:@"isVip"];
    [mutableVipInfo setValue:@"20990131" forKey:@"expireDate"];
    [mutableVipInfo setValue:@"4" forKey:@"vasType"];
    NSMutableDictionary *userInfo = [arg1 mutableCopy];
    [userInfo setObject:@[mutableVipInfo] forKey:@"vipList"];
    [self hook_updateUserInfo:userInfo];
}

@end
