//
//  MessageListCollectionViewCell.swift
//  tuider-programatically
//
//  Created by Gatien DIDRY on 04/01/2023.
//

import UIKit

class MessageListCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    static let reuseIdentifier = String(describing: MessageListCollectionViewCell.self)

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.layer.cornerCurve = .continuous
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill

        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.textAlignment = .left

        return label
    }()

    private func configureUI() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)

        contentView.backgroundColor = .secondarySystemBackground
      //  contentView.layer.cornerRadius = 20

        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.sizeToFit()

        let padding: CGFloat  = 10

        NSLayoutConstraint.activate([
                    imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: 5),
                   // imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
                    imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                    imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                    imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 16),


                    titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: padding),
                    titleLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor),
                    titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                    titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding)
                ])
    }

    func configure(profile: Profil) {
        titleLabel.text = profile.name
        imageView.image = UIImage(named: profile.picPath)
    }
}
