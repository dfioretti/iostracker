//
//  TaskDetailsController.m
//  App Tracker
//
//  Created by David Fioretti on 12/3/13.
//  Copyright (c) 2013 David Fioretti. All rights reserved.
//

#import "TaskDetailsController.h"
#import "AppDelegate.h"

@interface TaskDetailsController ()
- (void)configureView;
@end

@implementation TaskDetailsController


- (void)setDetailItem:(Component *)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    self.savedLabel.text = @"";
}

- (IBAction) updateDetails:(id)sender {
    
    NSLog(@"logging....");
    NSManagedObjectContext *context = [[self appDelegate] managedObjectContext];
    self.detailItem.status =[NSNumber numberWithInt:[self.pickerView selectedRowInComponent:0]];
    int slider = (int)self.progressBar.value;
    self.detailItem.progress = [NSNumber numberWithInt: slider];

    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    self.savedLabel.text = @"Saved!";


    
//    self.searchRadius = (int)searchRadiusSlider.value;
    

    // NSManagedObject is detailitem
/*    NSManagedObjectContext *context = [[self appDelegate] managedObjectContext];
    [self.detailItem setValue:self.deadlineText.text forKey:@"deadline"];
    [self.detailItem setValue:self.emailText.text forKey:@"email"];
    [self.detailItem setValue:self.phoneText.text forKey:@"phone"];
    [self.detailItem setValue:self.usernameText.text forKey:@"username"];
    [self.detailItem setValue:self.passwordText.text forKey:@"password"];
    [self.detailItem setValue:self.websiteText.text forKey:@"website"];
    
    
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    UINavigationController *navController = self.navigationController;
    [navController popViewControllerAnimated:YES];
    
    // [self configureView];
    */
    
}

- (void)configureView
{
    // Update the user interface for the detail item.
    
    if (self.detailItem) {
        
        self.titleLabel.text = self.detailItem.name;
        NSInteger myInteger = [self.detailItem.status integerValue];
        NSLog(@"index %d", myInteger);
        [self.pickerView selectRow: myInteger inComponent:0 animated:NO];
        float result = [self.detailItem.progress floatValue];

        self.progressBar.value = result;

        //self.detailDescriptionLabel.text = [[self.detailItem valueForKey:@"title"] description];
        //self.titleLabel.text = [[self.detailItem valueForKey:@"title"] description];
        //self.deadlineText.text = [[self.detailItem valueForKey:@"deadline"]description];
        //self.emailText.text = [[self.detailItem valueForKey:@"email"]description];
        //self.phoneText.text = [[self.detailItem valueForKey:@"phone"] description];
        //self.usernameText.text = [[self.detailItem valueForKey:@"username"] description];
        //self.passwordText.text = [[self.detailItem valueForKey:@"password"] description];
        //self.websiteText.text = [[self.detailItem valueForKey:@"website"] description];
        
    }
    
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row   forComponent:(NSInteger)component
{
    
    return [self.pickerArray objectAtIndex:row];
    
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
    
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component
{
    return 7;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.navigationItem.rightBarButtonItem = self.addButton;

  //  self.tabBarController.navigationItem.rightBarButtonItem = self.addButton;
    self.navigationItem.rightBarButtonItem = self.addButton;

    //self.tabBarController.navigationItem.rightBarButtonItem = nil;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];
    
    self.addButton = [[UIBarButtonItem alloc]
                      initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                      target:self action: @selector(updateDetails:)];
    
	// Do any additional setup after loading the view.
    //self.tabBarController.navigationItem.rightBarButtonItem = self.addButton;
//    self.navigationItem.rightBarButtonItem = self.addButton;
        self.tabBarController.navigationItem.rightBarButtonItem = self.addButton;

	// Do any additional setup after loading the view.
    self.pickerArray  = [[NSArray alloc] initWithObjects:@"Not Started",@"In Progress",@"Draft",@"Second Draft",@"Review",@"Complete", @"Submitted" , nil];

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
