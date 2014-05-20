//
//  NSDateEx.m
//  Yiban
//
//  Created by 赛锋 张 on 12-5-24.
//  Copyright (c) 2012年 eric. All rights reserved.
//
//

#import "NSStringEx.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString(NSStringEx)

- (NSString *)urlEncode
{
	NSString *result = (NSString *) CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, NULL, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`__ "), kCFStringEncodingUTF8));
    
	return result;
}

- (NSInteger)getChineseCount
{
	NSInteger lenght = [self length];
	NSInteger chineseCount = 0;
	NSInteger eCount = 0;
	for(NSInteger  index = 0;index < lenght;index++)
	{
		unichar intValue = [self characterAtIndex:index];
		if(intValue>500)
			chineseCount ++;
		else
			eCount ++;
	}

	NSInteger newCount = 0;
	if(eCount!=0)
		newCount = eCount/2.2+ 1;
	return (newCount+chineseCount);
}

- (CGFloat)getMessageHight:(NSInteger )lineCharaterCount
{
	NSInteger number  = [self getChineseCount];
	if(number == 0) return 0 ;
	NSInteger count = number%lineCharaterCount == 0 ? number/lineCharaterCount : number/lineCharaterCount+1;
	
	if(count == 1)
		return 15.0;
	else
		return 15.0+(count-1)*18.0;
}

- (BOOL)strCanSend
{
	if (self==nil || [self length]==0)
	{
		return NO;
	}
	BOOL flag = NO;
	for (int i=0; i<[self length]; i++)
	{
		int x = [self characterAtIndex:i];
		if (x!=32 && x!=13 && x!=10)//10换行  13归位 32空格
		{
			flag = YES;
			break;
		}
	}
	return flag;
}

// 服务端约定 replaceToken 包括下面几个方法
- (NSString *)createLinkEnableStr:(NSArray *)list
{
	NSString *reStr = nil;
	
	if ([self length]>0) 
	{
		reStr = [NSString stringWithString:self];
		
        if ([list count]==0)
        {
            return  reStr;
        }
        
		for (NSDictionary *dic in list)
		{
            if ([dic objectForKey:@"replaceToken"]==nil)
            {
                continue;
            }
			else if ([reStr rangeOfString:[dic objectForKey:@"replaceToken"]].location!=NSNotFound)
			{
				NSString *temp = [NSString stringWithFormat:@"<%@=@%@,%@=%@,%@=%d>", ShowText, [dic objectForKey:@"atName"], 
																				LinkSource, [dic objectForKey:@"atID"], 
                                                                                Type, User_Type];
				reStr = [reStr stringByReplacingOccurrencesOfString:[dic objectForKey:@"replaceToken"] withString:temp];
			}			
		}
	}
	
	return reStr;
}

- (NSString *)createLinkEnableStrByDic:(NSDictionary *)list
{
    NSString *reStr = nil;
	
	if ([self length]>0) 
	{
        reStr = [NSString stringWithString:self];
        
        if ([list count]==0)
        {
            return  reStr;
        }
        
        for (NSString *key in list)
        {
            for (NSDictionary *dic in (NSArray *)[list objectForKey:key])
            {
                if ([dic objectForKey:@"id"]==nil)
                {
                    continue;
                }
//                else if ([key isEqualToString:StampKey])
//                {
//                    if ([reStr rangeOfString:[dic objectForKey:@"replaceToken"]].location!=NSNotFound)
//                    {
//                        NSString *temp = [NSString stringWithFormat:@"<%@=%@,%@=%@,%@=%d>", ShowText, [dic objectForKey:@"stampName"], 
//                                          LinkSource, [dic objectForKey:@"stampID"], 
//                                          Type, Stamp_Type];
//                        reStr = [reStr stringByReplacingOccurrencesOfString:[dic objectForKey:@"replaceToken"] withString:temp];
//                    }
//                }
//                else if ([key isEqualToString:UserKey])
//                {
                    if ([reStr rangeOfString:[dic objectForKey:@"id"]].location!=NSNotFound)
                    {
                        NSString *temp = [NSString stringWithFormat:@"<%@=%@,%@=%@,%@=%d>", ShowText, [dic objectForKey:@"targetname"], 
                                          LinkSource, [dic objectForKey:@"targetid"], 
                                          Type, User_Type];
                        reStr = [reStr stringByReplacingOccurrencesOfString:[dic objectForKey:@"id"] withString:temp];
                    }
//                }
//                else if ([key isEqualToString:PoiKey])
//                {
//                    if ([reStr rangeOfString:[dic objectForKey:@"replaceToken"]].location!=NSNotFound)
//                    {
//                        NSString *temp = [NSString stringWithFormat:@"<%@=%@,%@=%@,%@=%d>", ShowText, [dic objectForKey:@"poiName"], 
//                                          LinkSource, [dic objectForKey:@"poiID"], 
//                                          Type, Poi_Type];
//                        reStr = [reStr stringByReplacingOccurrencesOfString:[dic objectForKey:@"replaceToken"] withString:temp];
//                    }
//                }
//                else if ([key isEqualToString:UrlKey])
//                {
//                    if ([reStr rangeOfString:[dic objectForKey:@"replaceToken"]].location!=NSNotFound)
//                    {
//                        NSString *temp = [NSString stringWithFormat:@"<%@=%@,%@=%@,%@=%d>", ShowText, [dic objectForKey:@"linkText"], 
//                                          LinkSource, [dic objectForKey:@"linkUrl"], 
//                                          Type, Link_Type];
//                        reStr = [reStr stringByReplacingOccurrencesOfString:[dic objectForKey:@"replaceToken"] withString:temp];
//                    }
//                }
//                else
//                {
//                    
//                }
            }
        }
    }
    
    return reStr;
}

- (NSString *)createLinkEnableStrByArray:(NSArray *)list
{
    NSString *reStr = nil;
	
	if ([self length]>0) 
	{
        reStr = [NSString stringWithString:self];
        
        if ([list count]==0)
        {
            return  reStr;
        }
        
        for (NSDictionary *dic  in list)
        {

                if ([dic objectForKey:@"id"]==nil)
                {
                    continue;
                }
            if ([[dic objectForKey:@"targetid"] length]<1 && [[dic objectForKey:@"targetlink"] length]>0) 
            {
                if ([reStr rangeOfString:[dic objectForKey:@"id"]].location!=NSNotFound)
                {
                    NSString *temp = [NSString stringWithFormat:@"<%@=%@,%@=%@,%@=%d>", ShowText, [dic objectForKey:@"targetname"], 
                                      LinkSource, [dic objectForKey:@"targetlink"], 
                                      Type, Link_Type];
                    reStr = [reStr stringByReplacingOccurrencesOfString:[dic objectForKey:@"id"] withString:temp];
                }
            }
            else 
            {
                if ([reStr rangeOfString:[dic objectForKey:@"id"]].location!=NSNotFound)
                {
                    NSString *temp = [NSString stringWithFormat:@"<%@=%@,%@=%@,%@=%d>", ShowText, [dic objectForKey:@"targetname"], 
                                      LinkSource, [dic objectForKey:@"targetid"], 
                                      Type, User_Type];
                    reStr = [reStr stringByReplacingOccurrencesOfString:[dic objectForKey:@"id"] withString:temp];
                }
            }


        }
        
    }
    
    return reStr;
}

- (NSString *)createLinkEnableStr:(NSArray *)list withType:(LinkType)type
{
	NSString *reStr = nil;
    NSString *ssr = [NSString stringWithFormat:@"%d", 1];
	
	if ([self length]>0) 
	{
		reStr = [NSString stringWithString:self];
		
        if ([list count]==0)
        {
            return  reStr;
        }
        
		for (NSDictionary *dic in list)
		{
            if ([dic objectForKey:@"replaceToken"]==nil)
            {
                continue;
            }
			else if ([reStr rangeOfString:[dic objectForKey:@"replaceToken"]].location!=NSNotFound)
			{
                switch (type)
                {
                    case Lord_Type:
                    {
                        NSString *temp = [NSString stringWithFormat:@"<%@=%@,%@=%@,%@=%d>", ShowText, [dic objectForKey:@"replaceValue"], 
                                          LinkSource, [dic objectForKey:@"color"], 
                                          Type, Lord_Type];
                        reStr = [reStr stringByReplacingOccurrencesOfString:[dic objectForKey:@"replaceToken"] withString:temp];
                    }
                        break;
                    case User_Type:
                    {
                        if ([[dic objectForKey:@"nickName"] length] > 0) 
                        {
                            NSString *temp = [NSString stringWithFormat:@"<%@=%@,%@=%@,%@=%d>", ShowText, [dic objectForKey:@"nickName"], 
                                              LinkSource, ssr, 
                                              Type, User_Type];
                            reStr = [reStr stringByReplacingOccurrencesOfString:[dic objectForKey:@"replaceToken"] withString:temp];
                        }
                        else if([[dic objectForKey:@"poiName"] length] > 0)
                        {
                            NSString *temp = [NSString stringWithFormat:@"<%@=%@,%@=%@,%@=%d>", ShowText, [dic objectForKey:@"poiName"], 
                                              LinkSource, ssr, 
                                              Type, User_Type];
                            reStr = [reStr stringByReplacingOccurrencesOfString:[dic objectForKey:@"replaceToken"] withString:temp];
                        }

                    }
                        break;
                    case Exp_Type:
                    case Other_Type:
                    {
                        NSString *temp = [NSString stringWithFormat:@"<%@=%@,%@=%@,%@=%d>", ShowText, [dic objectForKey:@"replaceValue"], 
                                          LinkSource, [dic objectForKey:@"color"], 
                                          Type, type];
                        reStr = [reStr stringByReplacingOccurrencesOfString:[dic objectForKey:@"replaceToken"] withString:temp]; 
                    }
                        break;
                    default:
                        break;
                }
			}			
		}
	}
	
	return reStr;
}

- (NSString *)createNoLinkStr:(NSArray *)list
{
	NSString *reStr = nil;
	
	if ([self length]>0) 
	{
		reStr = [NSString stringWithString:self];
		
        if ([list count]==0)
        {
            return  reStr;
        }
        
		for (NSDictionary *dic in list)
		{
            if ([dic objectForKey:@"replaceToken"]==nil) 
            {
                continue;
            }
			else if ([reStr rangeOfString:[dic objectForKey:@"replaceToken"]].location!=NSNotFound)
			{
				reStr = [reStr stringByReplacingOccurrencesOfString:[dic objectForKey:@"replaceToken"] 
														 withString:[NSString stringWithFormat:@"@%@", [dic objectForKey:@"atName"]]];	
            }
		}
	}
	
	return reStr;
}

- (NSString *)createNoLinkStrByDic:(NSDictionary *)list
{
    NSString *reStr = nil;
	
	if ([self length]>0) 
	{
		reStr = [NSString stringWithString:self];
        
        if ([list count]==0)
        {
            return  reStr;
        }
		
		for (NSString *key in list)
		{
            for (NSDictionary *dic in (NSArray *)[list objectForKey:key])
            {
                if ([dic objectForKey:@"replaceToken"]==nil)
                {
                    continue;
                }
                else if ([reStr rangeOfString:[dic objectForKey:@"replaceToken"]].location!=NSNotFound)
                {
                    if ([key isEqualToString:StampKey])
                    {
                        reStr = [reStr stringByReplacingOccurrencesOfString:[dic objectForKey:@"replaceToken"] 
                                                                 withString:[NSString stringWithFormat:@"%@", [dic objectForKey:@"stampName"]]];
                    }
                    else if ([key isEqualToString:UserKey])
                    {
                        reStr = [reStr stringByReplacingOccurrencesOfString:[dic objectForKey:@"replaceToken"] 
                                                                 withString:[NSString stringWithFormat:@"%@", [dic objectForKey:@"nickName"]]];
                    }
                    else if ([key isEqualToString:PoiKey])
                    {
                        reStr = [reStr stringByReplacingOccurrencesOfString:[dic objectForKey:@"replaceToken"] 
                                                                 withString:[NSString stringWithFormat:@"%@", [dic objectForKey:@"poiName"]]];
                    }
                    else if ([key isEqualToString:UrlKey])
                    {
                        reStr = [reStr stringByReplacingOccurrencesOfString:[dic objectForKey:@"replaceToken"] 
                                                                 withString:[NSString stringWithFormat:@"%@", [dic objectForKey:@"linkText"]]];
                    }
                    else
                    {
                        
                    }
                }	
            }
		}
	}
	
	return reStr;
}

- (NSString *)createNoLinkStrByArray:(NSArray *)list
{
    NSString *reStr = nil;
	
	if ([self length]>0) 
	{
		reStr = [NSString stringWithString:self];
        
        if ([list count]==0)
        {
            return  reStr;
        }
		
		for (NSDictionary *dic in list)
		{

                if ([dic objectForKey:@"id"]==nil)
                {
                    continue;
                }
                else if ([reStr rangeOfString:[dic objectForKey:@"id"]].location!=NSNotFound)
                {


                        reStr = [reStr stringByReplacingOccurrencesOfString:[dic objectForKey:@"id"] 
                                                                 withString:[NSString stringWithFormat:@"%@", [dic objectForKey:@"targetname"]]];
      
                }
		}
	}
	
	return reStr;
}

- (NSString *)createNoLinkStr:(NSArray *)list withType:(LinkType)type
{
	NSString *reStr = nil;
	
	if ([self length]>0) 
	{
		reStr = [NSString stringWithString:self];
		
        if ([list count]==0)
        {
            return  reStr;
        }
        
		for (NSDictionary *dic in list)
		{
            if ([dic objectForKey:@"replaceToken"]==nil) 
            {
                continue;
            }
			else if ([reStr rangeOfString:[dic objectForKey:@"replaceToken"]].location!=NSNotFound)
			{
                reStr = [reStr stringByReplacingOccurrencesOfString:[dic objectForKey:@"replaceToken"] 
                                                         withString:[NSString stringWithFormat:@"%@", [dic objectForKey:@"replaceValue"]]];	
            }
		}
	}
	
	return reStr;
}

+ (NSString *) md5: (NSString *) inPutText {
	const char *cStr = [inPutText UTF8String];
	unsigned char result[CC_MD5_DIGEST_LENGTH];
	CC_MD5(cStr, strlen(cStr), result);
	
	return [[NSString stringWithFormat: @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
			 result[0], result[1], result[2], result[3],
			 result[4], result[5], result[6], result[7],
			 result[8], result[9], result[10], result[11],
			 result[12], result[13], result[14], result[15]
			 ] lowercaseString];
}

+ (NSString *)getStrFromDistance:(NSInteger)distance
{
    NSString *reStr = [NSString stringWithFormat:@"%d米", distance];
    if (distance>=1000) 
    {
        NSString *tmp = [NSString stringWithFormat:@"%.1f", distance/1000.0];
        if ([tmp characterAtIndex:([tmp length]-1)] == '0') 
        {
            reStr = [NSString stringWithFormat:@"%.0f公里", distance/1000.0];
        }
        else
        {
            reStr = [NSString stringWithFormat:@"%.1f公里", distance/1000.0];
        }
        
    }
    return reStr;
}

+ (NSString *)getStrFromPrice:(float)price
{
    NSString *reStr = @"";
    NSString *tmp = [NSString stringWithFormat:@"%.1f", price];
    if ([tmp characterAtIndex:([tmp length]-1)] == '0') 
    {
        reStr = [NSString stringWithFormat:@"%.0f", price];
    }
    else
    {
        reStr = [NSString stringWithFormat:@"%.1f", price];
    }
    
    return reStr;
}

+ (NSString *)getDiscountFromOrgPrice:(CGFloat)orgPrice NowPrice:(CGFloat)nowPrice
{
    NSString    *reStr = @"0.1折";
    
    if (orgPrice==0)
    {
        return reStr;
    }
    CGFloat     percent = nowPrice/orgPrice;
    
    NSString    *tmp = [NSString stringWithFormat:@"%.2f", percent];  
    if ([tmp characterAtIndex:([tmp length]-1)]=='0')
    {
        reStr = [NSString stringWithFormat:@"%.0f折", percent*10];
    }
    else
    {
        reStr = [NSString stringWithFormat:@"%.1f折", percent*10];
    }
    
    if([reStr isEqualToString:@"0折"])
    {
        reStr = @"0.1折";
    }
    return reStr;
}



- (id)objectForKey:(id)aKey
{
    return nil;
}

- (NSUInteger)count
{
    return 0;
}


- (NSInteger)sinaCharacterLength
{
    int m = [self length];
    if (m<=0) {
        return 0;
    }

    float charcterLen = 0;
    
    for (int i = 0; i < m; i++)
    {
        unichar uni =[self characterAtIndex:i];
        
        if (uni>=0 && uni <=255)
        {
            charcterLen +=0.5;
        }
        else
        {
            charcterLen +=1.0;
        }
//        NSLog(@"charcterLen=%f",charcterLen);
//        NSLog(@"charcterlen=%u",uni);
    }
    
    charcterLen +=0.5;
    NSLog(@"charcterLen=%f",charcterLen);
    
    return (int)charcterLen;
}

- (NSString*)getSinaStrLenWithNum:(int)num
{
    
    int m = [self length];
    if (m<=0)
    {
        return 0;
    }
    
    float charcterLen = 0;
    
    for (int i = 0; i < m; i++)
    {
        unichar uni =[self characterAtIndex:i];
        
        if (uni>=0 && uni <=255)
        {
            charcterLen +=0.5;
        }
        else
        {
            charcterLen +=1.0;
        }
    
        
        if ((int)(charcterLen+0.5) > num)
        {
            
            return [self substringWithRange:NSMakeRange(0, i)];
        }
        
    
    }

    return self;
    
}

@end
