# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).ready ->
  $('form').submit ->
    address = $('#address').val()
    $.ajax
      url: 'http://gothere.sg/maps/geo'
      dataType: 'jsonp'
      data:
        'output': 'json'
        'q': address
        'client': ''
        'sensor': false
      type: 'GET'
      success: (data) ->
        `var status`
        field = $('textarea')
        myString = ''
        status = data.Status
        myString += 'Status.code: ' + status.code + '\n'
        myString += 'Status.request: ' + status.request + '\n'
        myString += 'Status.name: ' + status.name + '\n'
        if status.code == 200
          i = 0
          while i < data.Placemark.length
            placemark = data.Placemark[i]
            status = data.Status[i]
            myString += '============================\n'
            myString += 'Address:'+placemark.address + '\n'
            myString += placemark.AddressDetails.Country.CountryName + '\n'
            myString += 'Coordinates: [' + placemark.Point.coordinates[0] + ', ' + placemark.Point.coordinates[1] + ', ' + placemark.Point.coordinates[2] + ']\n'
            myString += '============================\n'
#            myString += '============================\n'
#            myString += 'Placemark.id: ' + placemark.id + '\n'
#            myString += 'Placemark.address: ' + placemark.address + '\n'
#            myString += 'Placemark.AddressDetails.Country.CountryName: ' + placemark.AddressDetails.Country.CountryName + '\n'
#            myString += 'Placemark.AddressDetails.Country.AddressLine: ' + placemark.AddressDetails.Country.AddressLine + '\n'
#            myString += 'Placemark.AddressDetails.Country.Thoroughfare.ThoroughfareName: ' + placemark.AddressDetails.Country.Thoroughfare.ThoroughfareName + '\n'
#            myString += 'Placemark.AddressDetails.Country.CountryNameCode: ' + placemark.AddressDetails.Country.CountryNameCode + '\n'
#            myString += 'Placemark.AddressDetails.Accuracy: ' + placemark.AddressDetails.Accuracy + '\n'
#            myString += 'Placemark.Point.coordinates: [' + placemark.Point.coordinates[0] + ', ' + placemark.Point.coordinates[1] + ', ' + placemark.Point.coordinates[2] + ']\n'
#            myString += '============================\n'
            i++
          field.val myString
        else if status.code == 603
          field.val 'No Record Found'
        return
      statusCode: 404: ->
        alert 'Page not found'
        return
    false
  return