import React from 'react'

const DestinationResultTile = props => {
  let id = props.destination.place_id
  let name = props.destination.name
  let address = props.destination.formatted_address
  let location = props.destination.geometry.location

  const handleMouseEnter = () => {
    props.setSelectedLine(id)
  }

  const handleMouseLeave = () => {
    props.setSelectedLine(null)
  }

  let classValue = ""
  if (props.selectedLine === id) {
    classValue = "text-selected"
  }

  const handleClick = (event) => {
    props.handleDestinationClick({
      name: name,
      address: address,
      latitude: location.lat,
      longitude: location.lng
    })
  }

  return(
    <div
      className={classValue}
      onMouseEnter={handleMouseEnter}
      onMouseLeave={handleMouseLeave}
      onClick={handleClick}
    >
      {name} - {address}
    </div>
  )
}

export default DestinationResultTile
