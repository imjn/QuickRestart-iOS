//
//  StackTextView.swift
//  QuickRestart
//
//  Created by Imagine Kawabe on 2019/06/30.
//  Copyright © 2019 Imagine Kawabe. All rights reserved.
//

import UIKit

public class StackTextView: UIView {

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
        get { return textView.text }
        set { textView.text = newValue}
    }

    // MARK: Private

    private let textView = UITextView()

    private func setUpViews() {
        setUpLabel()
    }

    private func setUpLabel() {
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.isScrollEnabled = false
        addSubview(textView)
    }

    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: topAnchor),
            textView.bottomAnchor.constraint(equalTo: bottomAnchor),
            textView.leadingAnchor.constraint(equalTo: leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
    }
}
