import React from 'react'
import { BrowserRouter, Route, Switch } from 'react-router-dom'

import DestinationIndexContainer from './DestinationIndexContainer'
import DestinationFormContainer from './DestinationFormContainer'
import ListingSave from './ListingSave'

export const App = (props) => {
  return (
    <BrowserRouter>
      <Switch>
        <Route exact path="/destinations" component={DestinationIndexContainer}/>
        <Route exact path="/destinations/new" component={DestinationFormContainer}/>
        <Route exact path="/listings/new" component={ListingSave}/>
      </Switch>
    </BrowserRouter>
  )
}

export default App
