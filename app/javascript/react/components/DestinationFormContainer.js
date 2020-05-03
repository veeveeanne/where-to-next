import React, { useState } from 'react'
import { Redirect } from 'react-router-dom'
import _ from 'lodash'

import DestinationFormTile from './DestinationFormTile'

const DestinationFormContainer = props => {
  const [destinationForm, setDestinationForm] = useState({
    name: "",
    state: ""
  })
  const [destination, setDestination] = useState({})
  const [errors, setErrors] = useState({})
  const [shouldRedirect, setShouldRedirect] = useState(false)

  const handleFormChange = (event) => {
    setDestinationForm({
      ...destinationForm,
      [event.currentTarget.id]: event.currentTarget.value
    })
  }

  const handleFormSubmit = (event) => {
    event.preventDefault()
    if (validForSubmission()) {
      fetch('/api/v1/destinations', {
        credentials: "same-origin",
        method: "POST",
        headers: {
          "Content-type": "application/json",
          "Accept": "application/json"
        },
        body: JSON.stringify(destinationForm)
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
        setDestination(body)
        setDestinationForm({
          name: "",
          state: ""
        })
        setShouldRedirect(true)
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

  if (shouldRedirect) {
    return(
      <Redirect to={{
          pathname: '/listing/new',
          destination: {destination}
        }} />
    )
  }

  return(
    <div className="form">
      <p>I know the exact name of the location I want to visit</p>
      <DestinationFormTile
        destinationForm = {destinationForm}
        handleFormChange = {handleFormChange}
        handleFormSubmit = {handleFormSubmit}
        errors = {errors}
      />
    </div>
  )
}

export default DestinationFormContainer
