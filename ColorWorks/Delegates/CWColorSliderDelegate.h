//
//  CWColorSliderDelegate.h
//  ColorWorks
//
//  Created by Dana Buehre on 4/2/20.
//  Copyright © 2020 CreatureCoding. All rights reserved.
//

@class CWColorSlider;
@protocol CWColorSliderDelegate <NSObject>

- (void)slider:(CWColorSlider *)colorSlider valueChanged:(CGFloat)value;
- (void)slider:(CWColorSlider *)colorSlider valueFinishedChange:(CGFloat)value;
- (void)slider:(CWColorSlider *)colorSlider colorChanged:(UIColor *)color;

@end
