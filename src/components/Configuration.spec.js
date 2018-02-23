import React from 'react'
import _ from 'lodash/fp'
import {configurations} from '~/json/configurations.json'
import Configuration from './Configuration'
describe('<Configuration />', () => {
  it('should render', () => {
    const data = configurations[0]
    const wrapper = shallow(<Configuration data={data} />)
    expect(wrapper).toHaveClassName('wrapper')
    expect(wrapper.childAt(0).dive().find('li')).toHaveLength(_.size(_.keys(data)))
  })
})
