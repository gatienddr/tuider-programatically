//
//  ViewController.swift
//  tuider-programatically
//
//  Created by Gatien DIDRY on 24/11/2022.
//

import UIKit

class ProposalsViewController: UIViewController, Swipeable {

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Attributes

    private var indexCurrentProfil = 0

    private let cardOne = UIView( )

    private let imageCardOne = UIImageView(image: UIImage(named: "nouser") )

    private let subTitleCardOne = UILabel()

    private let cardTwo = UIImageView()

    private let imageCardTwo = UIImageView(image: UIImage(named: "nouser") )

    private let subtitleCardTwo = UILabel()

    private let hearthView = UIImageView(image: UIImage(systemName: "heart.circle"))

    private let nonView = UIImageView(image: UIImage(systemName: "xmark.circle"))

    private var currentUser = Profil(name: "No body", picPath: "", lastMessage: "")

    private var nextUser : Profil?

    // MARK: setup views

    override func viewDidLoad() {
        super.viewDidLoad()

        self.currentUser = UsersService.profils.first!

        self.nextUser = UsersService.profils[1]

        setUpView()

    }

    override func viewDidLayoutSubviews() {
        let gradientCardOne = CAGradientLayer()

        let gradientColor = [UIColor(red: 255/255, green: 149/255, blue: 128/255, alpha: 1).cgColor, UIColor(red: 255/255, green: 199/255, blue: 131/255, alpha: 1).cgColor]
        gradientCardOne.frame = cardOne.bounds
        gradientCardOne.colors = gradientColor
        gradientCardOne.startPoint = CGPointZero;
        gradientCardOne.endPoint = CGPointMake(1, 1);

        gradientCardOne.cornerRadius = 20

        cardOne.layer.insertSublayer(gradientCardOne, at: 0)

        let gradientCartTwo = CAGradientLayer()
        gradientCartTwo.frame = cardTwo.bounds

        gradientCartTwo.colors = gradientColor

        gradientCartTwo.startPoint = CGPointZero;
        gradientCartTwo.endPoint = CGPointMake(1, 1);

        gradientCartTwo.cornerRadius = 20

        cardTwo.layer.insertSublayer(gradientCartTwo, at: 0)

        view.bringSubviewToFront(hearthView)
        view.bringSubviewToFront(nonView)


    }

    func setUpView() {

        setUpCards()

        setUpLikeView()

        setUpNonView()

        setUpConstraints()

        view.bringSubviewToFront(cardOne)
    }

    fileprivate func setUpCards() {

        cardOne.layer.cornerRadius = 20

        cardOne.translatesAutoresizingMaskIntoConstraints = false
        cardOne.isUserInteractionEnabled = true

        let cardOnePanGesture = CardPanGestureRecognize(
            target: self,
            action: #selector(self.usePanGesture(_:)),
            isCardOne: true)
        cardOne.addGestureRecognizer(cardOnePanGesture)

        imageCardOne.image = UIImage(named: UsersService.profils.first?.picPath ?? "")
        imageCardOne.contentMode = .scaleAspectFill
        imageCardOne.translatesAutoresizingMaskIntoConstraints = false
        imageCardOne.clipsToBounds = true
        imageCardOne.layer.cornerRadius = 20

        subTitleCardOne.text = UsersService.profils.first?.name
        subTitleCardOne.textColor = .gray
        subTitleCardOne.font = UIFont.systemFont(ofSize: 32)
        subTitleCardOne.translatesAutoresizingMaskIntoConstraints = false

        cardOne.addSubview(imageCardOne)
        cardOne.addSubview(subTitleCardOne)

        view.addSubview(cardOne)

        cardTwo.backgroundColor = .tertiarySystemGroupedBackground
        cardTwo.layer.cornerRadius = 20
        cardTwo.contentMode = .scaleAspectFit
        cardTwo.translatesAutoresizingMaskIntoConstraints = false

        imageCardTwo.image = UIImage(named: UsersService.profils[1].picPath)
        imageCardTwo.contentMode = .scaleAspectFill
        imageCardTwo.translatesAutoresizingMaskIntoConstraints = false
        imageCardTwo.clipsToBounds = true
        imageCardTwo.layer.cornerRadius = 20

        subtitleCardTwo.text = UsersService.profils[1].name
        subtitleCardTwo.font = UIFont.systemFont(ofSize: 32)
        subtitleCardTwo.textColor = .gray
        subtitleCardTwo.translatesAutoresizingMaskIntoConstraints = false

        cardTwo.addSubview(imageCardTwo)
        cardTwo.addSubview(subtitleCardTwo)

        let cardTwoPanGesture = CardPanGestureRecognize(
            target: self,
            action: #selector(self.usePanGesture(_:)),
            isCardOne: false)
        cardTwo.addGestureRecognizer(cardTwoPanGesture)

        view.addSubview(cardTwo)
    }

