//
//  PredicatePerformance.m
//  CoreDataPerf
//
//  Created by James Cryer on 23/09/2011.
//  Copyright 2011 Home. All rights reserved.
//

#import "PredicatePerformance.h"


@implementation PredicatePerformance

- (NSString *)name {
	return @"Predicate Performance Test";
}

- (NSTimeInterval)runPredicate:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context {
	
	NSFetchRequest *request;
	NSDate *startDate = [NSDate date];
	
	for (int i = 0; i < 1000; i++) {
		[context reset];
		
		request = [[NSFetchRequest alloc] init];
		[request setEntity:[NSEntityDescription entityForName:@"Movie" inManagedObjectContext:context]];
		
		[request setPredicate:predicate];
		[context executeFetchRequest:request error:nil];
		[request release];
	}
	NSDate *endDate = [NSDate date];
	
	NSTimeInterval time = [endDate timeIntervalSinceDate:startDate];
	return time;
}


- (NSString *)runWithContext:(NSManagedObjectContext *)context {

	NSMutableString *result = [NSMutableString string];
	
	NSPredicate *slowPredicate = [NSPredicate predicateWithFormat:@"(name LIKE %@ ) OR (rating < %d)", @"*c*or*", 5];
	NSPredicate *fastPredicate = [NSPredicate predicateWithFormat:@"(rating < %d) OR (name LIKE %@ )", 5, @"*c*or*"];
	
	[result appendFormat:@"Slow predicate: %.2f s\n", [self runPredicate:slowPredicate inContext:context]];
	[result appendFormat:@"Fast predicate: %.2f s\n", [self runPredicate:fastPredicate inContext:context]];

	return result;
}


@end
