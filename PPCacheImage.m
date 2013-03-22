//
//  PPCacheImage.m
//  PopPop
//
//  Created by Ardo Septama on 21.03.13.
//  Copyright (c) 2013 ardosoft. All rights reserved.
//

#import "PPCacheImage.h"
#define TMP NSTemporaryDirectory()

@implementation PPCacheImage

- (void) cacheImage: (NSString *) ImageURLString imageFile: (NSString *) filename
{
    NSURL *ImageURL = [NSURL URLWithString: ImageURLString];
    
    // Generate a unique path to a resource representing the image you want
    //filename = [[@"venue"]];
    NSString *uniquePath = [TMP stringByAppendingPathComponent: filename];
    
    // Check for file existence
    if(![[NSFileManager defaultManager] fileExistsAtPath: uniquePath] )
    {
        // The file doesn't exist, we should get a copy of it
        
        // Fetch image
        NSData *data = [[NSData alloc] initWithContentsOfURL: ImageURL];
        UIImage *image = [[UIImage alloc] initWithData: data];
        
        // Do we want to round the corners?
        //image = [self roundCorners: image];
        
        // Is it PNG or JPG/JPEG?
        // Running the image representation function writes the data from the image to a file
        if([ImageURLString rangeOfString:@".png"  options: NSCaseInsensitiveSearch].location != NSNotFound)
        {
            [UIImagePNGRepresentation(image) writeToFile: uniquePath atomically: YES];
        }
        else if([ImageURLString rangeOfString: @".jpg" options: NSCaseInsensitiveSearch].location != NSNotFound || [ImageURLString rangeOfString: @".jpeg" options: NSCaseInsensitiveSearch].location != NSNotFound)
                {
                        [UIImageJPEGRepresentation(image, 100) writeToFile: uniquePath atomically: YES];
                }
    }
}

- (UIImage *) getCachedImage: (NSString *) ImageFileName
{
        NSString *filename = ImageFileName; //[[something unique, perhaps the image name]];
        NSString *uniquePath = [TMP stringByAppendingPathComponent: filename];
        
        UIImage *image;
        
        // Check for a cached version
        if([[NSFileManager defaultManager] fileExistsAtPath: uniquePath])
        {
            image = [UIImage imageWithContentsOfFile: uniquePath]; // this is the cached image
        }
//            else
//            {
//                // get a new one
//                [self cacheImage: ImageURLString imageFile:@"a"];
//                image = [UIImage imageWithContentsOfFile: uniquePath];
//            }
    
        return image;
}

- (void) removeImage:(NSString *)filename
{
    NSString *uniquePath = [TMP stringByAppendingPathComponent: filename];
    NSError *error;
    if([[NSFileManager defaultManager] fileExistsAtPath: uniquePath] )  {
        [[NSFileManager defaultManager] removeItemAtPath:uniquePath error:&error];
    }
}

@end
