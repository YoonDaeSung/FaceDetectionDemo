//
//  ViewController.swift
//  FaceDetecionDemo
//
//  Created by YoonDaeSung on 2022/11/07.
//

import UIKit

import SnapKit

class ViewController: UIViewController {
	
	// test
	let testImg = UIImage(named: "Ma")!
	
	let viewModel = ViewModel()

	private lazy var containner = UIView()
	
	private lazy var imgView: UIImageView = {
		let imgView = UIImageView()
		view.backgroundColor = .blue
		
		return imgView
	}()
	
	private lazy var testButton: UIButton = {
		let button = UIButton()
		button.setTitle(" 전송 ", for: .normal)
		
		return button
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		testButton.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
		configureLayout()
	}
	
	private func configureLayout() {
		view.addSubview(containner)
		containner.snp.makeConstraints {
			$0.top.equalTo(view.safeAreaLayoutGuide)
			$0.leading.trailing.equalToSuperview().inset(10)
		}
		
		containner.addSubview(imgView)
		imgView.snp.makeConstraints {
			$0.top.equalToSuperview()
			$0.leading.equalToSuperview()
			$0.trailing.equalToSuperview()
			$0.height.equalTo(400)
		}
		
		containner.addSubview(testButton)
		testButton.snp.makeConstraints {
			$0.top.equalTo(imgView.snp.bottom).offset(10)
			$0.leading.trailing.equalToSuperview()
			$0.bottom.equalToSuperview()
		}
	}
	
	@objc func buttonDidTap() {
		viewModel.imgDetection(testImg) { (result, resultImg)  in
			
			guard let resultImg = resultImg else { return }
			
			switch result {
			case .foundFace:
				self.imgView.image = resultImg[0]
				print("얼굴 발견")
			case .notFound:
				print("얼굴 못찾음")
			case .unknownError:
				print("알수 없는 오류")
			}
		}
	}
}
