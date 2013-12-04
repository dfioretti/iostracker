//
//  CircleView.m
//  App Tracker
//
//  Created by David Fioretti on 12/3/13.
//  Copyright (c) 2013 David Fioretti. All rights reserved.
//

#import "CircleView.h"

@implementation CircleView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.colorPicked = [UIColor blackColor];
    }
    self.opaque = NO;
    self.backgroundColor = [UIColor clearColor];
    return self;
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Create a new rect with some padding
    // + create a circle from this new rect:
    CGRect box = CGRectInset(self.bounds, self.bounds.size.width * 0.1f, self.bounds.size.height * 0.1f);
    UIBezierPath *ballBezierPath = [UIBezierPath bezierPathWithOvalInRect:box];
    [[UIColor whiteColor] setStroke];
    [self.colorPicked setFill]; // Green here to show the black area
    [ballBezierPath stroke];
    [ballBezierPath fill];
    [self setBackgroundColor:[UIColor clearColor]]; // Happens with and without this line}
    self.opaque = NO;
    self.alpha = 0.5;
    self.backgroundColor = [UIColor clearColor];

}
@end
