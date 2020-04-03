//
//  CWColorSlider.h
//  ColorWorks
//
//  Created by Dana Buehre on 4/2/20.
//  Copyright © 2020 CreatureCoding. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWSliderType.h"
#import "CWColorSliderDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface CWColorSlider : UISlider

@property (nonatomic, weak) id <CWColorSliderDelegate> delegate;
@property (nonatomic, readonly) CWSliderType type;
@property (nonatomic, readonly) UIColor *colorValue;

- (instancetype)initWithSliderType:(CWSliderType)type color:(UIColor *)color;

- (void)setColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
