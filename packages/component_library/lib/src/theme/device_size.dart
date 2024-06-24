class DeviceSize {

  final double width;

  const DeviceSize({
    required this.width,
  });

   bool get isTablet  {
    return width >= 520;
  }
}