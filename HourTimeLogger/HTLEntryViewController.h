//
//  HTLEntryViewController.h
//  HourTimeLogger
//
//  Created by Jack Payette on 8/27/14.
//  Copyright (c) 2014 James Payette. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "HTLJobEntries.h"

@interface HTLEntryViewController : UIViewController <MFMailComposeViewControllerDelegate, UITextFieldDelegate>
{
    IBOutlet UITextField *job;
    IBOutlet UITextField *description;
    IBOutlet UITextField *hours;
}

@property (nonatomic,retain) HTLJobEntries *entry;

- (IBAction)addAnotherEntry:(id)sender;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (IBAction)textFieldReturn:(id)sender;

@end
