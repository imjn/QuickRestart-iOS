//
//  TitleWithCheckView.swift
//  QuickRestart
//
//  Created by Imagine Kawabe on 2019/06/30.
//  Copyright © 2019 Imagine Kawabe. All rights reserved.
//

import UIKit

public class TitleWithCheckView: UIView {

    // MARK: Lifecycle

    public init() {
        super.init(frame: .zero)
        setUpViews()
        setUpConstraints()
    }

    public required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public

    public var text: String? {
        get { return label.text }
        set { label.text = newValue}
    }

    // MARK: Private

    private let label = UILabel()
    private let checkImageView = UIImageView()
    private var showDetail: Bool = false

    private func setUpViews() {
        setUpLabel()
    }

    private func setUpLabel() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        addSubview(label)
    }

    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.leadingAnchor.constraint(equalTo: trailingAnchor)
            ])
    }
}
