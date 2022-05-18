//
//  IntroController.swift
//  ZirkonJewelery
//
//  Created by Shaxzod Azamatjonov on 18/05/22.
//

import UIKit

class IntroController: UIViewController {
    weak var collectionView: UICollectionView?
    let skipButton = UIButton()
    let viewModel = IntroViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        // Do any additional setup after loading the view.
    }
}

extension IntroController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    private func initViews(){
        view.addSubview(skipButton)
        skipButton.setTitle("Skip", for: .normal)
        view.bringSubviewToFront(skipButton)
        skipButton.addTarget(self, action: #selector(skipFunc), for: .touchUpInside)
        skipButton.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(20)
            make.right.equalToSuperview().inset(20)
        }
        let l = UICollectionViewFlowLayout()
        l.minimumInteritemSpacing = 0
        l.minimumLineSpacing = 0
        l.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: l)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .clear
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.register(IntroCell.self, forCellWithReuseIdentifier: IntroCell.reuseIdentifier)
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        view.sendSubviewToBack(collectionView)
        self.collectionView = collectionView
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getIntroCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IntroCell.reuseIdentifier, for: indexPath) as! IntroCell
        cell.updateUI(with: viewModel.getIntro(index: indexPath.item))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == 2 {
            skipButton.isHidden = false
        } else {
            skipButton.isHidden = true
        }
    }
    @objc func skipFunc() {
        let vc = UINavigationController(rootViewController: TabBarController())
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
        self.present(vc, animated: false, completion: nil)
        UserDefaultsManager.shared.saveAuth(reg: true)
    }
}
