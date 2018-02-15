//
//  TopGamesViewController.swift
//  Teste Zap Viva Real
//
//  Created by Bruno Rodrigues de Andrade on 12/02/18.
//  Copyright © 2018 Bruno Rodrigues de Andrade. All rights reserved.
//

import UIKit
import Foundation
import NVActivityIndicatorView


private let reuseIdentifier = "gameCell"


private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)


class TopGamesViewController: UICollectionViewController, UITabBarControllerDelegate {
   
    
    fileprivate let itemsPerRow: CGFloat = 2
    private let requestService = RequestService()
    private var gameList = [Game]()
    private let searchController = UISearchController(searchResultsController: nil)
    var filtered:[Game] = []
    var searchActive : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadData()
        configureSearchBar()
        collectionView?.delegate = self
        collectionView?.dataSource = self
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.updateConstraints()
        
//        self.starIconButton.imageView?.tintColor = UIColor.yellow
//        self.loadView()
    }
    
    override func viewWillLayoutSubviews() {
        
    }
    
    override func viewDidLayoutSubviews() {
        
        
    }
    
    private func reloadData() {
        let loadingView = UICollectionViewController.displaySpinner(onView: self.view)
        requestService.getTopGames(completion: { [weak self] result in

            UICollectionViewController.removeSpinner(loadingView)
            switch result {
            case let .error(error):
                print("Error: \(error)")
                break
            case let .success(gameList):
                self?.gameList = gameList
                self?.collectionView?.reloadData()
                print("Sucesso")
                break
            }
        })
    }
    
    private func configureSearchBar() {
        self.searchController.searchResultsUpdater = self
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = true
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search"
        self.searchController.searchBar.sizeToFit()
        
        self.searchController.searchBar.becomeFirstResponder()
        
//        self.navigationItem.titleView = self.searchController.searchBar
        self.navigationItem.searchController = self.searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? TopGamesDetailViewController {
            let cell = sender as! TopGamesCollectionViewCell
            guard let indexPath = self.collectionView?.indexPath(for: cell) else {return}
            vc.nameGameStr = cell.gameNameLabel.text
            vc.image = cell.gameLogoView.image
            vc.viewersStr = "Número de vizualizações: \(self.gameList[indexPath.item].viewers!)"
            
        }
        
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if !searchActive {
            return self.gameList.count
        }
        else {
            return self.filtered.count
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TopGamesCollectionViewCell
        let game: Game
        if !searchActive {
            game = self.gameList[indexPath.item]
        }
        else {
            game = self.filtered[indexPath.item]
        }
        cell.starIconButton.tintColor = UIColor.yellow
        cell.gameNameLabel.text = "#\(indexPath.item+1) \(game.name!)"
        cell.gameLogoView.image = game.logoImage
        cell.game = game
        // Configure the cell
    
        return cell
    }
    

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

extension TopGamesViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}


extension TopGamesViewController: UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        self.dismiss(animated: true, completion: nil)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchString = searchController.searchBar.text
    
        filtered = self.gameList.filter({ (item) -> Bool in
            if let countryText: NSString = item.name as NSString? {
                return (countryText.range(of: searchString!, options: NSString.CompareOptions.caseInsensitive).location) != NSNotFound
            }
            else {
                return false
            }
        })
        self.collectionView?.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
        self.collectionView?.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        self.collectionView?.reloadData()
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        if !searchActive {
            searchActive = true
            self.collectionView?.reloadData()
        }
        searchController.searchBar.resignFirstResponder()
    }
}




