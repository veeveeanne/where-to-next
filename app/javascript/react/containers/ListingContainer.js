import React, { useState, useEffect } from 'react'
import { Link } from 'react-router-dom'
import _ from 'lodash'

import ListingTile from '../components/ListingTile'
import VisitedTile from '../components/VisitedTile'
import DestinationFormTile from '../components/DestinationFormTile'
import ErrorList from '../components/ErrorList'
import MatchResultTile from '../components/MatchResultTile'
import DestinationResultTile from '../components/DestinationResultTile'
import whereToNextApi from '../services/WhereToNextApi'

const ListingContainer = props => {
  const [listingForm, setListingForm] = useState({
    name: "",
    state: ""
  })
  const [errors, setErrors] = useState({})
  const [destinationMatches, setDestinationMatches] = useState([])
  const [destination, setDestination] = useState({})
  const [searchDestinations, setSearchDestinations] = useState([])
  const [listings, setListings] = useState([])
  const [selectedLine, setSelectedLine] = useState(null)

  const legend = "Add to my bucket list"

  useEffect(() => {
    whereToNextApi.getListings()
    .then(body => {
      setListings(body.listings)
    })
  }, [])

  const handleFormChange = (event) => {
    setListingForm({
      ...listingForm,
      [event.currentTarget.id]: event.currentTarget.value
    })
  }

  let displayListings = []
  let visitedListings = []
  listings.forEach((destination) => {
    if (!destination.visited) {
      displayListings.push(
        <ListingTile
          key={destination.id}
          destination={destination}
          selectedLine={selectedLine}
          setSelectedLine={setSelectedLine}
        />
      )
    } else {
      visitedListings.push(
        <VisitedTile
          key={destination.id}
          destination={destination}
          selectedLine={selectedLine}
          setSelectedLine={setSelectedLine}
        />
      )
    }
  })

  let completedTripsDisplay
  if (visitedListings.length > 0) {
    completedTripsDisplay =
    <div className="tile green-box">
      <h3 className="header">Completed Trips</h3>
      {visitedListings}
    </div>
  }

  const handleFormSubmit = (event) => {
    event.preventDefault()
    setDestinationMatches([])
    setSearchDestinations([])
    if (validForSubmission()) {
      whereToNextApi.searchListings(listingForm)
      .then(body => {
        if (body.destinations.length > 0) {
          setDestinationMatches(body.destinations)
        } else {
          addDestination()
        }
      })
    }
  }

  const validForSubmission = () => {
    let submitErrors = {}
    let requiredFields = [
      "name",
      "state"
    ]
    requiredFields.forEach((field) => {
      if (listingForm[field].trim() === "") {
        submitErrors = {
          ...submitErrors,
          [field]: "needs to be filled out"
        }
      }
    })
    setErrors(submitErrors)
    return _.isEmpty(submitErrors)
  }

  const handleClearForm = () => {
    setListingForm({
      name: "",
      state: ""
    })
  }

  const handleMatchClick = (payload) => {
    whereToNextApi.postListings(payload)
    .then(body => {
      if (body.error) {
        setErrors({destination: body["error"]})
      } else {
        setListings([
          ...listings,
          body.listing
        ])
      }
      setListingForm({
        name: "",
        state: ""
      })
      setDestinationMatches([])
    })
  }

  let matchOptions
  if (destinationMatches.length > 0) {
    matchOptions = destinationMatches.map((destination) => {
      return(
        <MatchResultTile
          key={destination.address}
          destination={destination}
          handleMatchClick={handleMatchClick}
          selectedLine={selectedLine}
          setSelectedLine={setSelectedLine}
        />
      )
    })
  }

  const addDestination = () => {
    let query = listingForm.name.concat(" ", listingForm.state)
    whereToNextApi.searchDestination(query)
    .then(body => {
      if (body.results.length > 0) {
        setSearchDestinations(body.results)
        setDestination({
          ...destination,
          state: listingForm.state
        })
      } else {
        setErrors({"destination": "could not be found, please try a different search"})
      }
    })
  }

  const handleDestinationClick = (payload) => {
    let destinationHolder = {
      ...destination,
      name: payload.name,
      address: payload.address,
      latitude: payload.latitude,
      longitude: payload.longitude
    }
    setDestination(destinationHolder)
    createDestination(destinationHolder)
  }

  let destinationOptions
  if (searchDestinations.length > 0) {
    destinationOptions = searchDestinations.map(destination => {
      return(
        <DestinationResultTile
          key={destination.place_id}
          destination={destination}
          handleDestinationClick={handleDestinationClick}
          selectedLine={selectedLine}
          setSelectedLine={setSelectedLine}
        />
      )
    })
  }

  let selectionMessage
  let classValue = ""
  if (matchOptions || destinationOptions) {
    selectionMessage = "Please click your destination below"
    classValue = "option"
  }

  const createDestination = (destinationHolder) => {
    whereToNextApi.postDestination(destinationHolder)
    .then(body => {
      setDestination(body)
      setListingForm({
        name: "",
        state: ""
      })
      setSearchDestinations([])
      handleMatchClick({id: body.destination.id})
      whereToNextApi.postAirport(body)
    })
  }

  return(
    <div className="page">
      <div className="grid-container">
        <div className="grid-x grid-margin-x">
          <div className="medium-6 column">
            <div className="form">
              <DestinationFormTile
                destinationForm={listingForm}
                handleFormChange={handleFormChange}
                handleFormSubmit={handleFormSubmit}
                handleClearForm={handleClearForm}
                errors={errors}
                legend={legend}
              />
            </div>
          </div>
          <div className="medium-6 column align-self-middle">
            <h6 className="instruction">
              {selectionMessage}
            </h6>
            <div className={classValue}>
              {matchOptions}
              {destinationOptions}
            </div>
          </div>
        </div>
        <div className="tile green-box">
          <h3 className="header">My Travel Bucket List</h3>
          {displayListings}
        </div>
        {completedTripsDisplay}
        <div className="tile">
          <Link to="/travel/recommendation" className="button expanded">
            <h3 className="button-text">I'm ready to travel somewhere</h3>
          </Link>
        </div>
      </div>
    </div>
  )
}

export default ListingContainer
