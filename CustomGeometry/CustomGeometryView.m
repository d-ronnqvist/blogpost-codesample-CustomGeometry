//
//  CustomGeometryView.m
//  CustomGeometry
//
//  Created by David Rönnqvist on 6/3/13.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of
// this software and associated documentation files (the "Software"), to deal in the
// Software without restriction, including without limitation the rights to use, copy,
// modify, merge, publish, distribute, sublicense, and/or sell copies of the Software,
// and to permit persons to whom the Software is furnished to do so, subject to the
// following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
// INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
// PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
// HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
// SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


#import "CustomGeometryView.h"

@implementation CustomGeometryView
- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
	self.backgroundColor = [NSColor whiteColor];
    
    // ==== SCENE CREATION ==== //
    
    // An empty scene
    SCNScene *scene = [SCNScene scene];
    self.scene = scene;
    
	// A camera
    // --------
    // The camera is moved back and up from the center of the scene
    // and then rotated so that it looks down to the center
	SCNNode *cameraNode = [SCNNode node];
	cameraNode.camera = [SCNCamera camera];
	cameraNode.position = SCNVector3Make(0, 12, 30);
    cameraNode.transform = CATransform3DRotate(cameraNode.transform,
                                               -M_PI/7.0,
                                               1, 0, 0);
    
    [scene.rootNode addChildNode:cameraNode];
	
    // A spot light
    // ------------
    // The spot light is positioned right next to the camera
    // so it is offset sligthly and added to the camera node
    SCNLight *spotLight = [SCNLight light];
    spotLight.type = SCNLightTypeSpot;
    spotLight.color = [NSColor whiteColor];
	SCNNode *spotLightNode = [SCNNode node];
	spotLightNode.light = spotLight;
    spotLightNode.position = SCNVector3Make(-2, 1, 0);
    
    [cameraNode addChildNode:spotLightNode];
    
    
    
