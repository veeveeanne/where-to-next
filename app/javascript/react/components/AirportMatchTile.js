import React from 'react'
import _ from 'lodash'

const AirportMatchTile = props => {
  let id = props.airport.id
  let name = _.lowerCase(props.airport.name.replace("INTL", "International"))
  let city = _.lowerCase(props.airport.city)
  let iataCode = props.airport.iata_code

  name = _.startCase(`${name} Airport`)
  city = _.startCase(city)

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
    props.handleClick(iataCode)
  }

  return(
    <div
      onMouseEnter={handleMouseEnter}
      onMouseLeave={handleMouseLeave}
      onClick={handleClick}
      className={classValue}
    >
      {name}, {city}
    </div>
  )
}

export default AirportMatchTile
