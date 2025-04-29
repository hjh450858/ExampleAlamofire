//
//  ViewController.swift
//  ExampleAlamofire
//
//  Created by 황재현 on 4/29/25.
//

import UIKit
import SnapKit
import Alamofire
import RxSwift
import Then
import RxCocoa

class ViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    let vm = TimeVM()
    
    let searchZone = UISearchBar().then {
        $0.placeholder = "예시) asia/seoul"
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
        
        configureUI()
        
        binding()
    }
    
    func configureUI() {
        view.addSubview(searchZone)
        
        view.addSubview(stackBtnView)
        
        view.addSubview(resultLabel)
        
        searchZone.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }
        
        stackBtnView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.height.equalTo(120)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(searchZone.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(stackBtnView.snp.top).offset(-8)
        }
    }
    
    func binding() {
        zoneBtn.rx.tap.subscribe { [weak self] tap in
            guard let self = self else { return }
            print("zoneBtn - tap")
            TimeAPIService.getTimeZoneWithZone(zone: searchZone.text!, relay: vm.timeZoneRelay, errorSubject: vm.timeZoneErrorEvent)
        }.disposed(by: disposeBag)
        
        coordinateBtn.rx.tap.subscribe { [weak self] tap in
            guard let self = self else { return }
            print("coordinateBtn - tap")
            
        }.disposed(by: disposeBag)
        
        ipBtn.rx.tap.subscribe { [weak self] tap in
            guard let self = self else { return }
            print("ipBtn - tap")
            
        }.disposed(by: disposeBag)
        
        vm.timeZoneRelay.subscribe { [weak self] data in
            guard let self = self else { return }
            print("timeZone - data = \(data)")
            resultLabel.text = data.description
        }.disposed(by: disposeBag)
        
        vm.timeZoneErrorEvent.subscribe { [weak self] error in
            guard let self = self else { return }
            print("timeZoneErrorEvent - error = \(error)")
            self.resultLabel.text = error.localizedDescription
        }.disposed(by: disposeBag)
    }
}

