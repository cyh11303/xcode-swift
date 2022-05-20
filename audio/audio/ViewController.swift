//
//  ViewController.swift
//  audio
//
//  Created by 203a28 on 2022/05/20.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    var audioPlayer : AVAudioPlayer!    //AVAudioPlayer 인스턴스 변수
    var audioFile : URL!    //재생할 오디오의 파일명 변수
    let MAX_VOLUME : Float = 10.0   //최대 볼륨, 실수형 상수
    var progressTimer : Timer!  //타이머를 위한 변수
    let timePlayerSelector:Selector = #selector(ViewController.updatePlayTime)
    var audioRecorder : AVAudioRecorder!    //audioRecorder 인스턴수를 추가
    var isRecordMode = false    //녹음모드라는 것을 나타내기 위해 isRecordMode를 추가하고, 초기값을 false로 두어 처음 앱 실행 시에 재생모드가 나타나게 만듦.
    let timeRecordSelector:Selector = #selector(ViewController.updateRecordTime)
    
    @IBOutlet var pvProgressPlay: UIProgressView!
    @IBOutlet var lblCurrentTime: UILabel!
    @IBOutlet var lblEndTime: UILabel!
    @IBOutlet var btnPlay: UIButton!
    @IBOutlet var btnPause: UIButton!
    @IBOutlet var btnStop: UIButton!
    @IBOutlet var slVolume: UISlider!
    @IBOutlet var btnRecord: UIButton!
    @IBOutlet var lblRecordTime: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        selectAudioFile()
        if !isRecordMode{
            initPlay()  //재생모드이면 initPlay()을 호출함.
            btnRecord.isEnabled = false
            lblRecordTime.isEnabled = false
        } else{
            initRecord()    //녹음모드이면 initRecord()을 호출함.
        }
        
    }
    @objc func updatePlayTime(){
        lblCurrentTime.text = convertNSTimeInterval12String(audioPlayer.currentTime) //재생시간인 audioPlayer.currentTime을 레이블 'lblCurrentTime'에 나타냄.
        pvProgressPlay.progress = Float(audioPlayer.currentTime/audioPlayer.duration) // 프로그레스뷰인  pvProgressPlay의 진행상황에 audioPlayer.currentTime를 audioPlayer.duration로 나눈 값으로 표시함.
    }
    @objc func updateRecordTime(){
        lblRecordTime.text = convertNSTimeInterval12String(audioRecorder.currentTime)
    }
    func initPlay(){
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: audioFile)
        } catch let error as NSError{
            print("Error-initplay : \(error)")
        }
        slVolume.maximumValue = MAX_VOLUME  //슬라이더의 최대 볼륨을 위에서 설정한 MAX_VOLUME으로 초기화함.
        slVolume.value = 1.0    //슬라이더의 볼륨을 1.0으로 초기화함.
        pvProgressPlay.progress = 0 //프로그레스 뷰의 진행을 0으로 초기화 함.
        audioPlayer.delegate = self //audioPlayer의 델리게이트를 self로 지정
        audioPlayer.prepareToPlay() //prepareToPlay()를 실행함.
        audioPlayer.volume = slVolume.value //audioPlayer의 볼륨을 방금 앞에서 초기화한 슬라이더의 볼륨 값(1.0)으로 초기화함.
        
        lblEndTime.text = convertNSTimeInterval12String(audioPlayer.duration)   //오디오 파일의 재생시간인 audioPlayer.duration을 convertNSTimeInterval12String 함수를 이용하여 lblEndTIme의 텍스트에 출력함.
        lblCurrentTime.text = convertNSTimeInterval12String(0)  //lblCurrnetTime의 텍스트에는 convertNSTimeInterval12String 함수를 이용하여 00:00이 출력하도록 0을 입력해줌.
        setPlayButtons(true, pause: false, stop: false) //재생 관련 함수인 initPlay함수에서는 play버튼은 활성화하고 나머지 두 버튼은 비활성화함.
    }
    func convertNSTimeInterval12String(_ time:TimeInterval)-> String{
        let min = Int(time/60)  //재생기간의 매개변수인 time을 60으로 나눈 몫을 정수 값으로 변환하여 상수 min에 초기화함.
        let sec = Int(time.truncatingRemainder(dividingBy: 60)) //time을 60으로 나눈 나머지 값을 정수 값으로 변환하여 상수 sec에 초기화함.
        let strTime = String(format: "%02d:%02d", min, sec) //"%02d:%02d"형태의 문자열로 변환하여 상수strTime에 초기화함.
        return strTime
    }
    func setPlayButtons(_ play:Bool, pause:Bool, stop:Bool){
        btnPlay.isEnabled = play
        btnPause.isEnabled = pause
        btnStop.isEnabled = stop
    }
    func selectAudioFile(){
        if !isRecordMode{
            audioFile = Bundle.main.url(forResource: "Sicilian Breeze", withExtension: "mp3") // 재생모드일때는 "Sicilian Breeze.mp3"가 재생되도록 함.
        }else{
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            audioFile = documentDirectory.appendingPathComponent("recordFile.m4a")  //녹음모드일때는 새로운 파일인 "recordFile.m4a"가 생성됨.
        }
    }
    func initRecord(){
        let recordSettings = [
            AVFormatIDKey: NSNumber(value: kAudioFormatAppleLossless as UInt32),AVEncoderAudioQualityKey : AVAudioQuality.max.rawValue, AVEncoderBitRateKey: 320000, AVNumberOfChannelsKey: 2, AVSampleRateKey : 44100.0] as [String : Any] //녹음에 대한 설정으로 포맷은 'AppleLossless', 음질은 '최대', 비트율은 '320000bps(320kbps), 오디오 채널은 '2'로 하고 샘플률은 '44.100Hz'로 설정함
        do{
            audioRecorder = try AVAudioRecorder(url: audioFile, settings: recordSettings)
        } catch let error as NSError{
            print("Error-initRecord : \(error)")
        }
        audioRecorder.delegate = self
        slVolume.value = 1.0
        audioPlayer.volume = 1.0
        lblEndTime.text = convertNSTimeInterval12String(0)
        lblCurrentTime.text = convertNSTimeInterval12String(0)
        setPlayButtons(false, pause: false, stop: false)
        let session = AVAudioSession.sharedInstance()
        do{
            try AVAudioSession.sharedInstance().setCategory(.playAndRecord, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch let error as NSError{
            print(" Error=setCategory : \(error)")
        }
        do{
            try session.setActive(true)
        } catch let error as NSError{
            print(" Error-setActive : \(error)")
        }
        
    }
    @IBAction func btnPlayAudio(_ sender: UIButton) {
        audioPlayer.play()
        setPlayButtons(false, pause: true, stop: true)
        progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: timePlayerSelector, userInfo: nil, repeats: true)
    }
    @IBAction func btnPauseAudio(_ sender: UIButton) {
        audioPlayer.pause()
        setPlayButtons(true, pause: false, stop: true)
    }
    
    @IBAction func btnStopAudio(_ sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.currentTime = 0 //오디오를 정지하고 다시 재생하면 처음부터 재생해야하기에 audioPlayer.currentTime를 0으로 함
        lblCurrentTime.text = convertNSTimeInterval12String(0) //재생기간도 00:00으로 초기화하기 위해 convertNSTimeInterval12String(0)을 활용함.
        setPlayButtons(true, pause: false, stop: false) //play버튼만 활성화하고 나머지버튼은 비활성화함.
        progressTimer.invalidate() //타이머를 무효화함.
    }
    @IBAction func slChangeVolume(_ sender: UISlider) {
        audioPlayer.volume = slVolume.value
    }
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        progressTimer.invalidate()
        setPlayButtons(true, pause: false, stop: false) //play버튼만 활성화하고 나머지버튼은 비활성화함.
    }
    @IBAction func swRecordMode(_ sender: UISwitch) {
        if sender.isOn{ //스위치가 On일때
            audioPlayer.stop()  //녹음모드이므로 오디오 재생을 중지하고
            audioPlayer.currentTime = 0 //현재 재생시간을 00:00으로 만듦.
            lblRecordTime!.text = convertNSTimeInterval12String(0)
            isRecordMode = true
            btnRecord.isEnabled = true
            lblRecordTime.isEnabled = true
        } else{
            isRecordMode = false
            btnRecord.isEnabled = false
            lblRecordTime.isEnabled = false
            lblRecordTime.text = convertNSTimeInterval12String(0)
        }
        selectAudioFile()
        if !isRecordMode{
            initPlay()
        } else {
            initRecord()
        }
    }
    
    @IBAction func btnRecord(_ sender: Any) {
        if (sender as AnyObject).titleLabel?.text == "Record"{
            (sender as AnyObject).setTitle("Stop", for: UIControl.State())
            progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: timePlayerSelector, userInfo: nil, repeats: true)
        } else {
            audioRecorder.stop()
            progressTimer.invalidate()
            (sender as AnyObject).setTitle("Record", for: UIControl.State())
            btnPlay.isEnabled = true
            initPlay()
        }
    }
}

