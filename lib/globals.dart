import 'dart:ui';

const Map<String, Color> resourceColorMap1 = {
  "a1": Color(0xFFCF202A),
  "kva1": Color(0xFF4498FB),
  "kw1": Color(0xFF50C878),
  "v1": Color(0xFFFF7518),
  "kwh": Color(0xFF9966CC),
  "kvah": Color(0xFFFFCB67),
  "Connected": Color(0xFF9966CC),
  "Total lamps": Color(0xFF9966CC),
  "Power consumed": Color(0xFF9966CC),
  "Fault lamps": Color(0xFF9966CC)
};
const Map<String, Color> resourceColorMap2 = {
  "a1": Color(0xFFFF7E71),
  "kva1": Color(0xFFC7FFFF),
  "kw1": Color(0xFFA8FFC9),
  "kvah": Color(0xFFFFE486),
  "kwh": Color(0xFFF0DAFF),
  "v1": Color(0xFFFF7E71),
  "Connected": Color(0xFFF0DAFF),
  "Fault lamps": Color(0xFFF0DAFF),
  "Total lamps": Color(0xFFF0DAFF),
  "Power consumed": Color(0xFFF0DAFF)
};
class CCMSCheck {
  String ccmsName;
  bool isVisible;

  CCMSCheck({required this.ccmsName, required this.isVisible});
}