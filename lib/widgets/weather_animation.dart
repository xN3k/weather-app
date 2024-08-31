String weatherAnimation(String? condition) {
  if (condition == null || condition == 'clear') {
    return 'assets/animations/sunny.json';
  }

  switch (condition.toLowerCase()) {
    case 'clouds':
      return 'assets/animations/cloudy-day.json';
    case 'rain':
    case 'thunderstorm':
      return 'assets/animations/rainning.json';
    case 'wind':
    case 'mist':
    case 'Drizzle':
    case 'Smoke':
    case 'Fog':
    case 'Dust':
      return 'assets/animations/wind.json';
    case 'snow':
      return 'assets/animations/snow.json';
    default:
      return 'assets/animations/sunny.json';
  }
}
