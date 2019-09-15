class ArtilleryAdvisor < Advisor
  def compilers
    [
      MissileArtilleryCompiler,
      LaserArtilleryCompiler,
      HeavyLaserArtilleryCompiler,
      GaussArtilleryCompiler,
      IonArtilleryCompiler,
      PlasmaArtilleryCompiler,
      WeaponTechCompiler,
      ShieldTechCompiler,
      ArmorTechCompiler,
    ]
  end
end
