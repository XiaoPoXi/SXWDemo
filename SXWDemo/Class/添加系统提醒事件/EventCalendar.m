//
//  EventCalendar.m
//  SXWDemo
//
//  Created by XiaoXi on 2019/8/1.
//  Copyright © 2019 Xiaopoxi. All rights reserved.
//

#import "EventCalendar.h"
#import <EventKit/EventKit.h>
#import <UIKit/UIKit.h>

@implementation EventCalendar


static EventCalendar *calendar;

+ (instancetype)sharedEventCalendar{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        calendar = [[EventCalendar alloc] init];
    });
    
    return calendar;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        calendar = [super allocWithZone:zone];
    });
    return calendar;
}

- (void)createEventCalendarTitle:(NSString *)title location:(NSString *)location startDate:(NSDate *)startDate endDate:(NSDate *)endDate allDay:(BOOL)allDay alarmArray:(NSArray *)alarmArray WithNotification:(NSString *)notification{
    __weak typeof(self) weakSelf = self;
    
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    
    if ([eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)])
    {
        [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error){
            
            dispatch_async(dispatch_get_main_queue(), ^{
                __strong typeof(weakSelf) strongSelf = weakSelf;
                if (error)
                {
                    [strongSelf showAlert:@"添加失败，请稍后重试"];
                    
                }else if (!granted){
                    [strongSelf showAlert:@"不允许使用日历,请在设置中允许此App使用日历"];
                    
                }else{
                    EKEvent *event  = [EKEvent eventWithEventStore:eventStore];
                    event.title     = title;
                    event.location = location;
                    
                    NSDateFormatter *tempFormatter = [[NSDateFormatter alloc]init];
                    [tempFormatter setDateFormat:@"dd.MM.yyyy HH:mm"];
                    
                    event.startDate = startDate;
                    event.endDate   = endDate;
                    event.allDay = allDay;
                    
                    //添加提醒
                    if (alarmArray && alarmArray.count > 0) {
                        
                        for (NSString *timeString in alarmArray) {
                            [event addAlarm:[EKAlarm alarmWithRelativeOffset:[timeString integerValue]]];
                        }
                    }
                    
                    [event setCalendar:[eventStore defaultCalendarForNewEvents]];
                    NSError *err;
                    [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
                    if (!error) {
                        [strongSelf showAlert:@"设置成功,提前3分钟提醒哦~"];
                        JMLog(@"添加时间成功");
                        //添加成功后需要保存日历关键字
                        NSString *iden = event.eventIdentifier;
                        // 保存在沙盒，避免重复添加等其他判断
                        [[NSUserDefaults standardUserDefaults] setObject:iden forKey:notification];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                    }
                    
                    
                }
            });
        }];
    }
}

- (void)deleteEventCalendarWithNotificition:(NSString *)notification
{
    EKEventStore *myEventStore = [[EKEventStore alloc] init];
    // 获取上面的这个ID呀。
    NSString *identifier = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"notification"]];
    EKEvent *event = [myEventStore eventWithIdentifier:identifier];
    
    __block BOOL isDeleted = NO;
    WeakSelf(weakSelf);
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSError *err = nil;
        
        isDeleted = [myEventStore removeEvent:event span:EKSpanThisEvent commit:YES error:&err];
        if (!err) {
            NSLog(@"删除日历成功");
            [weakSelf showAlert:@"删除提醒成功"];

            [[NSUserDefaults standardUserDefaults] removeObjectForKey:notification];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
    });
}


- (void)showAlert:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}



@end
