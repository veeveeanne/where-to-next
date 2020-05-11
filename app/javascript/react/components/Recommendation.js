import React from 'react'

const Recommendation = props => {
  return(
    <div className="callout-container">
      <div className="callout">
        <h1>You should travel to:</h1>
        <h1>{props.city}</h1>
      </div>
    </div>
  )
}

export default Recommendation
