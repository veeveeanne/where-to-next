import React from 'react'
import { BrowserRouter, Route, Switch } from 'react-router-dom'

import DestinationsIndexContainer from './DestinationsIndexContainer'

export const App = (props) => {
  return (
    <BrowserRouter>
      <Switch>
        <Route exact path="/destinations" component={DestinationsIndexContainer}/>
      </Switch>
    </BrowserRouter>
  )
}

export default App
