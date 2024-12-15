//
//  ViewController.swift
//  Motion
//
//  Created by Alan Ulises on 14/12/24.
//

import UIKit
import SVGKit

class ViewController: UIViewController {
    
    var objetivo: UIImageView!
    var moviendo: UIImageView!
    var refX: CGFloat = 0.0
    var refY: CGFloat = 0.0
    var addMotion : 

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let W = self.view.bounds.width / 3
        let H = self.view.bounds.height / 6
        
        objetivo = UIImageView(frame: CGRect(x:0,y:0, width:W, height:H))
        objetivo.center = self.view.center
        objetivo.image = SVGKImage(named:"beer-mug-empty").uiImage
        self.view.addSubview(objetivo)
        
        
    }


}

