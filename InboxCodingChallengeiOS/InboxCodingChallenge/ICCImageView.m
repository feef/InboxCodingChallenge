//
//  ICCImageView.m
//  InboxCodingChallenge
//
//  Created by sharif ahmed on 1/11/15.
//  Copyright (c) 2015 Feef. All rights reserved.
//

#import "ICCImageView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ICCImageSaver.h"
#import <CoreData/CoreData.h>
#import <NSManagedObjectContext+MagicalRecord.h>
#import <MagicalRecord/NSManagedObjectContext+MagicalSaves.h>
#import <MagicalRecord/NSManagedObjectContext+MagicalThreading.h>

@implementation ICCImageView

-(void)loadImageFromModel:(ICCImageModel*)imageModel {
    
    if(imageModel.imagePath) {
        
        //We already have the image written to disk, use it
        [self sd_cancelCurrentImageLoad];
        [self setImage:[[UIImage alloc] initWithData:[NSData dataWithContentsOfFile:[NSHomeDirectory() stringByAppendingPathComponent:imageModel.imagePath]]]];
        
    } else {
        
        //We don't yet have the image data, so download the image.
        //NOTE: SDWebImage has a cache implementation built in which I am leveraging to cut out work that I will, otherwise, implement in a way that is less efficient
        __weak ICCImageModel *wImageModel = imageModel;
        [self sd_setImageWithURL:[NSURL URLWithString:imageModel.urlString] placeholderImage:nil options:SDWebImageLowPriority | SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
            float progress = (float)receivedSize / (float)expectedSize;
            
            [self setBackgroundColor:[UIColor colorWithRed:progress/2 green:1 - progress blue:progress/3 alpha:1 - progress]];
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
           
            [self setBackgroundColor:[UIColor blackColor]];
            
            if(image) {
                
                ICCImageModel *sImageModel = wImageModel;
                if(!sImageModel)
                    return;
                
                //Needs to be a block variable so that the actual instance of the variable (and not a copy) is modified
                __block ICCImageModel *IM = imageModel;
                [ICCImageSaver saveImageToDisk:image withSuccessBlock:^(NSString *path) {
                    
                    IM.imagePath = path;
                    [[NSManagedObjectContext MR_contextForCurrentThread] MR_saveToPersistentStoreWithCompletion:nil];
                    
                }];
                                
            }
            
            
        }];
        
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
