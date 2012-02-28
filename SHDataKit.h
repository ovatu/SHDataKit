//
//  SHDataKit.h
//  SHDataKit
//
//  Created by David Hole on 28/02/12.
//  Copyright (c) 2012 Shorthand. All rights reserved.
//

#import "NSManagedObjectContext+SHDataKitAdditions.h"
#import "SHManagedObject.h"
#import "SHDataAdapter.h"


//  [Usage]
// 
//  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
// 
//  NSManagedObjectContext *managedObjectContext = [NSManagedObjectContext managedObjectContextPreppedForMerge];
// 
//  SHDataAdapter *postAdapter = [Post dataAdapterWithManagedObjectContext:managedObjectContext];
// 
//  Post *post = [postAdapter insertWithValues:[NSDictionary dictionaryWithObjectsAndKeys:@"Post 1", @"post", nil]];
//  post.content = @"This is my first post";
// 
//  [managedObjectContext save:nil];
// 
//  [pool drain];
