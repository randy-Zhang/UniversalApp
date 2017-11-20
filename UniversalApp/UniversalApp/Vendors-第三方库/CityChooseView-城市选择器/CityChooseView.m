//
//  CityChooseView.m
//  qianguan
//
//  Created by Apple on 2017/3/30.
//  Copyright © 2017年 李文全. All rights reserved.
//

#import "CityChooseView.h"

static CGFloat bgViewHeith = 240;
static CGFloat cityPickViewHeigh = 200;
static CGFloat toolsViewHeith = 40;
static CGFloat animationTime = 0.25;

@interface CityChooseView ()<UIPickerViewDelegate, UIPickerViewDataSource>


@property (nonatomic, strong) UIButton *sureButton;        /** 确认按钮 */
@property (nonatomic, strong) UIButton *canselButton;      /** 取消按钮 */
@property (nonatomic, strong) UIView *toolsView;           /** 自定义标签栏 */
@property (nonatomic, strong) UIView *bgView;              /** 背景view */

//省  市 县 变量
//@property (nonatomic, strong) NSDictionary *allCityInfo;   /** 所有省市县信息 */
@property (nonatomic, strong) NSArray *provinceArr;        /** 省 数组 */
@property (nonatomic, strong) NSArray *cityArr;            /** 市 数组 */
@property (nonatomic, strong) NSArray *townArr;            /** 县城 数组 */
//@property (nonatomic, strong) NSDictionary *provinceDic;   /** 省下面所有的市县 */
//@property (nonatomic, strong) NSDictionary *cityDic;       /** 市下面所有的区县 */


/**选中的数组*/
@property (strong, nonatomic) NSMutableArray *selecteArray;

@end

@implementation CityChooseView

// init 会调用 initWithFrame
- (instancetype)init{
    if (self = [super init]) {
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initSubViews];
        [self initBaseData];
    }
    return self;
}

- (void)initSubViews{
    
    self.frame = [UIApplication sharedApplication].keyWindow.bounds;
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.toolsView];
    [self.toolsView addSubview:self.canselButton];
    [self.toolsView addSubview:self.sureButton];
    [self.bgView addSubview:self.cityPickerView];
    
    [self showPickView];
    
    self.cityField = [[UITextField alloc]init];
    self.cityField.font= [UIFont systemFontOfSize:15];
    self.cityField.inputView = self.cityPickerView;
    
}

- (void)initBaseData{
    NSString *areaPath = [[NSBundle mainBundle] pathForResource:@"area" ofType:@"txt"];
    NSData *areaData = [NSData dataWithContentsOfFile:areaPath];
    
  
    self.provinceArr = [NSJSONSerialization JSONObjectWithData:areaData options:kNilOptions error:nil]; // 省数组

    self.cityArr = [self getNameforProvince:0];
  
    
    self.townArr =self.cityArr[0][@"countys"];
    

    self.province = self.provinceArr[0][@"value"];
    self.city = self.cityArr[0][@"value"];
    self.town = self.townArr[0][@"value"];
   
    self.provinceKey = self.provinceArr[0][@"key"];
    self.cityKey = self.cityArr[0][@"key"];
    self.townKey = self.townArr[0][@"key"];
   
    
}

#pragma event menthods
- (void)canselButtonClick{
    [self hidePickView];
//    if (self.config) {
//        self.config(self.province,self.city,self.town,self.provinceKey,self.cityKey,self.townKey);
//    }
}

- (void)sureButtonClick{
    [self hidePickView];
    if (self.config) {
        self.config(self.province,self.city,self.town,self.provinceKey,self.cityKey,self.townKey);
    }
}

#pragma mark private methods
- (void)showPickView{
    [UIView animateWithDuration:animationTime animations:^{
        self.bgView.frame = CGRectMake(0, self.frame.size.height - bgViewHeith-64, self.frame.size.width, bgViewHeith);
    } completion:^(BOOL finished) {
        
    }];
}


- (void)hidePickView{
    
    [UIView animateWithDuration:animationTime animations:^{
        
        self.bgView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, bgViewHeith);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

- (NSArray *)getNameforProvince:(NSInteger)row{
    
        self.selecteArray= self.provinceArr[row][@"citys"]; //省
        NSMutableArray *temp2 = [[NSMutableArray alloc] init];
        if (self.selecteArray.count > 0) {
            temp2 = self.selecteArray;
        }else{
            temp2 = nil;
        }
      return temp2; //城市数组
}

#pragma mark - pickerViewDatasource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return self.provinceArr.count;
    }
    else if(component == 1){
        return  self.cityArr.count;
    }
    else if(component == 2){
        return self.townArr.count;
    }
    return 0;
}

