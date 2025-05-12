//
//  TimeVC.swift
//  ExampleAlamofire
//
//  Created by 황재현 on 5/7/25.
//

import UIKit
import SnapKit
import Alamofire
import RxSwift
import Then
import RxCocoa
import MaterialActivityIndicator

class TimeVC: UIViewController {
    
    let disposeBag = DisposeBag()
    
    let vm = TimeVM()
    
    let searchZone = UISearchBar().then {
        $0.placeholder = "예시) asia/seoul"
    }
    
    lazy var coordinateStackView = UIStackView(arrangedSubviews: [latitudeView, longitudeView]).then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fillEqually
        $0.spacing = 8
    }
    
    let latitudeView = UITextField().then {
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 0.3
        $0.layer.borderColor = UIColor.black.cgColor
        $0.keyboardType = .numbersAndPunctuation
        $0.placeholder = "-90 ~ 90"
        $0.addLeftPadding()
    }
    
    let longitudeView = UITextField().then {
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 0.3
        $0.layer.borderColor = UIColor.black.cgColor
        $0.keyboardType = .numbersAndPunctuation
        $0.placeholder = "-180 ~ 180"
        $0.addLeftPadding()
    }
    
    let ipView = UITextField().then {
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 0.3
        $0.layer.borderColor = UIColor.black.cgColor
        $0.keyboardType = .numbersAndPunctuation
        $0.placeholder = "예시) 237.71.232.203"
        $0.addLeftPadding()
    }
    
    let indicator = MaterialActivityIndicatorView().then {
        $0.color = .lightGray
        $0.layer.zPosition = 1
    }
    
    lazy var stackBtnView = UIStackView(arrangedSubviews: [zoneBtn, coordinateBtn, ipBtn]).then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fill
        $0.spacing = 8
    }
    
    let zoneBtn = UIButton().then {
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 0.3
        $0.layer.borderColor = UIColor.black.cgColor
        $0.setTitle("zone 찾기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    
    let coordinateBtn = UIButton().then {
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 0.3
        $0.layer.borderColor = UIColor.black.cgColor
        $0.setTitle("위도 경도로 찾기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    
    
    let ipBtn = UIButton().then {
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 0.3
        $0.layer.borderColor = UIColor.black.cgColor
        $0.setTitle("IP 찾기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    // 결과값 라벨
    let resultLabel = UILabel().then {
        $0.textAlignment = .center
        $0.font = $0.font.withSize(14)
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureUI()
        
        binding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func configureUI() {
        view.addSubview(indicator)
        
        view.addSubview(searchZone)
        
        view.addSubview(coordinateStackView)
        
        view.addSubview(stackBtnView)
        
        view.addSubview(ipView)
        
        view.addSubview(resultLabel)
        
        indicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(44)
        }
        
        searchZone.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }
        
        coordinateStackView.snp.makeConstraints { make in
            make.top.equalTo(searchZone.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }
        
        ipView.snp.makeConstraints { make in
            make.top.equalTo(coordinateStackView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }
        
        stackBtnView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.height.equalTo(120)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(ipView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(stackBtnView.snp.top).offset(-8)
        }
    }
    
    func binding() {
        zoneBtn.rx.tap.subscribe { [weak self] tap in
            guard let self = self else { return }
            print("zoneBtn - tap")
            self.vm.indicatorRelay.accept(true)
            TimeAPIService.getTimeZoneWithZone(zone: searchZone.text!, relay: self.vm.timeZoneRelay, errorRelay: self.vm.timeZoneErrorRelay)
        }.disposed(by: disposeBag)
        
//        latitudeView.rx.text.subscribe { [weak self] text in
//            guard let self = self else { return}
//            print("latitudeView - text = \(text)")
//        }.disposed(by: disposeBag)
//
//        longitudeView.rx.text.subscribe { [weak self] text in
//            guard let self = self else { return }
//            print("longitudeView - text = \(text)")
//        }.disposed(by: disposeBag)
        
        coordinateBtn.rx.tap.subscribe { [weak self] tap in
            guard let self = self else { return }
            print("coordinateBtn - tap")
            self.vm.indicatorRelay.accept(true)
            TimeAPIService.getTimeZoneWithCoordinate(latitude: (self.latitudeView.text! as NSString).floatValue, longitude: (self.longitudeView.text! as NSString).floatValue, relay: self.vm.coordinateRelay, errorRelay: self.vm.coordinateErrorRelay)
            
        }.disposed(by: disposeBag)
        
        ipBtn.rx.tap.subscribe { [weak self] tap in
            guard let self = self else { return }
            print("ipBtn - tap")
            self.vm.indicatorRelay.accept(true)
            TimeAPIService.getTimeZoneWithIP(ip: self.ipView.text!, relay: self.vm.ipRelay, errorRelay: self.vm.ipErrorRelay)
        }.disposed(by: disposeBag)
        
        vm.timeZoneRelay.subscribe { [weak self] data in
            guard let self = self else { return }
            print("timeZone - data = \(data)")
            self.vm.indicatorRelay.accept(false)
            self.vm.resultData.accept(data.description)
        }.disposed(by: disposeBag)
        
        vm.timeZoneErrorRelay.subscribe { [weak self] error in
            guard let self = self else { return }
            print("timeZoneErrorEvent - error = \(error)")
            self.vm.indicatorRelay.accept(false)
            self.vm.resultData.accept(error.localizedDescription)
        }.disposed(by: disposeBag)
        
        vm.resultData.bind(to: resultLabel.rx.text).disposed(by: disposeBag)
        
        vm.indicatorRelay.subscribe { [weak self] flag in
            guard let self = self else { return }
            flag == true ? self.indicator.startAnimating() : self.indicator.stopAnimating()
        }.disposed(by: disposeBag)
        
        vm.coordinateRelay.subscribe { [weak self] data in
            guard let self = self else { return }
            self.vm.indicatorRelay.accept(false)
            self.vm.resultData.accept(data.description)
        }.disposed(by: disposeBag)
        
        vm.coordinateErrorRelay.subscribe { [weak self] error in
            guard let self = self else { return }
            self.vm.indicatorRelay.accept(false)
            self.vm.resultData.accept(error.localizedDescription)
        }.disposed(by: disposeBag)
        
        vm.ipRelay.subscribe { [weak self] data in
            guard let self = self else { return }
            self.vm.indicatorRelay.accept(false)
            self.vm.resultData.accept(data.description)
        }.disposed(by: disposeBag)
        
        vm.ipErrorRelay.subscribe { [weak self] error in
            guard let self = self else { return }
            self.vm.indicatorRelay.accept(false)
            self.vm.resultData.accept(error.localizedDescription)
        }.disposed(by: disposeBag)
    }
}

