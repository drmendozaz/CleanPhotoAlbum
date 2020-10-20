//
//  ArrowButton.swift
//  CleanPhotoAlbum
//
//  Created by Daniel Mendoza Zamores on 19/10/20.
//  Copyright © 2020 Daniel Inc. All rights reserved.
//

import UIKit

@IBDesignable
class ArrowButton: UIButton {

  lazy var label: UILabel = self.makeLabel()
  lazy var arrow: UIImageView = self.makeArrow()

  let padding: CGFloat = 10
  let arrowSize: CGFloat = 8

  // MARK: - Initialization

  init() {
    super.init(frame: CGRect.zero)

    addSubview(label)
    addSubview(arrow)
  }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
  // MARK: - Layout

  override func layoutSubviews() {
    super.layoutSubviews()

    label.center = CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2)

    arrow.frame.size = CGSize(width: arrowSize, height: arrowSize)
    arrow.center = CGPoint(x: label.frame.maxX + padding, y: bounds.size.height / 2)
  }


  override var intrinsicContentSize : CGSize {
    let size = super.intrinsicContentSize
    label.sizeToFit()

    return CGSize(width: label.frame.size.width + arrowSize*2 + padding,
                  height: size.height)
  }

  // MARK: - Logic

  func updateText(_ text: String) {
    label.text = text.uppercased()
    arrow.alpha = text.isEmpty ? 0 : 1
    invalidateIntrinsicContentSize()
  }

  func toggle(_ expanding: Bool) {
    let transform = expanding
      ? CGAffineTransform(rotationAngle: CGFloat(Double.pi)) : CGAffineTransform.identity
    
    UIView.animate(withDuration: 0.25, animations: {
      self.arrow.transform = transform
    })
  }

  // MARK: - Controls

  private func makeLabel() -> UILabel {
    let label = UILabel()
    label.textColor = .darkGray
    label.font = UIFont.systemFont(ofSize: 16)
    label.textAlignment = .center

    return label
  }

  private func makeArrow() -> UIImageView {
    let arrow = UIImageView()
    arrow.image = UIImage(named: "arrow")
    arrow.tintColor = .darkGray
    arrow.alpha = 0

    return arrow
  }

  // MARK: - Touch

  override var isHighlighted: Bool {
    didSet {
      label.textColor = isHighlighted ? UIColor.lightGray : .darkGray
      arrow.tintColor = isHighlighted ? UIColor.lightGray : .darkGray
    }
  }
}
