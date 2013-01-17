//
//  Unit.m
//  TripleDemo
//
//  Created by 晓川 on 13-1-17.
//  Copyright (c) 2013年 晓川. All rights reserved.
//

#import "Unit.h"

@implementation Unit
+ (Unit *)createView
{
    NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"Unit" owner:nil options:nil];
    Unit *u = [arr objectAtIndex:0];
    return u;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.tf.delegate = self;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.tf resignFirstResponder];
    return YES;
}

- (IBAction)btnclick:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(unitClick:)]) {
        [self.delegate unitClick:self];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (NSString *)description
{
    return [NSString stringWithFormat:@"tag:%d text:%@",self.tag,self.tf.text];
    
}
- (NSString *)debugDescription
{
    return [NSString stringWithFormat:@"tag:%d text:%@",self.tag,self.tf.text];
}
@end
