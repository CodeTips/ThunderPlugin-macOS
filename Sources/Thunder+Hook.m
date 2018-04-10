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
    ct_hookMethod(objc_getClass("NSBundle"), @selector(executablePath), [self class], @selector(hook_executablePath));
    ct_hookMethod(objc_getClass("XLHostTaskController"), @selector(taskCanTryHighSpeed:), [self class], @selector(hook_taskCanTryHighSpeed:));
    ct_hookMethod(objc_getClass("LocalTask"), @selector(canVipAccelerate), [self class], @selector(hook_canVipAccelerate));
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
//绕过MD5检测
- (NSString*)hook_executablePath
{
    return [[self hook_executablePath] stringByAppendingString:@"_backup"];
}

- (BOOL)hook_taskCanTryHighSpeed:(long long)arg1
{
    [[objc_getClass("XLHostTaskController") sharedController] setValue:@YES forKeyPath:@"_isFirstTryVipAccelerate"];
    return YES;
}

- (BOOL)hook_canVipAccelerate
{
    return YES;
}



@end
