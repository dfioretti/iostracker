//
//  ComponentViewController.m
//  App Tracker
//
//  Created by David Fioretti on 12/3/13.
//  Copyright (c) 2013 David Fioretti. All rights reserved.
//

#import "ComponentViewController.h"
#import "AppDelegate.h"

@interface ComponentViewController ()
    - (void)configureView;
@end


@implementation ComponentViewController


- (void)setDetailItem:(App *)newDetailItem
{
    NSLog(@"compoent view new detail");
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}


- (void)configureView
{
    // Update the user interface for the detail item.
    self.tabBarController.navigationItem.rightBarButtonItem = self.addButton;

    NSLog(@"configure view component detail");
    if (self.detailItem) {
        self.deadlineText.text = [[self.detailItem valueForKey:@"deadline"]description];
        self.phoneText.text = self.detailItem.phone;
        self.websiteText.text = self.detailItem.website;
        self.emailText.text = self.detailItem.email;
        self.usernameText.text = [[self.detailItem valueForKey:@"username"] description];
        self.passwordText.text = [[self.detailItem valueForKey:@"password"] description];
    }
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self configureView];
    self.tabBarController.navigationItem.rightBarButtonItem = self.addButton;
    self.navigationItem.rightBarButtonItem = self.addButton;

}

- (IBAction) saveDetails:(id)sender {
    NSManagedObjectContext *context = [[self appDelegate] managedObjectContext];
    
    self.detailItem.deadline = self.deadlineText.text;
    self.detailItem.phone = self.phoneText.text;
    self.detailItem.website = self.websiteText.text;
    self.detailItem.email = self.emailText.text;
    self.detailItem.username = self.usernameText.text;
    self.detailItem.password = self.passwordText.text;
    
    self.deadlineText.enabled = NO;
    self.usernameText.enabled = NO;
    self.passwordText.enabled = NO;
    self.websiteText.enabled = NO;
    self.emailText.enabled = NO;
    self.phoneText.enabled = NO;
    
    
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    self.tabBarController.navigationItem.rightBarButtonItem = self.addButton;
}


- (IBAction) editDetails:(id)sender {
    self.tabBarController.navigationItem.rightBarButtonItem = self.saveButton;
    self.deadlineText.enabled = YES;
    [self.deadlineText becomeFirstResponder];
    self.usernameText.enabled = YES;
    self.passwordText.enabled = YES;
    self.websiteText.enabled = YES;
    self.emailText.enabled = YES;
    self.phoneText.enabled = YES;
    
    [self reloadInputViews];
    //[self performSegueWithIdentifier:@"showEdit" sender:@"component"];
}


-(IBAction) callPhone:(id)sender {
    NSString *phoneNumber = [NSString stringWithFormat:@"%@", self.detailItem.phone]; // dynamically assigned
    NSString *phoneURLString = [NSString stringWithFormat:@"tel:%@", phoneNumber];
    NSURL *phoneURL = [NSURL URLWithString:phoneURLString];
    [[UIApplication sharedApplication] openURL:phoneURL];
    
}

-(IBAction) visitWebsite:(id)sender {
    NSString *string = [NSString stringWithFormat:@"http://%@", self.detailItem.website];//if dyanmic then pass it as a parameter.
    NSURL *url = [NSURL URLWithString:string];
    [[UIApplication sharedApplication] openURL:url];
    
}


-(IBAction)sendEmail:(id)sender{
    mailComposer = [[MFMailComposeViewController alloc]init];
    mailComposer.mailComposeDelegate = self;
    //[mailComposer setSubject:@"Test mail"];
    [mailComposer setMessageBody:@"" isHTML:NO];
    NSArray *array = @[self.detailItem.email];
    [mailComposer setToRecipients: array];
     [self presentModalViewController:mailComposer animated:YES];
    }
     
#pragma mark - mail compose delegate
-(void)mailComposeController:(MFMailComposeViewController *)controller
             didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
                 if (result) {
                     NSLog(@"Result : %d",result);
                 }
                 if (error) {
                     NSLog(@"Error : %@",error);
                 }
                 [self dismissModalViewControllerAnimated:YES];
                 
}



 
 -(void) viewWillDisappear:(BOOL)animated
 {
     //self.tabBarController.navigationItem.rightBarButtonItem = nil;
 }

/*
 -(void)viewWillAppear:(BOOL)animated
 {
 self.tabBarController.navigationItem.rightBarButtonItem = self.addButton;
 }
 
 - (void)viewDidLoad
 {
 self.addButton = [[UIBarButtonItem alloc]
 initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
 target:self action: @selector(addButtonPressed:)];
 */




- (void)viewDidLoad
{
    self.addButton = [[UIBarButtonItem alloc]
                      initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                      target:self action: @selector(editDetails:)];
    
    self.saveButton = [[UIBarButtonItem alloc]
                      initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                      target:self action: @selector(saveDetails:)];


    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.tabBarController.navigationItem.rightBarButtonItem = self.addButton;

    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private methods
- (AppDelegate *)appDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

@end
