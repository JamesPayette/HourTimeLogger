//
//  HTLEntryViewController.m
//  HourTimeLogger
//
//  Created by Jack Payette on 8/27/14.
//  Copyright (c) 2014 James Payette. All rights reserved.
//

#import "HTLEntryViewController.h"
#import "HTLJob.h"

@interface HTLEntryViewController ()

@end

@implementation HTLEntryViewController

@synthesize entry;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    job.text = [defaults objectForKey:@"jobName"];
    description.text = [defaults objectForKey:@"jobDescription"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addAnotherEntry:(id)sender
{
    HTLJob *thisJob = [[HTLJob alloc]init];
    thisJob.jobName = job.text;
    thisJob.description = description.text;
    thisJob.hours = hours.text;
    [self.entry.eJobs addObject:thisJob];
}

- (IBAction)showEmail: (id)sender {
    
    if(![job.text isEqual:@""] && ![description.text isEqual:@""] && ![hours.text isEqual:@""] && ([hours.text integerValue] != 0 || [hours.text isEqualToString:@"0"]))
    {
        HTLJob *thisJob = [[HTLJob alloc]init];
        thisJob.jobName = job.text;
        thisJob.description = description.text;
        thisJob.hours = hours.text;
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setValue:thisJob.jobName forKey:@"jobName"];
        [defaults setValue:thisJob.description forKey:@"jobDescription"];
        [defaults synchronize];
        
        [self.entry.eJobs addObject:thisJob];
        
        NSString *recipient = self.entry.eRecipient;
        NSString *subject = [NSString stringWithFormat:@"%@'s work on %@",self.entry.eName,self.entry.eDate];
        NSString *messageBody = [NSString stringWithFormat:@"%@'s work on %@: \n \n",self.entry.eName,self.entry.eDate];
        int totalHours = 0;
        
        for (int i = 0; i<self.entry.eJobs.count; i++) {
            HTLJob * curJob = self.entry.eJobs[i];
            messageBody = [messageBody stringByAppendingString:[NSString stringWithFormat: @"Job #%i: %@ \n Description: %@ \n Hours: %@ \n \n",(i+1),curJob.jobName,curJob.description,curJob.hours]];
            totalHours += [curJob.hours intValue];
        }
        
        NSString *totalHoursString = [NSString stringWithFormat:@"%i",totalHours];
        
        messageBody = [messageBody stringByAppendingString:[NSString stringWithFormat:@"Total Hours: %@ \n \n Sent From HourLogger",totalHoursString]];
    
        MFMailComposeViewController *composer=[[MFMailComposeViewController alloc]init];
        [composer setMailComposeDelegate:self];
        if ([MFMailComposeViewController canSendMail]) {
            [composer setToRecipients:[NSArray arrayWithObjects:recipient, nil]];
            [composer setSubject:subject];
            [composer setMessageBody:messageBody isHTML:NO];
            [composer setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
            [self presentViewController:composer animated:YES completion:nil];
        }
        else {
        
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:[NSString stringWithFormat:@"Mail Account Not Set Up"]
                                                       delegate:self
                                              cancelButtonTitle: @"Cancel"
                                              otherButtonTitles:nil];
            [alert show];
        }
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:[NSString stringWithFormat:@"Please Enter Valid Text"]
                                                       delegate:self
                                              cancelButtonTitle: @"Cancel"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    
    if (![[touch view] isKindOfClass:[UITextField class]])
    {
        [self.view endEditing:YES];
    }
    [super touchesBegan:touches withEvent:event];
}

- (IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([identifier isEqualToString:@"entrySegue"] || [identifier isEqualToString:@"entrySegue1"])
    {
        if(![job.text isEqual:@""] && ![description.text isEqual:@""] && ![hours.text isEqual:@""] && ([hours.text integerValue] != 0 || [hours.text isEqualToString:@"0"]))
        {
            return YES;
        }
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:[NSString stringWithFormat:@"Please Enter Valid Text"]
                                                   delegate:self
                                          cancelButtonTitle: @"Cancel"
                                          otherButtonTitles:nil];
    [alert show];
    return NO;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"entrySegue"] || [segue.identifier isEqualToString:@"entrySegue1"]){
        HTLEntryViewController *controller = (HTLEntryViewController*)segue.destinationViewController;
        controller.entry = [[HTLJobEntries alloc]init];
        controller.entry = self.entry;
    }
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
        {
            NSLog(@"Mail cancelled");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning"
                                                            message:[NSString stringWithFormat:@"Mail Cancelled"]
                                                           delegate:self
                                                  cancelButtonTitle: @"Continue"
                                                  otherButtonTitles:nil];
            [alert show];
            break;
        }
        case MFMailComposeResultSaved:
        {
            NSLog(@"Mail saved");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning"
                                                            message:[NSString stringWithFormat:@"Mail Saved"]
                                                           delegate:self
                                                  cancelButtonTitle: @"Continue"
                                                  otherButtonTitles:nil];
            [alert show];
            break;
        }
        case MFMailComposeResultSent:
        {
            NSLog(@"Mail sent");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Congratulations"
                                                            message:[NSString stringWithFormat:@"Mail Sent"]
                                                           delegate:self
                                                  cancelButtonTitle: @"Continue"
                                                  otherButtonTitles:nil];
            [alert show];
            break;
        }
        case MFMailComposeResultFailed:
        {
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:[NSString stringWithFormat:@"Message Failed To Send"]
                                                           delegate:self
                                                  cancelButtonTitle: @"Continue"
                                                  otherButtonTitles:nil];
            [alert show];
            break;
        }
        default:
            break;
    }
    // Close the Mail Interface
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
