//
//  RSCoreDataDataSource.m
//  RSReport
//
//  Created by Roberto Scarciello on 26/03/13.
//  Copyright (c) 2013 Roberto Scarciello. All rights reserved.
//

#import "RSCoreDataDataSource.h"

@implementation RSCoreDataDataSource

@synthesize managedObjectContext = _managedObjectContext;
@synthesize entityName = _entityName;
@synthesize sortCondition = _sortCondition;
@synthesize predicate = _predicate;

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)moc entity:(NSString *)entity sortCondition:(NSString *)sortCondition predicate:(NSPredicate *)predicate
{
    self = [super init];
    if(self) {
        self.managedObjectContext = moc;
        self.entityName = entity;
        self.sortCondition = sortCondition;
        self.predicate = predicate;
    }
    return self;
}

- (BOOL)openStream
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:self.entityName inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    // Configure the request's entity, and optionally its predicate.
    if (self.predicate)
        [fetchRequest setPredicate:self.predicate];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:self.sortCondition ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    fetchedResultController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    NSError *error;
    BOOL success = [fetchedResultController performFetch:&error];
    currentRow = 0;
    currentObject = nil;
    return success;
}

- (void)closeStream
{
    // With ARC nothing has to be released
}

- (NSInteger)numberOfSections
{
    return [[fetchedResultController sections] count];
}

- (NSInteger)numberOfObjectsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedResultController sections] objectAtIndex:section];
    NSInteger rows = [sectionInfo numberOfObjects];
    return rows;
}

- (BOOL)firstItemInSection:(NSInteger)section
{
    currentRow = 0;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:currentRow inSection:section];
    currentObject = [fetchedResultController objectAtIndexPath:indexPath];
    if(currentObject)
        return YES;
    else
        return NO;
}

- (BOOL)hasNextInSection:(NSInteger)section
{
    ++currentRow;
    id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedResultController sections] objectAtIndex:section];
    NSInteger rows = [sectionInfo numberOfObjects];
    if(currentRow<rows) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:currentRow inSection:section];
        currentObject = [fetchedResultController objectAtIndexPath:indexPath];
        return YES;
    } else {
        currentObject = nil;
        return NO;
    }
}

- (id)getAttributeByPath:(NSString *)name
{
    return [currentObject valueForKeyPath:name];
}

@end
