/// Map of TIRADS composition choices with their descriptions and scores.
final Map<String, String> tiradsComposition = {
  "cystic": "Cystic or almost completely cystic (0)",
  "spongiform": "Spongiform (0)",
  "mixed": "Mixed cystic and solid (1)",
  "solid": "Solid or almost completely solid (2)",
  "undetermined": "Cannot be determined due to calcification (2)",
};

final Map<String, String> tiradsEchogenicity = {
    "an": "Anechoic (0)",
    "hyper": "Hyperechoic or Isoechoic (1)",
    "iso": "Isoechoic (1)",
    "hypo": "Hypoechoic (2)",
    "very-hypo": "Very hypoechoic (3)",
    "undetermined": "Can not be determined (1)"
};