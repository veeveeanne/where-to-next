import React from 'react'

import ErrorList from './ErrorList'

const AirportFormTile = props => {
  return (
    <form onSubmit={props.handleAirportFormSubmit}>
      <fieldset className="fieldset">
        <legend className="instruction">
          Airport I plan to fly out from
        </legend>
        <label htmlFor="keyword">Airport Name or City:</label>
        <input
          id="keyword"
          name="keyword"
          type="text"
          onChange={props.handleAirportFormChange}
          value={props.airportForm.keyword}
        />
        <input
          className="hollow button secondary"
          type="submit"
          value="Search for Airport"
        />
      <ErrorList
        errors = {props.errors}
      />
      </fieldset>
    </form>
  )
}

export default AirportFormTile
