//
//  NSManagedObjectContext+SHDataKitAdditions.m
//  SHDataKit
//
//  Created by David Hole on 28/02/12.
//  Copyright (c) 2012 Shorthand. All rights reserved.
//

#import "NSManagedObjectContext+SHDataKitAdditions.h"

@implementation NSManagedObjectContext (SHDataKitAdditions)

+ (NSManagedObjectContext*)sharedManagedObjectContextOnMainThread
{
    // Grab the app delegate
    id<UIApplicationDelegate> delegate = [[UIApplication sharedApplication] delegate];
    
    // If the delegate has a managedObjectContext property, return it, else nil
    if ([delegate respondsToSelector:@selector(managedObjectContext)])
    {        
        return [delegate performSelector:@selector(managedObjectContext)];
    }
    else
    {
        return nil;
    }
}

+ (NSPersistentStoreCoordinator*)sharedPersistentStoreCoordinatorOnMainThread
{
    // Grab the app delegate
    id<UIApplicationDelegate> delegate = [[UIApplication sharedApplication] delegate];
    
    // If the delegate has a persistentStoreCoordinator property, return it, else nil
    if ([delegate respondsToSelector:@selector(persistentStoreCoordinator)])
    {        
        return [delegate performSelector:@selector(persistentStoreCoordinator)];
    }
    else
    {
        return nil;
    }
}

+ (NSManagedObjectContext*)managedObjectContextPreppedForMerge
{
    // Grab the persistentStoreCoordinator on the main thread
    NSPersistentStoreCoordinator *coordinator = [[self class] sharedPersistentStoreCoordinatorOnMainThread];
    
    // Check for nil.
    if (coordinator)
    {
        // Create a new (autoreleased) managedObjectContext, set its persistentStoreCoordinator and set its undoManager to nil to improve performance
        NSManagedObjectContext *managedObjectContext = [[[NSManagedObjectContext alloc] init] autorelease];
        [managedObjectContext setPersistentStoreCoordinator:coordinator];
        [managedObjectContext setUndoManager:nil];
        
        // Add an observer to the new managedObjectContext to merge its changes back to the primary MOC when it is saved.
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter]; 
        [nc addObserver:[self class]
               selector:@selector(mergeChangesToManagedObjectContextOnMainThread:)
                   name:NSManagedObjectContextDidSaveNotification
                 object:managedObjectContext];
        
        return managedObjectContext;
    }
    else
    {
        return nil;
    }
}

+ (void)mergeChangesToManagedObjectContextOnMainThread:(NSNotification *)notification
{
    NSManagedObjectContext *mainContext = [[self class] sharedManagedObjectContextOnMainThread];
    
    // Merge changes into the main context on the main thread
    [mainContext performSelectorOnMainThread:@selector(mergeChangesFromContextDidSaveNotification:)
                                  withObject:notification
                               waitUntilDone:YES];
}

@end
