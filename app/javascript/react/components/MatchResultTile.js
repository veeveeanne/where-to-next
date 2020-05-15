import React from 'react'

const MatchResultTile = props => {
  let id = props.destination.id
  let name = props.destination.name
  let address = props.destination.address

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
    props.handleMatchClick({
      id: id
    })
  }

  return (
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

export default MatchResultTile
