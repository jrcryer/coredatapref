//
//  Actor.h
//  CoreDataPerf
//
//  Created by James Cryer on 23/09/2011.
//  Copyright 2011 Home. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface Actor :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * rating;
@property (nonatomic, retain) NSSet* movies;

@end


@interface Actor (CoreDataGeneratedAccessors)
- (void)addMoviesObject:(NSManagedObject *)value;
- (void)removeMoviesObject:(NSManagedObject *)value;
- (void)addMovies:(NSSet *)value;
- (void)removeMovies:(NSSet *)value;

@end

