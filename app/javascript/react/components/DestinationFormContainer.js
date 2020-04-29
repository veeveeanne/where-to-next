import React, { useState } from 'react'
import _ from 'lodash'

import ErrorList from './ErrorList'

const DestinationFormContainer = props => {
  const [destinationForm, setDestinationForm] = useState({
    name: "",
    state: ""
  })
  const [errors, setErrors] = useState({})

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
      setDestinationForm({
        name: "",
        state: ""
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

  return(
    <div className="form">
      <form onSubmit={handleFormSubmit}>
        <label htmlFor="name">Name of location:</label>
        <input
          name="name"
          id="name"
          type="text"
          onChange={handleFormChange}
          value={destinationForm.name}
        />

        <label htmlFor="state">State:</label>
        <input
          name="state"
          id="state"
          type="text"
          onChange={handleFormChange}
          value={destinationForm.state}
        />

        <ErrorList
          errors={errors}
        />

        <div className="button-group">
          <input
            className="button"
            type="submit"
            value="Add Destination"
          />
          <button type="button" className="button">Clear Form</button>
        </div>
      </form>
    </div>
  )
}

export default DestinationFormContainer
