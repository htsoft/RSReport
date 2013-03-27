//
//  RSCoreDataDataSource.h
//  RSReport
//
//  Created by Roberto Scarciello on 26/03/13.
//  Copyright (c) 2013 Roberto Scarciello. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSDataSource.h"

@interface RSCoreDataDataSource : NSObject<RSDataSource> {
    NSFetchedResultsController *fetchedResultController;
    NSInteger currentRow;
    NSManagedObject *currentObject;
}

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSString *entityName;
@property (nonatomic, strong) NSString *sortCondition;
@property (nonatomic, strong) NSPredicate *predicate;

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)moc entity:(NSString *)entity sortCondition:(NSString *)sortCondition predicate:(NSPredicate *)predicate;

@end
