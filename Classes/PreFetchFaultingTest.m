//
//  PreFetchFaultingTest.m
//  CoreDataPerf
//
//  Created by James Cryer on 23/09/2011.
//  Copyright 2011 Home. All rights reserved.
//

#import "PreFetchFaultingTest.h"


@implementation PreFetchFaultingTest

- (NSString *)name {
	return @"Pre-fetch Faulting Test";	
}

- (NSString *)runWithContext:(NSManagedObjectContext *)context {
	
	NSString *result = @"Single Firing Fault Test Complete!";
	
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setEntity:[NSEntityDescription entityForName:@"Movie" inManagedObjectContext:context]];
	[request setRelationshipKeyPathsForPrefetching:[NSArray arrayWithObjects:@"actors", @"studios", nil]];
	
	NSArray *results = [context executeFetchRequest:request error:nil];
	
	[request release];
	
	for (NSManagedObject *movie in results) {
		[movie valueForKey:@"name"];
		
		for (NSManagedObject *actor in [movie valueForKey:@"actors"]) {
			[actor valueForKey:@"name"];
		}
		
		for (NSManagedObject *studio in [movie valueForKey:@"studios"]) {
			[studio valueForKey:@"name"];
		}
	}
	
	return result;
}

@end
