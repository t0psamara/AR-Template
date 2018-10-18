//
//  ViewController.swift
//  AR Template
//
//  Created by Nikita on 18.10.2018.
//  Copyright © 2018 Nikita Petrenkov. All rights reserved.
//

import UIKit      // Разные элементы на экране
import SceneKit   // Бибилиотека для создания 3D моделей
import ARKit      // Библиотека помещает 3D модели в дополненную реальность

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!   // наследник UIView. Область, где происходит действие моделей
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Показывает статистику на экране
        sceneView.showsStatistics = true
        
        // Создание новой сцены
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Присваиваем эту сцену свойству "сцена" нашего ARSCNview
        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Создает сессию, которая следить за положением телефона в ОС и положение камеры
        let configuration = ARWorldTrackingConfiguration()

        // Запускает эту сессию
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Ставит сессию на паузу
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
