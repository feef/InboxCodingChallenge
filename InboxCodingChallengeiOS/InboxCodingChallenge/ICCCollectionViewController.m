//
//  ICCCollectionViewController.m
//  InboxCodingChallenge
//
//  Created by sharif ahmed on 1/11/15.
//  Copyright (c) 2015 Feef. All rights reserved.
//

#import "ICCCollectionViewController.h"
#import "ICCCollectionViewCell.h"
#import "ICCAppDelegate.h"
#import <FlickrKit/FlickrKit.h>
#import <MagicalRecord/NSManagedObjectContext+MagicalSaves.h>
#import <MagicalRecord/NSManagedObjectContext+MagicalThreading.h>
#import <NSManagedObjectContext+MagicalRecord.h>
#import <NSManagedObject+MagicalFinders.h>
#import <MagicalRecord/NSManagedObject+MagicalRecord.h>
#import "ICCImageModel.h"
#import "ICCPhotoDetailViewer.h"

@interface ICCCollectionViewController () <NSFetchedResultsControllerDelegate>

@property(nonatomic)NSArray *flickrResults;
@property(nonatomic)ICCPhotoDetailViewer *photoDetailViewer;

@end

@implementation ICCCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ICCCollectionViewCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.flickrResults = [ICCImageModel MR_findAllSortedBy:@"index" ascending:YES];
    if(!(self.flickrResults && self.flickrResults.count > 0)) {
     
        //We don't already have results saved on the device, load them anew from Flickr
        __weak ICCCollectionViewController *wSelf = self;
        [[FlickrKit sharedFlickrKit] call:[[FKFlickrInterestingnessGetList alloc] init] completion:^(NSDictionary *response, NSError *error) {
            
            // Note this is not the main thread!
            if (response) {
                
                ICCCollectionViewController *sSelf = wSelf;
                if(sSelf) {
                    
                    NSMutableArray *imageModels = [NSMutableArray array];
                    int index = 0;
                    for (NSDictionary *photoData in [response valueForKeyPath:@"photos.photo"]) {
                        
                        [imageModels addObject:[self imageModelForFlickrDictionary:photoData atIndex:index]];
                        index++;
                        
                    }
                    
                    sSelf.flickrResults = imageModels;
                    [self saveContext];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [[sSelf collectionView] reloadData];
                        
                    });
                    
                }
                
            }   
        }];
        
    } else {
        
        //We had Flickr data on device, just reload to show them
        [[self collectionView] reloadData];
        
    }

}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.flickrResults.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if([cell isKindOfClass:[ICCCollectionViewCell class]]) {
        
        [(ICCCollectionViewCell*)cell populateWithImageModel:self.flickrResults[indexPath.row]];
        
    }
    
}

-(ICCImageModel*)imageModelForFlickrDictionary:(NSDictionary*)fDict atIndex:(int)index {
    
    NSString *urlString = [[[FlickrKit sharedFlickrKit] photoURLForSize:FKPhotoSizeMedium640 fromPhotoDictionary:fDict] absoluteString];
    ICCImageModel *imageModel = [ICCImageModel MR_findFirstByAttribute:@"urlString" withValue:urlString];
    if(!imageModel) {
        
        //We don't yet have an imageModel for this url, create one
        imageModel = [ICCImageModel MR_createEntity];
        imageModel.urlString = urlString;
        
    }
    imageModel.index = @(index);
    return imageModel;
    
}

-(void)saveContext {
    
    //Have to save context on current thread when working on a background thread! Otherwise the save fails.
    [[NSManagedObjectContext MR_contextForCurrentThread] MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
        
        if (success) {
            NSLog(@"You successfully saved your context.");
        } else if (error) {
            NSLog(@"Error saving context: %@", error.description);
        }
        
    }];
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell* cell = [collectionView cellForItemAtIndexPath:indexPath];
    if([cell isKindOfClass:[ICCCollectionViewCell class]] ) {
        
        //Selected one of our image cells
        UIImageView* iv = [(ICCCollectionViewCell*)cell imageView];
        if(iv.image) {
            
            //We have an image to expand already loaded! Go through with the expand animation
            [self.photoDetailViewer showFromImageView:iv inView:self.view];
            
        }
        
    }
    
}

-(ICCPhotoDetailViewer *)photoDetailViewer {
    
    if(!_photoDetailViewer) {
        
        _photoDetailViewer = [ICCPhotoDetailViewer new];
        
    }
    return _photoDetailViewer;
    
}

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
