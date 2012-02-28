//
//  SHManagedObject.h
//  SHDataKit
//
//  Created by David Hole on 23/02/12.
//  Copyright (c) 2012 Shorthand. All rights reserved.
//

#import <CoreData/CoreData.h>

#import "SHDataAdapter.h"

@interface SHManagedObject : NSManagedObject

+ (NSString*)entityName;

+ (SHDataAdapter*)dataAdapter;
+ (SHDataAdapter*)dataAdapterWithManagedObjectContext:(NSManagedObjectContext*)managedObjectContext;

- (BOOL)saveObject:(NSError**)error;
- (BOOL)deleteObject:(BOOL)save error:(NSError**)error;
- (BOOL)deleteObject;

@end
