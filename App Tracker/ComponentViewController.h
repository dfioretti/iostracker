//
//  ComponentViewController.h
//  App Tracker
//
//  Created by David Fioretti on 12/3/13.
//  Copyright (c) 2013 David Fioretti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "App.h"
#import <MessageUI/MessageUI.h>


@interface ComponentViewController : UIViewController <MFMailComposeViewControllerDelegate> {
    MFMailComposeViewController *mailComposer;

}
- (IBAction)openMail:(id)sender;

@property (strong, nonatomic) App *detailItem;
@property (weak, nonatomic) IBOutlet UITextField *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *deadlineText;
@property (strong, nonatomic) UIBarButtonItem *addButton;
@property (weak, nonatomic) IBOutlet UITextField *emailText;
@property (weak, nonatomic) IBOutlet UITextField *phoneText;
@property (weak, nonatomic) IBOutlet UITextField *usernameText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;
@property (weak, nonatomic) IBOutlet UITextField *websiteText;
@property (strong, nonatomic) UIBarButtonItem *saveButton;



@end
