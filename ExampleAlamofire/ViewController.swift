//
//  ViewController.swift
//  ExampleAlamofire
//
//  Created by 황재현 on 4/29/25.
//

import UIKit
import SnapKit
import RxSwift
import Then
import RxCocoa

class ViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    lazy var stackBtnView = UIStackView(arrangedSubviews: [timeBtn, timeZoneBtn, conversionBtn, calculationBtn, healthBtn]).then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fillEqually
        $0.spacing = 8
    }
    
    let timeBtn = UIButton().then {
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 0.3
        $0.layer.borderColor = UIColor.black.cgColor
        $0.setTitle("Time API", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    
    let timeZoneBtn = UIButton().then {
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 0.3
        $0.layer.borderColor = UIColor.black.cgColor
        $0.setTitle("Time Zone API", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    
    let conversionBtn = UIButton().then {
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 0.3
        $0.layer.borderColor = UIColor.black.cgColor
        $0.setTitle("Conversion API", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    
    let calculationBtn = UIButton().then {
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 0.3
        $0.layer.borderColor = UIColor.black.cgColor
        $0.setTitle("Calculation API", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    
    let healthBtn = UIButton().then {
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 0.3
        $0.layer.borderColor = UIColor.black.cgColor
        $0.setTitle("Health API", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureUI()
        
        binding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func configureUI() {
        view.addSubview(stackBtnView)
        
        stackBtnView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    func binding() {
        timeBtn.rx.tap.subscribe { [weak self] tap in
            guard let self = self else { return }
            print("timeBtn - tap")
            let vc = TimeVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }.disposed(by: disposeBag)
        
        timeZoneBtn.rx.tap.subscribe { [weak self] tap in
            guard let self = self else { return }
            print("timeZoneBtn - tap")
        }.disposed(by: disposeBag)
        
        conversionBtn.rx.tap.subscribe { [weak self] tap in
            guard let self = self else { return }
            print("conversionBtn - tap")
        }.disposed(by: disposeBag)
        
        calculationBtn.rx.tap.subscribe { [weak self] tap in
            guard let self = self else { return }
            print("calculationBtn - tap")
            let vc = CalculationVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }.disposed(by: disposeBag)
        
        healthBtn.rx.tap.subscribe { [weak self] tap in
            guard let self = self else { return }
            print("healthBtn - tap")
        }.disposed(by: disposeBag)
    }
}

