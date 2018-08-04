//
//  AppDelegate.h
//  FleetingTime
//
//  Created by 许爱爱 on 2018/8/4.
//  Copyright © 2018年 X. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

