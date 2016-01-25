//
//  UINavigationBar+HeightFix.m
//  BarFun
//
//  Created by David Whetstone on 1/24/16.
//  Copyright © 2016 humblehacker. All rights reserved.
//

#import "UINavigationBar+HeightFix.h"
#import <objc/runtime.h>

@implementation UINavigationBar (HeightFix)

- (void)setCenter_heightFix:(CGPoint)center {

    if (self.window.frame.origin.y != 0.0)
        center.y = 22.0;

    [self setCenter_heightFix:center];
}

+ (void)load {

    static dispatch_once_t token = 0;
    dispatch_once(&token, ^{
        Method originalMethod    = class_getInstanceMethod(self, @selector(setCenter:));
        Method replacementMethod = class_getInstanceMethod(self, @selector(setCenter_heightFix:));
        method_exchangeImplementations(originalMethod, replacementMethod);
    });
}

@end
