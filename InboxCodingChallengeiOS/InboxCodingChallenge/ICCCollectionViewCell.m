//
//  ICCCollectionViewCell.m
//  InboxCodingChallenge
//
//  Created by sharif ahmed on 1/11/15.
//  Copyright (c) 2015 Feef. All rights reserved.
//

#import "ICCCollectionViewCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation ICCCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    [self.imageView setClipsToBounds:YES];
    [self.imageView.layer setCornerRadius:10];
    
}

-(void)populateWithImageModel:(ICCImageModel*)imageModel {
    
    [self.imageView loadImageFromModel:imageModel];
    
}

@end
