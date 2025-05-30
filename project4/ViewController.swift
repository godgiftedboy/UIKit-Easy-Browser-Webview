//
//  ViewController.swift
//  project4
//
//  Created by Waterflow Technology on 07/04/2025.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    var webview: WKWebView!;
    var progressView: UIProgressView!
    var websites = ["apple.com", "hackingwithswift.com"]
    //loadView is called before the viewDidLoad so it is placed earlier.
    //but order doesnt matter anyways.
    override func loadView() {
        webview = WKWebView();
        webview.navigationDelegate = self;
        view = webview;
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webview.reload))
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)

        toolbarItems = [progressButton, spacer, refresh]
        navigationController?.isToolbarHidden = false
        
        webview.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        let url = URL(string: "https://" + websites[0])!
        webview.load(URLRequest(url: url))
        webview.allowsBackForwardNavigationGestures = true
    }
    
    @objc func openTapped (){
        //message is nil because this alert doesnt need one.
        let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet);
        for website in websites {
            ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
        }
        //no handler here as it will just cancel the displayed alert box.
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel));
        
        //is imported for iPad
        //It tells iOs where action sheets should be anchored.
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem;
        present(ac,animated: true);
        
    }
    
    func openPage(action: UIAlertAction){
        guard let actionTitle = action.title
        else{
            return;
        }
        guard let url = URL(string: "https://" + actionTitle) else{return}
        webview.load(URLRequest(url: url))
        webview.allowsBackForwardNavigationGestures = true
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webview.title;
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress"{
            progressView.progress = Float(webview.estimatedProgress)
        }
    }
    //modern async variant using async/await.
    //differs from one in tutorial
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction) async -> WKNavigationActionPolicy {
        let url = navigationAction.request.url

        if let host = url?.host {
            for website in websites {
                if host.contains(website) {
                    return .allow
                }
            }
        }

        return .cancel
    }


}

