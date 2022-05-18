//
//  BaseViewController.swift
//  ZirkonJewelery
//
//  Created by Shaxzod Azamatjonov on 17/05/22.
//

import UIKit
import Reachability
import SnapKit

class BaseViewController: UIViewController {
    
    var loadingView: UIView = .init()
    let noConnectionView: UIView = .init()
    var loadingText: String?
    var reachability: Reachability?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            reachability =  try Reachability()
        } catch {
            
        }
        reachability?.whenReachable = { reach in
            if reach.connection == .wifi {
                self.noConnection = false
                self.isLoading = true
            } else {
                self.noConnection = false
                self.isLoading = true
            }
        }
        reachability?.whenUnreachable = { _ in
            self.noConnection = true
        }
        do {
            try reachability?.startNotifier()
        }
        catch{
            print("Unable to start reachability")
        }
        view.backgroundColor = .backgroundColor
        var indicator: UIActivityIndicatorView
        if #available(iOS 13.0, *) {
            indicator = .init(style: .large)
        } else {
            indicator = .init(style: .gray)
        }
        
        indicator.startAnimating()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        loadingView.addSubview(indicator)
        let loadingLabel: UILabel = .init()
        loadingLabel.text = loadingText
        loadingLabel.font = .systemFont(ofSize: 15)
        loadingLabel.textColor = .gray
        loadingLabel.translatesAutoresizingMaskIntoConstraints = false
        loadingView.addSubview(loadingLabel)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.isHidden = true
        view.addSubview(loadingView)
        loadingView.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
        }
        
        indicator.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        loadingLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(indicator.snp.bottom).offset(20)
        }
        
        let noConnectionImageView: UIImageView = .init(image: UIImage(named: "no-wifi"))
        noConnectionImageView.translatesAutoresizingMaskIntoConstraints = false
        noConnectionView.addSubview(noConnectionImageView)
    
        let noConnectionLabel: UILabel = .init()
        noConnectionLabel.font = .systemFont(ofSize: 12)
        noConnectionLabel.textColor = .gray
        noConnectionLabel.text = "Check your connection"
        noConnectionLabel.translatesAutoresizingMaskIntoConstraints = false
        noConnectionLabel.numberOfLines = 0
        noConnectionLabel.textAlignment = .center
        noConnectionView.addSubview(noConnectionLabel)
        noConnectionView.translatesAutoresizingMaskIntoConstraints = false
        noConnectionView.isHidden = true
        noConnectionView.translatesAutoresizingMaskIntoConstraints = false
        noConnectionView.isHidden = true
        view.addSubview(noConnectionView)
        noConnectionView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(250)
        }
        
        noConnectionImageView.snp.makeConstraints { make in
            make.top.equalTo(noConnectionView.snp.top)
            make.width.height.equalTo(100)
            make.centerX.equalTo(noConnectionView.snp.centerX)
        }
        noConnectionLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(noConnectionImageView.snp.bottom).offset(20)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        try? reachability?.startNotifier()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        reachability?.stopNotifier()
    }
    
    var isLoading: Bool = false {
        didSet {
            loadingView.isHidden = !isLoading
        }
    }
    
    var noConnection: Bool = false {
        didSet {
            noConnectionView.isHidden = !noConnection
        }
    }
    @objc func retry() {
        
    }
    
}
