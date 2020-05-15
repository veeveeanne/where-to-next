const deleteListing = (id, payload) => {
  return (
    fetch(`/api/v1/listings/${id}`, {
      credentials: "same-origin",
      method: "DELETE",
      headers: {
        "Content-type": "application/json",
        "Accept": "application/json"
      },
      body: JSON.stringify(payload)
    })
    .then(response => {
      if (response.ok) {
        return true
      } else {
        let errorMessage = `${response.status} (${response.statusText})`
        let error = new Error(errorMessage)
        throw(error)
      }
    })
    .catch(error => console.error(`Error in fetch: ${error}`))
  )
}

export default deleteListing
