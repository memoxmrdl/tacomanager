require 'test_helper'

feature 'EstablishmentsManagement Feature Test' do
  background do
    mock_omniauth
  end

  scenario 'when a user create establishment' do
    login_user

    visit '/dashboard/establishments/new'

    within('#new_establishment') do
      fill_in 'establishment_name', with: 'Tacos el gordo'
      fill_in 'establishment_schedule', with: '9:00am - 10:00pm'
      fill_in 'establishment_phone', with: '32 4 2459'
      fill_in 'establishment_address_attributes_street', with: 'Av. Constitucion #45'
      fill_in 'establishment_address_attributes_city', with: 'Colima'
      fill_in 'establishment_address_attributes_state', with: 'Colima'
      fill_in 'establishment_address_attributes_country', with: 'Mexico'
      fill_in 'establishment_address_attributes_zip_code', with: '28017'
    end

    click_button 'Guardar'

    page.must_have_selector '.notice', text: 'Establecimiento creado'
  end

  scenario 'when a user create invalid establishment' do
    login_user

    visit '/dashboard/establishments/new'

    click_button 'Guardar'

    page.must_have_selector '.alert', text: 'Surgio un error al guardar'
  end

  scenario 'user would see a establishment' do
    login_user

    testing = Establishment.create name: 'Test food', user_id: 100

    visit '/dashboard/establishments'
    save_and_open_page

    page.must_have_selector ".establishment[data-establishment-id='#{testing.id}']", text: testing.name
  end
end
