//
//  HTLViewController.h
//  HourTimeLogger
//
//  Created by Jack Payette on 8/26/14.
//  Copyright (c) 2014 James Payette. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTLJobEntries.h"
#import "HTLJob.h"

@interface HTLViewController : UIViewController <UITextFieldDelegate, UIAlertViewDelegate> {
    IBOutlet UITextField *name;
    IBOutlet UITextField *email;
    IBOutlet UITextField *month;
    IBOutlet UITextField *day;
    IBOutlet UITextField *year;
}

@property (strong) HTLJobEntries *entry;

- (IBAction)setDefaultName:(id)sender;
- (IBAction)setDefaultAddress:(id)sender;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (IBAction)textFieldReturn:(id)sender;

@end
