//
//  ViewController.swift
//  HuntTimehop
//
//  Created by thomas on 12/23/14.
//  Copyright (c) 2014 thomas. All rights reserved.
//

import UIKit

class ViewController: UITabBarController {
  
  let apiController = ApiController()
  var apiHuntsList: [ProductModel] = []
  var filterDate = NSDate().minusYears(1)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationController?.navigationBar.barTintColor = .white()
    navigationController?.navigationBar.tintColor = .orange()
    navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
    
    tabBar.tintColor = .orange()
    let storyboard = UIStoryboard(name: "TabBar", bundle: nil)
    let techVC = storyboard.instantiateViewControllerWithIdentifier("PostsViewController") as! PostsViewController
    let gamesVC = storyboard.instantiateViewControllerWithIdentifier("PostsViewController") as! PostsViewController
    let booksVC = storyboard.instantiateViewControllerWithIdentifier("PostsViewController") as! PostsViewController
    let podcastsVC = storyboard.instantiateViewControllerWithIdentifier("PostsViewController") as! PostsViewController
    viewControllers = [techVC, gamesVC, booksVC, podcastsVC]
    
    let techTabBarItem = UITabBarItem(title: "Tech", image: UIImage(named: "about"), selectedImage: UIImage(named: "close"))
    let gamesTabBarItem = UITabBarItem(title: "Games", image: UIImage(named: "about"), selectedImage: UIImage(named: "close"))
    let booksTabBarItem = UITabBarItem(title: "Books", image: UIImage(named: "about"), selectedImage: UIImage(named: "close"))
    let podcastsTabBarItem = UITabBarItem(title: "Podcasts", image: UIImage(named: "about"), selectedImage: UIImage(named: "close"))
    techVC.tabBarItem = techTabBarItem
    gamesVC.tabBarItem = gamesTabBarItem
    booksVC.tabBarItem = booksTabBarItem
    podcastsVC.tabBarItem = podcastsTabBarItem
  }
  
  @IBAction func filterButtonTapped(sender: UIBarButtonItem) {
    performSegueWithIdentifier("showFilterVC", sender: self)
  }
  
  @IBAction func aboutButtonTapped(sender: UIBarButtonItem) {
    performSegueWithIdentifier("showAboutVC", sender: self)
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "popoverFilterVC" {
      let filterVC = segue.destinationViewController as! FilterViewController
      filterVC.mainVC = self
      filterVC.modalPresentationStyle = .Popover
      filterVC.popoverPresentationController!.delegate = self
    }
  }
  
}


// MARK: - UIPopoverPresentationControllerDelegate
extension ViewController: UIPopoverPresentationControllerDelegate {
  
  func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
    return .None
  }
  
}
