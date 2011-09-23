//
//  UniquingTest.m
//  CoreDataPerf
//
//  Created by James Cryer on 23/09/2011.
//  Copyright 2011 Home. All rights reserved.
//

#import "UniquingTest.h"


@implementation UniquingTest

- (NSString *)name {
	return @"Uniquing Test";
}

- (NSString *)runWithContext:(NSManagedObjectContext *)context {

	NSString *result = @"Uniquing Test Passed";
	
	NSMutableArray *referenceActors = nil;
	
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey: @"name" ascending:YES];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	[sortDescriptor release];
	
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setEntity:[NSEntityDescription entityForName:@"Movie" inManagedObjectContext:context]];
	
	NSArray *results = [context executeFetchRequest:request error:nil];
	[request release];
	
	for (NSManagedObject *movie in results) {
		NSSet *actors = [movie mutableSetValueForKey:@"actors"];
		NSArray *sortedActors = [actors sortedArrayUsingDescriptors:sortDescriptors];
		
		if (referenceActors == nil) {
			referenceActors = [[NSArray alloc] initWithArray:sortedActors];
		}
		else {
			for (int i = 0, n = [sortedActors count]; i < n; i++) {
				if ([sortedActors objectAtIndex:i] != [referenceActors objectAtIndex:i]) {
					result = [NSString stringWithFormat:@"Uniquing test failed; %@ != %@", [sortedActors objectAtIndex:i], [referenceActors objectAtIndex:i]];
					break;
				}
			}
		}
	}
	[referenceActors release];
	[sortDescriptors release];
	return result;
}

@end
