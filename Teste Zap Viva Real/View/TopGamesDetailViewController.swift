//
//  TopGamesDetailViewController.swift
//  Teste Zap Viva Real
//
//  Created by Bruno Rodrigues de Andrade on 13/02/18.
//  Copyright © 2018 Bruno Rodrigues de Andrade. All rights reserved.
//

import UIKit

class TopGamesDetailViewController: UIViewController {
    @IBOutlet weak var imageLogoView: UIImageView!
    @IBOutlet weak var nameGameLabel: UILabel!
    @IBOutlet weak var viewersLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var image: UIImage? = UIImage()
    var nameGameStr: String? = ""
    var viewersStr: String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameGameLabel.text = nameGameStr
        self.imageLogoView.image = image
        self.viewersLabel.text = viewersStr
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension TopGamesDetailViewController: UIScrollViewDelegate {
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            print("Landscape")
            scrollView.contentSize.height = self.view.bounds.size.height*2
        } else {
            print("Portrait")
            
        }
    }
}
