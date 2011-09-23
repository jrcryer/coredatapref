//
//  SubqueryTest.m
//  CoreDataPerf
//
//  Created by James Cryer on 23/09/2011.
//  Copyright 2011 Home. All rights reserved.
//

#import "SubqueryTest.h"


@implementation SubqueryTest

- (NSString *)name {
	return @"Subquery performance test";
}

- (NSString *)runWithContext:(NSManagedObjectContext *)context {

	NSMutableString *result = [NSMutableString string];
	
	NSFetchRequest *request;
	
	int count = 0;
	
	[context reset];
	NSDate *startTest1 = [NSDate date];
	NSMutableDictionary *actorsMap = [NSMutableDictionary dictionary];
	request = [[NSFetchRequest alloc] init];
	[request setEntity:[NSEntityDescription entityForName:@"Movie" inManagedObjectContext:context]];
	
	[request setPredicate:[NSPredicate predicateWithFormat:@"(rating < %d) OR (name LIKE %@)", 5, @"*c*or*"]];
	
	NSArray *movies = [context executeFetchRequest:request error:nil];
	
	for (NSManagedObject *movie in movies) {
		NSSet *actorSet = [movie valueForKey:@"actors"];
		
		for (NSManagedObject *actor in actorSet) {
			[actorsMap setValue:actor forKey:[[[actor objectID] URIRepresentation] description]];
		}
	}
	
	count = [actorsMap count];
	
	[request release];
	NSDate *endTest1 = [NSDate date];
	
	NSTimeInterval test1 = [endTest1 timeIntervalSinceDate:startTest1];
	[result appendFormat:@"No subquery: %.2f s\n", test1];
	[result appendFormat:@"Actors retrieved: %d\n", count];
	
	[context reset];
	NSDate *startTest2 = [NSDate date];
	request = [[NSFetchRequest alloc] init];
	[request setEntity:[NSEntityDescription entityForName:@"Actor" inManagedObjectContext:context]];
	
	[request setPredicate:[NSPredicate predicateWithFormat:@"(SUBQUERY(movies, $x, ($x.rating < %d) OR ($x.name LIKE %@)).@count > 0)", 5, @"*c*or*"]];
	
	NSArray *actors = [context executeFetchRequest:request error:nil];
	count = [actors count];
	
	[request release];
	NSDate *endTest2 = [NSDate date];
	
	NSTimeInterval test2 = [endTest2 timeIntervalSinceDate:startTest2];
	[result appendFormat:@"Subquery: %.2f s\n", test2];
	[result appendFormat:@"Actors retrieved: %d\n", count];
	
	return result;
}

@end
