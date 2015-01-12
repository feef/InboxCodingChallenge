//
//  AppDelegate.h
//  InboxCodingChallenge
//
//  Created by sharif ahmed on 1/11/15.
//  Copyright (c) 2015 Feef. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ICCAppDelegate : UIResponder <UIApplicationDelegate>

+(ICCAppDelegate*)sharedInstance;

@property (strong, nonatomic) UIWindow *window;

@end