    fileprivate func setUpLikeView() {
        hearthView.tintColor = .green
        hearthView.translatesAutoresizingMaskIntoConstraints = false
        hearthView.isUserInteractionEnabled = true

        let likeGesture = UITapGestureRecognizer(target: self, action: #selector(self.likeProfile(_:)))
        hearthView.addGestureRecognizer(likeGesture)

        view.addSubview(hearthView)
    }

    fileprivate func setUpNonView() {
        nonView.tintColor = .red
        nonView.translatesAutoresizingMaskIntoConstraints = false
        nonView.isUserInteractionEnabled = true

        let refuseGesture = UITapGestureRecognizer(target: self, action: #selector(self.likeProfile(_:)))
        nonView.addGestureRecognizer(refuseGesture)

        view.addSubview(nonView)
    }

    fileprivate func setUpConstraints() {

        NSLayoutConstraint.activate([
            cardOne.topAnchor.constraint(equalTo: view.topAnchor, constant: 170),
            cardOne.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            cardOne.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            cardOne.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cardOne.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -130),

            imageCardOne.centerXAnchor.constraint(equalTo: cardOne.centerXAnchor),
            imageCardOne.topAnchor.constraint(equalTo: cardOne.topAnchor, constant: 40),
            imageCardOne.heightAnchor.constraint(equalToConstant: 420),
            imageCardOne.widthAnchor.constraint(equalToConstant: 280),

            subTitleCardOne.centerXAnchor.constraint(equalTo: cardOne.centerXAnchor),
            subTitleCardOne.topAnchor.constraint(equalTo: imageCardOne.bottomAnchor, constant: 10),

            cardTwo.topAnchor.constraint(equalTo: view.topAnchor, constant: 170),
            cardTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            cardTwo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            cardTwo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cardTwo.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -130),

            imageCardTwo.centerXAnchor.constraint(equalTo: cardTwo.centerXAnchor),
            imageCardTwo.topAnchor.constraint(equalTo: cardOne.topAnchor, constant: 40),
            imageCardTwo.heightAnchor.constraint(equalToConstant: 420),
            imageCardTwo.widthAnchor.constraint(equalToConstant: 280),

            subtitleCardTwo.centerXAnchor.constraint(equalTo: cardTwo.centerXAnchor),
            subtitleCardTwo.topAnchor.constraint(equalTo: imageCardTwo.bottomAnchor, constant: 10),

            hearthView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            hearthView.heightAnchor.constraint(equalToConstant: 70),
            hearthView.widthAnchor.constraint(equalToConstant: 70),
            hearthView.trailingAnchor.constraint(equalTo: cardOne.trailingAnchor, constant: -50),

            nonView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            nonView.heightAnchor.constraint(equalToConstant: 70),
            nonView.widthAnchor.constraint(equalToConstant: 70),
            nonView.leadingAnchor.constraint(equalTo: cardOne.leadingAnchor, constant: 50)
        ])
    }

    // MARK: Gesture
    fileprivate func resetCardVisible() {
        cardTwo.isHidden = false
        cardOne.isHidden = false
    }

    fileprivate func likeOrRefuseAction(
        _ sender: CardPanGestureRecognize,
        isCurrentlyCardOne: Bool) {

            resetCardVisible()

            if sender.swipeView(isCurrentlyCardOne ? cardOne : cardTwo) == .like {

            UsersService.profils[indexCurrentProfil].setMatched(true)

            displayNextProfil(isCurrentlyCardOne: isCurrentlyCardOne)

        } else if sender.swipeView(isCurrentlyCardOne ? cardOne : cardTwo) == .refuse {

            UsersService.profils[indexCurrentProfil].setMatched(false)

            displayNextProfil(isCurrentlyCardOne: isCurrentlyCardOne)

        }
    }

    @objc func usePanGesture(_ sender: CardPanGestureRecognize) {

        likeOrRefuseAction(sender, isCurrentlyCardOne: sender.isCardOne)

    }

    fileprivate func displayNextProfil(isCurrentlyCardOne: Bool) {

        let cardBringToFront: UIView
        let cardPutAtBack: UIView

        let imageBack: UIImageView
        let subTitleBack: UILabel

        if isCurrentlyCardOne {
            cardBringToFront = cardTwo
            cardPutAtBack = cardOne
            imageBack = imageCardOne
            subTitleBack = subTitleCardOne

        } else {
            cardBringToFront = self.cardOne
            cardPutAtBack = self.cardTwo
            imageBack = imageCardTwo
            subTitleBack = subtitleCardTwo
        }

        guard let _ = nextUser else {

            // last card
            cardBringToFront.isUserInteractionEnabled = false
            cardPutAtBack.isUserInteractionEnabled = false
            view.bringSubviewToFront(cardBringToFront)

            hearthView.tintColor = .gray
            nonView.tintColor = .gray

            return
        }

        if let nextProfile = self.getNextProfile() {

            cardBringToFront.isUserInteractionEnabled = true
            cardPutAtBack.isUserInteractionEnabled = false

            self.nextUser = nextProfile

            imageBack.image = UIImage(named: nextProfile.picPath)
            subTitleBack.text = nextProfile.name

        } else {

            self.nextUser = nil

            cardBringToFront.isUserInteractionEnabled = true

            imageBack.image =  UIImage(named: "nouser")
            subTitleBack.text = ""
            cardPutAtBack.isUserInteractionEnabled = false

        }

        view.bringSubviewToFront(cardBringToFront)
        view.bringSubviewToFront(hearthView)
        view.bringSubviewToFront(nonView)

    }

    @objc func likeProfile(_ sender: UITapGestureRecognizer? = nil) {
        currentUser.setMatched(true)
        print(indexCurrentProfil%2 == 0)
        displayNextProfil(isCurrentlyCardOne: indexCurrentProfil%2 == 0)
    }

    @objc func refuseProfile() {
        currentUser.setMatched(false)
        displayNextProfil(isCurrentlyCardOne: indexCurrentProfil%2 == 0)

    }

    func getNextProfile() -> Profil? {
        indexCurrentProfil+=1
        if indexCurrentProfil+1 < UsersService.profils.count {
            return UsersService.profils[indexCurrentProfil+1]
        }
        return nil
    }

}

class CardPanGestureRecognize: UIPanGestureRecognizer {
    private(set) var isCardOne: Bool

    init(target: Any?, action: Selector?, isCardOne: Bool) {
        self.isCardOne = isCardOne
        super.init(target: target, action: action)
    }
}
