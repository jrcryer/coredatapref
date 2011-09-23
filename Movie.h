//
//  Movie.h
//  CoreDataPerf
//
//  Created by James Cryer on 23/09/2011.
//  Copyright 2011 Home. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Actor;

@interface Movie :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * rating;
@property (nonatomic, retain) NSSet* studios;
@property (nonatomic, retain) NSSet* actors;

@end


@interface Movie (CoreDataGeneratedAccessors)
- (void)addStudiosObject:(NSManagedObject *)value;
- (void)removeStudiosObject:(NSManagedObject *)value;
- (void)addStudios:(NSSet *)value;
- (void)removeStudios:(NSSet *)value;

- (void)addActorsObject:(Actor *)value;
- (void)removeActorsObject:(Actor *)value;
- (void)addActors:(NSSet *)value;
- (void)removeActors:(NSSet *)value;

@end

