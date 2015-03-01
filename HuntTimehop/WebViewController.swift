//
//  WebViewController.swift
//  HuntTimehop
//
//  Created by thomas on 2/28/15.
//  Copyright (c) 2015 thomas. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
  
  // MARK: - UI Elements
  @IBOutlet weak var webView: UIWebView!
  @IBOutlet weak var toolbar: UIToolbar!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  var webProduct: ProductModel!
  var detailVC: PostDetailsViewController!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    webView.delegate = self
    
    openSite()
    
    toolbar.barTintColor = UIColor.white()
    toolbar.tintColor = UIColor.orange()
    activityIndicator.hidesWhenStopped = true
  }
  
  override func prefersStatusBarHidden() -> Bool {
    return true
  }
  
  @IBAction func stopButtonPressed(sender: AnyObject) {
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  @IBAction func actionButtonPressed(sender: AnyObject) {
    let url = NSURL(string: webProduct.phURL)!
    UIApplication.sharedApplication().openURL(url)
  }
  
  @IBAction func refreshButtonPressed(sender: AnyObject) {
    webView.reload()
  }
  
  @IBAction func backButtonPressed(sender: AnyObject) {
    webView.goBack()
  }
  
  @IBAction func forwardButtonPressed(sender: AnyObject) {
    webView.goForward()
  }
}

extension WebViewController: UIWebViewDelegate {
  
  func openSite() {
    activityIndicator.startAnimating()
    let phURL = NSURL(string: webProduct.phURL)!
    let request = NSURLRequest(URL: phURL)
    webView.loadRequest(request)
  }
  
  func webViewDidStartLoad(webView: UIWebView) {
    activityIndicator.startAnimating()
  }
  
  func webViewDidFinishLoad(webView: UIWebView) {
    activityIndicator.stopAnimating()
  }
}
