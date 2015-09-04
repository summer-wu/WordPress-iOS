import Foundation

class PeopleStore {
    let remote: PeopleRemote

    init(api: WordPressComApi) {
        remote = PeopleRemote(api: api)
    }

    func getTeam(siteID: Int, search: String?) -> RACSignal {
        return remote.getTeam(siteID, search: search)
    }
}