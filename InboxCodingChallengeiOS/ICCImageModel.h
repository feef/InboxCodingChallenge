//
//  ICCImageModel.h
//  
//
//  Created by sharif ahmed on 1/11/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ICCImageModel : NSManagedObject

@property (nonatomic, retain) NSString * imagePath;
@property (nonatomic, retain) NSString * urlString;
@property (nonatomic, retain) NSNumber * index;

@end
