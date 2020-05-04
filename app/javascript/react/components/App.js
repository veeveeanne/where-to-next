import React from 'react'
import { BrowserRouter, Route, Switch } from 'react-router-dom'

import DestinationIndexContainer from './DestinationIndexContainer'
import DestinationFormContainer from './DestinationFormContainer'

export const App = (props) => {
  return (
    <BrowserRouter>
      <Switch>
        <Route exact path="/destinations" component={DestinationIndexContainer}/>
        <Route exact path="/destinations/new" component={DestinationFormContainer}/>
      </Switch>
    </BrowserRouter>
  )
}

export default App
