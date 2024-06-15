abstract class BaseService{
  final String baseURL = "https://api.openweathermap.org/data/2.5/weather";
  // final String appId = "7094d3991048d0bfc1407d35dee9a0a3";
  final String appIdPath = "&appid=7094d3991048d0bfc1407d35dee9a0a3";

  Future<dynamic> getResponse(String city);
  Future<dynamic> getResponseByLocation(double lat, double long);
}