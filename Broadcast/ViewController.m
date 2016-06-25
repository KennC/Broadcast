//
//  ViewController.m
//  Broadcast
//
//  Created by kenn on 2016/6/25.
//  Copyright © 2016年 kenn. All rights reserved.
//

#import "ViewController.h"

@implementation ProductIDButton
@end

@interface ViewController ()
{
    NSArray                     *arrMarquee;
    UIView                      *vwBullhorn;
    NSTimer                     *timer;
    ProductIDButton             *btnBullhorn1;
    ProductIDButton             *btnBullhorn2;
    NSInteger                   index;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    arrMarquee = [[NSArray alloc]initWithObjects:@{@"name": @"Tony",@"product": @"salsa",@"pID": @"12345"},
                  @{@"name": @"Gino",@"product": @"money",@"pID": @"67890"},
                  @{@"name": @"Lili",@"product": @"water",@"pID": @"13579"},nil];
    
    [self setBullhornDataWithArray:arrMarquee];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setBullhornDataWithArray:(NSArray *)arr
{
    
    if (!arr || arr.count <= 0) return;
    
    //bg
    if (!vwBullhorn)
    {
        vwBullhorn = [[UIView alloc]initWithFrame:CGRectMake(10, 570, 320 -20, 40)];
        vwBullhorn.backgroundColor = [UIColor lightGrayColor];
        vwBullhorn.clipsToBounds = YES;
        [self.view addSubview:vwBullhorn];
        
        //image
        UIImageView *ivBullhorn = [[UIImageView alloc]initWithFrame:CGRectMake(5, 2 , 36, 36)];
        ivBullhorn.image = [UIImage imageNamed:@"icon_speaker.png"];
        [vwBullhorn addSubview:ivBullhorn];
        
        btnBullhorn1 = [[ProductIDButton alloc]initWithFrame:CGRectMake(ivBullhorn.frame.size.width+5, 0, vwBullhorn.frame.size.width - ivBullhorn.frame.size.width-10, 40)];
        [btnBullhorn1 addTarget:self action:@selector(Bullhorn_Click:) forControlEvents:UIControlEventTouchUpInside];
        btnBullhorn1.titleLabel.numberOfLines = 2;
        [vwBullhorn addSubview:btnBullhorn1];
        
        btnBullhorn2 = [[ProductIDButton alloc]initWithFrame:CGRectMake(ivBullhorn.frame.size.width+5, 40, vwBullhorn.frame.size.width - ivBullhorn.frame.size.width-10, 40)];
        [btnBullhorn2 addTarget:self action:@selector(Bullhorn_Click:) forControlEvents:UIControlEventTouchUpInside];
        btnBullhorn2.titleLabel.numberOfLines = 2;
        [vwBullhorn addSubview:btnBullhorn2];
        
        index = 0;
        
    }
    
    if (timer)
        [timer invalidate];
    
    //frequency
    timer = [NSTimer scheduledTimerWithTimeInterval:3
                                             target:self
                                           selector:@selector(updateBullhorn:)
                                           userInfo:nil
                                            repeats:YES];
    
    
}

-(void)updateBullhorn:(NSTimer *)timer
{
    [UIView animateWithDuration:0.5f
                          delay:0.0f
                        options:UIViewAnimationOptionOverrideInheritedDuration
                     animations:^{
                         btnBullhorn1.frame = CGRectMake(btnBullhorn1.frame.origin.x , btnBullhorn1.frame.origin.y - 40, btnBullhorn1.frame.size.width, btnBullhorn1.frame.size.height);
                         btnBullhorn2.frame = CGRectMake(btnBullhorn2.frame.origin.x , btnBullhorn2.frame.origin.y - 40, btnBullhorn2.frame.size.width, btnBullhorn2.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         
                         if (btnBullhorn1.frame.origin.y <= -40)
                         {
                             [self setButtonDataWithBtn:btnBullhorn1 data:arrMarquee];
                         }
                         else if (btnBullhorn2.frame.origin.y <= -40)
                         {
                             [self setButtonDataWithBtn:btnBullhorn2 data:arrMarquee];
                         }
                     }];
}

- (void)setButtonDataWithBtn:(ProductIDButton *)btn data:(NSArray *)data
{
    btn.frame = CGRectMake(btn.frame.origin.x , 40, btn.frame.size.width, btn.frame.size.height);
    [btn addTarget:self action:@selector(Bullhorn_Click:) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.numberOfLines = 2;
    NSString *purchaseName = [NSString stringWithFormat:@"Congratulations %@ get %@",[arrMarquee[index] objectForKey:@"name"],[arrMarquee[index] objectForKey:@"product"]];
    
    NSString *productName = [arrMarquee[index] objectForKey:@"product"];
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat:@"%@",purchaseName]];
    
    [attString addAttribute: NSFontAttributeName
                      value:  [UIFont systemFontOfSize:16]
                      range: NSMakeRange(0,attString.length)];
    
    [attString addAttribute: NSForegroundColorAttributeName
                      value: [UIColor blackColor]
                      range: NSMakeRange(0,purchaseName.length)];
    
    [attString addAttribute: NSForegroundColorAttributeName
                      value: [UIColor redColor]
                      range: NSMakeRange(purchaseName.length-productName.length,productName.length)];
    
    [btn setAttributedTitle:attString forState:UIControlStateNormal];
    [btn.titleLabel setTextAlignment: NSTextAlignmentCenter];
    btn.productID = [arrMarquee[index] objectForKey:@"pID"];
    
    //data pointer ary(0 ~ 9)
    index = (index == [arrMarquee count]-1) ? 0 : (index+=1) ;
}

- (void)Bullhorn_Click:(ProductIDButton *)sender
{
    NSLog(@"productID : %@",sender.productID);
}

@end
