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
SHManagedObject.h
SHManagedObject.m	

1. Import the header in any implementation file where you need to access Core Data:

	#import "SHDataKit.h"

2. Create a DataAdapter from the Post Model:

	SHDataAdapter *postAdapter = [Post dataAdapter];

3. Inert a new post object

	Post *post = [postAdapter insert];
	post.subject = @"Post 1";
	post.content = @"This is my first post";

	NSError *error;
	if (![post saveObject:error])
	{
		// Show error
	}

4. Fetch all Post Objects

	NSArray *posts = [postAdapter fetchAll];

5. Fetch select Post Objects and sort them

	NSArray *posts = [postAdapter fetchAllWithPredicate:[NSPredicate predicateWithFormat:@"enabled = 1"]
									sortDescriptor:[NSSortDescriptor sortDescriptorWithKey:@"order" ascending:YES]];

6. Get the count for the Post entity

	NSInteger postCount = [postAdapter count];