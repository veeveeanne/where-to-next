import getListings from './functions/GetListings'
import searchListings from './functions/SearchListings'
import postListings from './functions/PostListings'
import searchDestination from './functions/SearchDestination'
import postDestination from './functions/PostDestination'
import postAirport from './functions/PostAirport'
import getDestinations from './functions/GetDestinations'
import getListing from './functions/GetListing'
import patchListing from './functions/PatchListing'
import deleteListing from './functions/DeleteListing'
import getFlights from './functions/GetFlights'
import searchAirports from './functions/SearchAirports'
import postFlights from './functions/PostFlights'
import exploreAirports from './functions/ExploreAirports'

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

  static getDestinations() {
    return getDestinations()
  }

  static getListing(id) {
    return getListing(id)
  }

  static patchListing(id, payload) {
    return patchListing(id, payload)
  }

  static deleteListing(id, payload) {
    return deleteListing(id, payload)
  }

  static getFlights() {
    return getFlights()
  }

  static searchAirports(payload) {
    return searchAirports(payload)
  }

  static searchFlights() {
    return searchFlights()
  }

  static postFlights(payload) {
    return postFlights(payload)
  }

  static exploreAirports(payload) {
    return exploreAirports(payload)
  }
}

export default whereToNextApi
