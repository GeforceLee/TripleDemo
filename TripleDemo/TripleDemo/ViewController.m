//
//  ViewController.m
//  TripleDemo
//
//  Created by 晓川 on 13-1-17.
//  Copyright (c) 2013年 晓川. All rights reserved.
//

#import "ViewController.h"
#import "Unit.h"
#define Rainbow 9


//#define DEBUG_LOG 0

#ifdef DEBUG_LOG
#define Log(format,...) NSLog(format,##__VA_ARGS__)
#else
#define Log(format,...)
#endif





@interface ViewController ()

@end

@implementation ViewController
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.currentTf = textField;
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.tf resignFirstResponder];
    return YES;
}
-(void)test
{
    [self.currentTf resignFirstResponder];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.returnBut = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [self.view addSubview:self.returnBut];
    [self.returnBut setBackgroundColor:[UIColor redColor]];
    [self.returnBut addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
    self.tf.delegate = self;
    int scale =2;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        scale=1;
    }
	// Do any additional setup after loading the view, typically from a nib.
    _seeds = [NSMutableDictionary dictionaryWithCapacity:36];
    units = [NSMutableArray arrayWithCapacity:36];
    for (int i=1; i<=6; i++) {
        for (int j =1; j<=6; j++) {
            Unit *u = [Unit createView];
            [u setFrame:CGRectMake(-30+j*75*scale, i*35*scale, 70*scale, 30*scale)];
            u.tag = i*10+j;
            NSString *key = [NSString stringWithFormat:@"%d",u.tag];
            [_seeds setObject:u forKey:key];
            [self.view addSubview:u];
            u.delegate = self;
            [units addObject:u];
        }
    }
    
    for (Unit *u in units) {
        Log(@"%d",u.tag);
    }
    
}


- (void)unitClick:(Unit *)u
{
    if ([self.tf.text intValue] == 0) {
        return;
    }
    int next = [self.tf.text intValue];
    u.tf.text = [NSString stringWithFormat:@"%d",next];
    Log(@"next:%d",next);

    [self makeUpAll:u];
}

- (NSMutableArray *)aroundSeeds:(Unit *)currentU
{
    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:4];
    
    //上
    NSString *upKey = [NSString stringWithFormat:@"%d%d",(currentU.tag -10)/10,currentU.tag%10];
    Log(@"upKey:%@",upKey);
    Unit *tempU = [_seeds objectForKey:upKey];
    if (tempU) {
        [tempArr addObject:tempU];
    }
    
    //下
    NSString *downKey = [NSString stringWithFormat:@"%d%d",(currentU.tag +10)/10,currentU.tag%10];
    Log(@"downKey:%@",downKey);
    Unit *tempD = [_seeds objectForKey:downKey];
    if (tempD) {
        [tempArr addObject:tempD];
    }
    
    //左
    NSString *leftKey = [NSString stringWithFormat:@"%d%d",currentU.tag/10,(currentU.tag-1)%10];
    Log(@"leftKey:%@",leftKey);
    Unit *tempL = [_seeds objectForKey:leftKey];
    if (tempL) {
        [tempArr addObject:tempL];
    }
    
    //右
    NSString *rightKey = [NSString stringWithFormat:@"%d%d",currentU.tag/10,(currentU.tag+1)%10];
    Unit *tempR = [_seeds objectForKey:rightKey];
    if (tempR) {
        [tempArr addObject:tempR];
    }
    Log(@"排序前:%@",tempArr);
    [tempArr sortUsingComparator:^NSComparisonResult(Unit *obj1, Unit *obj2) {
        if ([obj1.tf.text intValue]<[obj2.tf.text intValue]) {
            return NSOrderedDescending;
        }
        else if([obj1.tf.text intValue]>[obj2.tf.text intValue]) {
            return NSOrderedAscending;
        }
        else
        {
            return NSOrderedSame;
        }
        
    }];
    Log(@"排序后:%@",tempArr);
    return tempArr;
}

- (NSMutableArray *)makeUp:(Unit *)theUnit
{
    NSMutableArray *resultArr = [NSMutableArray array];
    NSMutableArray *index = [NSMutableArray array];
    [index addObject:theUnit];
    do {
        Unit *currentU = [index objectAtIndex:0];
        [index removeObject:currentU];
        [resultArr addObject:currentU];
        Log(@"currentUnit :%@",currentU);
        
        NSMutableArray *tempArr = [self aroundSeeds:currentU];
        
//        if ([currentU.tf.text intValue] == Rainbow) {
//            Unit *maxU = nil;
//            for (Unit *tu in tempArr) {
//                if ([tu.tf.text intValue]>[maxU.tf.text intValue]) {
//                    maxU = tu;
//                }
//            }
//            if (maxU) {
//                currentU.tf.text = maxU.tf.text;
//            }
//        }
        for (Unit *tu in tempArr) {
            if ([tu.tf.text intValue] == [currentU.tf.text intValue]) {
                if (![resultArr containsObject:tu]) {
                    if (![index containsObject:tu]) {
                        [index addObject:tu];
                    }
                }
            }
        }
        
        
    } while ([index count] > 0);

    
    return resultArr;
    
}

- (void)makeUpAll:(Unit *)u
{
    NSMutableArray *index = [NSMutableArray array];
    NSMutableArray *result = nil;
    [index addObject:u];
    
    BOOL isRainbow = [u.tf.text intValue]== Rainbow ? YES:NO;
    
    int lastInt = [u.tf.text intValue];
    
    NSMutableArray *around = [self aroundSeeds:u];
    if (isRainbow) {
        BOOL canMake = NO;
        for (Unit *tu in around) {
            u.tf.text = tu.tf.text;
            result = [self makeUp:u];
            if ([result count]>2) {
                u.tf.text = [NSString stringWithFormat:@"%d",[u.tf.text intValue]+1];
                [result removeObject:u];
                for (Unit *atu in result) {
                    atu.tf.text = @"0";
                }
                [self makeUpAll:u];
                return;
            }
        }
        if (!canMake) {
            u.tf.text = [NSString stringWithFormat:@"%d",lastInt];
        }
    }
    else
    {
        result = [self makeUp:u];
        Log(@"result:%@",result);
        if([result count]>2){
            u.tf.text = [NSString stringWithFormat:@"%d",[u.tf.text intValue]+1];
            [result removeObject:u];
            for (Unit *tu in result) {
                tu.tf.text = @"0";
            }
            [self makeUpAll:u];
        }
    }
    

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