#pragma mark - pickerViewDelegate
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 40;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width/3.0, 30)];
    label.adjustsFontSizeToFitWidth = YES;
    label.textAlignment = NSTextAlignmentCenter;
    if (component == 0) {
        label.text =  self.provinceArr[row][@"value"];
    }else if (component == 1){
        label.text =  self.cityArr[row][@"value"];
    }else if (component == 2){
        label.text =  self.townArr[row][@"value"];
    }
    
//    //设置分割线
//    ((UILabel *)[pickerView.subviews objectAtIndex:1]).backgroundColor = [UIColor lightGrayColor];
//    ((UILabel *)[pickerView.subviews objectAtIndex:2]).backgroundColor = [UIColor lightGrayColor];
    
    return label;
}


//- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
//    if (component == 0) {
//        return self.provinceArr[row];
//    }else if (component == 1){
//        return self.cityArr[row];
//    }else if (component == 2){
//        return self.townArr[row];
//    }
//    return @"";
//}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (component == 0) {//选择省
        self.cityArr = [self getNameforProvince:row];
        self.townArr = self.cityArr[0][@"countys"];
        [self.cityPickerView reloadComponent:1];
        [self.cityPickerView selectRow:0 inComponent:1 animated:YES];
        [self.cityPickerView reloadComponent:2];
        [self.cityPickerView selectRow:0 inComponent:2 animated:YES];
        
        self.province   = self.provinceArr[row][@"value"];
        self.city       = self.cityArr[0][@"value"];
        self.town       = self.townArr[0][@"value"];
        
        self.provinceKey   = self.provinceArr[row][@"key"];
        self.cityKey       = self.cityArr[0][@"key"];
        self.townKey       = self.townArr[0][@"key"];
        
    }else if (component == 1){//选择城市
        self.townArr =self.cityArr[row][@"countys"];;
        [self.cityPickerView reloadComponent:2];
        [self.cityPickerView selectRow:0 inComponent:2 animated:YES];
        
        self.city = self.cityArr[row][@"value"];
        self.town = self.townArr[0][@"value"];
        self.cityKey = self.cityArr[row][@"key"];
        self.townKey = self.townArr[0][@"key"];
    }else if (component == 2){
        self.town = self.townArr[row][@"value"];
        self.townKey = self.townArr[row][@"key"];
    }
    
    self.cityField.text = [NSString stringWithFormat:@"%@-%@-%@",self.province,self.city,self.town];
    
    
//    if (self.config) {
//          self.config(self.province,self.city,self.town,self.provinceKey,self.cityKey,self.townKey);
//    }
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if ([touches.anyObject.view isKindOfClass:[self class]]) {
        [self hidePickView];
    }
}

#pragma mark - lazy

- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, bgViewHeith)];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}

- (UIPickerView *)cityPickerView{
    if (!_cityPickerView) {
        _cityPickerView = ({
            UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, toolsViewHeith, self.frame.size.width, cityPickViewHeigh)];
            pickerView.backgroundColor = [UIColor whiteColor];
            //            [pickerView setShowsSelectionIndicator:YES];
            pickerView.delegate = self;
            pickerView.dataSource = self;
            pickerView;
        });
    }
    return _cityPickerView;
}


- (UIView *)toolsView{
    
    if (!_toolsView) {
        _toolsView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, toolsViewHeith)];
        _toolsView.layer.borderWidth = 0.5;
        _toolsView.layer.borderColor = [UIColor grayColor].CGColor;
    }
    return _toolsView;
}

- (UIButton *)canselButton{
    if (!_canselButton) {
        _canselButton = ({
            UIButton *canselButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 0, 50, toolsViewHeith)];
            [canselButton setTitle:@"取消" forState:UIControlStateNormal];
            [canselButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [canselButton addTarget:self action:@selector(canselButtonClick) forControlEvents:UIControlEventTouchUpInside];
            canselButton;
        });
    }
    return _canselButton;
}

- (UIButton *)sureButton{
    if (!_sureButton) {
        _sureButton = ({
            UIButton *sureButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 20 - 50, 0, 50, toolsViewHeith)];
            [sureButton setTitle:@"确定" forState:UIControlStateNormal];
            [sureButton setTitleColor:[UIColor colorWithHexString:@"#4d93fc"] forState:UIControlStateNormal];
            [sureButton addTarget:self action:@selector(sureButtonClick) forControlEvents:UIControlEventTouchUpInside];
            sureButton;
        });
    }
    return _sureButton;
}

@end
