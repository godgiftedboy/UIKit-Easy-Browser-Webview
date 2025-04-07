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

        toolbarItems = [spacer, refresh]
        navigationController?.isToolbarHidden = false
        
        let url = URL(string: "https://www.hackingwithswift.com")!
        webview.load(URLRequest(url: url))
        webview.allowsBackForwardNavigationGestures = true
    }
    
    @objc func openTapped (){
        //message is nil because this alert doesnt need one.
        let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet);
        ac.addAction(UIAlertAction(title: "apple.com", style: .default, handler: openPage));
        ac.addAction(UIAlertAction(title: "hackingwithswift.com", style: .default, handler: openPage));
        
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


}

