//
//  OnboardingViewController.swift
//  Visium
//
//  Created by developer on 11/04/21.
//

import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var slides: [OnboardingSlide] = [OnboardingSlide(title: "1", image: "1", video: "1", isVideo: false), OnboardingSlide(title: "2", image: "2", video: "2", isVideo: true), OnboardingSlide(title: "2", image: "2", video: "2", isVideo: false)]
    var currentPage: Int = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 { // Last Page
                self.nextButton.setTitle("Go", for: .normal)
            } else {
                self.nextButton.setTitle("Next", for: .normal)
              
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
      //  self.collectionView.register(UINib(nibName: OnboardingCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: OnboardingCollectionViewCell.identifier)
        self.collectionView.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: OnboardingCollectionViewCell.identifier)
        let layout = UICollectionViewFlowLayout()
           layout.scrollDirection = .horizontal //.horizontal
           layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
           layout.minimumLineSpacing = 0
           layout.minimumInteritemSpacing = 0
        collectionView.setCollectionViewLayout(layout, animated: true)
        self.pageControl.numberOfPages = self.slides.count
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        
        if currentPage == slides.count - 1 {
            //Go to init screen
            presentLogInScreen()
            
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)

        }
      
    }
    
    @IBAction func skipButtonAction(_ sender: Any) {
        presentLogInScreen()
    }
    
    func presentLogInScreen() {
        if  let initialNavigationController = storyboard?.instantiateViewController(identifier: "InitialNavigationController") as? UINavigationController {
            initialNavigationController.modalPresentationStyle = .fullScreen
            initialNavigationController.modalTransitionStyle = .crossDissolve
            self.present(initialNavigationController, animated: true, completion: nil)
            
        }
    }
}

extension OnboardingViewController: UICollectionViewDelegate {
    
}

extension OnboardingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as? OnboardingCollectionViewCell else { return UICollectionViewCell() }
        cell.setUpCell(onboardingSlide: self.slides[indexPath.row])
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
        pageControl.currentPage = currentPage
    }
    
    
    
}

extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                          layout collectionViewLayout: UICollectionViewLayout,
                          sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.bounds.width, height: self.collectionView.bounds.height)
    }
}
