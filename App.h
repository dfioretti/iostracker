//
//  App.h
//  App Tracker
//
//  Created by David Fioretti on 12/3/13.
//  Copyright (c) 2013 David Fioretti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Component;

@interface App : NSManagedObject

@property (nonatomic, retain) NSString * deadline;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * website;

@property (nonatomic, retain) NSString * iemail;
@property (nonatomic, retain) NSString * iphone;
@property (nonatomic, retain) NSString * idate;
@property (nonatomic, retain) NSString * itime;
@property (nonatomic, retain) NSString * interviewer;
@property (nonatomic, retain) NSString * iaddress1;
@property (nonatomic, retain) NSString * iaddress2;


@property (nonatomic, retain) NSSet *components;
@end

@interface App (CoreDataGeneratedAccessors)

- (void)addComponentsObject:(Component *)value;
- (void)removeComponentsObject:(Component *)value;
- (void)addComponents:(NSSet *)values;
- (void)removeComponents:(NSSet *)values;

@end
