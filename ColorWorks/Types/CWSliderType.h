//
//  CWSliderType.h
//  ColorWorks
//
//  Created by Dana Buehre on 4/2/20.
//  Copyright © 2020 CreatureCoding. All rights reserved.
//

#ifndef CWSliderType_h
#define CWSliderType_h

typedef enum : NSUInteger {
    CWSliderTypeAlpha,
    CWSliderTypeHue,
    CWSliderTypeSaturation,
    CWSliderTypeBrightness,
    CWSliderTypeRed,
    CWSliderTypeGreen,
    CWSliderTypeBlue,
    CWSliderTypeCyan,
    CWSliderTypeMagenta,
    CWSliderTypeYellow,
    CWSliderTypeBlack
} CWSliderType;

NS_INLINE NSString *sliderTypeShortName(CWSliderType type) {
    switch (type) {
        case CWSliderTypeAlpha: return @"A";
        case CWSliderTypeHue: return @"H";
        case CWSliderTypeSaturation: return @"S";
        case CWSliderTypeBrightness: return @"B";
        case CWSliderTypeRed: return @"R";
        case CWSliderTypeGreen: return @"G";
        case CWSliderTypeBlue: return @"B";
        case CWSliderTypeCyan: return @"C";
        case CWSliderTypeMagenta: return @"M";
        case CWSliderTypeYellow: return @"Y";
        case CWSliderTypeBlack: return @"K";
    }
}

NS_INLINE CGFloat sliderTypeMaxValue(CWSliderType type) {
    switch (type) {
        case CWSliderTypeHue: return (CGFloat)360.0f;
        case CWSliderTypeRed:
        case CWSliderTypeGreen:
        case CWSliderTypeBlue: return (CGFloat)255.0f;
        case CWSliderTypeAlpha:
        case CWSliderTypeSaturation:
        case CWSliderTypeBrightness:
        case CWSliderTypeCyan:
        case CWSliderTypeMagenta:
        case CWSliderTypeYellow:
        case CWSliderTypeBlack: return (CGFloat)100.0f;
    }
}

#endif /* CWSliderType_h */
