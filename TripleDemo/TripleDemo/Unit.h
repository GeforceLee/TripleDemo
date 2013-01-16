//
//  Unit.h
//  TripleDemo
//
//  Created by 晓川 on 13-1-17.
//  Copyright (c) 2013年 晓川. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Unit : UIView<UITextFieldDelegate>
@property (nonatomic,assign)IBOutlet UITextField *tf;
@property (nonatomic,assign)IBOutlet UIButton *btn;
@property (nonatomic,weak)id delegate;
+ (Unit *)createView;
- (IBAction)btnclick:(id)sender;
@end
@protocol UnitDelegate <NSObject>

- (void)unitClick:(Unit *)u;

@end