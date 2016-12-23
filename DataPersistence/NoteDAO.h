//
//  NoteDAO.h
//  DataPersistence
//
//  Created by wapage-mac on 16/12/20.
//  Copyright © 2016年 wapage-mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NoteModel.h"

@interface NoteDAO : NSObject

//NoteDAO初始化
+ (instancetype)shareInstance;
//创建文件
- (void)createEditableCopyOdDatabaseIdNeeded;
//插入数据
- (BOOL)addData:(NoteModel *)model;
//删除数据
- (BOOL)remove:(NoteModel *)model;
//修改数据
- (BOOL)modify:(NoteModel *)model;
//查询所有记录
- (NSMutableArray *)findAll;
//查询单条记录
- (NoteModel *)findById:(NoteModel *)model;

@end
