//
//  RootViewController.m
//  动画
//
//  Created by 蒋 杏飞 on 14-1-22.
//  Copyright (c) 2014年 蒋 杏飞. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 1; i<8; i++) {
        
        NSString *name = [NSString stringWithFormat:@"huoju_%d.tiff",i];
        
        [arr addObject:[UIImage imageNamed:name]];
    }
    
    
    _aImageView = [[UIImageView alloc] initWithFrame:CGRectMake(60, 20, 200, 200)];
    [_aImageView setUserInteractionEnabled:YES];
    [_aImageView setAnimationImages:arr];
    [_aImageView setAnimationDuration:3];
    [_aImageView setAnimationRepeatCount:0];
    [_aImageView setImage:[UIImage imageNamed:@"iphone.jpg"]];
    [_aImageView startAnimating];
    [self.view addSubview:_aImageView];
    [_aImageView release];
    
    
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(20, 300, 200, 40)];
    [slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    slider.minimumValue = 0;
    slider.maximumValue = 3;
    [self.view addSubview:slider];
    [slider release];
    
    
    UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:@[@"拖拽",@"轻扫",@"点击",@"长按",@"捏合",@"旋转"]];
    [seg setBackgroundColor:[UIColor purpleColor]];
    [seg addTarget:self action:@selector(segAction:) forControlEvents:UIControlEventValueChanged];
    seg.tintColor = [UIColor orangeColor];
    [seg setFrame:CGRectMake(0, 400, 320, 40)];
    [self.view addSubview:seg];
    [seg release];
}
-(void)sliderAction:(id)sender{
    UISlider *slider = (UISlider *)sender;
    _aImageView.animationDuration = 3-slider.value;
    [_aImageView startAnimating];
}

-(void)segAction:(id)sender{
    
    UISegmentedControl *seg = (UISegmentedControl *)sender;
    NSLog(@"seg == %d",seg.selectedSegmentIndex);
    switch (seg.selectedSegmentIndex) {
        case 0:
        {
            UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
            [_aImageView addGestureRecognizer:pan];
            [pan release];
        }
            break;
        case 1:
        {
            UISwipeGestureRecognizer *swip = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipAction:)];
            [_aImageView addGestureRecognizer:swip];
            [swip release];
        }
            break;
        case 2:{
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
            [_aImageView addGestureRecognizer:tap];
            [tap release];
        }
            break;
        case 3:{
//            UILongPressGestureRecognizer *long = 
        }
            break;
        case 4:{
            UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchAction:)];
            [_aImageView addGestureRecognizer:pinch];
            [pinch release];
        }
            break;
        case 5:{
            UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationAction:)];
            [_aImageView addGestureRecognizer:rotation];
            [rotation release];
        }
            break;
        default:
            break;
    }
}

-(void)panGesture:(UIPanGestureRecognizer *)gesture{
    NSLog(@"%s",__func__);
    CGPoint point = [gesture translationInView:_aImageView];
    _aImageView.transform = CGAffineTransformTranslate(_aImageView.transform, point.x, point.y);
    [gesture setTranslation:CGPointMake(0, 0) inView:_aImageView];
    
}

-(void)swipAction:(UISwipeGestureRecognizer *)gesture{
    NSLog(@"%s",__func__);
    [_aImageView stopAnimating];
    [_aImageView setImage:[UIImage imageNamed:@"111.png"]];
}

-(void)tapAction:(UITapGestureRecognizer *)gesture{
    NSLog(@"%s",__func__);
}


-(void)pinchAction:(UIPinchGestureRecognizer *)gesture{
    [_aImageView stopAnimating];
//    _aImageView.transform = CGAffineTransformScale(_aImageView.transform, gesture.scale, gesture.scale);
    
    _aImageView.transform = CGAffineTransformMakeScale(gesture.scale, gesture.scale);
    
}

-(void)rotationAction:(UIRotationGestureRecognizer *)gesture{
    [_aImageView stopAnimating];
    
//    _aImageView.transform = CGAffineTransformRotate(_aImageView.transform, gesture.rotation);
    
    _aImageView.transform = CGAffineTransformMakeRotation(gesture.rotation);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
