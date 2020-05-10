import React from 'react'
import { BrowserRouter, Route, Switch } from 'react-router-dom'

import DestinationIndexContainer from './DestinationIndexContainer'
import NewDestinationFormContainer from './NewDestinationFormContainer'
import ListingContainer from './ListingContainer'
import UpdateListing from './UpdateListing'
import TravelPlanContainer from './TravelPlanContainer'

export const App = (props) => {
  return (
    <BrowserRouter>
      <Switch>
        <Route exact path="/destinations" component={DestinationIndexContainer} />
        <Route exact path="/destinations/new" component={NewDestinationFormContainer} />
        <Route exact path="/listings" component={ListingContainer} />
        <Route exact path="/listings/:id/update" component={UpdateListing} />
        <Route exact path="/travel" component={TravelPlanContainer} />
      </Switch>
    </BrowserRouter>
  )
}

export default App
