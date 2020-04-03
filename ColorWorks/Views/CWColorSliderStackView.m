//
//  CWColorSliderStackView.m
//  ColorWorks
//
//  Created by Dana Buehre on 4/2/20.
//  Copyright © 2020 CreatureCoding. All rights reserved.
//

#import "CWColorSliderStackView.h"
#import "CWColorSlider.h"
#import "CWColorDisplayView.h"
#import "UIColor+ColorWorks_Internal.h"

@implementation CWColorSliderStackView {
    NSArray *_sliders;
    UIColor *_color;
    CWColorSpaceType _type;
}

- (instancetype)initWithColor:(UIColor *)color stackType:(CWColorSpaceType)type delegate:(id<CWColorPickerDelegate>)delegate {
    if (self == [super init]) {
        self.delegate = delegate;
        [self configureForStackType:type color:color];
    }
    return self;
}

- (void)configureForStackType:(CWColorSpaceType)type color:(UIColor *)color {
    self.axis = UILayoutConstraintAxisVertical;
    self.alignment = UIStackViewAlignmentFill;
    self.distribution = UIStackViewDistributionFillEqually;
    self.spacing = 8;
    
    _type = type;
    _color = color;
    
    switch (type) {
            
        case CWColorSpaceTypeRGB:
            _sliders = @[
                [[CWColorSlider alloc] initWithSliderType:CWSliderTypeRed color:color],
                [[CWColorSlider alloc] initWithSliderType:CWSliderTypeGreen color:color],
                [[CWColorSlider alloc] initWithSliderType:CWSliderTypeBlue color:color]
            ];
            break;
        case CWColorSpaceTypeRGBA:
            _sliders = @[
                [[CWColorSlider alloc] initWithSliderType:CWSliderTypeRed color:color],
                [[CWColorSlider alloc] initWithSliderType:CWSliderTypeGreen color:color],
                [[CWColorSlider alloc] initWithSliderType:CWSliderTypeBlue color:color],
                [[CWColorSlider alloc] initWithSliderType:CWSliderTypeAlpha color:color],
            ];
            break;
        case CWColorSpaceTypeHSB:
            _sliders = @[
                [[CWColorSlider alloc] initWithSliderType:CWSliderTypeHue color:color],
                [[CWColorSlider alloc] initWithSliderType:CWSliderTypeSaturation color:color],
                [[CWColorSlider alloc] initWithSliderType:CWSliderTypeBrightness color:color]
            ];
            break;
        case CWColorSpaceTypeHSBA:
            _sliders = @[
                [[CWColorSlider alloc] initWithSliderType:CWSliderTypeHue color:color],
                [[CWColorSlider alloc] initWithSliderType:CWSliderTypeSaturation color:color],
                [[CWColorSlider alloc] initWithSliderType:CWSliderTypeBrightness color:color],
                [[CWColorSlider alloc] initWithSliderType:CWSliderTypeAlpha color:color]
            ];
            break;
        case CWColorSpaceTypeCMYK:
            _sliders = @[
                [[CWColorSlider alloc] initWithSliderType:CWSliderTypeCyan color:color],
                [[CWColorSlider alloc] initWithSliderType:CWSliderTypeMagenta color:color],
                [[CWColorSlider alloc] initWithSliderType:CWSliderTypeYellow color:color],
                [[CWColorSlider alloc] initWithSliderType:CWSliderTypeBlack color:color]
            ];
            break;
        case CWColorSpaceTypeCMYKA:
            _sliders = @[
                [[CWColorSlider alloc] initWithSliderType:CWSliderTypeCyan color:color],
                [[CWColorSlider alloc] initWithSliderType:CWSliderTypeMagenta color:color],
                [[CWColorSlider alloc] initWithSliderType:CWSliderTypeYellow color:color],
                [[CWColorSlider alloc] initWithSliderType:CWSliderTypeBlack color:color],
                [[CWColorSlider alloc] initWithSliderType:CWSliderTypeAlpha color:color]
            ];
            break;
    }
    
    [self.arrangedSubviews enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        [self removeArrangedSubview:obj];
        [obj removeConstraints:obj.constraints];
        [obj removeFromSuperview];
    }];
    
    for (CWColorSlider *slider in _sliders) {
        slider.delegate = self;
        [self addArrangedSubview:slider];
    }
}

- (void)applyColorExcludingSlider:(CWColorSlider *)excludingSlider {
    if (self.delegate) [self.delegate colorUpdated:_color];
    
    for (CWColorSlider *slider in _sliders) {
        if (slider != excludingSlider) {
            [slider setColor:_color];
        }
    }
}

- (void)setColor:(UIColor *)color {
    _color = color;
    [self applyColorExcludingSlider:nil];
}

#pragma mark - CWColorSliderDelegate

- (void)slider:(CWColorSlider *)colorSlider colorChanged:(UIColor *)color {
    _color = color;
    [self applyColorExcludingSlider:colorSlider];
}

- (void)slider:(CWColorSlider *)colorSlider valueChanged:(CGFloat)value {
    _color = [_color colorByApplyingValue:value / colorSlider.maximumValue sliderType:colorSlider.type];
    [self applyColorExcludingSlider:colorSlider];
}


@end
