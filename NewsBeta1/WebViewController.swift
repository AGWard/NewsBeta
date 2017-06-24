//
//  WebViewController.swift
//  NewsBeta1
//
//  Created by Anthony Ward on 6/17/17.
//  Copyright © 2017 AppCo. All rights reserved.
//

import UIKit
import SVProgressHUD
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    
    var url: String?
    var author: String?
    
    lazy var webView: WKWebView = {
       
        let web = WKWebView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        web.navigationDelegate = self
    
        return web
        
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show(withStatus: "Loading Website")
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshPage))
        navigationItem.title = author
        self.view.addSubview(webView)
        webView.load(URLRequest(url: URL(string: url!)!))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        URLCache.shared.removeAllCachedResponses()
    }
    
    @objc func refreshPage() {
    
        webView.reload()
        
    }
    
    
    @objc func cancel() {
        URLCache.shared.removeAllCachedResponses()
        dismiss(animated: true, completion: nil)
        SVProgressHUD.dismiss()
    }
    

    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        SVProgressHUD.dismiss()
    }



}
