//
//  NSManagedObjectContext+SHDataKitAdditions.h
//  SHDataKit
//
//  Created by David Hole on 28/02/12.
//  Copyright (c) 2012 Shorthand. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObjectContext (SHDataKitAdditions)

+ (NSManagedObjectContext*)sharedManagedObjectContextOnMainThread;
+ (NSPersistentStoreCoordinator*)sharedPersistentStoreCoordinatorOnMainThread;

+ (NSManagedObjectContext*)managedObjectContextPreppedForMerge;

@end
