import React, { useState, useEffect } from 'react'
import { Link, Redirect } from 'react-router-dom'
import _ from 'lodash'

const Recommendation = props => {
  const [recommendation, setRecommendation] = useState({})
  const [shouldRedirect, setShouldRedirect]= useState(false)

  useEffect(() => {
    fetch('/api/v1/flights')
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
      if (_.isEmpty(body.flight)) {
        setShouldRedirect(true)
      } else {
        setRecommendation(body.flight)
      }
    })
    .catch(error => console.error(`Error in fetch: ${error}`))
  }, [])

  let city
  let state
  let destinations
  if (!_.isEmpty(recommendation)) {
    let cityData = _.lowerCase(recommendation.destination_airport.city)
    city = _.startCase(cityData)
    destinations = recommendation.destinations.map((destination) => {
      state = destination.state
      return(
        <div key={destination.id}>
          {destination.name}
        </div>
      )
    })
  }

  if (shouldRedirect) {
    return(
      <Redirect to="/travel" />
    )
  } else {
    return(
      <div className="callout-container-travel">
        <div className="callout">
          <h2>You should travel to</h2>
          <h1 className="detail-text">{city}, {state}</h1>
          <h2>to visit</h2>
          <h1 className="detail-text">{destinations}</h1>
        </div>
        <div className="button-group align-justify">
          <Link to="/listings" className="button hollow secondary">Back to my bucket list</Link>
          <Link to="/travel" className="button hollow secondary">Get new recommendation</Link>
        </div>
      </div>
    )
  }
}

export default Recommendation
