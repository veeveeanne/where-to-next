import React from 'react'
import { BrowserRouter, Route, Switch } from 'react-router-dom'

import DestinationIndexContainer from '../containers/DestinationIndexContainer'
import ListingContainer from '../containers/ListingContainer'
import ListingShowContainer from '../containers/ListingShowContainer'
import TravelPlanContainer from '../containers/TravelPlanContainer'
import RecommendationContainer from '../containers/RecommendationContainer'

export const App = (props) => {
  return (
    <div>
      <BrowserRouter>
        <Switch>
          <Route exact path="/destinations" component={DestinationIndexContainer} />
          <Route exact path="/listings" component={ListingContainer} />
          <Route exact path="/listings/:id/update" component={ListingShowContainer} />
          <Route exact path="/travel" component={TravelPlanContainer} />
          <Route exact path="/travel/recommendation" component={RecommendationContainer} />
        </Switch>
      </BrowserRouter>
    </div>
  )
}

export default App
