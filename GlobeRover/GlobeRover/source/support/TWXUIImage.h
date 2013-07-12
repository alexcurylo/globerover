//
//  TWXUIImage.h
//
//  Copyright Trollwerks Inc 2013. All rights reserved.
//

@interface UIImage (TWXUIImage) /* < NSCoding > */

/*/* compliant in iOS 5
- (id)initWithCoder:(NSCoder *)decoder;
- (void)encodeWithCoder:(NSCoder *)encoder;
*/
- (UIImage *)scaleAndRotateImage480;

- (UIImage *)rotateRight;

// partial drawing
//- (void)drawInRect:(CGRect)drawRect fromRect:(CGRect)fromRect blendMode:(CGBlendMode)blendMode alpha:(CGFloat)alpha

// from AliSoftware UIImage+Resize
- (UIImage *)resizedImageToSize:(CGSize)dstSize;
- (UIImage *)resizedImageToFitInSize:(CGSize)boundingSize scaleIfSmaller:(BOOL)scale;

// for when @2x isn't being followed, like in cocos2d
+ (UIImage *)retinaImageWithContentsOfFile:(NSString *)path;

@end
