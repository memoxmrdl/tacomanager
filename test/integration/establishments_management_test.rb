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
      fill_in 'establishment_address_street', with: 'Av. Constitucion #45'
      fill_in 'establishment_address_city', with: 'Colima'
      fill_in 'establishment_address_state', with: 'Colima'
      fill_in 'establishment_address_country', with: 'Mexico'
      fill_in 'establishment_address_zip_code', with: '28017'
    end

    click_button 'Guardar'

    page.must_have_selector('.notice', text: 'Establecimiento creado')
  end
end
