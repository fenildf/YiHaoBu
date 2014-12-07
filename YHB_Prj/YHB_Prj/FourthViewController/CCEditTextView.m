//
//  CCEditTextView.m
//  YHB_Prj
//
//  Created by yato_kami on 14/12/2.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "CCEditTextView.h"
#define kIWidth (kMainScreenWidth-40)

@interface CCEditTextView()<UITextFieldDelegate>
{
    unary_operation_comfirm _comfirmblock;
    unary_operation_cancel _cancelblock;
}
@property (strong, nonatomic) UIView *inputView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UITextField *textfield;
@property (strong, nonatomic) UIButton *cancalButton;
@property (strong, nonatomic) UIButton *confirmButton;
@property (strong, nonatomic) UIView *dimView;
@end

@implementation CCEditTextView

- (UIView *)dimView
{
    if (!_dimView) {
        _dimView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight)];
        _dimView.backgroundColor = [UIColor blackColor];
        _dimView.alpha = 0.75;
    }
    return _dimView;
}

- (UIView *)inputView
{
    if (!_inputView) {
        _inputView = [[UIView alloc] initWithFrame:CGRectMake((kMainScreenWidth - kIWidth)/2.0, 60, kIWidth, 160)];
        _inputView.backgroundColor = RGBCOLOR(248, 248, 248);
        _inputView.alpha = 1.0f;
        _inputView.layer.borderWidth = 0.6;
        _inputView.layer.cornerRadius = 4.0f;
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, kIWidth-20, 15)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = kFont16;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_inputView addSubview:_titleLabel];
        
        _textfield = [[UITextField alloc] initWithFrame:CGRectMake(10, _titleLabel.bottom+20, kIWidth-20, 40)];
        _textfield.backgroundColor = [UIColor whiteColor];
        _textfield.layer.cornerRadius = 4.0;
        _textfield.layer.borderWidth = 0.5;
        _textfield.delegate = self;
        [_textfield setClearButtonMode:UITextFieldViewModeAlways];;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, _textfield.height)];
        view.backgroundColor = [UIColor clearColor];
        _textfield.leftView = view;
        _textfield.leftViewMode = UITextFieldViewModeAlways;
        
        _textfield.layer.borderColor = [kLineColor CGColor];
        [_inputView addSubview:_textfield];
        
        _cancalButton = [[UIButton alloc] initWithFrame:CGRectMake(10, _textfield.bottom + 20, (kIWidth-20-10)/2.0, 30)];
        [_cancalButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _cancalButton.layer.borderWidth = 0.5f;
        _cancalButton.layer.borderColor = [kLineColor CGColor];
        [_cancalButton setTitle:@" 取消" forState:UIControlStateNormal];
        _cancalButton.titleLabel.font = kFont14;
        [_cancalButton setBackgroundColor:[UIColor whiteColor]];
        [_cancalButton addTarget:self action:@selector(touchCancelButton) forControlEvents:UIControlEventTouchUpInside];
        [_inputView addSubview:_cancalButton];
        
        _confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(_cancalButton.right+10, _textfield.bottom + 20, (kIWidth-20-10)/2.0, 30)];
        [_confirmButton setBackgroundColor:[UIColor whiteColor]];
        [_confirmButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _confirmButton.layer.borderWidth = 0.5f;
        _confirmButton.layer.borderColor = [kLineColor CGColor];
        [_confirmButton setTitle:@" 确定" forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = kFont14;
        [_confirmButton addTarget:self action:@selector(touchConfirmButton) forControlEvents:UIControlEventTouchUpInside];
        [_confirmButton setTitleColor:KColor forState:UIControlStateNormal];
        [_inputView addSubview:_confirmButton];
        
    }
    return _inputView;
}

+ (instancetype )sharedView
{
    static dispatch_once_t once;
    static CCEditTextView *sharedView;
    //dispatch_once_t(&once,^{ sharedView = [[CCEditTextView alloc] init]})
    dispatch_once(&once, ^{
        sharedView = [[CCEditTextView alloc] init];
    });
    return sharedView;
}

- (instancetype)init
{
    self = [super init];
    self.frame = CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight);
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.inputView];
    
    return self;
}
- (void)showEditTextViewWithTitle:(NSString *)title textfieldText:(NSString *)text comfirmBlock: (COMFIRMBLOCK)cBlock cancelBlock:(CANCELBLOCK)cancleBlock
{
    [[UIApplication sharedApplication].keyWindow addSubview:self.dimView];
    self.titleLabel.text = title ? :@"";
    self.textfield.text = text ? :@"";
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self.textfield becomeFirstResponder];
    
    _comfirmblock = cBlock;
    _cancelblock = cancleBlock;
    
}

#pragma mark - action
- (void)touchCancelButton
{
    [self.textfield resignFirstResponder];
    [self removeFromSuperview];
    [self.dimView removeFromSuperview];
    if (_cancelblock) {
        _cancelblock();
    }
}

- (void)touchConfirmButton
{
    [self.textfield resignFirstResponder];
    [self removeFromSuperview];
    [self.dimView removeFromSuperview];
    if (_comfirmblock) {
        NSString *text = [self.textfield.text copy];
        _comfirmblock(text);
    }
}

#pragma mark - delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self removeFromSuperview];
    return YES;
}

@end