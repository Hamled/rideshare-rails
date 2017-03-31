module DriversHelper
  def driver_activate_button(driver)
    if driver.active?
      text = 'Go Offline'
      style = 'button alert'
    else
      text = 'Go Online'
      style = 'button success'
    end

    button_to text, activate_driver_path(driver), method: :post, class: style
  end
end
