//
//  Fance.swift
//  AR Template
//
//  Created by Nikita on 02/11/2018.
//  Copyright © 2018 Nikita Petrenkov. All rights reserved.
//

import Foundation
import SceneKit

// Создаём забор по периметру
func perimeter (boxNode: SCNNode) {
    
    // Создаём единичый забор
    func loadFence () -> SCNNode {
        let fenceNode = SCNNode()
        let fence = SCNBox(width: 0.02, height: 0.3, length: 0.001, chamferRadius: 0)
        fence.firstMaterial?.diffuse.contents = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
        fenceNode.geometry = fence
        
        // Вершина единичного забора
        let pyramidNode = SCNNode()
        let pyramid = SCNPyramid(width: 0.02, height: 0.05, length: 0.001)
        pyramid.firstMaterial?.diffuse.contents = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        pyramidNode.geometry = pyramid
        fenceNode.addChildNode(pyramidNode)
        pyramidNode.position.y += 0.151
        
        return fenceNode
    }

    // Забор спереди
    for x in stride(from: Float(-2.5), to: 2.5, by: 0.02) {
        let node = loadFence()
        node.position.x = x
        node.position.y -= 0.35
        node.position.z += 1.5
        
        boxNode.addChildNode(node)
    }
    
    // Забор сзади
    for x in stride(from: Float(-2.5), to: 2.5, by: 0.02) {
        let node = loadFence()
        node.position.x = x
        node.position.y -= 0.35
        node.position.z -= 1.5
        
        boxNode.addChildNode(node)
    }
    
    // Забор слева
    for z in stride(from: Float(-1.5), to: 1.5, by: 0.02) {
        let node = loadFence()
        node.position.z = z
        node.position.y -= 0.35
        node.position.x -= 2.5
        node.eulerAngles.y -= .pi/2
        
        boxNode.addChildNode(node)
    }
    
    // Забор справа
    for z in stride(from: Float(-1.5), to: 1.5, by: 0.02) {
        let node = loadFence()
        node.position.z = z
        node.position.y -= 0.35
        node.position.x += 2.5
        node.eulerAngles.y += .pi/2
        
        boxNode.addChildNode(node)
    }
}
