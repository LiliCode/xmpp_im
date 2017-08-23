//
//  LogConfig.h
//  GAIA供应
//
//  Created by winter on 2017/8/20.
//  Copyright © 2017年 laidongling. All rights reserved.
//

#ifndef LogConfig_h
#define LogConfig_h

//输出条数日志，可以控制不输出

#define DEBUG_LOG (1)

#define XMPPLog(frmt, ...) do { if (DEBUG_LOG) NSLog((frmt), ##__VA_ARGS__); } while(0)

#define NSLog_debug(frmt, ...) XMPPLog((frmt), ##__VA_ARGS__)

#endif /* LogConfig_h */
