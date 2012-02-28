# SHDataKit

This is a suite of Objective-C classes and categories for Core Data that
offers a different and we thing much simpler paradigm for [Core Data][1] programming
for Mac OS X and iPhone OS. It was developed for the [Shorthand iOS app][2].

## Using `SHDataKit`

Add the files to your Xcode project:

	SHDataKit.h
	NSManagedObjectContext+SHDataKitAdditions.h
	NSManagedObjectContext+SHDataKitAdditions.m
	SHDataAdapter.h
	SHDataAdapter.m
	SHManagedObject+SHDataKitAdditions.h
	SHManagedObject+SHDataKitAdditions.m	

##Import the header where you need to access Core Data:##

	#import "SHDataKit.h"

##Create a DataAdapter from the Post Model:##

	SHDataAdapter *postAdapter = [Post dataAdapter];

##Inert a new post object##

	Post *post = [postAdapter insert];
	post.subject = @"Post 1";
	post.content = @"This is my first post";

	NSError *error;
	if (![post saveObject:error])
	{
		// Show error
	}

##Fetch all Post Objects##

	NSArray *posts = [postAdapter fetchAll];

##Fetch select Post Objects and sort them##

	NSArray *posts = [postAdapter fetchAllWithPredicate:[NSPredicate predicateWithFormat:@"enabled = 1"]
								              sortDescriptor:[NSSortDescriptor sortDescriptorWithKey:@"order" ascending:YES]];

##Get the count for the Post entity##

	NSInteger postCount = [postAdapter count];
	
##Using SHKit in a background thread##

	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

	NSManagedObjectContext *managedObjectContext = [NSManagedObjectContext managedObjectContextPreppedForMerge];
	
	SHDataAdapter *postAdapter = [Post dataAdapterWithManagedObjectContext:managedObjectContext];
	
	Post *post = [postAdapter insertWithValues:[NSDictionary dictionaryWithObjectsAndKeys:@"Post 1", @"post", nil]];
	post.content = @"This is my first post";
	
	[managedObjectContext save:nil];
	
	[pool drain];

	
[1]: http://developer.apple.com/mac/library/DOCUMENTATION/Cocoa/Conceptual/CoreData/index.html "Core Data"
[2]: http://shorthandapp.com/ "Shorthand"