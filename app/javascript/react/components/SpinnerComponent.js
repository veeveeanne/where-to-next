import React from 'react'
import { usePromiseTracker } from 'react-promise-tracker'
import Loader from 'react-loader-spinner'

const SpinnerComponent = props => {
  const { promiseInProgress } = usePromiseTracker()

  return(
    promiseInProgress && (
      <div className="spinner">
        <Loader
          type="ThreeDots"
          color="#028090"
          height="100"
          width="100"
        />
      </div>
    )
  )
}

export default SpinnerComponent
