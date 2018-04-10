//
//  libThunderPlugin.h
//  libThunderPlugin
//
//  Copyright © 2018 CodeTips. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CDStructures.h"
#import "EtmApi.h"
//! Project version number for libThunderPlugin.
FOUNDATION_EXPORT double libThunderPluginVersionNumber;

//! Project version string for libThunderPlugin.
FOUNDATION_EXPORT const unsigned char libThunderPluginVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <libThunderPlugin/PublicHeader.h>
@interface XLUserInformation : NSObject
@property(readonly, copy) NSString *isVip; // @synthesize isVip=_isVip;
@property(readonly, copy) NSString *isYear; // @synthesize isYear=_isYear;
@property(readonly, copy) NSString *vipLevel; // @synthesize vipLevel=_vipLevel;
@property(readonly, copy) NSString *expireDate; // @synthesize
- (id)initWithUserInfo:(id)arg1;
@end

@interface XLHostBaseController : NSObject
@end
@interface XLHostTaskController : XLHostBaseController

+ (id)sharedController;
- (BOOL)taskCanTryHighSpeed:(long long)arg1;

@end

@interface LocalTask : NSObject
@property(readonly, nonatomic) BOOL canVipAccelerate;
@end
