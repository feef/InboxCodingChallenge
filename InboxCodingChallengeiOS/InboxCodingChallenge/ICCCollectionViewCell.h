//
//  ICCCollectionViewCell.h
//  InboxCodingChallenge
//
//  Created by sharif ahmed on 1/11/15.
//  Copyright (c) 2015 Feef. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ICCImageView.h"
#import "ICCImageModel.h"

@interface ICCCollectionViewCell : UICollectionViewCell

-(void)populateWithImageModel:(ICCImageModel*)imageModel;

@property(nonatomic,weak)IBOutlet ICCImageView *imageView;

@end
