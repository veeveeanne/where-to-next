import React from 'react'

const DestinationResultTile = props => {
  let name = props.destination.name
  let address = props.destination.formatted_address
  let location = props.destination.geometry.location

  const handleClick = (event) => {
    props.handleDestinationClick({
      name: name,
      address: address,
      latitude: location.lat,
      longitude: location.lng
    })
  }

  return(
    <div onClick={handleClick}>
      {name} - {address}
    </div>
  )
}

export default DestinationResultTile