/*
   ____          _                                                    _
  / ___|   _ ___| |_ ___  _ __ ___     __ _  ___  ___  _ __ ___   ___| |_ _ __ _   _
 | |  | | | / __| __/ _ \| '_ ` _ \   / _` |/ _ \/ _ \| '_ ` _ \ / _ \ __| '__| | | |
 | |__| |_| \__ \ || (_) | | | | | | | (_| |  __/ (_) | | | | | |  __/ |_| |  | |_| |
  \____\__,_|___/\__\___/|_| |_| |_|  \__, |\___|\___/|_| |_| |_|\___|\__|_|   \__, |
                                       |___/                                    |___/
      _             _         _
  ___| |_ __ _ _ __| |_ ___  | |__   ___ _ __ ___
 / __| __/ _` | '__| __/ __| | '_ \ / _ \ '__/ _ \
 \__ \ || (_| | |  | |_\__ \ | | | |  __/ | |  __/  _   _   _
 |___/\__\__,_|_|   \__|___/ |_| |_|\___|_|  \___| (_) (_) (_)
 
 */
    
    // Custom geometry for a cube
    // --------------------------
    // A square box is positioned in the center of the scene (default)
    // and given a small rotation around Y to highlight the perspective.
    CGFloat cubeSide = 15.0;
    CGFloat halfSide = cubeSide/2.;
    
    SCNVector3 positions[] = {
        SCNVector3Make(-halfSide, -halfSide,  halfSide),
        SCNVector3Make( halfSide, -halfSide,  halfSide),
        SCNVector3Make(-halfSide, -halfSide, -halfSide),
        SCNVector3Make( halfSide, -halfSide, -halfSide),
        SCNVector3Make(-halfSide,  halfSide,  halfSide),
        SCNVector3Make( halfSide,  halfSide,  halfSide),
        SCNVector3Make(-halfSide,  halfSide, -halfSide),
        SCNVector3Make( halfSide,  halfSide, -halfSide),
        
        // repeat exactly the same
        SCNVector3Make(-halfSide, -halfSide,  halfSide),
        SCNVector3Make( halfSide, -halfSide,  halfSide),
        SCNVector3Make(-halfSide, -halfSide, -halfSide),
        SCNVector3Make( halfSide, -halfSide, -halfSide),
        SCNVector3Make(-halfSide,  halfSide,  halfSide),
        SCNVector3Make( halfSide,  halfSide,  halfSide),
        SCNVector3Make(-halfSide,  halfSide, -halfSide),
        SCNVector3Make( halfSide,  halfSide, -halfSide),
        
        // repeat exactly the same
        SCNVector3Make(-halfSide, -halfSide,  halfSide),
        SCNVector3Make( halfSide, -halfSide,  halfSide),
        SCNVector3Make(-halfSide, -halfSide, -halfSide),
        SCNVector3Make( halfSide, -halfSide, -halfSide),
        SCNVector3Make(-halfSide,  halfSide,  halfSide),
        SCNVector3Make( halfSide,  halfSide,  halfSide),
        SCNVector3Make(-halfSide,  halfSide, -halfSide),
        SCNVector3Make( halfSide,  halfSide, -halfSide)
    };
    
    SCNVector3 normals[] = {
        
        SCNVector3Make( 0, -1, 0),
        SCNVector3Make( 0, -1, 0),
        SCNVector3Make( 0, -1, 0),
        SCNVector3Make( 0, -1, 0),
        
        SCNVector3Make( 0, 1, 0),
        SCNVector3Make( 0, 1, 0),
        SCNVector3Make( 0, 1, 0),
        SCNVector3Make( 0, 1, 0),
        
        
        SCNVector3Make( 0, 0,  1),
        SCNVector3Make( 0, 0,  1),
        SCNVector3Make( 0, 0, -1),
        SCNVector3Make( 0, 0, -1),
        
        SCNVector3Make( 0, 0, 1),
        SCNVector3Make( 0, 0, 1),
        SCNVector3Make( 0, 0, -1),
        SCNVector3Make( 0, 0, -1),
        
        
        SCNVector3Make(-1, 0, 0),
        SCNVector3Make( 1, 0, 0),
        SCNVector3Make(-1, 0, 0),
        SCNVector3Make( 1, 0, 0),
        
        SCNVector3Make(-1, 0, 0),
        SCNVector3Make( 1, 0, 0),
        SCNVector3Make(-1, 0, 0),
        SCNVector3Make( 1, 0, 0),
    };
    
    
    // The indices for the 12 triangles that make up the cubes sides
    // Note the ordering to control the frontside and backside of each
    // surface. 
    
    int indices[] = {
        // bottom
        0, 2, 1,
        1, 2, 3,
        // back
        10, 14, 11,  // 2, 6, 3,   + 8
        11, 14, 15,  // 3, 6, 7,   + 8
        // left
        16, 20, 18,  // 0, 4, 2,   + 16
        18, 20, 22,  // 2, 4, 6,   + 16
        // right
        17, 19, 21,  // 1, 3, 5,   + 16
        19, 23, 21,  // 3, 7, 5,   + 16
        // front
        8,  9, 12,  // 0, 1, 4,   + 8
        9, 13, 12,  // 1, 5, 4,   + 8
        // top
        4, 5, 6,
        5, 7, 6
    };
    
    
    // Create sources for the vertices and normals
    
    SCNGeometrySource *vertexSource =
    [SCNGeometrySource geometrySourceWithVertices:positions
                                            count:24];
    SCNGeometrySource *normalSource =
    [SCNGeometrySource geometrySourceWithNormals:normals
                                           count:24];
    
    


    
    NSData *indexData = [NSData dataWithBytes:indices
                                       length:sizeof(indices)];
    
    // Note that there is still only 12 indices for the 12 triangles
    // even though there are 24 vertices
    
    SCNGeometryElement *element =
    [SCNGeometryElement geometryElementWithData:indexData
                                  primitiveType:SCNGeometryPrimitiveTypeTriangles
                                 primitiveCount:12
                                  bytesPerIndex:sizeof(int)];
    
    
    SCNGeometry *geometry =
    [SCNGeometry geometryWithSources:@[vertexSource, normalSource]
                            elements:@[element]];
    
    
    // Give the cube a red colored material
    
    SCNMaterial *redMataterial = [SCNMaterial material];
    redMataterial.diffuse.contents = [NSColor redColor];

    geometry.materials = @[redMataterial];
    
    
    SCNNode *cubeNode = [SCNNode nodeWithGeometry:geometry];
    cubeNode.transform = CATransform3DMakeRotation(M_PI_2/3,
                                                   0, 1, 0);
    [scene.rootNode addChildNode:cubeNode];
}

@end
