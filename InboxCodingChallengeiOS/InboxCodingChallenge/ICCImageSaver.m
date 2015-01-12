//  ImageSaver.m
//  Magical_Record
//  Copyright (c) 2013 Ray Wenderlich. All rights reserved.

#import "ICCImageSaver.h"
#import "ICCImageModel.h"
#import "ICCAppDelegate.h"

@implementation ICCImageSaver

+ (BOOL)saveImageToDisk:(UIImage*)image withSuccessBlock:(void (^)(NSString *path))successBlock {

	NSData *imgData = UIImageJPEGRepresentation(image, 0.5);
	NSString *name = [[NSUUID UUID] UUIDString];
	NSString *path = [NSString stringWithFormat:@"Documents/%@.jpg", name];
	NSString *jpgPath = [NSHomeDirectory() stringByAppendingPathComponent:path];
	if ([imgData writeToFile:jpgPath atomically:YES]) {
        
        //Successfully wrote the image to disk, call the success block
        if(successBlock) {
            successBlock(path);
        }
        
	} else {
        
        //There was an error saving the image, just throw an error and let it try again next time
		return NO;
        
	}
	return YES;
}

@end
