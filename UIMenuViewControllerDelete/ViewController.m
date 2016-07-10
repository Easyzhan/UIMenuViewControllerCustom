//
//  ViewController.m
//  UIMenuViewControllerDelete
//
//  Created by Zin_戦 on 16/7/10.
//  Copyright © 2016年 Zin戦壕. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    
        NSMutableArray * dataSource;
        BOOL showMenu;
        NSIndexPath * path;
    
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.dataSource = self;
    _tableView.delegate = self;
     dataSource = [[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",nil];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return dataSource.count;
}
/** <#注释#> */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.textLabel.text = dataSource[indexPath.row];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (!showMenu) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    showMenu = NO;
}

-(BOOL)canBecomeFirstResponder
{
    return YES;
}
#pragma mark - 三个系统代理必须全部实现！

- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    showMenu = YES;
    path = indexPath;
    
    //cell中需要重写canBecomeFirstResponder
    UITableViewCell * cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    //需要成为第一响应者
    [cell becomeFirstResponder];
    
    
    UIMenuController *menu = [UIMenuController sharedMenuController];
    
    //这里的frame影响箭头的位置
    CGRect rect = cell.frame;
    rect.size.width= 200;
    [menu setTargetRect:rect inView:tableView];
    
    //添加你要自定义的MenuItem
    UIMenuItem *item = [[UIMenuItem alloc] initWithTitle:@"复制"
                                                  action:@selector(copyMenuPress:)];
    UIMenuItem *item2 = [[UIMenuItem alloc] initWithTitle:@"删除"
                                                   action:@selector(delMenuPress:)];
    UIMenuItem *item3 = [[UIMenuItem alloc] initWithTitle:@"编辑"
                                                   action:@selector(copyMenuPress:)];
    UIMenuItem *item4 = [[UIMenuItem alloc] initWithTitle:@"转发"
                                                   action:@selector(copyMenuPress:)];
    UIMenuItem *item5 = [[UIMenuItem alloc] initWithTitle:@"分享分享"
                                                   action:@selector(copyMenuPress:)];
    menu.menuItems = [NSArray arrayWithObjects:item,item2,item3,item4,item5,nil];
    
    [menu setMenuVisible:YES animated:YES];
    
    //return YES or NO 都可以
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
    
    //屏蔽掉系统的copy:等其它函数
    return NO;
}

- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
    
    //这里只会调用系统的SEL
    if (action == @selector(copy:)) {
        
        // [UIPasteboard generalPasteboard].string = [data objectAtIndex:indexPath.row];
    }
}


#pragma mark - menu method

/**
 *  @author wangxuanao
 *
 *  menu响应方法  复制
 *
 *  @param menu
 */
-(void)copyMenuPress:(UIMenuController *)menu
{
    
    UITableViewCell * cell = [self.tableView cellForRowAtIndexPath:path];
    
    [dataSource addObject:cell.textLabel.text];
    
    [self.tableView reloadData];
    
}

/**
 *  @author wangxuanao
 *
 *  menu响应方法  删除
 *
 *  @param menu
 */
-(void)delMenuPress:(UIMenuController *)menu
{
    
    [dataSource removeObjectAtIndex:path.row];
    
    [self.tableView reloadData];
    
}


@end
