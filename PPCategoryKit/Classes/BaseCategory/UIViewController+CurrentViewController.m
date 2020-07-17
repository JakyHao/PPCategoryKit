//
//  UIViewController+CurrentViewController.m
//  UU
//
//  Created by zyx on 2018/9/12.
//  Copyright © 2018年 王 家振. All rights reserved.
//

#import "UIViewController+CurrentViewController.h"

@implementation UIViewController (CurrentViewController)

+ (UIViewController *)currentViewController {
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        result = nextResponder;
    } else {
        result = window.rootViewController;
    }
    do {
        if ([result isKindOfClass:[UITabBarController class]]) {
            result = ((UITabBarController *)result).childViewControllers.firstObject;
        }
        if (result.presentedViewController) {
            result = result.presentedViewController;
        }
        if ([result isKindOfClass:[UINavigationController class]]) {
            result = ((UINavigationController *)result).childViewControllers.lastObject;
        }
    } while ([result isKindOfClass:[UITabBarController class]]);
    
    return result;
}

@end
