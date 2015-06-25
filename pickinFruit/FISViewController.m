//
//  FISViewController.m
//  pickinFruit
//
//  Created by Joe Burgess on 7/3/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//

#import "FISViewController.h"

@interface FISViewController () <UIPickerViewDataSource, UIPickerViewDelegate, UIAlertViewDelegate>

- (IBAction)spin:(id)sender;

@end

@implementation FISViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.fruitPicker.delegate = self;
    self.fruitPicker.dataSource = self;

    self.fruitsArray = @[@"Apple",@"Orange",@"Banana",@"Pear",@"Grape", @"Kiwi", @"Mango", @"Blueberry", @"Raspberry"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.fruitsArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.fruitsArray[row];
}

- (IBAction)spin:(id)sender
{
    [self spinFruit];
}

- (void)spinFruit
{
    for (NSUInteger i = 0; i < 3; i++){
        NSUInteger randomRow = arc4random_uniform((int)self.fruitsArray.count);
        [self.fruitPicker selectRow:randomRow inComponent:i animated:YES];
    }
    
    // check for winner
    [self checkForWinner];
}

- (void)checkForWinner
{
    // if all three components are equal
    NSUInteger row1 = [self.fruitPicker selectedRowInComponent:0];
    NSUInteger row2 = [self.fruitPicker selectedRowInComponent:1];
    NSUInteger row3 = [self.fruitPicker selectedRowInComponent:2];
    
    NSString *message;
    if (row1 == row2 && row2 == row3) {
        message = @"You won!";
    } else {
        message = @"You lost!";
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Drumroll please..."
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Re-spin", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        NSLog(@"Cancel");
    } else if (buttonIndex == 1) {
        NSLog(@"Re-spin");
        [self spinFruit];
    }
}

@end
