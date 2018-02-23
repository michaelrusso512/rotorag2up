## `yarn install &&  npx json-server --watch db.json --routes routes.json`

## (in a separate window) `yarn run start:dev`

1) A server sends the following data when requesting 'http://[yourserver]/download/request?host=2'  :

{
"configurations" : [
     {
        "name" : "host1",
        "hostname" : "nessus-ntp.lab.com",
        "port" : 1241,
        "username" : "toto"
     },
     {
        "name" : "host2",
        "hostname" : "nessus-xml.lab.com",
        "port" : 3384,
        "username" : "admin"
     }
 ]
}

Write an HTML/JS code to send this request and display the result.

```
async function fetchAsync (url) {
  const response = await fetch(url)
  const data = await response.json()
  return data
}

componentDidMount () {
  fetchAsync('http://localhost:3000/download/request?host=2')
    .then(configurations => {
      this.setState({
        configurations
      })
    })
}
```
2) Use jQuery to add some style and design to the previous code.
I avoid using jQuery unless absolutely necessary, especially with React, since it bypasses the Virtual Dom

3) Add some CSS design/style
See source code

4) Use the React framework and any additonal JavaScript libraries in the React ecosystem that you want and/or like to show us your skills on this small web application.

5) instead of sending host=2 you now send host=10000 and the response contains 10000 fields. How would you handle that? What could be improved to get the best performance?

- Performance can be improved by minimizing bandwith (paging, caches, etc.) and minimizing DOM operations. The latter can be accomplished by rendering only what is visible in the browser, as DOM operations are expensive. For example, with a large scrolling table, we keep the records in memory, only rendering and mounting those records that fall within the visible space. The bounding area dimensions be retrieved from the DOM and stored in `state` via componentDidMount and componentDidUpdate.
