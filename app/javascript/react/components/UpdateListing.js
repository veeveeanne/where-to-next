import React, { useState, useEffect } from 'react'
import { Link, Redirect } from 'react-router-dom'

const UpdateListing = props => {
  const [destination, setDestination] = useState({})
  const [visitedStatus, setVisitedStatus] = useState(null)
  const [shouldRedirect, setShouldRedirect] = useState(false)

  const id = props.match.params.id

  useEffect(() => {
    fetch(`/api/v1/listings/${id}`)
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
      setDestination(body.destination)
      setVisitedStatus(body.destination.user_listing.visited)
    })
    .catch(error => console.error(`Error in fetch: ${error}`))
  }, [])

  const handleClickVisited = (event) => {
    event.preventDefault()
    let payload = {
      id: id,
      visited: !visitedStatus,
    }
    fetch(`/api/v1/listings/${id}`, {
      credentials: "same-origin",
      method: "PATCH",
      headers: {
        "Content-type": "application/json",
        "Accept": "application/json"
      },
      body: JSON.stringify(payload)
    })
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
      setVisitedStatus(body.visited)
    })
    .catch(error => console.error(`Error in fetch: ${error}`))
  }

  const handleClickDelete = (event) => {
    event.preventDefault()
    let payload = {id: id}
    fetch(`/api/v1/listings/${id}`, {
      credentials: "same-origin",
      method: "DELETE",
      headers: {
        "Content-type": "application/json",
        "Accept": "application/json"
      },
      body: JSON.stringify(payload)
    })
    .then(response => {
      if (response.ok) {
        setShouldRedirect(true)
      } else {
        let errorMessage = `${response.status} (${response.statusText})`
        let error = new Error(errorMessage)
        throw(error)
      }
    })
    .catch(error => console.error(`Error in fetch: ${error}`))
  }

  let iconName = "far fa-square fa-3x"
  if (visitedStatus) {
    iconName = "far fa-check-square fa-3x"
  }

  if (shouldRedirect) {
    return (
      <Redirect to="/listings" />
    )
  } else {
    return(
      <div>
        <div className="callout">
          <h1>{destination.name}</h1>
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
          <div className="delete">
            <button
              type="button"
              className="hollow button secondary"
              onClick={handleClickDelete}
            >
              Delete this destination from my list
            </button>
          </div>
          <div className="clear" />
        </div>
        <div className="back">
          <Link to="/listings">Back to my bucket list</Link>
        </div>
      </div>
    )
  }
}

export default UpdateListing
