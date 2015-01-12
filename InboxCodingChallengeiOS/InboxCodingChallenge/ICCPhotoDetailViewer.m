//
//  ICCPhotoDetailViewer.m
//  InboxCodingChallenge
//
//  Created by sharif ahmed on 1/11/15.
//  Copyright (c) 2015 Feef. All rights reserved.
//

#import "ICCPhotoDetailViewer.h"

@interface ICCPhotoDetailViewer ()

@property(nonatomic)UIImageView *detailImageView;
@property(nonatomic)CGRect startRect;
@property(nonatomic)float offset;

@end

@implementation ICCPhotoDetailViewer

-(instancetype)init {
    
    self = [super initWithFrame:[[[UIApplication sharedApplication] delegate] window].frame];
    if(self) {
        
        _detailImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        
        //Add a gesture recognizer to recognize a "tap" which will close out this view
        UITapGestureRecognizer* tgr = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector( onTap: )];
        _detailImageView.userInteractionEnabled = YES;
        _detailImageView.clipsToBounds = NO;
        [_detailImageView addGestureRecognizer: tgr];
        [self addSubview:_detailImageView];
        
    }
    return self;
    
}

-(void)showFromImageView:(UIImageView*)imageView inView:(UIView*)view {
    
    self.detailImageView.image = imageView.image;
    self.detailImageView.contentMode = imageView.contentMode;
    _startRect = [view convertRect: imageView.frame fromView: imageView.superview];
    self.frame = _startRect;
    self.detailImageView.frame = CGRectMake(0, 0, _startRect.size.width, _startRect.size.height);
    
    CGSize finalSize = imageView.image.size;
    self.contentSize = finalSize;
    
    [self setBackgroundColor:[UIColor clearColor]];
    
    CGRect bounds = view.bounds;
    self.offset = (self.contentSize.width - bounds.size.width)/2;
    
    //compute origin of imageview and offset so that the image stays centered
    CGPoint origin = CGPointMake(MAX(0,(bounds.size.width - finalSize.width)/2), MAX(0,(bounds.size.height - finalSize.height)/2));
    CGPoint offset = CGPointMake(MAX(0,(finalSize.width - bounds.size.width)/2), MAX(0,(finalSize.height - bounds.size.height)/2));
    
    [UIView transitionWithView: view
                      duration: 0.4
                       options: UIViewAnimationOptionAllowAnimatedContent
                    animations:^{
                        
                        [self setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0]];
                        [view addSubview: self];
                        self.frame = bounds;
                        [self.detailImageView setFrame:CGRectMake(origin.x, origin.y, finalSize.width, finalSize.height)];
                        [self setContentOffset:offset];
                        
                    } completion:nil];

    
}

- (void) onTap: (UITapGestureRecognizer*) tgr
{
    [UIView animateWithDuration: 0.4
                     animations:^{
                         
                         //Restore to original values to appear to shrink the image back to its starting position
                         [_detailImageView setFrame:CGRectMake(0, 0, _startRect.size.width, _startRect.size.height)];
                         self.frame = _startRect;
                         [self setContentSize:_startRect.size];
                         
                     } completion:^(BOOL finished) {
                         
                         [self removeFromSuperview];
                     }];
}

@end
