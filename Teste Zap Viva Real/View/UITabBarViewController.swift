//
//  UITabBarViewController.swift
//  Teste Zap Viva Real
//
//  Created by Bruno Rodrigues de Andrade on 14/02/18.
//  Copyright © 2018 Bruno Rodrigues de Andrade. All rights reserved.
//

import UIKit

class UITabBarViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        var tabOne = storyboard.instantiateViewController(withIdentifier: "gameViewController")
        tabOne = UINavigationController(rootViewController:tabOne )
        let tabOneItem = UITabBarItem(title: "Top Games", image: UIImage(named: "house") , selectedImage: UIImage(named: "house"))
        tabOne.tabBarItem = tabOneItem
        
        var tabTwo = storyboard.instantiateViewController(withIdentifier: "gameViewController")
        tabTwo = UINavigationController(rootViewController:tabTwo )
        let tabTwoItem = UITabBarItem(title: "Favoritos", image: UIImage(named: "black_star") , selectedImage: UIImage(named: "black_star"))
        tabTwo.tabBarItem = tabTwoItem
        
        self.viewControllers = [tabOne,tabTwo]
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
