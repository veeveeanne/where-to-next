import React, { useState, useEffect } from 'react'
import { Link, Redirect } from 'react-router-dom'
import { trackPromise } from 'react-promise-tracker'
import _ from 'lodash'

import TravelFormTile from '../components/TravelFormTile'
import AirportFormTile from '../components/AirportFormTile'
import AirportMatchTile from '../components/AirportMatchTile'
import SpinnerComponent from '../components/SpinnerComponent'
import whereToNextApi from '../services/WhereToNextApi'

const TravelPlanContainer = props => {
  const [airportForm, setAirportForm] = useState({
    keyword: ""
  })
  const [travelForm, setTravelForm] = useState({
    airport_code: "",
    departure_date: "",
    return_date: ""
  })
  const [haveIataCode, setHaveIataCode] = useState(false)
  const [errors, setErrors] = useState({})
  const [airportMatches, setAirportMatches] = useState([])
  const [selectedLine, setSelectedLine] = useState(null)
  const [shouldRedirect, setShouldRedirect] = useState(false)

  const handleTravelFormChange = (event) => {
    setTravelForm({
      ...travelForm,
      [event.currentTarget.id]: event.currentTarget.value
    })
  }

  const handleAirportFormChange = (event) => {
    setAirportForm({
      ...airportForm,
      [event.currentTarget.id]: event.currentTarget.value
    })
  }

  const handleAirportFormSubmit = (event) => {
    event.preventDefault()
    setAirportMatches([])
    if (airportValidForSubmission()) {
      whereToNextApi.searchAirports(airportForm.keyword)
      .then(body => {
        if (body.airports) {
          searchAirports()
        } else {
          setAirportMatches(body)
          setAirportForm({
            keyword: ""
          })
        }
      })
    }
  }

  const airportValidForSubmission = () => {
    let submitErrors = {}
    if (airportForm.keyword.trim() === "") {
      submitErrors = {
        ...submitErrors,
        "airport": "name or city needs to be filled out"
      }
    }

    setErrors(submitErrors)
    return _.isEmpty(submitErrors)
  }

  const handleAirportMatchClick = (payload) => {
    setAirportMatches([])
    setTravelForm({
      ...travelForm,
      airport_code: payload
    })
    setHaveIataCode(true)
  }

  let airportMatchesDisplay
  if (airportMatches.length > 0) {
    airportMatchesDisplay = airportMatches.map((airport) => {
      return (
        <AirportMatchTile
          key={airport.id}
          airport={airport}
          selectedLine={selectedLine}
          setSelectedLine={setSelectedLine}
          handleClick={handleAirportMatchClick}
        />
      )
    })
  }

  const handleTravelFormSubmit = (event) => {
    event.preventDefault()
    if (validForSubmission()) {
      trackPromise(
        whereToNextApi.postFlights(travelForm)
        .then(body => {
          if (!_.isEmpty(body.flight)) {
            setTravelForm({
              airport_code: "",
              departure_date: "",
              return_date: ""
            })
            setShouldRedirect(true)
          } else {
            setErrors({"recommendation": "could not be made. Please check that you have destinations saved on your bucket list"})
          }
        })
      )
    }
  }

  const validForSubmission = () => {
    let submitErrors = {}
    let requiredFields = [
      "departure_date",
      "return_date"
    ]
    let input_date_array = []

    requiredFields.forEach((field) => {
      if (travelForm[field].trim() === "") {
        submitErrors = {
          ...submitErrors,
          [field]: "needs to be filled out"
        }
      } else {
        let today = Date.now()
        let inputDate = new Date(`${travelForm[field]} 00:00:00`)
        let inputDateMilliseconds = inputDate.getTime()
        input_date_array.push(inputDateMilliseconds)

        if (inputDateMilliseconds < today) {
          submitErrors = {
            ...submitErrors,
            [field]: "needs to be a future date"
          }
        }
      }

      if (input_date_array.length === 2) {
        if (input_date_array[1] < input_date_array[0]) {
          submitErrors = {
            ...submitErrors,
            "return_date": "needs to be after Departure Date"
          }
        }
      }
    })
    setErrors(submitErrors)
    return _.isEmpty(submitErrors)
  }

  let selectionMessage
  if (airportMatchesDisplay) {
    selectionMessage = "Please click your airport below"
  }

  const searchAirports = () => {
    whereToNextApi.exploreAirports(airportForm.keyword)
    .then(body => {
      if (body.errors) {
        setErrors({airport: body["error"]})
      } else {
        setAirportMatches(body)
      }
    })
  }

  let airport_info
  let travel_dates
  if (!haveIataCode) {
    travel_dates = ""
    airport_info =
      <AirportFormTile
        airportForm={airportForm}
        handleAirportFormChange={handleAirportFormChange}
        handleAirportFormSubmit={handleAirportFormSubmit}
        errors={errors}
      />
  } else {
    airport_info = ""
    travel_dates =
      <TravelFormTile
        travelForm = {travelForm}
        handleTravelFormChange = {handleTravelFormChange}
        handleTravelFormSubmit = {handleTravelFormSubmit}
        errors = {errors}
      />
  }

  if (shouldRedirect) {
    return (
      <Redirect to="/travel/recommendation" />
    )
  } else {
    return (
      <div className="travel">
        <div className="form-spacer">
          <h3>I want a recommendation for my next trip</h3>
          <div className="form">
            {airport_info}
          </div>
          <div className="form">
            <h6 className="instruction">
              {selectionMessage}
            </h6>
            {airportMatchesDisplay}
          </div>
          <div className="form">
            {travel_dates}
          </div>
          <SpinnerComponent />
        </div>
        <div className="spacer">
          <Link to="/listings" className="button hollow secondary">Back to my bucket list</Link>
        </div>
      </div>
    )
  }
}

export default TravelPlanContainer
