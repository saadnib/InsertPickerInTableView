//
//  RootViewController.h
//  InsertInTable
//
//  Created by Ashish Sharma (saadnib) on 15/07/13.
//  Copyright (c) 2013 Ashish Sharma (saadnib). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController
{
    BOOL isPickerVisible;
    
    NSMutableArray *array;
}

@property (nonatomic, strong) IBOutlet UITableView *tblView;

@end
