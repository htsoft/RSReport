//
//  RSBodySection.m
//  RSReport
//
//  Created by Roberto Scarciello on 16/08/11.
//  Copyright 2011 Roberto Scarciello. All rights reserved.
//

#import "RSBodySection.h"
#import "RSGenericItem.h"

@implementation RSBodySection

@synthesize entityName = _entityName;
@synthesize sortKey = _sortKey;

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

- (void)printSectionWithContext:(CGContextRef)context {
    // Save the original frame
    CGRect originalFrame = self.frame;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSManagedObjectContext *managedObjectContext = [self.delegate getManagedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:_entityName inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];    
    // Configure the request's entity, and optionally its predicate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:_sortKey ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    [sortDescriptors release];
    [sortDescriptor release];
    
    NSFetchedResultsController *fetchedController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    [fetchRequest release];
    
    NSError *error;
    BOOL success = [fetchedController performFetch:&error];
    
    if (success) {
        NSInteger sections = [[fetchedController sections] count];
        for(NSInteger currentSection=0;currentSection<sections;currentSection++) {
            id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedController sections] objectAtIndex:currentSection];
            NSInteger rows = [sectionInfo numberOfObjects];
            for (NSInteger currentRow = 0; currentRow < rows; ++currentRow) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:currentRow inSection:currentSection];
                NSManagedObject *currentManagedObject = [fetchedController objectAtIndexPath:indexPath];
                self.managedObject = currentManagedObject;
                // Checks for frame position and eventually update it, drawing PageHeader and PageFooter
                if(![self.delegate checkforFrame:self.frame])
                    self.frame = originalFrame;
                [super printSectionWithContext:context];
                self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y + self.frame.size.height, self.frame.size.width, self.frame.size.height);
            }
        }
        
    }
}


@end
