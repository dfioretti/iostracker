//
//  NotesView.m
//  App Tracker
//
//  Created by David Fioretti on 12/3/13.
//  Copyright (c) 2013 David Fioretti. All rights reserved.
//

#import "NotesView.h"
#import "AppDelegate.h"

@interface NotesView ()
    - (void)configureView;
@end

@implementation NotesView

-(void)setTabController:(UITabBarController *)tabController
{
    if (_tabController != tabController) {
        _tabController = tabController;
    }
}

- (void)setDetailItem:(Component *)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
    }
    [self configureView];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    NSLog(@"textViewShouldBeginEditing:");
    return YES;
}
- (void)textViewDidBeginEditing:(UITextView *)textView {
    NSLog(@"textViewDidBeginEditing:");
}

-(void) setTextView:(UITextView *) newTextView
{
    if (_textView != newTextView) {
        _textView = newTextView;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    //self.tabBarController.navigationItem.rightBarButtonItem = self.addButton;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)moveTextViewForKeyboard:(NSNotification*)aNotification up:(BOOL)up {
    self.tabBarController.navigationItem.rightBarButtonItem = self.addButton;
    NSDictionary* userInfo = [aNotification userInfo];
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    CGRect keyboardEndFrame;
    
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardEndFrame];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    
    CGRect newFrame = self.textView.frame;
    CGRect keyboardFrame = [self.view convertRect:keyboardEndFrame toView:nil];
    keyboardFrame.size.height -= self.tabBarController.tabBar.frame.size.height;
    newFrame.size.height -= keyboardFrame.size.height * (up?1:-1);
    self.textView.frame = newFrame;
    
    [UIView commitAnimations];
}

- (void)keyboardWillShown:(NSNotification*)aNotification
{
    self.addButton.enabled = true;
    [self moveTextViewForKeyboard:aNotification up:YES];
}

- (void)keyboardWillHide:(NSNotification*)aNotification
{
    //self.addButton.enabled = false;
    self.tabBarController.navigationItem.rightBarButtonItem = nil;

    [self moveTextViewForKeyboard:aNotification up:NO];
}



- (IBAction) updateDetails:(id)sender {
    [self.textView resignFirstResponder];
    self.tabBarController.navigationItem.rightBarButtonItem = nil;
    self.detailItem.notes = self.textView.text;
    NSManagedObjectContext *context = [[self appDelegate] managedObjectContext];
    
    NSError *error = nil;
    
    if (![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan:withEvent:");
    [self.textView endEditing:YES];
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
//{
//    if([text isEqualToString:@"\n"])
//    {
//        [textView resignFirstResponder];
//        return NO;
//    }
//    return YES;
//}













- (void)configureView
{
    self.view.backgroundColor = [UIColor colorWithRed: 244.0/255.0 green: 244.0/255.0 blue:244.0/255.0 alpha: 1.0];

    self.view.alpha = 1.0;
    //UITextView *txt = [[UITextView alloc] initWithFrame:CGRectMake(10, 90, 300, 400)];
//    txt.showsHorizontalScrollIndicator = NO;
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 70, 300, 400)];
    self.textView.backgroundColor = [UIColor clearColor];
    self.textView.text = self.detailItem.notes;

    UIColor *ios7BlueColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];

    self.textView.textColor = ios7BlueColor;
    self.textView.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0];

    self.textView.delegate = self;
    self.textView.scrollEnabled = YES;
    
    
    [self.view addSubview:self.textView];

//    [txt setText:@"Ananth"];
 //   [self.view addSubview:txt];
  //  txt.delegate = self;

    /*
    CGRect textViewFrame = CGRectMake(20.0f, 20.0f, 280.0f, 124.0f);
     self.textView = [[UITextView alloc] initWithFrame:textViewFrame];
    self.textView.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:self.textView];
    self.textView.text = self.detailItem.notes;
     */
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    NSLog(@"textViewShouldEndEditing:");
    return YES;
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    self.tabBarController.navigationItem.rightBarButtonItem = nil;
    
    NSLog(@"textViewDidEndEditing:");
}

- (void)viewDidLoad
{
    self.addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action: @selector(updateDetails:)];
    //self.tabBarController.navigationItem.rightBarButtonItem = self.addButton;

    [super viewDidLoad];
    NSLog(@"view did load");
	// Do any additional setup after loading the view.
   // self.addButton = [[UIBarButtonItem alloc]
     //                 initWithBarButtonSystemItem:UIBarButtonSystemItemDone
       //               target:self action: @selector(addButtonPressed:)];
    
    //self.navigationController.navigationBar.backgroundColor = [UIColor greenColor];
//    self.navigationController.navigationItem.rightBarButtonItem = self.addButton;


    
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
