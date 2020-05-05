import React, { useState } from 'react'
import _ from 'lodash'

import DestinationFormTile from './DestinationFormTile'
import ErrorList from './ErrorList'
import MatchResultTile from './MatchResultTile'
import DestinationResultTile from './DestinationResultTile'

const NewListingFormContainer = props => {
  const [listingForm, setListingForm] = useState({
    name: "",
    state: ""
  })
  const [errors, setErrors] = useState({})
  const [destinationMatches, setDestinationMatches] = useState([])
  const [shouldAddDestination, setShouldAddDestination] = useState(false)
  const [destination, setDestination] = useState({create: false})
  const [searchDestinations, setSearchDestinations] = useState([])
  const [addedListing, setAddedListing] = useState({})

  const legend = "Add a new destination to my bucket list"

  const handleFormChange = (event) => {
    setListingForm({
      ...listingForm,
      [event.currentTarget.id]: event.currentTarget.value
    })
  }

  const handleFormSubmit = (event) => {
    event.preventDefault()
    if (validForSubmission()) {
      fetch(`/api/v1/listings/search?name=${listingForm.name}&state=${listingForm.state}`)
      .then(response => {
        if (response.ok) {
          return response
        } else {
          let errorMessage = `${response.status} (${response.statusText})`
          let error = new Error(errorMessage)
          throw(error)
        }
      })
      .then(response => response.json())
      .then(body => {
        if (body.destinations.length > 0) {
          setDestinationMatches(body.destinations)
          setListingForm({
            name: "",
            state: ""
          })
        } else {
          setShouldAddDestination(true)
        }
      })
      .catch(error => console.error(`Error in fetch: ${error}`))
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
    fetch('/api/v1/listings', {
      credentials: "same-origin",
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json"
      },
      body: JSON.stringify(payload)
    })
    .then(response => {
      if (response.ok) {
        return response
      } else {
        let errorMessage = `${response.status} (${response.statusText})`
        let error = new Error(errorMessage)
        throw(error)
      }
    })
    .then(response => response.json())
    .then(body => {
      if (body.error) {
        setErrors({destination: body["error"]})
      } else {
        setAddedListing(body)
      }
      setDestinationMatches([])
    })
    .catch(error => console.error(`Error in fetch: ${error}`))
  }

  let matchOptions
  if (destinationMatches.length > 0) {
    matchOptions = destinationMatches.map((destination) => {
      return(
        <MatchResultTile
          key={destination.address}
          destination={destination}
          handleMatchClick={handleMatchClick}
        />
      )
    })
  }

  if (shouldAddDestination) {
    let query = listingForm.name.concat(" ", listingForm.state)
    fetch(`/api/v1/destinations/search?query=${query}`)
    .then(response => {
      if (response.ok) {
        return response
      } else {
        let errorMessage = `${response.status} (${response.statusText})`
        let error = new Error(errorMessage)
        throw(error)
      }
    })
    .then(response => response.json())
    .then(body => {
      setShouldAddDestination(false)
      setSearchDestinations(body.results)
      setDestination({
        ...destination,
        state: listingForm.state
      })
      setListingForm({
        name: "",
        state: ""
      })
    })
    .catch(error => console.error(`Error in fetch: ${error}`))
  }

  const handleDestinationClick = (payload) => {
    setDestination({
      ...destination,
      name: payload.name,
      address: payload.address,
      latitude: payload.latitude,
      longitude: payload.longitude,
      create: true
    })
  }

  let destinationOptions
  if (searchDestinations.length > 0) {
    destinationOptions = searchDestinations.map(destination => {
      return(
        <DestinationResultTile
          key={destination.place_id}
          destination={destination}
          handleDestinationClick={handleDestinationClick}
        />
      )
    })
  }

  if (destination.create) {
    fetch('/api/v1/destinations', {
      credentials: "same-origin",
      method: "POST",
      headers: {
        "Content-type": "application/json",
        "Accept": "application/json"
      },
      body: JSON.stringify(destination)
    })
    .then(response => {
      if (response.ok) {
        return response
      } else {
        let errorMessage = `${response.status} (${response.statusText})`
        let error = new Error(errorMessage)
        throw(error)
      }
    })
    .then(response => response.json())
    .then(body => {
      setDestination({
        create: false
      })
      handleMatchClick({id: body.destination.id})
      setSearchDestinations([])
    })
    .catch(error => console.error(`Error in fetch: ${error}`))
  }

  return(
    <div className="form">
      <DestinationFormTile
        destinationForm = {listingForm}
        handleFormChange = {handleFormChange}
        handleFormSubmit = {handleFormSubmit}
        handleClearForm = {handleClearForm}
        errors = {errors}
        legend = {legend}
      />
      {matchOptions}
      {destinationOptions}
    </div>
  )
}

export default NewListingFormContainer
