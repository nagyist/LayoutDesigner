//
//  LMMessageParamImage.h
//  LaMo
//
//  Created by Ved Surtani on 12/09/11.
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
//


#import "TypeAdapter.h"

/*!
 @class     UIImageAdapter
 @brief     Adapter for UIImage. This adapts a UIImage to an NSImage and vice versa. 
 @details   This adapter is used to transfer images from LDClient to LDServer and vice versa. The underlying imageData is wrapped here images are 
 reconstructed using the imageData.
 */
@interface UIImageAdapter : NSObject<TypeAdapter>
{
    NSData *imageData;
    
    @private
    UIImage *image;
}

/*!
 @property      imageData
 @brief         the image data which is used for reconstructing an image.
 @details       for passing/receiving images to/from remote process this adapter is used. To send an image, create an instance of this adapter, set the 
 imageData and send it.
 */
@property(nonatomic,strong)NSData *imageData;
@end
