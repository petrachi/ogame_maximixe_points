class ProductionAdvisor < Advisor
  def compilers
    [
      MetalMineCompiler,
      CristalMineCompiler,
      DeuteriumMineCompiler,
      PlasmaTechCompiler,
      MetalStorageCompiler,
      CristalStorageCompiler,
      DeuteriumStorageCompiler,
    ]
  end
end
