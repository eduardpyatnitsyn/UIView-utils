//
//  UIView+Utils.m
//  
//
//  Created by Эдуард Пятницын on 23.11.15.
//
//

#import "UIView+Utils.h"
#import "objc/runtime.h"

@implementation UIView (Utils)

@dynamic usualHeight;

-(void) showView:(BOOL) show animated:(BOOL) animated direction:(UIViewHideDirection)direction{
    [self layoutIfNeeded];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *height = [self constraintForAttribute:NSLayoutAttributeHeight];
    NSLayoutConstraint *edgedConstraint = [self constraintForHideDirection:direction];
    
    if ((!self.usualHeight) && (height.constant != 0)){
        [self setUsualHeight: [NSNumber numberWithFloat: height.constant]];
    }
    
    CGFloat bottonPaneHeight = show ? self.usualHeight.floatValue : 0;
    CGFloat newEdgeConstraint = show ? 0 : - self.usualHeight.floatValue;
      
    height.constant = bottonPaneHeight;
    edgedConstraint.constant = newEdgeConstraint;
    
    CGFloat animationDuration = animated ? .25f : 0;
    [UIView animateWithDuration:animationDuration animations:^(){
        [self layoutIfNeeded];
    }];
}

- (NSLayoutConstraint *) constraintForHideDirection:(UIViewHideDirection) direction{
    NSLayoutConstraint *constraint;
    switch (direction) {
        case UIViewHideDirectionDown:
        default:
            constraint = [self constraintForAttribute:NSLayoutAttributeBottom];
            break;
        case UIViewHideDirectionUp:
            constraint = [self constraintForAttribute:NSLayoutAttributeTop];
            break;
    }
    return constraint;
}

- (NSArray *)constaintsForAttribute:(NSLayoutAttribute)attribute {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"firstAttribute = %d", attribute];
    NSArray *filteredArray = [[self constraints] filteredArrayUsingPredicate:predicate];
    
    return filteredArray;
}

- (NSLayoutConstraint *)constraintForAttribute:(NSLayoutAttribute)attribute {
    NSArray *constraints = [self constaintsForAttribute:attribute];
    
    if (constraints.count) {
        return constraints[0];
    }
    
    return nil;
}

#pragma mark - setters&getters for @property usualHeight;
static char UIB_USUALHEIGHT_KEY;

-(void)setUsualHeight:(NSNumber *)usualHeight{
    objc_setAssociatedObject(self, &UIB_USUALHEIGHT_KEY, usualHeight, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSObject*)usualHeight{
    return (NSObject*)objc_getAssociatedObject(self, &UIB_USUALHEIGHT_KEY);
}

@end
