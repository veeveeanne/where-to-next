import React from 'react'

const ListingSave = props => {
  if (props.location.destination) {
    let location = props.location.destination.destination

    return(
      <div>
      <p>Is the location you would like to visit</p>
      <p>{`${location.name} in ${location.state}`}</p>
      <p>{location.address}</p>
      </div>
    )
  } else {
    return(
      <div>nothing to see here</div>
    )
  }
}

export default ListingSave
