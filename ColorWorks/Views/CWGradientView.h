//
//  CWGradientView.h
//  ColorWorks
//
//  Created by Dana Buehre on 4/2/20.
//  Copyright © 2020 CreatureCoding. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "CWSliderType.h"

NS_ASSUME_NONNULL_BEGIN

@class UIColor;
@interface CWGradientView : CAGradientLayer

- (instancetype)initWithColors:(NSArray *)colors;
- (void)setColorsForSliderType:(CWSliderType)type primaryColor:(UIColor *)primary;

@end

NS_ASSUME_NONNULL_END
