//
//  AppDelegate.h
//  InsertInTable
//
//  Created by Ashish Sharma (saadnib) on 15/07/13.
//  Copyright (c) 2013 Ashish Sharma (saadnib). All rights reserved.
//  http://stackoverflow.com/users/672531/saadnib
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    RootViewController *rootViewController;
}

@property (strong, nonatomic) IBOutlet UIWindow *window;

@end
