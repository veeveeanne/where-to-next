import getListings from './functions/GetListings'
import searchListings from './functions/SearchListings'
import postListings from './functions/PostListings'
import searchDestination from './functions/SearchDestination'
import postDestination from './functions/PostDestination'
import postAirport from './functions/PostAirport'

class whereToNextApi {
  static getListings() {
    return getListings()
  }

  static searchListings(payload) {
    return searchListings(payload)
  }

  static postListings(payload) {
    return postListings(payload)
  }

  static searchDestination(query) {
    return searchDestination(query)
  }

  static postDestination(destination) {
    return postDestination(destination)
  }

  static postAirport(destination) {
    return postAirport(destination)
  }
}

export default whereToNextApi
