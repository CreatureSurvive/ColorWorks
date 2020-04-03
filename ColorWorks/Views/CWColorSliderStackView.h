//
//  CWColorSliderStackView.h
//  ColorWorks
//
//  Created by Dana Buehre on 4/2/20.
//  Copyright © 2020 CreatureCoding. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWColorSliderDelegate.h"
#import "CWColorPickerDelegate.h"
#import "CWColorSpaceType.h"

NS_ASSUME_NONNULL_BEGIN

@interface CWColorSliderStackView : UIStackView <CWColorSliderDelegate>

@property (nonatomic, weak) id <CWColorPickerDelegate> delegate;

- (instancetype)initWithColor:(UIColor *)color stackType:(CWColorSpaceType)type delegate:(id<CWColorPickerDelegate>)delegate;
- (void)configureForStackType:(CWColorSpaceType)type color:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
