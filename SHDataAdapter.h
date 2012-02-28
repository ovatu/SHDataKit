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

+ (id)dataAdapterWithEntityName:(NSString*)entityName inManagedObjectContext:(NSManagedObjectContext*)managedObjectContext;
- (id)initWithEntityName:(NSString*)entityName inManagedObjectContext:(NSManagedObjectContext*)managedObjectContext;

- (NSFetchRequest*)fetchRequest;

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

- (NSArray*)fetchAllWithRequest:(NSFetchRequest*)request;

- (id)fetchOneWithPredicate:(NSPredicate*)predicate sortDescriptors:(NSArray*)sortDescriptors;
- (id)fetchOneWithPredicate:(NSPredicate*)predicate sortDescriptor:(NSSortDescriptor*)sortDescriptor;
- (id)fetchOneWithPredicate:(NSPredicate*)predicate;

- (NSInteger)countWithPredicate:(NSPredicate*)predicate;
- (NSInteger)count;

- (NSInteger)countWithRequest:(NSFetchRequest*)request;

- (void)removeAllWithPredicate:(NSPredicate*)predicate;
- (void)removeAll;

- (void)removeAllWithRequest:(NSFetchRequest*)request;

@end
