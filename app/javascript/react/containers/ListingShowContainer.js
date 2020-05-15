import React, { useState, useEffect } from 'react'
import { Link, Redirect } from 'react-router-dom'
import _ from 'lodash'

import whereToNextApi from '../services/WhereToNextApi'

const ListingShowContainer = props => {
  const [destination, setDestination] = useState({})
  const [visitedStatus, setVisitedStatus] = useState(null)
  const [shouldRedirect, setShouldRedirect] = useState(false)

  const id = props.match.params.id

  useEffect(() => {
    whereToNextApi.getListing(id)
    .then(body => {
      setDestination(body.listing.destination)
      setVisitedStatus(body.listing.visited)
    })
  }, [])

  const handleClickVisited = (event) => {
    event.preventDefault()
    let payload = {
      id: id,
      visited: !visitedStatus,
    }
    whereToNextApi.patchListing(id, payload)
    .then(body => {
      setVisitedStatus(body.listing.visited)
    })

  }

  const handleClickDelete = (event) => {
    event.preventDefault()
    let payload = {id: id}
    if (whereToNextApi.deleteListing(id, payload)) {
      setShouldRedirect(true)
    }
  }

  let iconName = "far fa-square fa-3x"
  if (visitedStatus) {
    iconName = "far fa-check-square fa-3x"
  }

  let addressDisplay
  let display_array = []
  if (!_.isEmpty(destination)) {
    addressDisplay = destination.state
    let address_array = destination.address.split(", ")
    address_array.forEach((element) => {
      if (element !== "United States" && element !== "USA") {
        display_array.push(element)
      }
    })
  }

  if (display_array.length > 0) {
    addressDisplay = display_array.join(", ")
  }

  if (shouldRedirect) {
    return (
      <Redirect to="/listings" />
    )
  } else {
    return (
      <div className="callout-container">
        <div className="callout">
          <h1>{destination.name}</h1>
          <h4 className="detail-text">{addressDisplay}</h4>
          <div className="column text-center">
            <span className="checkbox">
              <i
                className={iconName}
                onClick={handleClickVisited}
              />
            </span>
            <span className="checkbox checkbox-text">
              <h3 className="field">Check this destination off my bucket list</h3>
            </span>
          </div>
          <div className="button-group align-justify">
            <Link to="/listings" className="button hollow secondary">Back to my bucket list</Link>
            <button
              type="button"
              className="hollow button secondary"
              onClick={handleClickDelete}
            >
              Delete this destination
            </button>
          </div>
        </div>
      </div>
    )
  }
}

export default ListingShowContainer
