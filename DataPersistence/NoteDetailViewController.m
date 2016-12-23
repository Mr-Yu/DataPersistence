//
//  NoteDetailViewController.m
//  DataPersistence
//
//  Created by wapage-mac on 16/12/21.
//  Copyright © 2016年 wapage-mac. All rights reserved.
//

#import "NoteDetailViewController.h"
#import "UIViewController+BackButtonHandler.h"
#import "UIColor+Hex.h"
#import "NoteDAO.h"

@interface NoteDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backGround;
@property (weak, nonatomic) IBOutlet UITextView *inputTextView;
- (IBAction)saveBtnClick:(id)sender;

@end

@implementation NoteDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"详情";
    [self setRightBtn];
    [self setData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)setRightBtn{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 10)];
    [btn  setTitle:@"完成" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize: 17];
    [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [btn setTitleColor:[UIColor colorWithHexString:@"1cd391"] forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(saveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = right;
    
//    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 10)];
//    [btn setTitle:@"完成" forState:UIControlStateNormal];
//    btn.titleLabel.font = [UIFont systemFontOfSize: 12];
//    [btn addTarget:self action:@selector(saveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [btn setTintColor:[UIColor blueColor]];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}

- (void)setData {
    if (self.noteData != nil) {
        self.inputTextView.text = [self.noteData content];
    }
}

- (IBAction)saveBtnClick:(id)sender {
    [self saveData];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)saveData {
    if (self.noteData != nil) {
        [[NoteDAO shareInstance] remove:self.noteData];
    }
    if (self.inputTextView.text != nil && self.inputTextView.text.length > 0) {
        NoteModel *note = [[NoteModel alloc] init];
        note.date = [[NSDate alloc] init];
        note.content = self.inputTextView.text;
        
        [[NoteDAO shareInstance] addData:note];
    }
}

//获取系统返回
- (BOOL)navigationShouldPopOnBackButton{
    NSLog(@"Yuning:ready to leave");
    return NO;
}
@end
