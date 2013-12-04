//
//  TaskDetailsController.h
//  App Tracker
//
//  Created by David Fioretti on 12/3/13.
//  Copyright (c) 2013 David Fioretti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Component.h"

@interface TaskDetailsController : UIViewController

@property (strong, nonatomic) UIBarButtonItem *addButton;
@property  (strong, nonatomic) Component *detailItem;
@property  (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property  (weak, nonatomic) IBOutlet UILabel *savedLabel;
@property  (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property  (weak, nonatomic) IBOutlet UISlider  *progressBar;
@property (strong, nonatomic)          NSArray *pickerArray;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;


@end
