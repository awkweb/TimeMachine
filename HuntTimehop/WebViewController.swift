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
  @IBOutlet weak var progressView: UIProgressView!
  
  var webProduct: ProductModel!
  var detailVC: PostDetailsViewController!
  var progressComplete = false
  var progressTimer = NSTimer()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    webView.delegate = self
    
    openSite()
    
    toolbar.barTintColor = UIColor.white()
    toolbar.tintColor = UIColor.orange()
    progressView.tintColor = UIColor.orange()
  }
  
  override func prefersStatusBarHidden() -> Bool {
    return true
  }
  
  @IBAction func swipeBackGesture(sender: AnyObject) {
    webView.goBack()
  }
  
  @IBAction func swipeForwardGesture(sender: AnyObject) {
    webView.goForward()
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
    let phURL = NSURL(string: webProduct.phURL)!
    let request = NSURLRequest(URL: phURL)
    webView.loadRequest(request)
  }
  
  func webViewDidStartLoad(webView: UIWebView) {
    startProgressBar()
  }
  
  func webViewDidFinishLoad(webView: UIWebView) {
    progressComplete = true
  }
  
  func startProgressBar() {
    progressView.hidden = false
    progressView.progress = 0.0
    progressComplete = false
    progressTimer = NSTimer.scheduledTimerWithTimeInterval(0.01667, target: self, selector: "timerCallback", userInfo: nil, repeats: true)
  }
  
  func timerCallback() {
    if progressComplete {
      if progressView.progress >= 1 {
        progressView.hidden = true
        progressTimer.invalidate()
      } else {
        progressView.progress += 0.1
      }
    } else {
      progressView.progress += 0.01
    }
  }
}
