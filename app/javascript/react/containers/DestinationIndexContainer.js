import React, { useState, useEffect } from 'react'
import { Link } from 'react-router-dom'

import whereToNextApi from '../services/WhereToNextApi'

const DestinationIndexContainer = props => {
  const [destinations, setDestinations] = useState([])

  useEffect(() => {
    whereToNextApi.getDestinations()
    .then(body => {
      setDestinations(body.destinations)
    })
  }, [])

  let destinationsList = destinations.map(destinationObj => {
    return (
      <li key={destinationObj.id}>
        {destinationObj.name}, {destinationObj.state}
      </li>
    )
  })

  return(
    <div className="callout-container">
      <div className="callout">
        <h1>Popular Destinations</h1>
        <ul>
          {destinationsList}
        </ul>
      </div>
    </div>
  )
}

export default DestinationIndexContainer
