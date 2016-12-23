//
//  NoteModel.h
//  DataPersistence
//
//  Created by wapage-mac on 16/12/20.
//  Copyright © 2016年 wapage-mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NoteModel : NSObject
//内容
@property (nonatomic, copy) NSString *content;
//日期
@property (nonatomic, copy) NSDate *date;
@end
