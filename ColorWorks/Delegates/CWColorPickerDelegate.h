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
- (void)colorPicked:(UIColor *)color;
- (void)colorUpdated:(UIColor *)color;

@end

#endif /* CWColorPickerDelegate_h */
