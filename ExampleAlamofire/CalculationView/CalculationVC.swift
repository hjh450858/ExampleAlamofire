//
//  CalculationVC.swift
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

class CalculationVC: UIViewController {
    // 인디케이터
    let indicator = MaterialActivityIndicatorView().then {
        $0.color = .lightGray
        $0.layer.zPosition = 1
    }
    
    let disposeBag = DisposeBag()
    // 뷰모델
    let vm = CalculationVM()
    
    lazy var stackViewTF = UIStackView(arrangedSubviews: [timeZoneTF, timeSpanTF, dateTimeTF, dstAmbiguityTF]).then {
        $0.axis = .vertical
        $0.spacing = 8
        $0.alignment = .fill
        $0.distribution = .fillEqually
    }
    
    let timeZoneTF = UITextField().then {
        $0.placeholder = "예시) asia/seoul"
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 0.3
        $0.layer.borderColor = UIColor.black.cgColor
        $0.addLeftPadding()
    }
    
    let timeSpanTF = UITextField().then {
        $0.placeholder = "예시) 16:03:45:17"
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 0.3
        $0.layer.borderColor = UIColor.black.cgColor
        $0.addLeftPadding()
    }
    
    let dateTimeTF = UITextField().then {
        $0.placeholder = "예시) 2021-11-27 05:45:00"
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 0.3
        $0.layer.borderColor = UIColor.black.cgColor
        $0.addLeftPadding()
    }
    
    let dstAmbiguityTF = UITextField().then {
        $0.placeholder = "예시) 빈값 가능"
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 0.3
        $0.layer.borderColor = UIColor.black.cgColor
        $0.addLeftPadding()
    }
    
    // 결과값 라벨
    let resultLabel = UILabel().then {
        $0.textAlignment = .center
        $0.font = $0.font.withSize(14)
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
    }
    
    lazy var stackBtn = UIStackView(arrangedSubviews: [stackCurrentBtn, stackCustomBtn]).then {
        $0.axis = .vertical
        $0.spacing = 8
        $0.alignment = .fill
        $0.distribution = .fillEqually
    }
    
