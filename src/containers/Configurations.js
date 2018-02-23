import React from 'react'
import _ from 'lodash/fp'
import Configuration from '~/components/Configuration'

async function fetchAsync (url) {
  const response = await fetch(url)
  const data = await response.json()
  return data
}
const Configurations = class Configurations extends React.Component {
  constructor (props) {
    super(props)
    this.state = {
      configurations: [],
      toggled: []
    }
    this.toggleConfiguration = this.toggleConfiguration.bind(this)
  }
  componentDidMount () {
    fetchAsync('http://localhost:3000/download/request?host=2')
      .then(configurations => {
        this.setState({
          configurations
        })
      })
  }
  handleClick = _.curry((configuration, event) => {
    console.log('toggled: ');

    const toggled = _.find(configuration, this.state.toggled) ? _.omit(configuration, this.state.toggled) : _.concat(configuration, this.state.toggled)
    this.setState({toggled})
  })
  toggleConfiguration = (configuration) => {
    let toggled
    if (_.isUndefined(_.find(configuration, this.state.toggled))) {
      toggled = _.concat(this.state.toggled, configuration)
    } else {
      toggled = _.omit(configuration, this.state.toggled)
    }
    this.setState({toggled})
  }
  render () {
    return (
      <div>
        {
          _.map(data => {
            const handleClick = _.partial(this.toggleConfiguration, [data])
            return (
              <Configuration
                key={data.hostname}
                handleClick={handleClick}
                data={data}
                toggle={_.isUndefined(_.find(data, this.state.toggled))}
              />
            )
          }, this.state.configurations) || null
        }
      </div>
    )
  }
}
export default Configurations
