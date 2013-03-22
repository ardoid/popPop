//
//  PPCacheImage.h
//  PopPop
//
//  Created by Ardo Septama on 21.03.13.
//  Copyright (c) 2013 ardosoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PPCacheImage : NSObject

- (void) cacheImage: (NSString *) ImageURLString imageFile: (NSString *) filename;
- (UIImage *) getCachedImage: (NSString *) ImageURLString;
- (void) removeImage: (NSString *) filename;

@end
