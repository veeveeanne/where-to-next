import React, { useState, useEffect } from 'react'
import { Link, Redirect } from 'react-router-dom'
import _ from 'lodash'

import whereToNextApi from '../services/WhereToNextApi'

const RecommendationContainer = props => {
  const [recommendation, setRecommendation] = useState({})
  const [shouldRedirect, setShouldRedirect]= useState(false)

  useEffect(() => {
    whereToNextApi.getFlights()
    .then(body => {
      if (_.isEmpty(body.flight)) {
        setShouldRedirect(true)
      } else {
        setRecommendation(body.flight)
      }
    })
  }, [])

  let city
  let state
  let destinations
  if (!_.isEmpty(recommendation)) {
    let cityData = _.lowerCase(recommendation.destination_airport.city)
    city = _.startCase(cityData)
    state = recommendation.destination_airport.state
    destinations = recommendation.destinations.map((destination) => {
      return (
        <div key={destination.id}>
          {destination.name}
        </div>
      )
    })
  }

  if (shouldRedirect) {
    return (
      <Redirect to="/travel" />
    )
  } else {
    return (
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

export default RecommendationContainer
