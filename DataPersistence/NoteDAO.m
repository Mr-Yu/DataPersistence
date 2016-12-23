//
//  NoteDAO.m
//  DataPersistence
//
//  Created by wapage-mac on 16/12/20.
//  Copyright © 2016年 wapage-mac. All rights reserved.
//

#import "NoteDAO.h"

@implementation NoteDAO

+ (instancetype)shareInstance{
    static NoteDAO *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[NoteDAO alloc] init];
    });
    
    return _sharedManager;
}

//获取文件路径
- (NSString *)applicationDocumentDirectoryFile {
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [documentDirectory stringByAppendingPathComponent:@"NotesList.plist"];
    return path;
}

//读取文件
- (void)createEditableCopyOdDatabaseIdNeeded {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *writableDSPath = [self applicationDocumentDirectoryFile];
    
    BOOL dbexists = [fileManager fileExistsAtPath:writableDSPath];
    if (!dbexists) {
        //不存在
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"NotesList.plist"];
        NSError *error;
        BOOL success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDSPath error:&error];
        NSAssert(success, @"错误写入文件");
        
    }
}

//插入数据
- (BOOL)addData:(NoteModel *)model {
    NSString *path = [self applicationDocumentDirectoryFile];
    NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:path];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDictionary *dict = [NSDictionary dictionaryWithObjects:@[[dateFormat stringFromDate:model.date],model.content] forKeys:@[@"date",@"content"]];
    [array addObject:dict];
    [array writeToFile:path atomically:YES];
    return YES;
}

//删除数据
- (BOOL)remove:(NoteModel *)model {
    NSString *path = [self applicationDocumentDirectoryFile];
    NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:path];
    for (NSDictionary *dict in array) {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        NSDate *date = [dateFormat dateFromString:[dict objectForKey:@"date"]];
        
        //比较日期是否相等
        if ([date isEqualToDate:model.date]) {
            [array removeObject:dict];
            [array writeToFile:path atomically:YES];
            break;
        }
    }
    return YES;
}

//修改数据
- (BOOL)modify:(NoteModel *)model {
    NSString *path = [self applicationDocumentDirectoryFile];
    NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:path];
    for (NSDictionary *dict in array) {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        NSDate *date = [dateFormat dateFromString:[dict objectForKey:@"date"]];
        NSString *content = [dict objectForKey:@"content"];
        
        //比较日期是否相等
        if ([date isEqualToDate:model.date]) {
            [dict setValue:content forKey:@"content"];
            [array writeToFile:path atomically:YES];
            break;
        }
    }
    return YES;
}

//查询所有记录
- (NSMutableArray *)findAll {
    NSString *path = [self applicationDocumentDirectoryFile];
    
    NSMutableArray *listData = [[NSMutableArray alloc] init];
    NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:path];
    
    for (NSDictionary *dict in array) {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        NoteModel *note = [[NoteModel alloc] init];
        note.date = [dateFormat dateFromString:[dict objectForKey:@"date"]];
        note.content = [dict objectForKey:@"content"];
        
        [listData addObject:note];
    }
    
    return listData;
}

//查询单条记录
- (NoteModel *)findById:(NoteModel *)model {
    NSString *path = [self applicationDocumentDirectoryFile];
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:path];
    
    for (NSDictionary *dict in array) {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        NoteModel *note = [[NoteModel alloc] init];
        note.date = [dateFormat dateFromString:[dict objectForKey:@"date"]];
        note.content = [dict objectForKey:@"content"];
        
        //比较日期主键是否相同
        if ([note.date isEqualToDate:model.date]) {
            return note;
        }
    }
    
    return nil;

}


@end
