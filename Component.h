//
//  Component.h
//  App Tracker
//
//  Created by David Fioretti on 12/3/13.
//  Copyright (c) 2013 David Fioretti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class App, Todo;

@interface Component : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * status;
@property (nonatomic, retain) NSNumber *progress;
@property (nonatomic, retain) NSString *notes;
@property (nonatomic, retain) App *app;
@property (nonatomic, retain) NSSet *todos;
@end

@interface Component (CoreDataGeneratedAccessors)

- (void)addTodosObject:(Todo *)value;
- (void)removeTodosObject:(Todo *)value;
- (void)addTodos:(NSSet *)values;
- (void)removeTodos:(NSSet *)values;

@end
