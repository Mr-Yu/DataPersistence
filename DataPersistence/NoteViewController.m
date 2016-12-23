//
//  NoteViewController.m
//  DataPersistence
//
//  Created by wapage-mac on 16/12/21.
//  Copyright © 2016年 wapage-mac. All rights reserved.
//

#import "NoteViewController.h"
#import "NoteDetailViewController.h"
#import "NoteDAO.h"

@interface NoteViewController () <UITableViewDelegate, UITableViewDataSource> {
    NSMutableArray *dataArray;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)addBtnClick:(id)sender;

@end

@implementation NoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    dataArray = [[NSMutableArray alloc] init];
    
    [self setExtraCellLineHidden:self.tableView];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [self setLocalData];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//设置数据
- (void)setLocalData{
    [[NoteDAO shareInstance] createEditableCopyOdDatabaseIdNeeded];
    dataArray = [[NoteDAO shareInstance] findAll];
}

//去掉多余分割线
- (void)setExtraCellLineHidden: (UITableView *)tableView{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

/****************  UITableViewDataSource ********************/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NoteDetailViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"NoteDetailViewController"];
    vc.noteData = [dataArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"noteCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    UILabel *showTime = [cell viewWithTag:10002];
    UILabel *showDetail = [cell viewWithTag:10001];
    
    NoteModel *singleData = dataArray[indexPath.row];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    showTime.text = [dateFormat stringFromDate:[singleData date]];
    showDetail.text = [singleData content];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [dataArray count];
}
/****************  UITableViewDataSource end ********************/

- (IBAction)addBtnClick:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NoteDetailViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"NoteDetailViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
