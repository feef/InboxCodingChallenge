//
//  ICCCollectionViewFlowLayout.m
//  InboxCodingChallenge
//
//  Created by sharif ahmed on 1/11/15.
//  Copyright (c) 2015 Feef. All rights reserved.
//

#define BOUNDARY 10

#import "ICCCollectionViewFlowLayout.h"

@implementation ICCCollectionViewFlowLayout

-(instancetype)init {
    
    self = [super init];
    if(self) {
        
        [self setup];
        
    }
    return self;
    
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    if(self) {
        
        [self setup];
        
    }
    return self;
    
}

-(void)setup {
    
    self.minimumInteritemSpacing = BOUNDARY;
    self.minimumLineSpacing = BOUNDARY;
    self.sectionInset = UIEdgeInsetsMake(BOUNDARY + 20, 0, BOUNDARY, 0);
    float side = CGRectInset([[[[UIApplication sharedApplication] delegate] window] frame], BOUNDARY, BOUNDARY).size.width;
    self.itemSize = CGSizeMake(side, side);
    
}

@end
