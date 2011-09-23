//
//  Studio.h
//  CoreDataPerf
//
//  Created by James Cryer on 23/09/2011.
//  Copyright 2011 Home. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Movie;

@interface Studio :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * rating;
@property (nonatomic, retain) NSSet* movies;

@end


@interface Studio (CoreDataGeneratedAccessors)
- (void)addMoviesObject:(Movie *)value;
- (void)removeMoviesObject:(Movie *)value;
- (void)addMovies:(NSSet *)value;
- (void)removeMovies:(NSSet *)value;

@end

