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
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.tf resignFirstResponder];
    return YES;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tf.delegate = self;
	// Do any additional setup after loading the view, typically from a nib.
    units = [NSMutableArray arrayWithCapacity:36];
    for (int i=0; i<6; i++) {
        for (int j =0; j<6; j++) {
            Unit *u = [Unit createView];
            [u setFrame:CGRectMake(20+j*75, 50+i*35, 70, 30)];
            u.tag = i*10+j;
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
    NSLog(@"%@",u.tf.text);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
