//
//  CWColorPickerDelegate.h
//  ColorWorks
//
//  Created by Dana Buehre on 4/2/20.
//  Copyright © 2020 CreatureCoding. All rights reserved.
//

#ifndef CWColorPickerDelegate_h
#define CWColorPickerDelegate_h

@protocol CWColorPickerDelegate <NSObject>

@optional
- (void)colorPickerDismissedWithColor:(UIColor *)color;
- (void)colorPickerDidUpdateColor:(UIColor *)color;
- (void)colorPickerDidChangeColor:(UIColor *)color;

@end

#endif /* CWColorPickerDelegate_h */
