//
//  ViewController.h
//  TripleDemo
//
//  Created by 晓川 on 13-1-17.
//  Copyright (c) 2013年 晓川. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITextFieldDelegate>
{
    NSMutableArray *units;
    NSMutableDictionary *_seeds;
}

@property (nonatomic,assign)IBOutlet UITextField *tf;
@property (nonatomic,strong)UIButton *returnBut;
@property (nonatomic,weak)UITextField *currentTf;
@end
