//
//  ViewModel.swift
//  FaceDetecionDemo
//
//  Created by YoonDaeSung on 2022/11/07.
//

import UIKit

import ImageDetect

enum FaceDetecionResult {
	case foundFace
	case notFound
	case unknownError
}

class ViewModel {
	
	func imgDetection(
		_ selectedImg: UIImage,
		completion: @escaping (FaceDetecionResult, [UIImage]?) -> Void
	) {
		selectedImg.detector.crop(type: .face) { [weak self] result in
			switch result {
			case .success(let croppedImages):
				completion(.foundFace, croppedImages)
			case .notFound:
				completion(.notFound, nil)
			case .failure(let error):
				completion(.unknownError, nil)
				print(error.localizedDescription)
			}
		}
	}
}
