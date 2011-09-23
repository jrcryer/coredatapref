//
//  SingleFiringFaultTest.m
//  CoreDataPerf
//
//  Created by James Cryer on 23/09/2011.
//  Copyright 2011 Home. All rights reserved.
//

#import "SingleFiringFaultTest.h"


@implementation SingleFiringFaultTest

- (NSString *)name {
	return @"Single Firing Fault Test";	
}

- (NSString *)runWithContext:(NSManagedObjectContext *)context {

	NSString *result = @"Single Firing Fault Test Complete!";
	
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setEntity:[NSEntityDescription entityForName:@"Movie" inManagedObjectContext:context]];
	NSArray *results = [context executeFetchRequest:request error:nil];
	
	[request release];
	
	for (NSManagedObject *movie in results) {
		[movie valueForKey:@"name"];
			
		for (NSManagedObject *actor in [movie valueForKey:@"actors"]) {
			[actor valueForKey:@"name"];
			
			[context refreshObject:actor mergeChanges:NO];
		}
		
		for (NSManagedObject *studio in [movie valueForKey:@"studios"]) {
			[studio valueForKey:@"name"];
			
			[context refreshObject:studio mergeChanges:NO];
		}
	}
	
	return result;
}

@end
