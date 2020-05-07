import React, { useState } from 'react'
import { Link } from 'react-router-dom'

const ListingTile = props => {
  const id = props.destination.id.toString()
  const name = props.destination.name
  const state = props.destination.state
  const listing = props.destination.user_listing

  const handleMouseEnter = () => {
    props.setSelectedLine(id)
  }

  const handleMouseLeave = () => {
    props.setSelectedLine(null)
  }

  let classValue="tile text"
  if (props.selectedLine === id) {
    classValue="tile text-selected"
  }

  return(
    <div>
    <Link to={{
        pathname: `/listings/${listing.id}/update`,
        state: { destination: props.destination }
      }}
    >
      <h3
        className={classValue}
        onMouseEnter={handleMouseEnter}
        onMouseLeave={handleMouseLeave}
      >
        {`${name}, ${state}`}
      </h3>
    </Link>

    </div>
  )
}

export default ListingTile
