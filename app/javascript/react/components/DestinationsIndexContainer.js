import React, { useState, useEffect } from 'react'

const DestinationsIndexContainer = props => {
  const [destinations, setDestinations] = useState([])

  useEffect(() => {
    fetch('/api/v1/destinations')
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
      setDestinations(body)
    })
    .catch(error => console.error(`Error in fetch: ${error}`))
  }, [])

  let destinationsList = destinations.map(destinationObj => {
    return(
      <li key={destinationObj.id}>
      {destinationObj.name}, {destinationObj.state}
      </li>
    )
  })

  return(
    <ul>
      {destinationsList}
    </ul>
  )
}

export default DestinationsIndexContainer
