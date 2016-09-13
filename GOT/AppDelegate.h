//
//  AppDelegate.h
//  GOT
//
//  Created by Dragos Marinescu on 09/09/16.
//  Copyright © 2016 NetGuru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GOTArticlesVC.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController* navController;
@property (strong, nonatomic) GOTArticlesVC* gotArticlesVC;

@end

