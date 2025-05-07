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
        
        bindingVM()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func configureUI() {
        view.addSubview(indicator)
        
        view.addSubview(resultLabel)
        
        indicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(44)
        }
        
        vm.resultData.bind(to: resultLabel.rx.text).disposed(by: disposeBag)
        
        CalculationAPIService.postCalculationCurrentIncrement(model: CalculationCurrentModel(timeZone: "Europe/Amsterdam", timeSpan: "16:03:45:17"), relay: vm.currentIncrementRelay, errorRelay: vm.currentIncrementError)
    }
    
    func bindingVM() {
        vm.indicatorRelay.subscribe { [weak self] flag in
            guard let self = self else { return }
            flag == true ? self.indicator.startAnimating() : self.indicator.stopAnimating()
        }.disposed(by: disposeBag)
        
        vm.currentIncrementRelay.subscribe { [weak self] data in
            guard let self = self else { return }
            print("currentIncrementRelay - data = \(data)")
        }.disposed(by: disposeBag)
        
        vm.currentIncrementError.subscribe { [weak self] error in
            guard let self = self else { return }
            print("currentIncrementError - error = \(error)")
        }.disposed(by: disposeBag)
    }
}
