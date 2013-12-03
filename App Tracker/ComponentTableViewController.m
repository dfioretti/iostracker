//
//  ComponentTableViewController.m
//  App Tracker
//
//  Created by David Fioretti on 12/2/13.
//  Copyright (c) 2013 David Fioretti. All rights reserved.
//

#import "ComponentTableViewController.h"
#import "Component.h"
#import "App.h"
#import "AppDelegate.h"
#import "CompoentTabBarController.h"
#import "CircleView.h"

@interface ComponentTableViewController ()
    - (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end


@implementation ComponentTableViewController

static NSString *cellIdentifier;



-(void)setTabController:(UITabBarController *)tabController
{
    if (_tabController != tabController) {
        _tabController = tabController;
    }
}

- (void)setDetailItem:(App *)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
    }
}


- (id)initWithStyle:(UITableViewStyle)style
{
    //self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) viewWillDisappear:(BOOL)animated
{
    self.tabController.navigationItem.rightBarButtonItem = nil;
    
}
-(void)viewWillAppear:(BOOL)animated
{
    self.data = [[self.detailItem.components allObjects] mutableCopy];
    [self.tableView reloadData];
    self.tabController.navigationItem.rightBarButtonItem = self.addButton;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"indexpath did select %d", indexPath.row);
    self.row = indexPath.row;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"componentSegue" sender:@"component"];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"componentSegue"]) {
        //NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Component *object = (Component *)[self.data objectAtIndex: self.row];
        
        NSLog(@"indexpath prepare %d", self.row);
        CompoentTabBarController *todo = [segue destinationViewController];
        [todo setTabController:self.tabBarController];
        [todo setDetailItem:object];
        [todo setComponentItem:object];
    }
}

-(void)addButtonPressed:(UIBarButtonItem *)sender{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"New Component"
                          message:@"Please enter the name for this component."
                          delegate:self
                          cancelButtonTitle:@"Cancel"
                          otherButtonTitles:@"OK"
                          , nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Component *component = [self.data objectAtIndex: indexPath.row];
        NSManagedObjectContext *context = [[self appDelegate] managedObjectContext];
        [context deleteObject:component];
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
//        self.data = [[self.detailItem.components allObjects] mutableCopy];
        self.data = nil;
        self.data = [[self.detailItem.components allObjects] mutableCopy];
        [self.tableView reloadData];

        //add code here for when you hit delete
    }
}


- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        UITextField *componentName = [actionSheet textFieldAtIndex:0];
        NSManagedObjectContext *context = [[self appDelegate] managedObjectContext];
        Component *comp = (Component *)[NSEntityDescription insertNewObjectForEntityForName:@"Component" inManagedObjectContext:context];
        
        comp.name = componentName.text;
        comp.status = 0;
        [self.detailItem addComponentsObject:comp];
        
        
        NSError *error = nil;
        
        if (![context save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        self.data = [[self.detailItem.components allObjects] mutableCopy];
        [self.tableView reloadData];
    }
}


- (void)viewDidLoad
{
    self.addButton = [[UIBarButtonItem alloc]
                     initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                     target:self action: @selector(addButtonPressed:)];
    
    
    self.data = [[self.detailItem.components allObjects] mutableCopy];
    cellIdentifier = @"rowCell";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier: cellIdentifier];
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    Component *component = [self.data objectAtIndex: indexPath.row];
    cell.textLabel.text = component.name;

    CGRect positionFrame = CGRectMake(0, 0, cell.bounds.size.height - 35, cell.bounds.size.height -35);
    CircleView *drawBallView = [[CircleView alloc] initWithFrame:positionFrame];
    int number = [component.status intValue];

    if (number < 2) {
        drawBallView.colorPicked = [UIColor redColor];
    } else if (number < 4) {
        drawBallView.colorPicked = [UIColor orangeColor];
    } else if (number < 6) {
        drawBallView.colorPicked = [UIColor yellowColor];
    } else {
        drawBallView.colorPicked = [UIColor greenColor];
    }
    
    cell.accessoryView = drawBallView;
    
//    [self.contentView addSubview:drawBallView];
    
    

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */
- (AppDelegate *)appDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

@end
