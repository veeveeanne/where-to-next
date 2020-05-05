import React from 'react'

import ErrorList from './ErrorList'

let states = ['Alabama','Alaska','American Samoa','Arizona','Arkansas','California','Colorado','Connecticut','Delaware','District of Columbia','Federated States of Micronesia','Florida','Georgia','Guam','Hawaii','Idaho','Illinois','Indiana','Iowa','Kansas','Kentucky','Louisiana','Maine','Marshall Islands','Maryland','Massachusetts','Michigan','Minnesota','Mississippi','Missouri','Montana','Nebraska','Nevada','New Hampshire','New Jersey','New Mexico','New York','North Carolina','North Dakota','Northern Mariana Islands','Ohio','Oklahoma','Oregon','Palau','Pennsylvania','Puerto Rico','Rhode Island','South Carolina','South Dakota','Tennessee','Texas','Utah','Vermont','Virgin Island','Virginia','Washington','West Virginia','Wisconsin','Wyoming']


const DestinationFormTile = props => {
  let destinationForm = props.destinationForm
  let handleFormChange = props.handleFormChange
  let handleFormSubmit = props.handleFormSubmit
  let handleClearForm = props.handleClearForm
  let errors = props.errors

  const stateOptions = [""].concat(states).map(state => {
    return(
      <option key={state} value={state}>
        {state}
      </option>
    )
  })

  return(
    <form onSubmit={handleFormSubmit}>
      <fieldset className="fieldset">
        <legend>{props.legend}</legend>
        <div className="grid-container">
          <div className="grid-y">
            <div className="cell small-6 medium-4 large-10">
              <label htmlFor="name">Name of location:</label>
              <input
                name="name"
                id="name"
                type="text"
                onChange={handleFormChange}
                value={destinationForm.name}
                />
            </div>
            <div className="cell small-6 medium-4 large-10">
              <label htmlFor="state">State:</label>
              <select
                name="state"
                id="state"
                onChange={handleFormChange}
                value={destinationForm.state}>
                {stateOptions}
              </select>
            </div>
            <div className="button-group">
              <input
                className="hollow button secondary"
                type="submit"
                value="Add Destination"
                />
              <button
                type="button"
                className="hollow button secondary"
                onClick={handleClearForm}>
                  Clear Form
              </button>
            </div>
              <ErrorList
                errors={errors}
              />
          </div>
        </div>
      </fieldset>
    </form>
  )
}

export default DestinationFormTile
