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
