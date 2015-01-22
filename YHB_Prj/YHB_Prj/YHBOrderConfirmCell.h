//
//  YHBOrderConfirmCell.h
//  YHB_Prj
//
//  Created by yato_kami on 15/1/21.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kOrderCellHeight 220

@protocol YHBOrderConfirmCellDelegate <NSObject>

- (void)numberChangedWithValue:(NSString *)num IndexPath:(NSIndexPath *)indexPath;

@end

@interface YHBOrderConfirmCell : UITableViewCell

@property (weak, nonatomic) id<YHBOrderConfirmCellDelegate> delegate;
@property (weak, nonatomic) NSIndexPath *cellIndexPath;

- (void)setUIWithTitle:(NSString *)title sku:(NSString *)sku price:(NSString *)price number:(NSString *)number isFloat:(BOOL)isFloat;

- (void)keyboardWillShowWithHeight:(CGFloat)height;

@end
