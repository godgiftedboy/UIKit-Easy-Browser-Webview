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
        let url = URL(string: "https://www.hackingwithswift.com")!
        webview.load(URLRequest(url: url))
        webview.allowsBackForwardNavigationGestures = true
    }


}

