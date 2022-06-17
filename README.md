# 모바일 프로그래밍 실습
* 12장 table
* 13장 audio
* 14장 MoviePlayer
* 15장 CameraPhotoLibrary
* 16장 Sketch, DrawGraphics
* 17장 taptouch
* 18장 SwipeGesture
* 19장 PinchGesture1,Pinchgesture2

# 모바일 프로그래밍 기말고사
* 기말고사 프로젝트로 1학기동안 배운 맵뷰, 페이지컨트롤, 내비게이션 컨트롤러,스와이프 제스처를 활용하여 만들어봤습니다. 
* 초기화면에서 어러 음식사진을 페이지컨트롤과 스와이프 제스처를 이용하여 보여주고 상단의 map버튼을 누르면 음식을 파는 식당의 위치를 맵뷰를 통해 나타내보았습니다.


![스크린샷 2022-06-17 오후 3 20 29](https://user-images.githubusercontent.com/63995513/174237634-3605efec-877a-4b71-917e-a8ffba5d4a3a.png)
![스크린샷 2022-06-17 오후 3 20 53](https://user-images.githubusercontent.com/63995513/174237652-37288bec-051c-439c-9fe7-f8a632516107.png)


#### 초기화면 코드
```
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
```
#### 전환화면 코드
```
//
//  MapViewController.swift
//  report
//
//  Created by 203a28 on 2022/06/16.
//

import UIKit
import MapKit


var images = ["우동.jpg","텐동.jpg","햄버거.jpg" ,"라멘.jpg" ,"돈가스나베.jpg", "오므라이스.jpg", "마제소바.jpg"]
class MapViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet var myMap: MKMapView!
    @IBOutlet var lblLocationInfo1: UILabel!
    @IBOutlet var lblLocationInfo2: UILabel!
    @IBOutlet var lblLocationInfo3: UILabel!
    @IBOutlet var imgView: UIImageView!
    
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lblLocationInfo1.text = ""
        lblLocationInfo2.text = ""
        lblLocationInfo3.text = ""
       
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


    
    @IBAction func sgChangeLocation(_ sender: UISegmentedControl) {
        //세그먼트컨트롤을 이용하여 각 식당의 장소를 나타내보았습니다.
        if sender.selectedSegmentIndex == 0 {
            setAnnotation(latitudeValue: 37.565448830758, longitudeValue: 126.97908415952, delta: 0.005, title: "이나니와 요스케 시청점", subtitle: "서울특별시 중구 을지로 6 (을지로1가) 재능빌딩")
            self.lblLocationInfo1.text = "이나니와 요스케 시청점"
            self.lblLocationInfo2.text = "서울특별시 중구 을지로 6 (을지로1가) 재능빌딩"
            self.lblLocationInfo3.text = "추천메뉴: 세이로 간장 쯔유(냉우동) 12000원, 가라아게 8000원"
            imgView.image = UIImage(named: images[sender.selectedSegmentIndex])
            
        } else if sender.selectedSegmentIndex == 1 {
            setAnnotation(latitudeValue: 37.568448428019, longitudeValue: 126.97770168249, delta: 0.0075, title: "온센 텐동 광화문점", subtitle: "서울특별시 중구 세종대로 136 SFC몰 B2층")
            self.lblLocationInfo1.text = "온센 텐동 광화문점"
            self.lblLocationInfo2.text = "서울특별시 중구 세종대로 136 SFC몰 B2층"
            self.lblLocationInfo3.text = "추천메뉴: 온센텐동(모듬튀김덮밥) 8900원, 에비텐동(새우튀김덮밥) 12900원"
            imgView.image = UIImage(named: images[sender.selectedSegmentIndex])
        } else if sender.selectedSegmentIndex == 2 {
            setAnnotation(latitudeValue: 37.537239251754, longitudeValue: 127.00107901118, delta: 0.005, title: "ckbg.lab", subtitle: "서울특별시 용산구 이태원로 254 지하 1층")
            self.lblLocationInfo1.text = "ckbg.lab"
            self.lblLocationInfo2.text = "서울특별시 용산구 이태원로 254 지하 1층"
            self.lblLocationInfo3.text = "추천메뉴: 오리지널 치킨버거 9800원"
            imgView.image = UIImage(named: images[sender.selectedSegmentIndex])
        } else if sender.selectedSegmentIndex == 3 {
            setAnnotation(latitudeValue: 37.556785988685, longitudeValue: 126.96829282895, delta: 0.005, title: "유즈라멘 서울역점", subtitle: "서울특별시 중구 만리동1가 53-8")
            self.lblLocationInfo1.text = "유즈라멘 서울역점"
            self.lblLocationInfo2.text = "서울특별시 중구 만리동1가 53-8"
            self.lblLocationInfo3.text = "추천메뉴: 유즈시오라멘 11000원, 튀김김치만두 4000원"
            imgView.image = UIImage(named: images[sender.selectedSegmentIndex])
        } else if sender.selectedSegmentIndex == 4 {
            setAnnotation(latitudeValue: 37.576966083784, longitudeValue: 127.0252085921, delta: 0.005, title: "동경", subtitle: "서울특별시 동대문구 왕산로 17-12 (신설동)")
            self.lblLocationInfo1.text = "동경"
            self.lblLocationInfo2.text = "서울특별시 동대문구 왕산로 17-12 (신설동)"
            self.lblLocationInfo3.text = "추천메뉴: 매운돈가스나베 8500원, 모밀정식 10000원"
            imgView.image = UIImage(named: images[sender.selectedSegmentIndex])
        } else if sender.selectedSegmentIndex == 5 {
            setAnnotation(latitudeValue: 37.563703900803, longitudeValue: 126.9914248952, delta: 0.005, title: "을지다락", subtitle: "서울특별시 중구 수표로10길 19")
            self.lblLocationInfo1.text = "을지다락"
            self.lblLocationInfo2.text = "서울특별시 중구 수표로10길 19"
            self.lblLocationInfo3.text = "추천메뉴: 다락오므라이스 14000원"
            imgView.image = UIImage(named: images[sender.selectedSegmentIndex])
        } else if sender.selectedSegmentIndex == 6 {
            setAnnotation(latitudeValue: 37.5651681712, longitudeValue: 126.99232377705, delta: 0.005, title: "부타이 제2막", subtitle: "서울특별시 중구 충무로5길 6-1 (을지로3가)")
            self.lblLocationInfo1.text = "부타이 제2막"
            self.lblLocationInfo2.text = "서울특별시 중구 충무로5길 6-1 (을지로3가)"
            self.lblLocationInfo3.text = "추천메뉴: 마제소바 10000원, 차슈 추가 3500원 "
            imgView.image = UIImage(named: images[sender.selectedSegmentIndex])
            
        }
   
    
}
    func goLocation(latitudeValue: CLLocationDegrees, longitudeValue : CLLocationDegrees, delta span :Double) -> CLLocationCoordinate2D {
        let pLocation = CLLocationCoordinate2DMake(latitudeValue, longitudeValue)
        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
        let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue)
        myMap.setRegion(pRegion, animated: true)
        return pLocation
        
    }

    func setAnnotation(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees, delta span: Double, title strTitle: String, subtitle strSubtitle:String){
        //원하는 장소에 핀을 꽂을 수 있게 만들어주는 함수
        let annotation = MKPointAnnotation()
        annotation.coordinate = goLocation(latitudeValue: latitudeValue, longitudeValue: longitudeValue, delta: span)
        annotation.title = strTitle
        annotation.subtitle = strSubtitle
        myMap.addAnnotation(annotation)
        
    }
    

     
}
```

