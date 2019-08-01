////
////  statistics.m
////  SXWDemo
////
////  Created by XiaoXi on 2019/7/19.
////  Copyright © 2019 Xiaopoxi. All rights reserved.
////
//
//#import "statistics.h"
//
///*
// 
//  
// 
//  key值-Value值对应关系:
// 
//    界面名称:----访问次数
// 
//    1界面名称----进入界面时刻
// 
//    2界面名称-----离开界面时刻
// 
//    界面名称histime------界面停留历史时间
// 
//    界面名称time--------界面停留总时间
// 
//    界面名称oppositeTime----相对时间
// 
//  */
//
//
//@implementation statistics
//
//
//
//#pragma mark-
//
//#pragma mark 统计次数
//
//+(void)staticsvisitTimesDataWithViewControllerType:(NSString *)type
//
//{
//    
//    
//    
//        NSString * timesStart=[ZJDataSaver getStringForKey:type]?[ZJDataSaver getStringForKey:type]:nil;
//    
//        int add=[timesStart intValue];
//    
//        add++;
//    
//        [ZJDataSaver saveString:[NSString stringWithFormat:@"%d",add] forKey:type];
//    
//        
//    
//}
//
//+(void)staticsstayTimeDataWithType:(NSString *)type WithController:(NSString *)name//计算一次在该界面停留的时间
//
//{
//    
//        switch ([type intValue]) {
//            
//                    case 1://用来获取进入界面的时刻
//            
//                    {
//                
//                        
//                
//                            NSDate * date=[NSDate date];
//                
//                            NSString * dateStr=[NSString stringWithFormat:@"%0.f",[date timeIntervalSince1970]];
//                
//                            [ZJDataSaver saveString:dateStr forKey:[NSString stringWithFormat:@"%@%@",type,name]];
//                
//                        }
//            
//                        
//            
//                        break;
//            
//                        
//            
//                    case 2://用来获取离开界面的时刻    /**/
//            
//                        
//            
//                        
//            
//                
//            
//                    {
//                
//                            NSDate * date=[NSDate date];
//                
//                            NSString * dateStr=[NSString stringWithFormat:@"%0.f",[date timeIntervalSince1970]];
//                
//                            [ZJDataSaver saveString:dateStr forKey:[NSString stringWithFormat:@"%@%@",type,name]];
//                
//                            NSString * startTime=[ZJDataSaver getStringForKey:[NSString stringWithFormat:@"%@%@",@"1",name]]?[ZJDataSaver getStringForKey:[NSString stringWithFormat:@"%@%@",@"1",name]]:@"0";//进入界面时间
//                
//                            NSString * endTime=[ZJDataSaver getStringForKey:[NSString stringWithFormat:@"%@%@",@"2",name]]?[ZJDataSaver getStringForKey:[NSString stringWithFormat:@"%@%@",@"2",name]]:@"0";;//离开界面时间
//                
//                            long  time=0;
//                
//                            if([endTime longLongValue]==0)
//                    
//                                {
//                        
//                                        time=0;
//                        
//                                        [ZJDataSaver removeStringForKey:[NSString stringWithFormat:@"%@%@",@"1",name]];//移除开始时间
//                        
//                                        [ZJDataSaver removeStringForKey:[NSString stringWithFormat:@"%@%@",@"2",name]];
//                        
//                                        
//                        
//                                    }
//                
//                            else
//                    
//                                {
//                        
//                                        time=[endTime longLongValue]-[startTime longLongValue];
//                        
//                                        [ZJDataSaver removeStringForKey:[NSString stringWithFormat:@"%@%@",@"1",name]];
//                        
//                                        [ZJDataSaver removeStringForKey:[NSString stringWithFormat:@"%@%@",@"2",name]];
//                        
//                                    }
//                
//                            
//                
//                            
//                
//                            NSString * hisTime=[ZJDataSaver getStringForKey:[NSString stringWithFormat:@"%@histime",name]];//历史时间
//                
//                            long ZTime=[hisTime longLongValue]+time;
//                
//                            NSString * Time=[NSString stringWithFormat:@"%ld",ZTime];//该界面的总时间
//                
//                            [ZJDataSaver saveString:Time forKey:[NSString stringWithFormat:@"%@time",name]];//存储总时间
//                
//                            [ZJDataSaver saveString:Time forKey:[NSString stringWithFormat:@"%@histime",name]];//存储历史时间
//                
//                 
//                
//                        }
//            
//                        break;
//            
//                    default:
//            
//                        break;
//            
//            }
//    
//        
//    
//}
//
//+(NSString *)staticsTimeDataWithController:(NSString *)name
//
//{
//    
//        
//    
//        NSString * hisTime=[ZJDataSaver getStringForKey:[NSString stringWithFormat:@"%@histime",name]];//历史时间
//    
//        NSString * startTime=[ZJDataSaver getStringForKey:[NSString stringWithFormat:@"%@%@",@"1",name]]?[ZJDataSaver getStringForKey:[NSString stringWithFormat:@"%@%@",@"1",name]]:@"0";//进入界面时间
//    
//        long oppositeTime=[hisTime longLongValue]-[startTime longLongValue];//相对时间,针对只有开始时间,一直停留在该界面的处理情况
//    
//        NSDate * date=[NSDate date];
//    
//        NSString * dateStr=[NSString stringWithFormat:@"%0.f",[date timeIntervalSince1970]];
//    
//        long time=[dateStr longLongValue]+oppositeTime;
//    
//        //[ZJDataSaver saveString:[NSString stringWithFormat:@"%ld",time] forKey:[NSString stringWithFormat:@"%@ztime",name]];
//    
//        [ZJDataSaver saveString:dateStr forKey:[NSString stringWithFormat:@"%@%@",@"1",name]];
//    
//        [statistics staticsvisitTimesDataWithViewControllerType:name];
//    
//        return [NSString stringWithFormat:@"%ld",time];
//    
//    
//    
//}
//
//+(NSString *)getStayTime:(NSString *)controller
//
//{
//    
//        NSString * time=[ZJDataSaver getStringForKey:[NSString stringWithFormat:@"1%@",controller]]&&![ZJDataSaver getStringForKey:[NSString stringWithFormat:@"2%@",controller]]?[statistics staticsTimeDataWithController:[NSString stringWithFormat:@"%@",controller]]:[ZJDataSaver getStringForKey:[NSString stringWithFormat:@"%@time",controller]];
//    
//        return time;
//    
//        
//    
//}
//
//+(void)removeLocalDataWithController:(NSString *)name
//{
//    [ZJDataSaver removeStringForKey:[NSString stringWithFormat:@"%@",name]];
//    
//    [ZJDataSaver removeStringForKey:[NSString stringWithFormat:@"%@time",name]];
//
//    [ZJDataSaver removeStringForKey:[NSString stringWithFormat:@"%@histime",name]];
//    
//       Save(@"",@"StaticsArray");
//    
//       Remove(@"StaticsArray");
//    
//        
//    
//        
//    
//}
//
//+(NSDictionary *)packageDictionary:(NSString *)name WithType:(NSString *)type//打包字典
//
//{
//    
//        NSString * time=[statistics getStayTime:[NSString stringWithFormat:@"%@",name]];//判断是否一直停留在该界面,离开取总时间,停留取相对时间
//    
//        
//    
//        NSMutableArray * dataArray=Get(@"StaticsArray")?Get(@"StaticsArray"):[NSMutableArray array];
//    
//        NSDictionary * dic=@{@"visitName":[NSString stringWithFormat:@"%@",name],@"visitType":[NSString stringWithFormat:@"%@",type],@"visitTimes":[ZJDataSaver getStringForKey:[NSString stringWithFormat:@"%@",name]]?[ZJDataSaver getStringForKey:[NSString stringWithFormat:@"%@",name]]:@"0",@"staySeconds":time?time:@"0"};
//    
//        [dataArray addObject:dic];
//    
//        Save(dataArray, @"StaticsArray");
//    
//        NSDictionary * BigDic=@{@"list":dataArray};
//    
//        return BigDic;
//    
//}
//
//
//@end
