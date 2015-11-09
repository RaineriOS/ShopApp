//
//  KeyboardHelper.m
//  ShopApp
//
//  Created by shikee_app03 on 15/9/8.
//  Copyright (c) 2015年 shikee_app03. All rights reserved.
//

#import "KeyboardHelper.h"

@interface KeyboardHelper()<UITextFieldDelegate>
{
    
}
@property(nonatomic,weak) UIViewController *vc;
@property(nonatomic,strong) UIScrollView *scrollView;
@property(nonatomic,strong) NSMutableArray *textFieldArray;
@property(nonatomic,weak)   UIView *moveView;
@property(nonatomic,assign) CGPoint moveViewPoint;

@end

@implementation KeyboardHelper

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(instancetype)initWithVC:(UIViewController *)vc
{
    self=[super init];
    if(self){
        [self setVC:vc];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
    }
    return self;
}

-(void)setVC:(UIViewController *)vc
{
    self.vc=vc;
    [self resetKeyboardPanel];
}

-(void)addTextField:(UITextField *)textField
{
    textField.delegate=self;
    [self.textFieldArray addObject:textField];
}

-(void)setMoveView:(UIView *)moveView
{
    _moveView=moveView;
}

-(void)resetKeyboardPanel
{
    for (UIView *subView in self.vc.view.subviews) {
        [self.scrollView addSubview:subView];
    }
    self.scrollView.frame=self.vc.view.bounds;
    self.scrollView.contentSize=CGSizeMake(0, self.vc.view.getHeight);
    [self.vc.view insertSubview:self.scrollView atIndex:0];
}

-(void)keyboardWillShow:(NSNotification *)aNotification
{
    CGRect keyboardFrame = [[aNotification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [self.scrollView setHeight:self.vc.view.getHeight-keyboardFrame.size.height];
    double animationDuration=[[aNotification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    double keyboardHeight=keyboardFrame.size.height;
    double keyboardPointY=self.vc.view.getHeight-keyboardHeight;
    if(keyboardPointY<self.moveViewPoint.y){//需要移动
//        BKLog(@"需要移动 %f",self.moveViewPoint.y-keyboardPointY);
        [self.scrollView setContentOffset:CGPointMake(0, (self.moveView.getPointY-keyboardPointY+self.moveView.getHeight)) animated:YES];
    }
}

-(void)keyboardWillHide:(NSNotification *)aNotification
{
    CGRect keyboardFrame = [[aNotification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];

}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    BKLog(@"good!");
    bif(self.moveView){
        BKLog(@"整体移动");
    }else {
        BKLog(@"move %@",self.moveView);
        self.moveViewPoint=[self.moveView convertPoint:CGPointMake(0, 0) toView:self.vc.view];
        BKLog(@"");
        
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.vc.view endEditing:YES];
    return YES;
}


#pragma mark - InitVar
-(UIScrollView *)scrollView
{
    bif(_scrollView){
        _scrollView=[[UIScrollView alloc]init];
    }
    return _scrollView;
}


#pragma mark data
-(NSMutableArray *)textFieldArray
{
    bif(_textFieldArray)
    {
        _textFieldArray=[[NSMutableArray alloc]init];
    }
    return _textFieldArray;
}

@end
