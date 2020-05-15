import React from 'react'
import { usePromiseTracker } from 'react-promise-tracker'
import Loader from 'react-loader-spinner'

const SpinnerComponent = props => {
  const { promiseInProgress } = usePromiseTracker()

  return(
    promiseInProgress && (
      <div className="form-spacer">
        <h5 className="wait-msg">Please wait while we take a look at flight prices and evaluate the cheapest destination</h5>
        <div className="spinner">
          <Loader
            type="ThreeDots"
            color="#028090"
            height="100"
            width="100"
            />
        </div>
      </div>
    )
  )
}

export default SpinnerComponent
