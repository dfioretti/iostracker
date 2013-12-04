//
//  StatusViewController.m
//  App Tracker
//
//  Created by David Fioretti on 12/3/13.
//  Copyright (c) 2013 David Fioretti. All rights reserved.
//

#import "StatusViewController.h"
#import "Component.h"
#import "Todo.h"

@interface StatusViewController ()
- (void)configureView;
@end

@implementation StatusViewController

- (void)setDetailItem:(App *)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
    }
    [self configureView];
}

-(void)configureView {
    if (self.detailItem) {
        self.data = [[self.detailItem.components allObjects] mutableCopy];
    }
    [self.tableView reloadData];
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    // If you're serving data from an array, return the length of the array:
    return [self.data count];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
    //return [indexPath row] * 20;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //static NSString *CellIdentifier = @"Cell";
    
    UIColor *ios7BlueColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
    Component *comp = [self.data objectAtIndex:indexPath.row];

    UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(10, 10, tableView.frame.size.width, 30)];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UIColor *myColor = [UIColor colorWithRed: 244.0/255.0 green: 244.0/255.0 blue:244.0/255.0 alpha: 0.6];
    cell.backgroundColor = myColor;
    
    UILabel *statusIndicator = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, 30)];
    statusIndicator.alpha = 0.5;
    statusIndicator.textColor = [UIColor whiteColor];
    statusIndicator.font = [UIFont fontWithName:@"Helvetica-Bold" size:20.0];
    statusIndicator.textAlignment = NSTextAlignmentCenter;
    statusIndicator.text = comp.name;
    
    int status = [comp.status integerValue];
    if (status < 2) {
        statusIndicator.backgroundColor = [UIColor redColor];
        //statusIndicator.text = @"Important";
    } else if (status < 4) {
        //statusIndicator.text = @"Started";
        statusIndicator.backgroundColor = [UIColor orangeColor];
    } else if (status < 6) {
        //statusIndicator.text = @"In Progress";
        statusIndicator.backgroundColor = [UIColor yellowColor];
    } else {
        //statusIndicator.text = @"Complete";
        statusIndicator.backgroundColor = [UIColor greenColor];
    }
    
    [cell addSubview:statusIndicator];
    
    UILabel *task = [[UILabel alloc] init];
    task.text = @"Task Count";
    task.font = [UIFont fontWithName:@"Helvetica" size:16.0];
    task.textColor = ios7BlueColor;
    [task sizeToFit];
    CGRect frame = task.frame;
    frame.origin = CGPointMake(10, 45);
    task.frame = frame;
    [cell addSubview:task];
    
    UILabel *taskNumber = [[UILabel alloc] init];
    taskNumber.text = [NSString stringWithFormat:@"%d", comp.todos.count];
    taskNumber.font = [UIFont fontWithName:@"Helvetica-Bold" size:20.0];
    taskNumber.textColor = [UIColor redColor];
    taskNumber.alpha = 0.5;
    [taskNumber sizeToFit];
    frame = taskNumber.frame;
    frame.origin = CGPointMake(180, 42);
    taskNumber.frame = frame;
    
    [cell addSubview:taskNumber];
    
    UILabel *progressLabel = [[UILabel alloc] init];
    progressLabel.text = @"Current Progress";
    progressLabel.font = [UIFont fontWithName:@"Helvetica" size:16.0];
    progressLabel.textColor = ios7BlueColor;
    [progressLabel sizeToFit];
    frame = progressLabel.frame;
    frame.origin = CGPointMake(10, 80);
    progressLabel.frame = frame;
    
    [cell addSubview:progressLabel];
    
    UILabel *progressCount = [[UILabel alloc] init];
    int prog = [comp.progress integerValue];
    progressCount.text = [NSString stringWithFormat:@"%d%@", prog, @"%"];
    progressCount.textColor = [UIColor redColor];
    progressCount.alpha = 0.5;
    progressCount.font = [UIFont fontWithName:@"Helvetica-Bold" size:20.0];
    [progressCount sizeToFit];
    frame = progressCount.frame;
    frame.origin = CGPointMake(180, 77);
    progressCount.frame = frame;
    
    [cell addSubview:progressCount];
    
    UILabel *notesLabel = [[UILabel alloc] init];
    notesLabel.text = @"Notes Length";
    notesLabel.font = [UIFont fontWithName:@"Helvetica" size:16.0];
    notesLabel.textColor = ios7BlueColor;
    [notesLabel sizeToFit];
    frame = notesLabel.frame;
    frame.origin = CGPointMake(10, 115);
    notesLabel.frame = frame;
    
    [cell addSubview:notesLabel];
    
    UILabel *notesCount = [[UILabel alloc] init];
    notesCount.text = [NSString stringWithFormat:@"%d", comp.notes.length];
    notesCount.textColor = [UIColor redColor];
    notesCount.alpha = 0.5;
    notesCount.font = [UIFont fontWithName:@"Helvetica-Bold" size:20.0];
    [notesCount sizeToFit];
    frame = notesCount.frame;
    frame.origin = CGPointMake(180, 111);
    notesCount.frame = frame;
    
    [cell addSubview:notesCount];
    
    

    
    /*
    UILabel *label = [[UILabel alloc] init];
    label.text = comp.name;
    label.textColor = ios7BlueColor;
    [label sizeToFit];
    CGRect frame = label.frame;
    frame.origin = CGPointMake(10, 10);
    label.frame = frame;
    
    [cell addSubview:label];
    
    UILabel *todoCount = [[UILabel alloc] init];
    todoCount.text = [NSString stringWithFormat:@"Task Count: - %d", comp.todos.count];
    todoCount.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    [todoCount sizeToFit];
    frame = todoCount.frame;
    frame.origin = CGPointMake(label.frame.origin.x, label.bounds.size.height + 15);
    todoCount.frame = frame;
    [cell addSubview:todoCount];
    
    /*
    UILabel *statusLabel = [[UILabel alloc] init];
    statusLabel.text = ;
    [deadLineLabel sizeToFit];
    frame = deadLineLabel.frame;
    frame.origin = CGPointMake(todoCount.frame.origin.x, todoCount.bounds.size.height + 35);
    deadLineLabel.frame = frame;
    [cell addSubview:deadLineLabel];
     */
    
    
  /*
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set the data for this cell:
    
    cell.textLabel.text = [dataArray objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = @"More text";
    cell.imageView.image = [UIImage imageNamed:@"flower.png"];
    
    // set the accessory view:
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    */
    
    return cell;
}




- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
