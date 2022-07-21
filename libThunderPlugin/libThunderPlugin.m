//
//  libThunderPlugin.m
//  libThunderPlugin
//
//  Created by LEMON on 2022/7/20.
//

#import "libThunderPlugin.h"
#import "objc/runtime.h"

void lm_hookMethod(Class originalClass, SEL originalSelector, Class swizzledClass, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(originalClass, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(swizzledClass, swizzledSelector);
    if(originalMethod && swizzledMethod) {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@implementation NSObject (Thunder)
+ (void)hookThunder{
    lm_hookMethod(objc_getClass("XLUserInformation"), @selector(initWithUserInfo:), [self class], @selector(hook_initWithUserInfo:));
    lm_hookMethod(objc_getClass("XLUserInformation"), @selector(updateUserInfo:), [self class], @selector(hook_updateUserInfo:));
}
- (id)hook_initWithUserInfo:(id)arg1{
    return [self hook_initWithUserInfo:[self modify:arg1]];
}
- (void)hook_updateUserInfo:(id)arg1{
    [self hook_updateUserInfo:[self modify:arg1]];
}
- (NSDictionary *)modify:(NSDictionary *)user{
    NSDictionary *vipInfo = [[user objectForKey:@"vipList"] firstObject];
    NSMutableDictionary *mutableVipInfo = [vipInfo mutableCopy];
    [mutableVipInfo setValue:@"1" forKey:@"isVip"];
    [mutableVipInfo setValue:@"20990131" forKey:@"expireDate"];
    [mutableVipInfo setValue:@"4" forKey:@"vasType"];
    NSMutableDictionary *userInfo = [user mutableCopy];
    [userInfo setObject:@[mutableVipInfo] forKey:@"vipList"];
    return userInfo;
}
@end


static void __attribute__((constructor)) initialize(void) {
    [NSObject hookThunder];
}
