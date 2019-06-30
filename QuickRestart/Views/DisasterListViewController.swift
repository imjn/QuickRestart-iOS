//
//  ViewController.swift
//  QuickRestart
//
//  Created by Imagine Kawabe on 2019/06/29.
//  Copyright © 2019 Imagine Kawabe. All rights reserved.
//

import UIKit
import CoreLocation
import RxSwift
import ReactorKit
import RxDataSources

class DisasterListViewController: UIViewController {
    
    var locationManager: CLLocationManager!
    var disposeBag: DisposeBag = DisposeBag()
    typealias Reactor = DisasterListViewReactor
    private var cellHightsDictionary: [String: CGFloat] = [:]

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.reactor = DisasterListViewReactor(view: self)
        tableView.register(UINib(nibName: "DisasterTableViewCell", bundle: nil), forCellReuseIdentifier: "DisasterCell")
        setupLocationManager()
    }

    func setupLocationManager() {
        locationManager = CLLocationManager()
        guard let locationManager = locationManager else { return }
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()

        let status = CLLocationManager.authorizationStatus()
        if status == .authorizedWhenInUse {
            locationManager.distanceFilter = 10
            locationManager.startUpdatingLocation()
        }
    }
}

extension DisasterListViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        LocationService.sendLocation(location: location, completion: { success in
            print(success)
        })
    }
}

extension DisasterListViewController: StoryboardView {
    func bind(reactor: DisasterListViewReactor) {
        // RXDATASOURCES
        self.tableView.rx.setDelegate(self).disposed(by: self.disposeBag)
        let dataSource = RxTableViewSectionedAnimatedDataSource<ItemSection>.init(animationConfiguration: AnimationConfiguration(insertAnimation: .fade, reloadAnimation: .fade, deleteAnimation: .fade), configureCell: { [weak self] dataSource, table, indexPath, disaster in
            guard let self = self else { return UITableViewCell() }
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "DisasterCell", for: indexPath) as? DisasterTableViewCell else { return UITableViewCell() }
            cell.disasterTitleLabel.text = disaster.title
            let formatterForDate = DateFormatter()
            formatterForDate.timeStyle = .none
            formatterForDate.dateStyle = .full
            cell.dateLabel.text = formatterForDate.string(from: disaster.date)
            let formatterForTime = DateFormatter()
            formatterForTime.timeStyle = .short
            formatterForTime.dateStyle = .none
            cell.timeLabel.text = formatterForTime.string(from: disaster.date)
            cell.categoryLabel.text = disaster.labels?.last
            if let cat = disaster.labels?.last {
                cell.gradationImageView.image = UIImage(named: cat + "-pic")
            }
            return cell
        })

        // ACTION
        Observable<Void>.just(())
            .map { _ in Reactor.Action.load }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

//        self.tableView.rx.isReachedBottom
//            .filter { _ in reactor.currentState.hasNext }
//            .filter { _ in !reactor.currentState.isLoading }
//            .map { Reactor.Action.loadNext }
//            .bind(to: reactor.action)
//            .disposed(by: self.disposeBag)

        tableView.rx.modelSelected(Disaster.self)
            .subscribe(onNext: { disaster in
                guard let destination = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SingleDisaster") as? SingleDisasterViewController else { return }
                destination.disaster = disaster
                self.navigationController?.pushViewController(destination, animated: true)
            })
            .disposed(by: disposeBag)

        // STATE
        reactor.state.asObservable()
            .map { [$0.section] }
            .distinctUntilChanged()
            .bind(to: self.tableView.rx.items(dataSource: dataSource))
            .disposed(by: self.disposeBag)


    }
}

extension DisasterListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cellHightsDictionary[indexPath.cacheKey] = cell.frame.size.height
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHightsDictionary[indexPath.cacheKey] ?? UITableView.automaticDimension
    }
}
