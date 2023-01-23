//
//  LaunchDetailsViewController.swift
//  TaskAppLaunch
//
//  Created by Kishore on 21/01/23.
//

import UIKit
import WebKit

class LaunchDetailsViewController: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var webView: WKWebView!
    
    //MARK: - Constants and Variables
    var url = ""
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.load(URLRequest(url: URL(string: url)!))
        webView.allowsBackForwardNavigationGestures = true
    }
    
}
