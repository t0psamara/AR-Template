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
        
        // Показывает начало координат
        // sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin]
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Показывает статистику на экране
        sceneView.showsStatistics = true
        
        // Создание новой сцены
        let scene = SCNScene(named: "art.scnassets/campus.scn")!
        
        // Присваиваем эту сцену свойству "сцена" нашего ARSCNview
        sceneView.scene = scene
        
        loadCampus()
        loadCampusCode()
    }
    
    // Загружает модель из конструктора
    func loadCampus () {
        // Создание новой сцены
        let scene = SCNScene(named: "art.scnassets/campus.scn")!
        // Присваиваем эту сцену свойству "сцена" нашего ARSCNview
        sceneView.scene = scene
    }
    
    
    // Загружает модель из кода
    func loadCampusCode () {
        
        // Создаём начальный узел
        let nodeCode = SCNNode()
        // Даём координаты узлу
        nodeCode.position = SCNVector3 (x: 0, y: -1, z: -3)
        nodeCode.scale = SCNVector3 (x: 0.5, y: 0.5, z: 0.5)
        
        
        //создаём стены дома, размер и цвет
        let boxNode = SCNNode()
        let steni = SCNBox(width: 3, height: 1, length: 1, chamferRadius: 0)
        //let color = color Literal
        steni.firstMaterial?.diffuse.contents = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)             // Также можно присвоить текстуру через UIImage
        steni.firstMaterial?.isDoubleSided = true              // Делаем траву двусторонней
        boxNode.geometry = steni                               // Добавляем геометрию узлу
        boxNode.position.y += 0.001                            // Смещаем чуть выше, чтобы с травой не накладывалось
        
        
        // Добавляем траву
        let planeNode = SCNNode()
        let trava = SCNPlane(width: 5, height: 3)
        trava.firstMaterial?.diffuse.contents = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        planeNode.geometry = trava
        planeNode.eulerAngles.x -= .pi/2                       // Поворачиваем на 90 градусов. Если не видно, то повернуто не той стороной
        planeNode.position.y -= 0.5                            // Опускаем на полметра
        
        let treeNode = loadTree()
        treeNode.position = SCNVector3(2, 0, 0.251)

        // Добавляем забор
        perimeter(boxNode: boxNode)

        nodeCode.addChildNode(boxNode)                         // Добавляем Стены к узлу
        nodeCode.addChildNode(planeNode)                       // Добавляем Траву к узлу
        planeNode.addChildNode(treeNode)                       // Добавляем Дерево к узлу (траве)
        
        sceneView.scene.rootNode.addChildNode(nodeCode)        // Добавляем узел к верхнему узлу
    }
    
    // Создаём дерево целиком
    func loadTree () -> SCNNode {
        
        // Создаём ствол
        let stvolNode = SCNNode()
        let stvol = SCNCylinder(radius: 0.05, height: 0.5)
        stvol.firstMaterial?.diffuse.contents = #colorLiteral(red: 0.3098039329, green: 0.2039215714, blue: 0.03921568766, alpha: 1)
        stvolNode.geometry = stvol
        stvolNode.scale = SCNVector3 (1, 1, 1)
        stvolNode.eulerAngles.x += .pi/2
        
        // Создаём крону
        let cronaNode = SCNNode()
        let crona = SCNSphere(radius: 0.2)
        crona.firstMaterial?.diffuse.contents = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        cronaNode.geometry = crona
        cronaNode.position = SCNVector3(0, 0.4, 0)
        
        stvolNode.addChildNode(cronaNode)
        
        return stvolNode
    }
        
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Создает сессию, которая следит за положением телефона в ОС и положение камеры
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
