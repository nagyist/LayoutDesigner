//
//  TypeAdapter.h
//  LDClient
//
//  Created by Ved Surtani on 04/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 @protocol      TypeAdapter
 @brief         Protocol for ObjC type adapters that will hold single value of the type they are adapting to. 
 All adapters should also implement NSCoding and NSCopying protocols.
 @details       TypeAdapters are for wrapping the objC types to facilitate serialization across LDServer(Mac OS platform) and LDClient (iPhone).
 These Adapters can hold any type, primitives, structures or complex objects. NSCoding methods should be implemented by adapters for serialization.
 NSCopying is expected by LDClient for it's working. Example: an integer adapter will hold an integer value and make sure it gets encoded and 
 decoded properly.
 */
@protocol TypeAdapter <NSObject,NSCoding,NSCopying>
@required
/*!
 @brief     this method should return the value of the type that Adapter holds.
 @details   Example: An adapter for integer should return the value of integer it holds.
 */
-(void*)value;
@end
