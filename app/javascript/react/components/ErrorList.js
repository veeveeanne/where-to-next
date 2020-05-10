import React from 'react'
import _ from 'lodash'

const ErrorList = props => {
  const errantFields = Object.keys(props.errors)

  if (errantFields.length > 0) {
    let index = 0
    const errorDisplay = errantFields.map((field) => {
      index ++
      return (
        <li key={index}>
          {_.startCase(field)} {props.errors[field]}
        </li>
      )
    })
    return errorDisplay
  } else {
    return ""
  }
}

export default ErrorList
