//
//  ViewController.m
//  DataPersistence
//
//  Created by wapage-mac on 16/12/20.
//  Copyright © 2016年 wapage-mac. All rights reserved.
//

#import "ViewController.h"
#import "NoteViewController.h"

@interface ViewController () {
    NSString *documentLocation;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setUI];
    
    //document目录
    NSArray *documentDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    documentLocation = [documentDirectory objectAtIndex:0];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//界面UI
- (void)setUI{
    UIButton *testBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 50, self.view.frame.size.height / 2 - 5, 100, 10)];
    [testBtn addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [testBtn setTitle:@"test" forState:UIControlStateNormal];
    [testBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:testBtn];
}

//alert
- (void)showAlert:(NSString* __nonnull)message handler:(void (^ __nullable)(UIAlertAction *__nullable action ))handler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:handler];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

//Btn Target
- (void)buttonClick{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NoteViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"NoteViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}



@end
