import React, { useState } from 'react'

import ErrorList from './ErrorList'

const DestinationFormContainer = props => {
  const [destinationForm, setDestinationForm] = useState({
    name: "",
    state: ""
  })

  let errors = ""

  return(
    <div className="form">
      <form>
        <label htmlFor="name">Name of location:</label>
        <input
          name="name"
          id="name"
          type="text"
        />

        <label htmlFor="state">State:</label>
        <input
          name="state"
          id="state"
          type="text"
        />

        <ErrorList
          errors={errors}
        />

        <div className="button-group">
          <input className="button" type="submit" value="Add Destination" />
          <button type="button" className="button">Clear Form</button>
        </div>
      </form>
    </div>
  )
}

export default DestinationFormContainer
