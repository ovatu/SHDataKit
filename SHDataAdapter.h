//
//  SHDataAdapter.h
//  SHDataKit
//
//  Created by David Hole on 23/02/12.
//  Copyright (c) 2012 Shorthand. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHDataAdapter : NSObject {
    NSString *_entityName;
    NSManagedObjectContext *_managedObjectContext;
}

@property (readonly, getter = entityName) NSString *entityName;
@property (readonly, getter = managedObjectContext) NSManagedObjectContext *managedObjectContext;
@property (readonly, getter = entityDescription) NSEntityDescription *entityDescription;

- (id)initWithEntityName:(NSString*)entityName managedObjectContext:(NSManagedObjectContext*)managedObjectContext;

- (id)insert;
- (id)insertWithValues:(NSDictionary*)values;

- (NSArray*)fetchAllWithPredicate:(NSPredicate*)predicate sortDescriptors:(NSArray*)sortDescriptors limit:(NSInteger)limit offset:(NSInteger)offset;
- (NSArray*)fetchAllWithPredicate:(NSPredicate*)predicate sortDescriptors:(NSArray*)sortDescriptors limit:(NSInteger)limit;
- (NSArray*)fetchAllWithPredicate:(NSPredicate*)predicate sortDescriptors:(NSArray*)sortDescriptors;
- (NSArray*)fetchAllWithPredicate:(NSPredicate*)predicate sortDescriptor:(NSSortDescriptor*)sortDescriptor limit:(NSInteger)limit offset:(NSInteger)offset;
- (NSArray*)fetchAllWithPredicate:(NSPredicate*)predicate sortDescriptor:(NSSortDescriptor*)sortDescriptor limit:(NSInteger)limit;
- (NSArray*)fetchAllWithPredicate:(NSPredicate*)predicate sortDescriptor:(NSSortDescriptor*)sortDescriptor;
- (NSArray*)fetchAllWithPredicate:(NSPredicate*)predicate;
- (NSArray*)fetchAll;

- (id)fetchOneWithPredicate:(NSPredicate*)predicate sortDescriptors:(NSArray*)sortDescriptors;
- (id)fetchOneWithPredicate:(NSPredicate*)predicate sortDescriptor:(NSSortDescriptor*)sortDescriptor;
- (id)fetchOneWithPredicate:(NSPredicate*)predicate;

- (NSInteger)countWithPredicate:(NSPredicate*)predicate;
- (NSInteger)count;

- (void)removeAllWithPredicate:(NSPredicate*)predicate;
- (void)removeAll;

@end
