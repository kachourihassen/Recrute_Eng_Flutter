class PlanetInfo {
  final int position;
  final String name;
  final String iconImage;
  final String description;
  final String description1;
  final String prix;

  PlanetInfo(
    this.position, {
    this.name,
    this.iconImage,
    this.description,
    this.description1,
    this.prix,
  });
}

List<PlanetInfo> planets = [
  PlanetInfo(1,
      name: 'Gold',
      iconImage: 'assets/logo5_3_12052.png',
      description: 'Watch video',
      description1: '',
      prix: '10'),
  PlanetInfo(2,
      name: 'Platinum',
      iconImage: 'assets/logo5_3_12052.png',
      description: 'Question Page',
      description1: 'Watch video',
      prix: '15'),
];
