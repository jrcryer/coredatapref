//
//  PerformanceTest.h
//  CoreDataPerf
//
//  Created by James Cryer on 23/09/2011.
//  Copyright 2011 Home. All rights reserved.
//

#import <CoreData/CoreData.h>

@protocol PerformanceTest

- (NSString *)name;
- (NSString *)runWithContext:(NSManagedObjectContext *)context;

@end
