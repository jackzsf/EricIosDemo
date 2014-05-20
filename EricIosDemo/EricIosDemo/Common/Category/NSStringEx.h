//
//  untitled.h
//  Yiban
//
//  Created by 赛锋 张 on 12-5-24.
//  Copyright (c) 2012年 eric. All rights reserved.
//

#import <Foundation/Foundation.h>

#define	ShowText	@"txt"
#define	LinkSource	@"link"
#define Type        @"type"

#define StampKey    @"stamps"
#define UserKey     @"users"
#define PoiKey      @"pois"
#define UrlKey      @"links"
#define ExpKey      @"exp"
typedef enum LinkType
{
    None,
    User_Type,
    Poi_Type,
    Stamp_Type,
    Link_Type,
    HttpStr_Type,
    Exp_Type,
    Lord_Type,
    Other_Type
}LinkType;

@interface NSString (NSStringEx) 

- (NSInteger)getChineseCount;
- (CGFloat)getMessageHight:(NSInteger )lineCharaterCount;//正文的
- (BOOL)strCanSend;

+ (NSString *) md5: (NSString *) inPutText;
- (NSString *)urlEncode;

- (NSString *)createLinkEnableStr:(NSArray *)list;
- (NSString *)createNoLinkStr:(NSArray *)list;
- (NSString *)createLinkEnableStrByDic:(NSDictionary *)list;
- (NSString *)createLinkEnableStrByArray:(NSArray *)list;
- (NSString *)createNoLinkStrByDic:(NSDictionary *)list;
- (NSString *)createNoLinkStrByArray:(NSArray *)list;

//根据新浪对字符长度规定 ascii码范围内一个算0.5 其他的一个算一个
- (NSInteger)sinaCharacterLength;
- (NSString*)getSinaStrLenWithNum:(int)num;

//- (NSString *)createLinkEnableStr:(NSArray *)list withType:(LinkType)type;
//- (NSString *)createNoLinkStr:(NSArray *)list withType:(LinkType)type;

- (id)objectForKey:(id)aKey;
- (NSUInteger)count;


+ (NSString *)getStrFromDistance:(NSInteger)distance;
+ (NSString *)getStrFromPrice:(float)price;
+ (NSString *)getDiscountFromOrgPrice:(CGFloat)orgPrice NowPrice:(CGFloat)nowPrice;

@end
