//
//  CWColorPickerViewController.m
//  ColorWorks
//
//  Created by Dana Buehre on 4/2/20.
//  Copyright © 2020 CreatureCoding. All rights reserved.
//

#import "CWColorPickerViewController.h"
#import "CWColorSliderStackView.h"
#import "UIColor+ColorWorks_Internal.h"
#import "CWColorDisplayView.h"

@interface CWColorPickerViewController ()
@property (nonatomic, strong) UIStackView *viewStack;
@property (nonatomic, strong) CWColorDisplayView *colorDisplayView;
@property (nonatomic, strong) CWColorSliderStackView *sliderStackView;
@property (nonatomic, strong) UISegmentedControl *typeSelectionView;
@property (nonatomic, strong) UICollectionView *colorCollectionView;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *grabberView;
@property (nonatomic, strong) NSArray<CWColorCollection *> *colorDataSource;
@end

@implementation CWColorPickerViewController

- (instancetype)initWithColor:(UIColor *)color stackType:(CWColorSpaceType)stackType delegate:(id<CWColorPickerDelegate>)delegate {
    if (self == [super init]) {
        self.delegate = delegate;
        self.currentColor = color;
        
        _sliderStackView = [[CWColorSliderStackView alloc] initWithColor:color stackType:stackType delegate:self];
        _colorDisplayView = [[CWColorDisplayView alloc] initWithColor:color];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
        
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(30, 30);
    layout.headerReferenceSize = CGSizeMake(40, 30);
    layout.minimumInteritemSpacing = 8;
    layout.minimumLineSpacing = 8;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    _colorCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _colorCollectionView.backgroundColor = nil;
    _colorCollectionView.dataSource = self;
    _colorCollectionView.delegate = self;
    _colorCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [_colorCollectionView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:@"CELL"];
    [_colorCollectionView registerClass:UICollectionReusableView.class forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HEADER"];
    
    [self setColorCollection:_colorCollection];
    
    _backgroundView = [UIView new];
    _backgroundView.layer.cornerRadius = 16;
    _backgroundView.layer.masksToBounds = YES;
    _backgroundView.layer.cornerCurve = kCACornerCurveContinuous;
    _backgroundView.backgroundColor = [UIColor.systemGroupedBackgroundColor colorWithAlphaComponent:0.8];
    [self.view addSubview:_backgroundView];
    
    _grabberView = [UIView new];
    _grabberView.layer.cornerRadius = 3;
    _grabberView.layer.masksToBounds = YES;
    _grabberView.backgroundColor = UIColor.tertiarySystemFillColor;
    [self.view addSubview:_grabberView];

    _typeSelectionView = [UISegmentedControl new];
    [_typeSelectionView addTarget:self action:@selector(setStackType:) forControlEvents:UIControlEventValueChanged];
    [_typeSelectionView insertSegmentWithTitle:@"HSB" atIndex:0 animated:NO];
    [_typeSelectionView insertSegmentWithTitle:@"RGB" atIndex:1 animated:NO];
    [_typeSelectionView insertSegmentWithTitle:@"CMYK" atIndex:2 animated:NO];
    [_typeSelectionView insertSegmentWithTitle:@"Picker" atIndex:3 animated:NO];
    _typeSelectionView.selectedSegmentIndex = 0;
    [self.view addSubview:_typeSelectionView];

    [self.view addSubview:_sliderStackView];
    
    _viewStack = [UIStackView new];
    _viewStack.axis = UILayoutConstraintAxisVertical;
    _viewStack.alignment = UIStackViewAlignmentFill;
    _viewStack.distribution = UIStackViewDistributionFill;
    _viewStack.spacing = 8;
    [_backgroundView addSubview:_viewStack];
    
    [_viewStack addArrangedSubview:_colorDisplayView];
    [_viewStack addArrangedSubview:_typeSelectionView];
    [_viewStack addArrangedSubview:_sliderStackView];
    
    _viewStack.translatesAutoresizingMaskIntoConstraints = NO;
    _grabberView.translatesAutoresizingMaskIntoConstraints = NO;
    _sliderStackView.translatesAutoresizingMaskIntoConstraints = NO;
    _typeSelectionView.translatesAutoresizingMaskIntoConstraints = NO;
    _backgroundView.translatesAutoresizingMaskIntoConstraints = NO;

    [_grabberView.widthAnchor constraintEqualToConstant:75].active = YES;
    [_grabberView.heightAnchor constraintEqualToConstant:6].active = YES;
    [_grabberView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [_grabberView.topAnchor constraintEqualToAnchor:_backgroundView.topAnchor constant:12].active = YES;
    
    [_backgroundView.heightAnchor constraintEqualToAnchor:_viewStack.heightAnchor constant:46].active = YES;
    [_backgroundView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-32].active = YES;
    [_backgroundView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:16].active = YES;
    [_backgroundView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-16].active = YES;

    [_viewStack.leadingAnchor constraintEqualToAnchor:_backgroundView.leadingAnchor constant:16].active = YES;
    [_viewStack.trailingAnchor constraintEqualToAnchor:_backgroundView.trailingAnchor constant:-16].active = YES;
    [_viewStack.bottomAnchor constraintEqualToAnchor:_backgroundView.bottomAnchor constant:-16].active = YES;
    
    [_colorDisplayView.heightAnchor constraintEqualToConstant: 40].active = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(colorPickerDismissedWithColor:)]) {
        [self.delegate colorPickerDismissedWithColor:self.currentColor];
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        self.view.frame = CGRectMake(0, UIScreen.mainScreen.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)colorPickerDidUpdateColor:(UIColor *)color {
    self.currentColor = color;
    _colorDisplayView.color = color;
    if (self.delegate && [self.delegate respondsToSelector:@selector(colorPickerDidUpdateColor:)]) {
        [self.delegate colorPickerDidUpdateColor:self.currentColor];
    }
}

- (void)colorPickerDidChangeColor:(UIColor *)color {
    if (self.delegate && [self.delegate respondsToSelector:@selector(colorPickerDidChangeColor:)]) {
        [self.delegate colorPickerDidChangeColor:self.currentColor];
    }
}

- (UIModalPresentationStyle)modalPresentationStyle {
    return UIModalPresentationOverCurrentContext;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    if (touches.anyObject.view == self.view) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else if (touches.anyObject.view != _colorDisplayView) {
        [_colorDisplayView resignFirstResponder];
    }
}

- (void)setStackType:(UISegmentedControl *)sender {
    
    if (sender.selectedSegmentIndex < 3) {
        if (![_viewStack.arrangedSubviews containsObject:_sliderStackView]) {
            [_colorCollectionView removeFromSuperview];
            [_viewStack addArrangedSubview:_sliderStackView];
        }
    } else {
        if (![_viewStack.arrangedSubviews containsObject:_colorCollectionView]) {
            [_sliderStackView removeFromSuperview];
            [_colorCollectionView.heightAnchor constraintEqualToConstant:200].active = YES;
            [_viewStack addArrangedSubview:_colorCollectionView];
        }
    }
    
    switch (sender.selectedSegmentIndex) {
        case 0: { [_sliderStackView configureForStackType:CWColorSpaceTypeHSBA color:self.currentColor]; } break;
        case 1: { [_sliderStackView configureForStackType:CWColorSpaceTypeRGBA color:self.currentColor]; } break;
        case 2: { [_sliderStackView configureForStackType:CWColorSpaceTypeCMYKA color:self.currentColor]; } break;
        case 3: { } break;
        default: { [_sliderStackView configureForStackType:CWColorSpaceTypeHSBA color:self.currentColor]; } break;
    }
}

- (void)setColor:(UIColor *)color {
    self.currentColor = color;
    _colorDisplayView.color = color;
    [_sliderStackView setColor:color];
}

- (void)setColorCollection:(CWColorCollection *)colorCollection {
    _colorCollection = colorCollection;
    
    NSArray *defaultColors = @[
        [CWColorCollection defaultSystemColorsCollection],
        [CWColorCollection defaultPrimaryColorsCollection],
        [CWColorCollection defaultHueColorsCollection]
    ];
    
    _colorDataSource = colorCollection ? [@[colorCollection] arrayByAddingObjectsFromArray:defaultColors] : defaultColors;
    [_colorCollectionView reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _colorDataSource.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _colorDataSource[section].count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    cell.backgroundColor = _colorDataSource[indexPath.section].colors[indexPath.row];
    cell.layer.cornerRadius = 15;
    cell.layer.masksToBounds = YES;
    cell.layer.borderWidth = 1;
    cell.layer.borderColor = UIColor.systemGrayColor.CGColor;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *headerView;
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HEADER" forIndexPath:indexPath];
        
        NSInteger labelTag = 0x2727272;
        UILabel *label = [headerView viewWithTag:labelTag];
        
        if (!label) {
            label = [UILabel new];
            [headerView addSubview:label];
            [label setTag:labelTag];
            [label setTextColor:UIColor.secondaryLabelColor];
            [label setTranslatesAutoresizingMaskIntoConstraints:NO];
            [label.topAnchor constraintEqualToAnchor:headerView.topAnchor].active = YES;
            [label.bottomAnchor constraintEqualToAnchor:headerView.bottomAnchor].active = YES;
            [label.leadingAnchor constraintEqualToAnchor:headerView.leadingAnchor].active = YES;
            [label.trailingAnchor constraintEqualToAnchor:headerView.trailingAnchor].active = YES;
        }
        
        label.text = _colorDataSource[indexPath.section].title.uppercaseString;
    }
    
    return headerView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(40, 40);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    [self colorPickerDidUpdateColor:_colorDataSource[indexPath.section].colors[indexPath.row]];
}
}

@end
