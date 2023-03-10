//
//  ProfilViewController.swift
//  tuider-programatically
//
//  Created by Gatien DIDRY on 27/11/2022.
//

import UIKit

final class ProfilViewController: UIViewController {

    // MARK: Private Properties

    let imageView = UIImageView(image: UIImage(named: "domingo"))
    let imageViewArea = UIView()
    let widthImageViewArea = UIScreen.main.bounds.width / 2

    let cardView = UIView()

    let completeProfileView = UIView()

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }

    // MARK: Private method
    fileprivate func setUpConstraint(
        _ cardView: UIView,
        _ completeProfileLabel: UILabel,
        _ backgroundImageColor: UIImageView
    ) {
        NSLayoutConstraint.activate([
            cardView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cardView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            cardView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            cardView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),

            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            imageViewArea.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            imageViewArea.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 50),
            imageViewArea.heightAnchor.constraint(equalToConstant: widthImageViewArea ),
            imageViewArea.widthAnchor.constraint(equalToConstant: widthImageViewArea),

            imageView.heightAnchor.constraint(equalToConstant: widthImageViewArea),
            imageView.widthAnchor.constraint(equalToConstant: widthImageViewArea),

            completeProfileView.centerXAnchor.constraint(equalTo: imageViewArea.centerXAnchor),
            completeProfileView.topAnchor.constraint(equalTo: imageViewArea.bottomAnchor, constant: -5),
            completeProfileView.widthAnchor.constraint(equalToConstant: widthImageViewArea),
            completeProfileView.heightAnchor.constraint(equalToConstant: 30),

            completeProfileLabel.centerXAnchor.constraint(equalTo: completeProfileView.centerXAnchor),
            completeProfileLabel.centerYAnchor.constraint(equalTo: completeProfileView.centerYAnchor),

            backgroundImageColor.centerXAnchor.constraint(equalTo: self.completeProfileView.centerXAnchor),
            backgroundImageColor.centerYAnchor.constraint(equalTo: self.completeProfileView.centerYAnchor)
        ])
    }

    private func setUpView() {
        self.imageViewArea.translatesAutoresizingMaskIntoConstraints = false
        self.imageViewArea.backgroundColor = .red
        self.imageViewArea.layer.cornerRadius = self.widthImageViewArea / 2
        self.imageViewArea.clipsToBounds = true

        self.imageView.contentMode = .scaleAspectFit
        self.imageView.translatesAutoresizingMaskIntoConstraints = false

        let cardView = UIView()
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.backgroundColor = .systemGroupedBackground
        cardView.layer.cornerRadius = 30
        cardView.clipsToBounds = true

        self.completeProfileView.backgroundColor = .red
        self.completeProfileView.translatesAutoresizingMaskIntoConstraints = false
        self.completeProfileView.layer.cornerRadius = 10

        // area under pic
        let backgroundImageColor = UIImageView(image: UIImage(named: "background_text"))
        self.completeProfileView.clipsToBounds = true
        backgroundImageColor.translatesAutoresizingMaskIntoConstraints = false
        self.completeProfileView.addSubview(backgroundImageColor)

        // Label under pic
        let completeProfileLabel = UILabel()
        completeProfileLabel.translatesAutoresizingMaskIntoConstraints = false
        completeProfileLabel.text = "Completed at 56 %"
        completeProfileLabel.textColor = .white

        completeProfileView.addSubview(completeProfileLabel)

        // circle around pic

        let xPosCircle: Double = 191
        let yPosCircle: Double = 154

        let circlePath = UIBezierPath(
            arcCenter: CGPoint(
                x: xPosCircle,
                y: yPosCircle
            ),
            radius: 107,
            startAngle: 0,
            endAngle: 10,
            clockwise: true
        )

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath

        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 5.0

        cardView.layer.addSublayer(shapeLayer)

        view.addSubview(cardView)
        cardView.addSubview(self.imageViewArea)
        cardView.addSubview(self.completeProfileView)

        self.imageViewArea.addSubview(self.imageView)

        setUpConstraint(cardView, completeProfileLabel, backgroundImageColor)
    }

}
