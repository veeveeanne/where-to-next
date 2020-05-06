import React, { useState } from 'react'

const ListingTile = props => {
  const id = props.destination.id.toString()
  const name = props.destination.name
  const state = props.destination.state

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
    <h3
      className={classValue}
      onMouseEnter={handleMouseEnter}
      onMouseLeave={handleMouseLeave}
    >
      {`${name}, ${state}`}
    </h3>
  )
}

export default ListingTile
