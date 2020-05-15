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

  const handleClick = () => {
    props.handleDestinationClick({
      name: name,
      address: address,
      latitude: location.lat,
      longitude: location.lng
    })
  }

  let display_array = []
  let address_array = address.split(", ")
  address_array.forEach((element) => {
    if (element !== "United States" && element !== "USA") {
      display_array.push(element)
    }
  })

  let addressDisplay = ""
  if (display_array.length > 0) {
    addressDisplay = display_array.join(", ")
  }

  return (
    <div
      className={classValue}
      onMouseEnter={handleMouseEnter}
      onMouseLeave={handleMouseLeave}
      onClick={handleClick}
    >
      {name} - {addressDisplay}
    </div>
  )
}

export default DestinationResultTile
