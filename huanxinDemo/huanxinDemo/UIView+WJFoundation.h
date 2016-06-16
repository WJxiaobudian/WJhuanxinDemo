//
//  UIView+WJFoundation.h
//  Extension
//
//  Created by WJ on 16/5/16.
//  Copyright © 2016年 WJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (WJFoundation)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;

@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat bottom;

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

@property (nonatomic,readonly, assign) CGFloat screenX;
@property (nonatomic,readonly, assign) CGFloat screenY;
@property (nonatomic,readonly, assign) CGFloat screenViewX;
@property (nonatomic,readonly, assign) CGFloat screenViewY;
@property (nonatomic,readonly, assign) CGRect screenFrame;

@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize size;

- (void)removeAllSubviews;
- (UIViewController *)viewController;
- (void)setRoundedCorners:(UIRectCorner)corners radius:(CGFloat)radius;

@end
