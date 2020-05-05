import React, { useState } from 'react'
import { Redirect } from 'react-router-dom'
import _ from 'lodash'

import DestinationFormTile from './DestinationFormTile'
import DestinationResultTile from './DestinationResultTile'

const NewDestinationFormContainer = props => {
  const [destinationForm, setDestinationForm] = useState({
    name: "",
    state: ""
  })
  const [searchDestinations, setSearchDestinations] = useState([])
  const [errors, setErrors] = useState({})
  const [destination, setDestination] = useState({create: false})
  const [shouldRedirect, setShouldRedirect] = useState(false)

  const handleFormChange = (event) => {
    setDestinationForm({
      ...destinationForm,
      [event.currentTarget.id]: event.currentTarget.value
    })
  }

  const validForSubmission = () => {
    let submitErrors = {}
    let requiredFields = [
      "name",
      "state"
    ]
    requiredFields.forEach((field) => {
      if (destinationForm[field].trim() === "") {
        submitErrors = {
          ...submitErrors,
          [field]: "needs to be filled out"
        }
      }
    })
    setErrors(submitErrors)
    return _.isEmpty(submitErrors)
  }

  const handleFormSubmit = (event) => {
    event.preventDefault()
    if (validForSubmission()) {
      let query = destinationForm.name.concat(" ", destinationForm.state)
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
        setSearchDestinations(body.results)
        setDestination({
          ...destination,
          state: destinationForm.state
        })
        setDestinationForm({
          name: "",
          state: ""
        })
      })
      .catch(error => console.error(`Error in fetch: ${error}`))
    }
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
      if (body.errors) {
        setErrors(body.errors)
      } else {
        setDestination({
          create: false
        })
        setShouldRedirect(true)
      }
    })
    .catch(error => console.error(`Error in fetch: ${error}`))
  }

  const handleClearForm = () => {
    setDestinationForm({
      name: "",
      state: ""
    })
  }

  let legend = "Add a new destination"

  if (shouldRedirect) {
    return <Redirect to='/destinations' />
  } else {
    return(
      <div className="form">
        <DestinationFormTile
          destinationForm = {destinationForm}
          handleFormChange = {handleFormChange}
          handleFormSubmit = {handleFormSubmit}
          handleClearForm = {handleClearForm}
          errors = {errors}
          legend= {legend}
        />
        {destinationOptions}
      </div>
    )
  }
}

export default NewDestinationFormContainer
