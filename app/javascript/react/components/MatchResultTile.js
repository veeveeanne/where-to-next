import React from 'react'

const MatchResultTile = props => {
  let id = props.destination.id
  let name = props.destination.name
  let address = props.destination.address

  const handleClick = (event) => {
    props.handleMatchClick({
      id: id
    })
  }

  return(
    <div onClick={handleClick}>
      {name} - {address}
    </div>
  )
}

export default MatchResultTile
