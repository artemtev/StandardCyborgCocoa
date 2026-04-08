// ZipArchive.h
// Minimal shim so StandardCyborgFusion can compile against the SSZipArchive API.
// The actual implementation is provided at link time by the SSZipArchive CocoaPods dependency.
#pragma once
#import <Foundation/Foundation.h>

@interface SSZipArchive : NSObject
+ (BOOL)createZipFileAtPath:(NSString *)path withContentsOfDirectory:(NSString *)directoryPath;
+ (BOOL)unzipFileAtPath:(NSString *)path toDestination:(NSString *)destination;
@end
