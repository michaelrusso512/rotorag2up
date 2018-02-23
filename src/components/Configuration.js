import React from 'react'
import _ from 'lodash/fp'
import Style from './Configuration.css'
import classnames from 'classnames'
import {object, bool, string, func} from 'prop-types'

const Configuration = class Configuration extends React.Component {

  render () {
    const {data, className} = this.props
    const json = JSON.stringify(data)
    return (
      <div className={classnames(Style.wrapper, className)}>
        <pre className={Style.json}>{json}</pre>
      </div>
    )
  }
}

Configuration.propTypes = {
  data: object,
  className: string
}
export default Configuration
