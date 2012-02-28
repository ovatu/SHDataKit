//
//  SHManagedObject+SHDataKitAdditions.m
//  SHDataKit
//
//  Created by David Hole on 23/02/12.
//  Copyright (c) 2012 Shorthand. All rights reserved.
//

#import "NSManagedObject+SHDataKitAdditions.h"
#import "NSManagedObjectContext+SHDataKitAdditions.h"

@implementation NSManagedObject (SHDataKitAdditions)

+ (NSString*)entityName
{
    // Returns the class name by default, override if different.
    return NSStringFromClass(self);
}

+ (SHDataAdapter*)dataAdapter
{
    // Obtain the shared managedObjectContext from the main thread (app delegate)
    NSManagedObjectContext *managedObjectContext = [NSManagedObjectContext sharedManagedObjectContextOnMainThread];
    
    // If it exists, return a new data adapter for the MOC
    if (managedObjectContext)
    {        
        return [[self class] dataAdapterWithManagedObjectContext:managedObjectContext];
    }
    else
    {
        return nil;
    }
}

+ (SHDataAdapter*)dataAdapterWithManagedObjectContext:(NSManagedObjectContext*)managedObjectContext
{
    // Return a new (autoreleased) data adapter for the supplied managedObjectContext and using the classes entity name.
    return [[[SHDataAdapter alloc] initWithEntityName:[[self class] entityName] managedObjectContext:managedObjectContext] autorelease];
}

- (BOOL)saveObject:(NSError**)error
{
    // Save the MOC
    return [[self managedObjectContext] save:error];
}

- (BOOL)deleteObject:(BOOL)save error:(NSError**)error
{
    // Delete the object from the MOC
    [self.managedObjectContext deleteObject:self];
    
    // Save the MOC if requested
    if (save)
    {
        return [self.managedObjectContext save:error];
    }
    else
    {
        return YES;
    }
}

- (BOOL)deleteObject
{
    return [self deleteObject:NO error:nil];
}

@end
