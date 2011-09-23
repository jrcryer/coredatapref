// 
//  Actor.m
//  CoreDataPerf
//
//  Created by James Cryer on 23/09/2011.
//  Copyright 2011 Home. All rights reserved.
//

#import "Actor.h"


@implementation Actor 

@dynamic name;
@dynamic rating;
@dynamic movies;

- (void)willTurnIntoFault {
	NSLog(@"Actor named %@ will turn into fault", self.name);
}

- (void)didTurnIntoFault {
	NSLog(@"Actor named %@ did turn into fault", self.name);	
}

@end
