//
//  MenuTableViewController.m
//  0316-菜谱大全
//
//  Created by 孙明海 on 16/3/17.
//  Copyright © 2016年 孙明海. All rights reserved.
//

#import "MenuTableViewController.h"
#import "MenuCell.h"
#import "UIView+Extension.h"
#import "UIImageView+WebCache.h"

@interface MenuTableViewController ()

@end


static NSString *ID = @"MenuTableViewControllerCell";
static NSString *headerID = @"MenuTableViewHeaderID";

@implementation MenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.menu.title;
    self.tableView.rowHeight = 210;
    [self.tableView registerNib:[UINib nibWithNibName:@"MenuCell" bundle:nil] forCellReuseIdentifier:ID];


    [self loadHeardView];
}

-(void)loadHeardView{
    
    UIImageView *hearBC=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 250)];
    hearBC.backgroundColor=[UIColor redColor];
    
    [hearBC sd_setImageWithURL:[NSURL URLWithString:self.menu.albums[0]]];
    self.tableView.tableHeaderView=hearBC;
    
    UILabel *ZuoLiao=[[UILabel alloc]initWithFrame:CGRectMake(15,150, 40, 30)];
    ZuoLiao.text=@"作料:";
    ZuoLiao.font=[UIFont systemFontOfSize:16.0f];
    ZuoLiao.numberOfLines=0;
    ZuoLiao.textAlignment=NSTextAlignmentLeft;
    [hearBC addSubview:ZuoLiao];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(15,170, 300, 40)];
    label.text= self.menu.burden;
    label.font=[UIFont systemFontOfSize:13.0f];
    label.numberOfLines=0;
    label.textAlignment=NSTextAlignmentLeft;
    [hearBC addSubview:label];
    
    UILabel *Cailiao=[[UILabel alloc]initWithFrame:CGRectMake(15,205, 40, 30)];
    Cailiao.text=@"材料:";
    Cailiao.font=[UIFont systemFontOfSize:16.0f];
    Cailiao.numberOfLines=0;
    Cailiao.textAlignment=NSTextAlignmentLeft;
    [hearBC addSubview:Cailiao];
    
    
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(55,200, 300, 40)];
    label2.text=self.menu.ingredients;
    label2.font=[UIFont systemFontOfSize:13.0f];
    label2.numberOfLines=0;
    label2.textAlignment=NSTextAlignmentLeft;
    [hearBC addSubview:label2];
    
    
    
}
#pragma mark - 数据源 , 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  self.menu.steps.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.step = self.menu.steps[indexPath.row];
    return cell;
}


@end
