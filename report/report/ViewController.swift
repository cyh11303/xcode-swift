//
//  ViewController.swift
//  report
//
//  Created by 203a28 on 2022/06/16.
//

import UIKit


class ViewController: UIViewController {
    var images = ["우동.jpg","텐동.jpg","햄버거.jpg" ,"라멘.jpg" ,"돈가스나베.jpg", "오므라이스.jpg", "마제소바.jpg"]
    var foodname = ["우동","텐동","햄버거" ,"라멘" ,"돈가스나베", "오므라이스", "마제소바"]
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var lblFoodName: UILabel!
    var imgLeft = [UIImage]()
    var imgRight = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        pageControl.numberOfPages = images.count
        pageControl.currentPage = 0
        imgView.image = UIImage(named: images[0])
        lblFoodName.text = foodname[0]
        //스와이프 제스처를 등록(왼쪽, 오른쪽)
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGesture(_:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGesture(_:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        
    }
    
    @objc func respondToSwipeGesture(_ gesture: UIGestureRecognizer){
        //페이지 컨트롤과 스와이프 제스쳐를 이용하여 이미지를 변경
        if let swipeGesture = gesture as? UISwipeGestureRecognizer{
            switch swipeGesture.direction{
            case UISwipeGestureRecognizer.Direction.left:
                //화면을 왼쪽으로 밀었을때 다음 사진이 나타나게 만들어봤습니다.
                pageControl.currentPage += 1
                imgView.image = UIImage(named: images[pageControl.currentPage])
                lblFoodName.text = foodname[pageControl.currentPage]
            case UISwipeGestureRecognizer.Direction.right:
                //화면을 오른쪽으로 밀었을때 이전 사진이 나타나게 만들어봤습니다.
                pageControl.currentPage -= 1
                imgView.image = UIImage(named: images[pageControl.currentPage])
                lblFoodName.text = foodname[pageControl.currentPage]
            default:
                break
            }
        }
    }
    @IBAction func pageChange(_ sender: UIPageControl) {
        imgView.image = UIImage(named: images[pageControl.currentPage])
    }
}
