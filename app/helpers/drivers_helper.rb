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

  def driver_trip_action_button(driver)
    return unless driver.current_trip

    case driver.current_trip.status
    when 'pickup'
      text = 'Confirm pickup'
      action = :pickup
    when 'travel'
      text = 'Confirm dropoff'
      action = :dropoff
    else
      return
    end

    button_to text, { controller: 'drivers', action: action, driver: driver },
                    { method: :post, class: 'button success' }
  end
end
