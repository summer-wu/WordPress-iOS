import Foundation

class PeopleController {
    let siteID: Int
    let store: PeopleStore

    init(siteID: Int, account: WPAccount) {
        self.siteID = siteID
        self.store = PeopleStore(api: account.restApi)
    }

    func getUsers() -> RACSignal {
        return store.getTeam(siteID, search: nil).map {
            return PeopleCellViewModel(person: $0) as AnyObject
        }
    }
}
