//
//  FetchAllMoviesActorsAndStudiosTest.m
//  CoreDataPerf
//
//  Created by James Cryer on 23/09/2011.
//  Copyright 2011 Home. All rights reserved.
//

#import "FetchAllMoviesActorsAndStudiosTest.h"


@implementation FetchAllMoviesActorsAndStudiosTest

- (NSString *)name {
	return @"Fetch all test";
}

- (NSString *)runWithContext:(NSManagedObjectContext *)context {
	
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setEntity:[NSEntityDescription entityForName:@"Movie" inManagedObjectContext:context]];
	
	NSArray *results = [context executeFetchRequest:request error:nil];
	int actorsRead   = 0;
	int studiosRead  = 0;
	
	for (NSManagedObject *movie in results) {
		actorsRead += [[movie valueForKey:@"actors"] count];
		studiosRead += [[movie valueForKey:@"studios"] count];
		
		[context refreshObject:movie mergeChanges:NO];
	}
	[request release];

	return [NSString stringWithFormat:@"Fetched %d actors and %d studios", actorsRead, studiosRead];
}

@end
