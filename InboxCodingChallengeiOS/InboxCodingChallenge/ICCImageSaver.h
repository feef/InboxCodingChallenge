//  ImageSaver.h
//  Magical_Record
//  Copyright (c) 2013 Ray Wenderlich. All rights reserved.

//Blatantly copied from Wenderlich's example project ( http://www.raywenderlich.com/56879/magicalrecord-tutorial-ios ) and repurposed for my needs

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ICCImageModel.h"

@interface ICCImageSaver : NSObject

+ (BOOL)saveImageToDisk:(UIImage*)image withSuccessBlock:(void (^)(NSString *path))successBlock;

@end
