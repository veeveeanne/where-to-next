import React from 'react'

import ErrorList from './ErrorList'

let states = [ "AK - Alaska",
                "AL - Alabama",
                "AR - Arkansas",
                "AZ - Arizona",
                "CA - California",
                "CO - Colorado",
                "CT - Connecticut",
                "DC - District of Columbia",
                "DE - Delaware",
                "FL - Florida",
                "GA - Georgia",
                "GU - Guam",
                "HI - Hawaii",
                "IA - Iowa",
                "ID - Idaho",
                "IL - Illinois",
                "IN - Indiana",
                "KS - Kansas",
                "KY - Kentucky",
                "LA - Louisiana",
                "MA - Massachusetts",
                "MD - Maryland",
                "ME - Maine",
                "MI - Michigan",
                "MN - Minnesota",
                "MO - Missouri",
                "MS - Mississippi",
                "MT - Montana",
                "NC - North Carolina",
                "ND - North Dakota",
                "NE - Nebraska",
                "NH - New Hampshire",
                "NJ - New Jersey",
                "NM - New Mexico",
                "NV - Nevada",
                "NY - New York",
                "OH - Ohio",
                "OK - Oklahoma",
                "OR - Oregon",
                "PA - Pennsylvania",
                "PR - Puerto Rico",
                "RI - Rhode Island",
                "SC - South Carolina",
                "SD - South Dakota",
                "TN - Tennessee",
                "TX - Texas",
                "UT - Utah",
                "VA - Virginia",
                "VI - Virgin Islands",
                "VT - Vermont",
                "WA - Washington",
                "WI - Wisconsin",
                "WV - West Virginia",
                "WY - Wyoming"
              ]

const DestinationFormTile = props => {
  let destinationForm = props.destinationForm
  let handleFormChange = props.handleFormChange
  let handleFormSubmit = props.handleFormSubmit
  let handleClearForm = props.handleClearForm
  let errors = props.errors

  const stateOptions = [""].concat(states).map(state => {
    let value = ""
    if (state !== "") {
      value = state.split("-")[1].trim()
    }

    return (
      <option key={state} value={value}>
        {state}
      </option>
    )
  })

  return (
    <form onSubmit={handleFormSubmit}>
      <fieldset className="fieldset">
        <legend className="instruction">
          {props.legend}
        </legend>
        <div className="grid-container">
          <div className="grid-y">
            <div className="cell small-6 medium-4 large-10">
              <label htmlFor="name">Name of destination:</label>
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
                value={destinationForm.state}
              >
                {stateOptions}
              </select>
            </div>
            <div className="button-group">
              <input
                className="hollow button secondary"
                type="submit"
                value="Search for Destination"
              />
              <button
                type="button"
                className="hollow button secondary"
                onClick={handleClearForm}
              >
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
