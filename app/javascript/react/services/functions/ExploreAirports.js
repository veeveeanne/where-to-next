const exploreAirports = (payload) => {
  return (
    fetch(`/api/v1/airports/explore?keyword=${payload}`)
    .then(response => {
      if (response.ok) {
        return response
      } else {
        let errorMessage = `${response.status} (${response.statusText})`
        let error = new Error(errorMessage)
        throw(error)
      }
    })
    .then(response => response.json())
    .catch(error => console.error(`Error in fetch: ${error}`))
  )
}

export default exploreAirports
