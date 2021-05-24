//
//  SettingsTableViewCell.swift
//  Qode
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 29/04/2021.
//

import UIKit

final class SettingsTableViewCell: UITableViewCell {
    // Properties
    static let identifier = "SettingsTableViewCell"
    
    // Views
    private let iconContainer: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }()
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let optionTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let containerSize = contentView.frame.size.height - 12
        let iconSize: CGFloat = containerSize / 1.5
        let labelWidth: CGFloat = contentView.frame.size.width - 25 - iconContainer.frame.size.width
        
        iconContainer.frame = CGRect(x: 15, y: 6, width: containerSize, height: containerSize)
        iconImageView.frame = CGRect(x: (containerSize - iconSize) / 2, y: (containerSize - iconSize) / 2, width: iconSize, height: iconSize)
        
        optionTitleLabel.frame = CGRect(
            x: iconContainer.frame.size.width + 25,
            y: 0,
            width: labelWidth,
            height: contentView.frame.size.height
        )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // Reset cell content
        imageView?.image = nil
        optionTitleLabel.text = nil
        iconContainer.backgroundColor = nil
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(optionTitleLabel)
        contentView.addSubview(iconContainer)
        iconContainer.addSubview(iconImageView)
        
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with option: SettingsOption) {
        optionTitleLabel.text = option.title
        iconImageView.image = option.icon
        iconContainer.backgroundColor = option.iconBackgroundColor
    }
}