    lazy var stackCurrentBtn = UIStackView(arrangedSubviews: [currentIncrementBtn, currentDecrementBtn]).then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.alignment = .fill
        $0.distribution = .fillEqually
    }
    
    lazy var stackCustomBtn = UIStackView(arrangedSubviews: [customIncrementBtn, customDecrementBtn]).then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.alignment = .fill
        $0.distribution = .fillEqually
    }
    
    let currentIncrementBtn = UIButton().then {
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 0.3
        $0.layer.borderColor = UIColor.black.cgColor
        $0.setTitle("current +", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    
    let currentDecrementBtn = UIButton().then {
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 0.3
        $0.layer.borderColor = UIColor.black.cgColor
        $0.setTitle("current -", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    
    let customIncrementBtn = UIButton().then {
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 0.3
        $0.layer.borderColor = UIColor.black.cgColor
        $0.setTitle("custom +", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    
    let customDecrementBtn = UIButton().then {
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 0.3
        $0.layer.borderColor = UIColor.black.cgColor
        $0.setTitle("custom -", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        configureUI()
        
        bindingVM()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func configureUI() {
        view.addSubview(indicator)
        
        view.addSubview(resultLabel)
        
        view.addSubview(stackViewTF)
        
        view.addSubview(stackBtn)
        
        indicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(44)
        }
        
        stackViewTF.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(160)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(stackViewTF.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(stackBtn.snp.top).offset(8)
        }
        
        stackBtn.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.height.equalTo(80)
        }
    }
    
    func bindingVM() {
        vm.indicatorRelay.subscribe { [weak self] flag in
            guard let self = self else { return }
            flag == true ? self.indicator.startAnimating() : self.indicator.stopAnimating()
        }.disposed(by: disposeBag)
        
        vm.resultData.bind(to: resultLabel.rx.text).disposed(by: disposeBag)
        
        // current + 터치
        currentIncrementBtn.rx.tap.subscribe { [weak self] tap in
            guard let self = self else { return }
            print("currentIncrementBtn - tap")
            vm.indicatorRelay.accept(true)
            CalculationAPIService.postCalculationCurrentIncrement(model: CalculationCurrentModel(timeZone: timeZoneTF.text!, timeSpan: timeSpanTF.text!), relay: vm.currentIncrementRelay, errorRelay: vm.currentIncrementError)
        }.disposed(by: disposeBag)
        
        // current - 터치
        currentDecrementBtn.rx.tap.subscribe { [weak self] tap in
            guard let self = self else { return }
            print("currentDecrementBtn - tap")
            vm.indicatorRelay.accept(true)
            CalculationAPIService.postCalculationCurrentDecrement(model: CalculationCurrentModel(timeZone: timeZoneTF.text!, timeSpan: timeSpanTF.text!), relay: vm.currentDecrementRelay, errorRelay: vm.currentDecrementError)
        }.disposed(by: disposeBag)
        
        // custom + 터치
        customIncrementBtn.rx.tap.subscribe { [weak self] tap in
            guard let self = self else { return }
            print("customIncrementBtn - tap")
            vm.indicatorRelay.accept(true)
            CalculationAPIService.postCalculationCustomIncrement(model: CalculationCustomModel(timeZone: timeZoneTF.text!, dateTime: dateTimeTF.text!, timeSpan: timeSpanTF.text!, dstAmbiguity: dstAmbiguityTF.text!), relay: vm.customIncrementRelay, errorRelay: vm.customIncrementError)
            
//            let resultRelay = CalculationAPIService.postCalculationCustomIncrementReturnRelay(model: CalculationCustomModel(timeZone: timeZoneTF.text!, dateTime: dateTimeTF.text!, timeSpan: timeSpanTF.text!, dstAmbiguity: dstAmbiguityTF.text!))
//            
//            resultRelay.subscribe { result in
//                switch result {
//                case .success(let data):
//                    print("success data = \(data)")
//                    self.vm.customIncrementRelay.accept(data)
//                case .failure(let error):
//                    print("failure error = \(error)")
//                    self.vm.customIncrementError.accept(error)
//                }
//            }.disposed(by: disposeBag)
            
        }.disposed(by: disposeBag)
        
        // custom - 터치
        customDecrementBtn.rx.tap.subscribe { [weak self] tap in
            guard let self = self else { return }
            print("customDecrementBtn - tap")
            vm.indicatorRelay.accept(true)
            CalculationAPIService.postCalculationCustomDecrement(model: CalculationCustomModel(timeZone: timeZoneTF.text!, dateTime: dateTimeTF.text!, timeSpan: timeSpanTF.text!, dstAmbiguity: dstAmbiguityTF.text!), relay: vm.customDecrementRelay, errorRelay: vm.customDecrementError)
        }.disposed(by: disposeBag)
        
        // current + 이벤트
        vm.currentIncrementRelay.subscribe { [weak self] data in
            guard let self = self else { return }
            print("currentIncrementRelay - data = \(data)")
            vm.indicatorRelay.accept(false)
            vm.resultData.accept(data.description)
        }.disposed(by: disposeBag)
        
        // current + 에러 이벤트
        vm.currentIncrementError.subscribe { [weak self] error in
            guard let self = self else { return }
            print("currentIncrementError - error = \(error)")
            vm.indicatorRelay.accept(false)
            vm.resultData.accept(error.localizedDescription)
        }.disposed(by: disposeBag)
        
        // current - 이벤트
        vm.currentDecrementRelay.subscribe { [weak self] data in
            guard let self = self else { return }
            print("currentDecrementRelay - data = \(data)")
            vm.indicatorRelay.accept(false)
            vm.resultData.accept(data.description)
        }.disposed(by: disposeBag)
        
        // current - 에러 이벤트
        vm.currentDecrementError.subscribe { [weak self] error in
            guard let self = self else { return }
            print("currentDecrementError - error = \(error)")
            vm.indicatorRelay.accept(false)
            vm.resultData.accept(error.localizedDescription)
        }.disposed(by: disposeBag)
        
        // custom + 이벤트
        vm.customIncrementRelay.subscribe { [weak self] data in
            guard let self = self else { return }
            print("customIncrementRelay - data = \(data)")
            vm.indicatorRelay.accept(false)
            vm.resultData.accept(data.description)
        }.disposed(by: disposeBag)
        
        // custom + 에러 이벤트
        vm.customIncrementError.subscribe { [weak self] error in
            guard let self = self else { return }
            print("customIncrementError - error = \(error)")
            vm.indicatorRelay.accept(false)
            vm.resultData.accept(error.localizedDescription)
        }.disposed(by: disposeBag)
        
        // custom - 이벤트
        vm.customDecrementRelay.subscribe { [weak self] data in
            guard let self = self else { return }
            print("customDecrementRelay - data = \(data)")
            vm.indicatorRelay.accept(false)
            vm.resultData.accept(data.description)
        }.disposed(by: disposeBag)
        
        // custom - 에러 이벤트
        vm.customDecrementError.subscribe { [weak self] error in
            guard let self = self else { return }
            print("customDecrementError - error = \(error)")
            vm.indicatorRelay.accept(false)
            vm.resultData.accept(error.localizedDescription)
        }.disposed(by: disposeBag)
    }
}
