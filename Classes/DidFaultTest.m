//
//  DidFaultTest.m
//  CoreDataPerf
//
//  Created by James Cryer on 23/09/2011.
//  Copyright 2011 Home. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "DidFaultTest.h"
#import "Actor.h"

@implementation DidFaultTest

- (NSString *)name {
	return @"Did Turn Into Fault Test";	
}

- (NSString *)runWithContext:(NSManagedObjectContext *)context {

	NSString *result = nil;
	
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setEntity:[NSEntityDescription entityForName:@"Movie" inManagedObjectContext:context]];
	[request setPredicate:[NSPredicate predicateWithFormat:@"name = %@", @"Movie 1"]];
	
	NSArray *results = [context executeFetchRequest:request error:nil];
	[request release];	
	
	if ([results lastObject]) {
		NSManagedObject *movie = (NSManagedObject *)[results objectAtIndex:0];
		NSSet *actors = [movie valueForKey:@"actors"];
		
		if ([actors count] != 200) {
			result = @"Failed to find the 200 actors for the first movie";
		}
		else {
			Actor *actor = (Actor *)[actors anyObject];
			
			result = [actor isFault] ? @"Actor is a fault\n" : @"Actor is NOT a fault\n";
			result = [result stringByAppendingFormat:@"Actor is name %@\n", actor.name];
			result = [result stringByAppendingFormat:@"Actor is rated %@\n", actor.rating];
			
			result = [result stringByAppendingString:[actor isFault] ? @"Actor is a fault\n" : @"Actor is NOT a fault\n"];
			result = [result stringByAppendingString:@"Turning actor back into a fault\n"];
			[context refreshObject:actor mergeChanges:NO];
			
			result = [result stringByAppendingString:[actor isFault] ? @"Actor is a fault\n" : @"Actor is NOT a fault\n"];			
		}

	}else {
		result = @"Failed to fetch the first movie";
	}
	return result;
}


@end
