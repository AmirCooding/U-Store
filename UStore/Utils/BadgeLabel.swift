//
//  BadgeLabel.swift
//  UStore
//
//  Created by Amir Lotfi on 12.09.24.
//

import Foundation
import UIKit

var badgeLabel: UILabel = {
  let label = UILabel(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
  label.translatesAutoresizingMaskIntoConstraints = false
  label.layer.cornerRadius = label.bounds.size.height / 2
  label.textAlignment = .center
  label.layer.masksToBounds = true
  label.textColor = .white
  label.font = label.font.withSize(12)
  label.backgroundColor = .systemRed
  return label
}()

func showBadge(count: Int , cartButton: UIButton! ) {
  badgeLabel.text = "\(count)"
  cartButton.addSubview(badgeLabel)
  let constraints = [
    badgeLabel.leftAnchor.constraint(equalTo: cartButton.centerXAnchor, constant: 2),
    badgeLabel.topAnchor.constraint(equalTo: cartButton.topAnchor, constant: -6),
    badgeLabel.widthAnchor.constraint(equalToConstant: 16),
    badgeLabel.heightAnchor.constraint(equalToConstant: 16)
  ]
  NSLayoutConstraint.activate(constraints)
}

