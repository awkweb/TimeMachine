//
//  ViewController.swift
//  HuntTimehop
//
//  Created by thomas on 12/23/14.
//  Copyright (c) 2014 thomas. All rights reserved.
//

import UIKit

class ViewController: UITabBarController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.delegate = self
    
    navigationController?.navigationBar.barTintColor = .white()
    navigationController?.navigationBar.tintColor = .red()
    navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
    
    tabBar.tintColor = .red()
    
    let storyboard = UIStoryboard(name: "TabBar", bundle: nil)
    let techVC = storyboard.instantiateViewControllerWithIdentifier("PostsViewController") as! PostsViewController
    let gamesVC = storyboard.instantiateViewControllerWithIdentifier("PostsViewController") as! PostsViewController
    let booksVC = storyboard.instantiateViewControllerWithIdentifier("PostsViewController") as! PostsViewController
    let podcastsVC = storyboard.instantiateViewControllerWithIdentifier("PostsViewController") as! PostsViewController
    
    let techCategory = Category(name: "Tech", origin: NSDate.stringToDate(year: 2013, month: 11, day: 24), color: .blue())
    let gamesCategory = Category(name: "Games", origin: NSDate.stringToDate(year: 2015, month: 5, day: 6), color: .purple())
    let booksCategory = Category(name: "Books", origin: NSDate.stringToDate(year: 2015, month: 6, day: 25), color: .orange())
    let podcastsCategory = Category(name: "Podcasts", origin: NSDate.stringToDate(year: 2015, month: 9, day: 18), color: .green())
    techVC.category = techCategory
    gamesVC.category = gamesCategory
    booksVC.category = booksCategory
    podcastsVC.category = podcastsCategory
    
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
      let selectedVC = selectedViewController as! PostsViewController
      filterVC.selectedVC = selectedVC
      filterVC.modalPresentationStyle = .Popover
      filterVC.popoverPresentationController!.delegate = self
    }
  }
  
}


// MARK: - 
extension ViewController: UITabBarControllerDelegate {
  
  func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
    let postsViewController = viewController as! PostsViewController
    navigationItem.title = NSDate.toPrettyString(date: postsViewController.filterDate)
  }
  
}


// MARK: - UIPopoverPresentationControllerDelegate
extension ViewController: UIPopoverPresentationControllerDelegate {
  
  func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
    return .None
  }
  
}
