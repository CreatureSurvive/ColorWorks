//
//  CWColorCollection.h
//  ColorWorks
//
//  Created by Dana Buehre on 4/3/20.
//  Copyright © 2020 CreatureCoding. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CWColorCollection : NSObject
@property (nonatomic, strong, readonly) NSString *title;
@property (nonatomic, strong, readonly) NSArray<UIColor *> *colors;

@property (nonatomic, readonly) NSInteger count;

+ (instancetype)collectionWithTitle:(NSString *)title colors:(NSArray<UIColor *> *)colors;
- (instancetype)initWithTitle:(NSString *)title colors:(NSArray<UIColor *> *)colors;

+ (instancetype)defaultSystemColorsCollection;
+ (instancetype)defaultPrimaryColorsCollection;
+ (instancetype)defaultHueColorsCollection;

@end

NS_ASSUME_NONNULL_END
