import { mount } from '@vue/test-utils'
import { store } from '../../../app/packs/src/store'
import Home from '@/pages/Home.vue'

describe('Home', () => {
  const wrapper = mount(Home, {
    props: {
      name: 'World',
    },
    global: {
      plugins: [store]
    }
  })

  test('renders name', () => {
    const title = wrapper.find('h1')?.element?.textContent?.trim()
    expect(title).toEqual('Hello World!')
  })

  test('matches snapshot', () => {
    expect(wrapper.html()).toMatchSnapshot()
  })

  test('counts button clicks', async () => {
    const button = wrapper.find('button')
    await button.trigger('click')
    await button.trigger('click')

    expect(button.html()).toContain('Clicks: 2')
  })
})