//
//  SHDataAdapter.m
//  SHDataKit
//
//  Created by David Hole on 23/02/12.
//  Copyright (c) 2012 Shorthand. All rights reserved.
//

#import "SHDataAdapter.h"
#import "NSManagedObject+SHDataKitAdditions.h"

@implementation SHDataAdapter

+ (id)dataAdapterWithEntityName:(NSString*)entityName inManagedObjectContext:(NSManagedObjectContext*)managedObjectContext
{
    return [[[self class] alloc] initWithEntityName:entityName inManagedObjectContext:managedObjectContext];
}

- (id)initWithEntityName:(NSString *)entityName inManagedObjectContext:(NSManagedObjectContext*)managedObjectContext
{
    self = [super init];
    if (self) {
        _entityName = entityName;
        [_entityName retain];
        
        _managedObjectContext = managedObjectContext;
        [_managedObjectContext retain];
    }
    return self;
}

- (void)dealloc
{
    [_entityName release];
    [_managedObjectContext release];
}

- (NSString*)entityName
{
    return _entityName;
}

- (NSManagedObjectContext*)managedObjectContext
{
    return _managedObjectContext;
}

- (NSEntityDescription*)entityDescription
{
	return [NSEntityDescription entityForName:self.entityName inManagedObjectContext:self.managedObjectContext];   
}

- (NSFetchRequest*)fetchRequest
{
    NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease]; 
    [request setEntity:self.entityDescription];

	return request;   
}

- (id)insert
{
    // Insert the new object
    return [NSEntityDescription insertNewObjectForEntityForName:self.entityName inManagedObjectContext:self.managedObjectContext];
}

- (id)insertWithValues:(NSDictionary*)values
{
    // Insert the new object
    NSManagedObject *newObject = [self insert];

    // Set its values with the supplied dictionary
    [newObject setValuesForKeysWithDictionary:values];

    // Return the new object
    return newObject;
}

- (NSArray*)fetchAllWithPredicate:(NSPredicate*)predicate sortDescriptors:(NSArray*)sortDescriptors limit:(NSInteger)limit offset:(NSInteger)offset
{	
    // Initialise the request, set the entity
    NSFetchRequest *request = [self fetchRequest]; 
    
    // Set the predicate if not nil
    if (predicate != nil)
    {
        [request setPredicate:predicate];
    }
    
    // Set the sort descriptors if not nil
    if (sortDescriptors != nil)
    {
        [request setSortDescriptors:sortDescriptors];
    }
    
    // Set the fetch limit if it is greater than 0
    if (limit > 0)
    {
        [request setFetchLimit:limit];
    }
    
    // Set the fetch offset if it is greater than 0
    if (offset > 0)
    {
        [request setFetchOffset:offset];
    }
    
    // Grab return the results
	return [self fetchAllWithRequest:request];
}

- (NSArray*)fetchAllWithPredicate:(NSPredicate*)predicate sortDescriptors:(NSArray*)sortDescriptors limit:(NSInteger)limit
{
    return [self fetchAllWithPredicate:predicate sortDescriptors:sortDescriptors limit:0 offset:0];
}

- (NSArray*)fetchAllWithPredicate:(NSPredicate*)predicate sortDescriptors:(NSArray*)sortDescriptors {
    return [self fetchAllWithPredicate:predicate sortDescriptors:sortDescriptors limit:0];
}

- (NSArray*)fetchAllWithPredicate:(NSPredicate*)predicate sortDescriptor:(NSSortDescriptor*)sortDescriptor limit:(NSInteger)limit offset:(NSInteger)offset
{
    return [self fetchAllWithPredicate:predicate sortDescriptors:[NSArray arrayWithObject:sortDescriptor] limit:limit offset:offset];
}

- (NSArray*)fetchAllWithPredicate:(NSPredicate*)predicate sortDescriptor:(NSSortDescriptor*)sortDescriptor limit:(NSInteger)limit
{
    return [self fetchAllWithPredicate:predicate sortDescriptors:[NSArray arrayWithObject:sortDescriptor] limit:limit];
}

- (NSArray*)fetchAllWithPredicate:(NSPredicate*)predicate sortDescriptor:(NSSortDescriptor*)sortDescriptor
{
    return [self fetchAllWithPredicate:predicate sortDescriptors:[NSArray arrayWithObject:sortDescriptor] limit:0];
}

- (NSArray*)fetchAllWithPredicate:(NSPredicate*)predicate
{
    return [self fetchAllWithPredicate:predicate sortDescriptors:nil];
}

- (NSArray*)fetchAll
{
    // Grab everything (nil predicate)
    return [self fetchAllWithPredicate:nil];
}

- (NSArray*)fetchAllWithRequest:(NSFetchRequest*)request;
{
	return [self.managedObjectContext executeFetchRequest:request error:nil];
}

- (id)fetchOneWithPredicate:(NSPredicate*)predicate sortDescriptors:(NSArray*)sortDescriptors
{
    // Grab an array of entities limited to 1
    NSArray *returns = [self fetchAllWithPredicate:predicate sortDescriptors:sortDescriptors limit:1];
    
    // Return the object if the array is not empty
    if (returns && [returns count] > 0)
    {
        return [returns lastObject];
    }
    else
    {
        return nil;
    }
}

- (id)fetchOneWithPredicate:(NSPredicate*)predicate sortDescriptor:(NSSortDescriptor*)sortDescriptor
{
    return [self fetchOneWithPredicate:predicate sortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
}

- (id)fetchOneWithPredicate:(NSPredicate*)predicate
{
    return [self fetchOneWithPredicate:predicate sortDescriptors:nil];
}

- (NSInteger)countWithPredicate:(NSPredicate*)predicate
{
    // Initialise the request, set the entity.
    NSFetchRequest *request = [self fetchRequest]; 

    // Set the predicate if not nil
    if (predicate != nil)
    {
        [request setPredicate:predicate];
    }

    // Grab and return the results
	return [self countWithRequest:request];
}

- (NSInteger)count
{
    // Count everything (nil predicate)
    return [self countWithPredicate:nil];
}

- (NSInteger)countWithRequest:(NSFetchRequest *)request
{
	return [self.managedObjectContext countForFetchRequest:request error:nil];
}


- (void)removeAllWithPredicate:(NSPredicate*)predicate
{
    // Grab all objects for the entity
    NSArray *all = [self fetchAllWithPredicate:predicate];
    
    // Iteratively remove them all
    for (NSInteger i = 0; i<[all count]; i++)
    {
        NSManagedObject *object = [all objectAtIndex:i];
        
        [object deleteObject];
    }
}

- (void)removeAll
{
    // Remove all objects (nil predicate)
    [self removeAllWithPredicate:nil];
}

- (void)removeAllWithRequest:(NSFetchRequest *)request
{
    // Grab all objects for the entity
    NSArray *all = [self fetchAllWithRequest:request];
    
    // Iteratively remove them all
    for (NSInteger i = 0; i<[all count]; i++)
    {
        NSManagedObject *object = [all objectAtIndex:i];
        
        [object deleteObject];
    }
}

@end
