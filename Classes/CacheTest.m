//
//  CacheTest.m
//  CoreDataPerf
//
//  Created by James Cryer on 23/09/2011.
//  Copyright 2011 Home. All rights reserved.
//

#import "CacheTest.h"
#import "Actor.h"

@implementation CacheTest

- (NSString *)name {
	return @"Cache Test";
}

- (void)loadDataFromContext:(NSManagedObjectContext *)context {

	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setEntity:[NSEntityDescription entityForName:@"Movie" inManagedObjectContext:context]];
	
	NSArray *results = [context executeFetchRequest:request error:nil];
	[request release];
	
	for (NSManagedObject *movie in results) {
		NSSet *actors = [movie valueForKey:@"actors"];
		
		for (Actor *actor in actors) {
			[actor valueForKey:@"name"];
		}
	}
}

- (NSString *)runWithContext:(NSManagedObjectContext *)context {
	
	NSMutableString *result = [NSMutableString string];
	[context reset];
	
	NSDate *startTest1 = [NSDate date];
	[self loadDataFromContext:context];
	NSDate *endTest1   = [NSDate date];
	
	NSTimeInterval test1 = [endTest1 timeIntervalSinceDate:startTest1];
	[result appendFormat:@"Without cache: %.2f s\n", test1];
	
	NSDate *startTest2 = [NSDate date];
	[self loadDataFromContext:context];
	NSDate *endTest2   = [NSDate date];
	
	NSTimeInterval test2 = [endTest2 timeIntervalSinceDate:startTest2];
	[result appendFormat:@"Without cache: %.2f s\n", test2];
	
	return result;
}

@end
