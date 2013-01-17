//
//  ViewController.m
//  TripleDemo
//
//  Created by 晓川 on 13-1-17.
//  Copyright (c) 2013年 晓川. All rights reserved.
//

#import "ViewController.h"
#import "Unit.h"
@interface ViewController ()

@end

@implementation ViewController
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.tf resignFirstResponder];
    return YES;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
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
            [u setFrame:CGRectMake(j*75*scale, i*35*scale, 70*scale, 30*scale)];
            u.tag = i*10+j;
            NSString *key = [NSString stringWithFormat:@"%d",u.tag];
            [_seeds setObject:u forKey:key];
            [self.view addSubview:u];
            u.delegate = self;
            [units addObject:u];
        }
    }
    
    for (Unit *u in units) {
        NSLog(@"%d",u.tag);
    }
    
}


- (void)unitClick:(Unit *)u
{
    if ([self.tf.text intValue] == 0) {
        return;
    }
    int next = [self.tf.text intValue];
    u.tf.text = [NSString stringWithFormat:@"%d",next];
    NSLog(@"next:%d",next);

    [self makeUp:u];
}



- (void)makeUp:(Unit *)u
{
    NSMutableArray *index = [NSMutableArray array];
    NSMutableArray *result =[NSMutableArray array];
    [index addObject:u];
    do {
        Unit *currentU = [index objectAtIndex:0];
        [index removeObject:currentU];
        [result addObject:currentU];
        NSLog(@"currentUnit :%@",currentU);
        NSString *upKey = [NSString stringWithFormat:@"%d%d",(currentU.tag -10)/10,currentU.tag%10];
        NSLog(@"upKey:%@",upKey);
        Unit *tempU = [_seeds objectForKey:upKey];
        if (tempU) {
            
            if ([tempU.tf.text intValue] == [currentU.tf.text intValue]) {
                NSLog(@"UpUnit:%@",tempU);
                if (![result containsObject:tempU]) {
                    NSLog(@"结果不包含");
                    if (![index containsObject:tempU]) {
                        NSLog(@"index不包含");
                        [index addObject:tempU];
                    }
                    
                    //                    [result addObject:tempU];
                }
            }
        }
        
        
        NSString *downKey = [NSString stringWithFormat:@"%d%d",(currentU.tag +10)/10,currentU.tag%10];
        NSLog(@"downKey:%@",downKey);
        Unit *tempD = [_seeds objectForKey:downKey];
        if (tempD) {
            
            if ([tempD.tf.text intValue] == [currentU.tf.text intValue]) {
                NSLog(@"DownUnit:%@",tempD);
                if (![result containsObject:tempD]) {
                    NSLog(@"结果不包含");
                    if (![index containsObject:tempD]) {
                        NSLog(@"index不包含");
                        [index addObject:tempD];
                    }
                    
                    //                    [result addObject:tempD];
                }
            }
        }
        
        NSString *leftKey = [NSString stringWithFormat:@"%d%d",currentU.tag/10,(currentU.tag-1)%10];
        NSLog(@"leftKey:%@",leftKey);
        Unit *tempL = [_seeds objectForKey:leftKey];
        if (tempL) {
            
            if ([tempL.tf.text intValue] == [currentU.tf.text intValue]) {
                NSLog(@"LeftUnit:%@",tempL);
                if (![result containsObject:tempL]) {
                    NSLog(@"结果不包含");
                    if (![index containsObject:tempL]) {
                        NSLog(@"index不包含");
                        [index addObject:tempL];
                    }
                    
                    //                    [result addObject:tempL];
                }
            }
        }
        
        
        NSString *rightKey = [NSString stringWithFormat:@"%d%d",currentU.tag/10,(currentU.tag+1)%10];
        
        Unit *tempR = [_seeds objectForKey:rightKey];
        if (tempR) {
            NSLog(@"rightKey:%@",rightKey);
            if ([tempR.tf.text intValue] == [currentU.tf.text intValue]) {
                NSLog(@"RightUnit:%@",tempR);
                if (![result containsObject:tempR]) {
                    NSLog(@"结果不包含");
                    if (![index containsObject:tempR]) {
                        NSLog(@"index不包含");
                        [index addObject:tempR];
                    }
                    
                    //                    [result addObject:tempR];
                }
            }
        }
        
        
    } while ([index count] > 0);
    
    
    NSLog(@"result:%@",result);
    
    if([result count]>2){
        u.tf.text = [NSString stringWithFormat:@"%d",[u.tf.text intValue]+1];
        [result removeObject:u];
        for (Unit *tu in result) {
            tu.tf.text = @"0";
        }
        [self makeUp:u];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
