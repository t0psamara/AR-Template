//
//  Perimeter.swift
//  AR Template
//
//  Created by Nikita on 30/10/2018.
//  Copyright © 2018 Nikita Petrenkov. All rights reserved.
//

import Foundation
import UIKit      // Разные элементы на экране
import SceneKit   // Бибилиотека для создания 3D моделей
import ARKit      // Библиотека помещает 3D модели в дополненную реальность

// Создаём забор
func loadFence () -> SCNNode {
    let fenceNode = SCNNode()
    let fence = SCNBox(width: 0.02, height: 0.3, length: 0.001, chamferRadius: 0)
    fence.firstMaterial?.diffuse.contents = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
    fence.firstMaterial?.isDoubleSided = true
    fenceNode.geometry = fence
    fenceNode.position = SCNVector3(x: 2.5, y: -0.35, z: 1.5)
    
    return fenceNode
}



func perimeter (width: Float, by: Float, node: SCNNode, parentNode: SCNNode) {
    
    let n = node
    //    if by = 0 {
    //        by = n.
    //    }
    
    if width != 0 && by != 0 {
        for x in stride(from: n.position.x, to: width, by: by) {
            guard x != n.position.x else { continue }
            let node = n
            node.position.x = x
            node.position.y = n.position.y
            node.position.z = n.position.z
            
            parentNode.addChildNode(node)
        }
        
    }
}
