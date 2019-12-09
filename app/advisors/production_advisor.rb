class ProductionAdvisor < Advisor
  def compilers
    [
      MetalMineCompiler,
      CristalMineCompiler,
      DeuteriumMineCompiler,
      PlasmaTechCompiler,
      AstrophysicsTechCompiler,
      MetalStorageCompiler,
      CristalStorageCompiler,
      DeuteriumStorageCompiler,
    ]
  end
end
