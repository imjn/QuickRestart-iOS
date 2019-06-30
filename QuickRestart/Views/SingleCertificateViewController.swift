//
//  SingleCertificateViewController.swift
//  QuickRestart
//
//  Created by Imagine Kawabe on 2019/06/29.
//  Copyright © 2019 Imagine Kawabe. All rights reserved.
//

import AloeStackView
import UIKit
import Alamofire
import AlamofireImage

public class SingleCertificateViewController: AloeStackViewController {

    // MARK: Public

    public override func viewDidLoad() {
        super.viewDidLoad()
        setUpSelf()
        setUpStackView()
        setUpTopImageRow()
    }

    var certificate: Certificate!

    // MARK: Private

    private let stackTextViewForQuick = StackTextView()
    private var shouldShowQuickSupportTextView = false

    private let stackTextViewForFurther = StackTextView()
    private var shouldShowFurtherupportTextView = false

    private func setUpSelf() {
        title = self.certificate.title
    }

    private func setUpStackView() {
        stackView.automaticallyHidesLastSeparator = true
    }

    private func setUpTopImageRow() {
        getImage(certificate.imageRef) { image in
            if let image = image {
                let imageView = UIImageView()
                imageView.contentMode = .scaleAspectFill
                let aspectRatio = image.size.height / image.size.width
                imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: aspectRatio).isActive = true
                UIView.transition(with: imageView,
                                  duration: 0.75,
                                  options: .transitionCrossDissolve,
                                  animations: { imageView.image = image },
                                  completion: nil)
                imageView.clipsToBounds = true
                imageView.layer.cornerRadius = 4
                self.stackView.addRow(imageView, animated: true)
                self.setUpQuickSupportRow()
                self.setUpFurtherSupportRow()
            }
        }
    }

    private func setUpQuickSupportRow() {
        let quickSupportCheckView = TitleWithCheckView()
        quickSupportCheckView.text = "✔️ Quick support enabled by your location"
        stackView.addRow(quickSupportCheckView, animated: true)
        stackTextViewForQuick.text = """
            You can get following support:
                - Prioritized access to LINE, Twitter and Facebook.
                - Right to get free food from QuickRestart fund.
        """
        stackView.addRow(stackTextViewForQuick, animated: true)
        stackView.hideRow(stackTextViewForQuick)
        let rowInset = UIEdgeInsets(
            top: stackView.rowInset.top,
            left: stackView.rowInset.left * 2,
            bottom: stackView.rowInset.bottom,
            right: stackView.rowInset.right)
        stackView.setInset(forRow: stackTextViewForQuick, inset: rowInset)
        stackView.setTapHandler(forRow: quickSupportCheckView) { [weak self] _ in
            guard let self = self else { return }
            self.shouldShowQuickSupportTextView = !self.shouldShowQuickSupportTextView
            self.stackView.setRowsHidden([self.stackTextViewForQuick], isHidden: self.shouldShowQuickSupportTextView, animated: true)
        }
        stackView.hideSeparator(forRow: quickSupportCheckView)
    }

    private func setUpFurtherSupportRow() {
        let furtherSupportCheckView = TitleWithCheckView()
        furtherSupportCheckView.text = "❌ Further supports not enabled"
        stackView.addRow(furtherSupportCheckView, animated: true)
        stackTextViewForFurther.text = """
        You can get further supports by:
        - submitting the pictures that tell how the damages to you were
        - getting a certificate from local government
        """
        stackView.addRow(stackTextViewForFurther, animated: true)
        stackView.hideRow(stackTextViewForFurther)
        let rowInset = UIEdgeInsets(
            top: stackView.rowInset.top,
            left: stackView.rowInset.left * 2,
            bottom: stackView.rowInset.bottom,
            right: stackView.rowInset.right)
        stackView.setInset(forRow: stackTextViewForFurther, inset: rowInset)
        stackView.setTapHandler(forRow: furtherSupportCheckView) { [weak self] _ in
            guard let self = self else { return }
            self.shouldShowQuickSupportTextView = !self.shouldShowQuickSupportTextView
            self.stackView.setRowsHidden([self.stackTextViewForFurther], isHidden: self.shouldShowQuickSupportTextView, animated: true)
        }
        stackView.hideSeparator(forRow: furtherSupportCheckView)
    }

    func getImage(_ url:URL,handler: @escaping (UIImage?)->Void) {
        Alamofire.request(url, method: .get).responseImage { response in
            if let data = response.result.value {
                handler(data)
            } else {
                handler(nil)
            }
        }
    }
}

