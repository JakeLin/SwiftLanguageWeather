//
//  OptionsViewController.swift
//  SwiftWeather
//
//  Created by kenneth carmichael on 2016-04-07.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import Foundation

import UIKit

class OptionsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let reuseIdentifier = "cell" // also enter this string as the cell identifier in the storyboard
    var images = ["badGrass", "badBeach", "snowy", "clouds" ]
    var selected = String()
    @IBOutlet weak var mylabel: UILabel!
    
    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    // make a cell for each cell index path
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MyCollectionViewCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        cell.myImage.image = UIImage(named:self.images[indexPath.item])!
        cell.backgroundColor = UIColor.yellowColor() // make cell more visible in our example project
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // handle tap events
        selected = images[indexPath.item]
        print("You selected cell #\(indexPath.item)!")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let DestViewController : WeatherViewController = segue.destinationViewController as! WeatherViewController
        
        DestViewController.text = selected
        
        
    }
}