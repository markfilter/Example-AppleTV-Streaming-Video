//
//  ViewController.swift
//  AppleTV Stream
//
//  Created by Mark Filter on 2/19/18.
//  Copyright © 2018 Mark Filter. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Mark: - Outlets & Variables
    public let TAG: String = "ViewController.TAG"
    @IBOutlet var tableViewStudios: UITableView!
    @IBOutlet var collectionViewVideos: UICollectionView!
    var currentlySelectedStudioIndex : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup
        setupTableView()
        setupCollectionView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupTableView() {
        // Set Delegates
        tableViewStudios.delegate = self
        tableViewStudios.dataSource = self
    }
    
    func setupCollectionView() {
        collectionViewVideos.delegate = self
        collectionViewVideos.dataSource = self
    }

}

extension ViewController : UITableViewDelegate {
    
}

extension ViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RemoteVideoResources.studio.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AppConstants.REUSE_ID_VC1_TV1, for: indexPath) as UITableViewCell
        
        cell.textLabel?.text = RemoteVideoResources.studio[indexPath.row]
        
        return cell
    }
    
}


extension ViewController : UICollectionViewDelegate {
    
}

extension ViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return RemoteVideoResources.titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewVideos.dequeueReusableCell(withReuseIdentifier: AppConstants.REUSE_ID_VC1_CV1, for: indexPath) as! TitlesCollectionViewCell
        
        if let url = URL.init(string: RemoteVideoResources.cardImageUrl[indexPath.row]) {
            cell.setImageView(url: url)
        }
        
        return cell
    }
    
}









