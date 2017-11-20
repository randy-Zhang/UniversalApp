//
//  CityChooseView.h
//  qianguan
//
//  Created by Apple on 2017/3/30.
//  Copyright © 2017年 李文全. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^sureButtonClick) (NSString *province ,NSString *city ,NSString *town,NSNumber *provinceKey ,NSNumber *cityKey ,NSNumber *townKey);

@interface CityChooseView : UIView

@property (nonatomic, strong) NSString *province;           /** 省 */
@property (nonatomic, strong) NSString *city;               /** 市 */
@property (nonatomic, strong) NSString *town;               /** 县 */

/**省对应的key值*/
@property (nonatomic, strong) NSNumber *provinceKey;
/**市对应的key值*/
@property (nonatomic, strong) NSNumber *cityKey;
/**县对应的key值*/
@property (nonatomic, strong) NSNumber *townKey;


@property (nonatomic, copy) sureButtonClick config;


/**城市输入框*/
@property(nonatomic,strong)UITextField *cityField;

@property (nonatomic, strong) UIPickerView *cityPickerView;/** 城市选择器 */

@end
