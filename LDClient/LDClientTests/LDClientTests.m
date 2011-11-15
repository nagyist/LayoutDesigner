//
//  LDClientTests.m
//  LDClientTests
//
//  Created by Ved Surtani on 05/10/11.
//  Copyright 2011 Imaginea 
//  Licensed under the Apache License, Version 2.0 (the "License");
//    you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at

//  http://www.apache.org/licenses/LICENSE-2.0

//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

#import "LDClientTests.h"
#import "LDPropertyMap.h"
#import "LDProperty.h"
#import "LDCommandMap.h"
#import "DefaultCommandHandler.h"

@implementation LDClientTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
    [LDClient start];

}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

-(void)testLDClientSharedInstance
{
    LDClient *client = [LDClient sharedInstance];
    STAssertNotNil(client, @"client is nil");
}

//tests if all the commands have handlers.
-(void)testCommandHandlerInitialization
{
    //the map should have handlers for all.
}




@end
