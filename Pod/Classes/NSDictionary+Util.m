//
//  NSDictionary+Util.m
//  Pods
//
//  Created by Tanner on 2/15/16.
//
//

#import "NSDictionary+Util.h"

@implementation NSDictionary (Util)

- (NSString *)JSONString {
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:0 error:nil];
    return data ? [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] : @"{}";
}

- (NSArray *)split:(NSUInteger)entryLimit {
    NSParameterAssert(entryLimit > 0);
    if (self.allKeys.count <= entryLimit)
        return @[self];
    
    NSMutableArray *dicts = [NSMutableArray array];
    __block NSMutableDictionary *tmp = [NSMutableDictionary dictionary];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        tmp[key] = obj;
        if (tmp.allKeys.count % entryLimit == 0) {
            [dicts addObject:tmp];
            tmp = [NSMutableDictionary dictionary];
        }
    }];
    
    return dicts;
}

- (NSDictionary *)dictionaryByReplacingValuesForKeys:(NSDictionary *)dictionary {
    if (!dictionary || !dictionary.allKeys.count || !self) return self;
    
    NSMutableDictionary *m = self.mutableCopy;
    [m setValuesForKeysWithDictionary:dictionary];
    return m.copy;
}

- (NSDictionary *)dictionaryByReplacingKeysWithNewKeys:(NSDictionary *)oldKeysToNewKeys {
    if (!oldKeysToNewKeys || !oldKeysToNewKeys.allKeys.count || !self) return self;
    
    NSMutableDictionary *m = self.mutableCopy;
    [oldKeysToNewKeys enumerateKeysAndObjectsUsingBlock:^(NSString *oldKey, NSString *newKey, BOOL *stop) {
        id val = m[oldKey];
        m[oldKey] = nil;
        m[newKey] = val;
    }];
    
    return m;
}

- (NSArray *)allKeyPaths {
    NSMutableArray *keyPaths = [NSMutableArray array];
    
    [self enumerateKeysAndObjectsUsingBlock:^(NSString *key, id obj, BOOL *stop) {
        [keyPaths addObject:key];
        
        if ([obj isKindOfClass:[NSDictionary class]]) {
            for (NSString *kp in [obj allKeyPaths])
                [keyPaths addObject:[NSString stringWithFormat:@"%@.%@", key, kp]];
        }
    }];
    
    return keyPaths.copy;
}

@end
