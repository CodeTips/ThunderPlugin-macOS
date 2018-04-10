//
//  main.c
//  libThunderPlugin
//
//  Copyright © 2018 CodeTips. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Thunder+Hook.h"
static void __attribute__((constructor)) initialize(void) {
    [NSObject hookThunder];
}
