//
//  ICCImageView.h
//  InboxCodingChallenge
//
//  Created by sharif ahmed on 1/11/15.
//  Copyright (c) 2015 Feef. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ICCImageModel.h"

@interface ICCImageView : UIImageView

-(void)loadImageFromModel:(ICCImageModel*)imageModel;

@end
