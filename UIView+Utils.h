//
//  UIView+Utils.h
//  
//
//  Created by Эдуард Пятницын on 23.11.15.
//
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, UIViewHideDirection) {
    UIViewHideDirectionLeft,
    UIViewHideDirectionRight,
    UIViewHideDirectionUp,
    UIViewHideDirectionDown
};

@interface UIView (Utils)

@property (nonatomic) NSNumber *usualHeight;

-(void) showView:(BOOL) show animated:(BOOL) animated direction:(UIViewHideDirection) direction;

@end
