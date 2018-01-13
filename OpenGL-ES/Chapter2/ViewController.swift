//
//  ViewController.swift
//  Chapter2
//
//  Created by zeek on 2017/12/16.
//  Copyright © 2017年 Zeek. All rights reserved.
//

import UIKit
import OpenGLES
import GLKit

struct SceneVertex {
    var positionCoords: GLKVector3
}

let vertices: [SceneVertex] = [SceneVertex(positionCoords: GLKVector3(v: (Float(-0.5), Float(0.5), Float(0)))),
                               SceneVertex(positionCoords: GLKVector3(v: (Float(0.5), Float(-0.5), Float(0)))),
                               SceneVertex(positionCoords: GLKVector3(v: (Float(-0.5), Float(-0.5), Float(0))))
]

class ViewController: GLKViewController {
    var baseEffect: GLKBaseEffect = GLKBaseEffect()
    var vertexBufferID:GLuint = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("MemoryLayout<[SceneVertex]>.size:\(MemoryLayout<[SceneVertex]>.size)")
        print("MemoryLayout<[SceneVertex]>.aligment:\(MemoryLayout<[SceneVertex]>.alignment)")
        print("MemoryLayout<[SceneVertex]>.size(:\(MemoryLayout<[SceneVertex]>.size(ofValue: vertices))")
        print("MemoryLayout<[SceneVertex]>.stride(:\(MemoryLayout<[SceneVertex]>.alignment(ofValue: vertices))")
        print("MemoryLayout<[SceneVertex]>.aligment(:\(MemoryLayout<[SceneVertex]>.alignment)")
        print("MemoryLayout<SceneVertex>.size:\(MemoryLayout<SceneVertex>.size)")
        print("v.size:\(MemoryLayout<SceneVertex>.size * GLsizeiptr(vertices.count))")
        
        guard let glkView = self.view as? GLKView else { return  }
        guard let context_openGLES2 = EAGLContext(api: .openGLES2) else { return }
        
        glkView.context = context_openGLES2
        EAGLContext.setCurrent(glkView.context)
        
    
        glClearColor(GLclampf(0), GLclampf(0), GLclampf(0), GLclampf(1))
        
        //Create
        //Bind
        //Copy
        glGenBuffers(1, &vertexBufferID)
        glBindBuffer(GLenum(GL_ARRAY_BUFFER), vertexBufferID)
        glBufferData(GLenum(GL_ARRAY_BUFFER),
                     MemoryLayout<SceneVertex>.size * GLsizeiptr(vertices.count),
                     vertices,
                     GLenum(GL_STATIC_DRAW))
    }
}

extension ViewController {

    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        baseEffect.prepareToDraw()
        
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
        
        glEnableVertexAttribArray(GLuint(GLKVertexAttrib.position.rawValue))
        
        glVertexAttribPointer(GLuint((GLKVertexAttrib.position).rawValue),
                              GLint(3),
                              GLenum(GL_FLOAT),
                              GLboolean(GL_FALSE),
                              GLsizei(MemoryLayout<SceneVertex>.size),
                              nil)
        
        glDrawArrays(GLenum(GL_TRIANGLES), GLint(0), GLsizei(vertices.count))
    }
    
}

