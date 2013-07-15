//
//  RootViewController.m
//  InsertInTable
//
//  Created by Ashish Sharma (saadnib) on 15/07/13.
//  Copyright (c) 2013 Ashish Sharma (saadnib). All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

@synthesize tblView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // init array
    array = [[NSMutableArray alloc] init];
    
    // populate array
    for (int i = 0; i < 21; i++)
    {
        NSMutableDictionary *rowInfo = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"Row -- %d",i],@"rowTitle",@"1",@"type",nil];
        
        [array addObject:rowInfo];
    }
}

- (void) doneBtnTap:(id) sender
{
    UIButton *doneBtn = (UIButton*) sender;
    
    UITableViewCell *cell = (UITableViewCell*) [[doneBtn superview] superview];
    
    // get selected date and set to above cell
    UIDatePicker *datePicker = (UIDatePicker*) [cell viewWithTag:1];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    
    NSIndexPath *indexPath = [self.tblView indexPathForCell:cell];
    
    NSIndexPath *prevCellIndexPath = [NSIndexPath indexPathForRow:indexPath.row-1 inSection:0];
    
    UITableViewCell *prevCell = [self.tblView cellForRowAtIndexPath:prevCellIndexPath];
    
    [prevCell.textLabel setText:[dateFormatter stringFromDate:[datePicker date]]];
    
    NSMutableDictionary *rowInfo = [array objectAtIndex:prevCellIndexPath.row];
    
    [rowInfo setObject:[dateFormatter stringFromDate:[datePicker date]] forKey:@"rowTitle"];
    
    
    // remove picker cell
    [array removeObjectAtIndex:indexPath.row];
    
    [self.tblView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    isPickerVisible = NO;
}

#pragma mark - UITableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *rowCellIdentifier = @"row";
    static NSString *pickerCellIdentifier = @"picker";
    
    NSMutableDictionary *rowInfo = [array objectAtIndex:indexPath.row];
    
    if ([[rowInfo objectForKey:@"type"] intValue] == 1)
    {
        UITableViewCell *cell = [self.tblView dequeueReusableCellWithIdentifier:rowCellIdentifier];
        
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rowCellIdentifier];
        }
        
        [cell.textLabel setText:[rowInfo objectForKey:@"rowTitle"]];
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
        
        return cell;
    }
    else if ([[rowInfo objectForKey:@"type"] intValue] == 2)
    {
        UITableViewCell *cell = [self.tblView dequeueReusableCellWithIdentifier:pickerCellIdentifier];
        
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:pickerCellIdentifier];
            
            UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.0f, 40.0f, 320.0f, 216.0f)];
            [datePicker setDatePickerMode:UIDatePickerModeDate];
            [datePicker setTag:1];
            [cell addSubview:datePicker];
            
            UIButton *doneBtn = [[UIButton alloc] initWithFrame:CGRectMake(250.0f, 5.0f, 60.0f, 30.0f)];
            [doneBtn setTitle:@"Done" forState:UIControlStateNormal];
            [doneBtn setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
            [doneBtn addTarget:self action:@selector(doneBtnTap:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:doneBtn];
        }
        
        return cell;
    }
    
    return [[UITableViewCell alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *rowInfo = [array objectAtIndex:indexPath.row];
    
    if ([[rowInfo objectForKey:@"type"] intValue] == 1)
    {
        return 44.0f;
    }
    else
    {
        return 256.0f;
    }
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!isPickerVisible)
    {
        NSMutableDictionary *rowInfo = [array objectAtIndex:indexPath.row];
        
        if ([[rowInfo objectForKey:@"type"] intValue] == 1)
        {
            NSMutableDictionary *rowInfo = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"2",@"type",nil];
            
            [array insertObject:rowInfo atIndex:indexPath.row+1];
            
            NSIndexPath *nextIndexPath = [NSIndexPath indexPathForRow:indexPath.row+1 inSection:0];
            
            [self.tblView insertRowsAtIndexPaths:[NSArray arrayWithObject:nextIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            
            isPickerVisible = YES;
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
