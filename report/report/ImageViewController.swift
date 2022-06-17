//
//  ImageViewController.swift
//  report
//
//  Created by 203a28 on 2022/06/16.
//

import UIKit

class ImageViewController: UIViewController {
    var images = ["우동.jpg","텐동.jpg","햄버거.jpg" ,"라멘.jpg" ,"돈가스나베.jpg", "오므라이스.jpg", "마제소바.jpg"]
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var imgView: UIImageView!
    var imgLeft = [UIImage]()
    var imgRight = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        pageControl.numberOfPages = images.count
        pageControl.currentPage = 0
        imgView.image = UIImage(named: images[0])
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(ImageViewController.respondToSwipeGesture(_:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(ImageViewController.respondToSwipeGesture(_:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc func respondToSwipeGesture(_ gesture: UIGestureRecognizer){
        if let swipeGesture = gesture as? UISwipeGestureRecognizer{
            switch swipeGesture.direction{
            case UISwipeGestureRecognizer.Direction.left:
                pageControl.currentPage += 1
                imgView.image = UIImage(named: images[pageControl.currentPage])
            case UISwipeGestureRecognizer.Direction.right:
                pageControl.currentPage -= 1
                imgView.image = UIImage(named: images[pageControl.currentPage])
            default:
                break
            }
        }
    }
    @IBAction func pageChange(_ sender: UIPageControl) {
        imgView.image = UIImage(named: images[pageControl.currentPage])
    }
}
