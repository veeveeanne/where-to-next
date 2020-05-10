import React, { useState } from 'react'

import ErrorList from './ErrorList'

const TravelFormTile = props => {
  return(
    <form onSubmit={props.handleTravelFormSubmit}>
      <fieldset className="fieldset">
        <legend className="instruction">
          The dates I'm looking to travel
        </legend>
        <div className="grid-container">
          <div className="grid-y">
            <div className="cell small-6 medium-4 large-10">
              <label htmlFor="departure_date">Departure Date:</label>
              <input
                name="departure_date"
                id="departure_date"
                type="date"
                onChange={props.handleTravelFormChange}
              />
            </div>
            <div className="cell small-6 medium-4 large-10">
              <label htmlFor="return_date">Return Date:</label>
              <input
                name="return_date"
                id="return_date"
                type="date"
                onChange={props.handleTravelFormChange}
              />
            </div>
            <div className="button-group">
              <input
                className="hollow button secondary"
                type="submit"
                value="Enter my travel plans"
              />
              <button
                type="button"
                className="hollow button secondary"
              >
                Clear Form
              </button>
            </div>
          </div>
        </div>
        <ErrorList
          errors = {props.errors}
        />
      </fieldset>
    </form>
  )
}

export default TravelFormTile
