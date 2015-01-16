//
//  HTLViewController.m
//  HourTimeLogger
//
//  Created by Jack Payette on 8/26/14.
//  Copyright (c) 2014 James Payette. All rights reserved.
//

#import "HTLViewController.h"
#import "HTLEntryViewController.h"
#import "HTLJob.h"
#import "HTLJobEntries.h"

@interface HTLViewController ()

@end

@implementation HTLViewController

@synthesize entry;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.entry = [[HTLJobEntries alloc]init];
    self.entry.eJobs = [[NSMutableArray alloc]init];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    name.text = [defaults objectForKey:@"defaultName"];
    email.text = [defaults objectForKey:@"defaultAdress"];
    
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"MM"];
    month.text = [dateFormat stringFromDate:today];
    [dateFormat setDateFormat:@"dd"];
    day.text = [dateFormat stringFromDate:today];
    [dateFormat setDateFormat:@"yyyy"];
    year.text = [dateFormat stringFromDate:today];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)setDefaultName:(UIButton *)sender
{
    UIAlertView* nameAlert = [[UIAlertView alloc]
                               initWithTitle: @"Warning" message: @"Are you sure you want to change your default name?"
                                                        delegate: self
                                               cancelButtonTitle: @"Cancel"
                                               otherButtonTitles: @"Yes", nil];
                                               nameAlert.tag = 0;
    [nameAlert show];
}

- (IBAction)setDefaultAddress:(UIButton *)sender
{
    UIAlertView* addressAlert = [[UIAlertView alloc]
                                  initWithTitle: @"Warning" message: @"Are you sure you want to change your default email?"
                                                           delegate: self
                                                  cancelButtonTitle: @"Cancel"
                                                  otherButtonTitles: @"Yes", nil];
                                                  addressAlert.tag = 1;
    [addressAlert show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex != [alertView cancelButtonIndex])
    {
        if (alertView.tag == 0) {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setValue:name.text forKey:@"defaultName"];
            [defaults synchronize];
        }
        else if (alertView.tag == 1) {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setValue:email.text forKey:@"defaultAdress"];
            [defaults synchronize];
        }
    }
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([identifier isEqualToString:@"segue"] || [identifier isEqualToString:@"segue1"])
    {
        if(![name.text isEqualToString:@""] && ![email.text isEqualToString:@""]
           && [month.text integerValue] != 0 && [day.text integerValue] != 0 &&
           [year.text integerValue] != 0)
        {
            self.entry.eName = name.text;
            self.entry.eRecipient = email.text;
            self.entry.eDate = [NSString stringWithFormat:@"%@/%@/%@",month.text,day.text,year.text];
            return YES;
        }
    }
    else
    {
        if ([name.text isEqualToString:@""])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:[NSString stringWithFormat:@"Choose a Valid Name"]
                                                           delegate:self
                                                  cancelButtonTitle: @"Cancel"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        if([email.text isEqualToString:@""])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:[NSString stringWithFormat:@"Choose a Valid Recipient"]
                                                           delegate:self
                                                  cancelButtonTitle: @"Cancel"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        if ([month.text integerValue] == 0 || [day.text integerValue] == 0 ||
            [year.text integerValue] == 0)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:[NSString stringWithFormat:@"Enter a Valid Date"]
                                                           delegate:self
                                                  cancelButtonTitle: @"Cancel"
                                                  otherButtonTitles:nil];
            [alert show];
        }

    }
    return NO;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"segue"] || [segue.identifier isEqualToString:@"segue1"]){
        HTLEntryViewController *controller = (HTLEntryViewController*)segue.destinationViewController;
        controller.entry = [[HTLJobEntries alloc]init];
        controller.entry = self.entry;
    }
}

-(IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];

    if (![[touch view] isKindOfClass:[UITextField class]]) {
        [self.view endEditing:YES];
        
    }
    [super touchesBegan:touches withEvent:event];
}

@end
