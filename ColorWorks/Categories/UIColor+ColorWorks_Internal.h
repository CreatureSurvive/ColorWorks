//
//  UIColor+ColorWorks_Internal.h
//  ColorWorks
//
//  Created by Dana Buehre on 4/2/20.
//  Copyright © 2020 CreatureCoding. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWSliderType.h"
#import "UIColor+ColorWorks.h"

#define rgba(r,g,b,a) [UIColor colorWithRed:r green:g blue:b alpha:a]
#define hsba(h,s,b,a) [UIColor colorWithHue:h saturation:s brightness:b alpha:a]
#define cmyka(c,m,y,k,a) [UIColor colorWithCyan:c magenta:m yellow:y black:k alpha:a]

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (ColorWorks_Internal)

+ (NSArray *)hueColors;
+ (NSArray *)someColors;
- (UIImage *)imageWithSize:(CGSize)size;
- (CGFloat)valueForType:(CWSliderType)sliderType;
- (UIColor *)colorByApplyingValue:(CGFloat)value sliderType:(CWSliderType)slidetType;

@end

NS_ASSUME_NONNULL_END
