{ system
  , compiler
  , flags
  , pkgs
  , hsPkgs
  , pkgconfPkgs
  , errorHandler
  , config
  , ... }:
  ({
    flags = {};
    package = {
      specVersion = "2.2";
      identifier = { name = "algebraic-graphs"; version = "0.6.1"; };
      license = "MIT";
      copyright = "Andrey Mokhov, 2016-2022";
      maintainer = "Andrey Mokhov <andrey.mokhov@gmail.com>, github: @snowleopard,\nAlexandre Moine <alexandre@moine.me>, github: @nobrakal";
      author = "Andrey Mokhov <andrey.mokhov@gmail.com>, github: @snowleopard";
      homepage = "https://github.com/snowleopard/alga";
      url = "";
      synopsis = "A library for algebraic graph construction and transformation";
      description = "<https://github.com/snowleopard/alga Alga> is a library for algebraic construction and\nmanipulation of graphs in Haskell. See <https://github.com/snowleopard/alga-paper this paper>\nfor the motivation behind the library, the underlying theory and implementation details.\n\nThe top-level module\n<http://hackage.haskell.org/package/algebraic-graphs/docs/Algebra-Graph.html Algebra.Graph>\ndefines the main data type for /algebraic graphs/\n<http://hackage.haskell.org/package/algebraic-graphs/docs/Algebra-Graph.html#t:Graph Graph>,\nas well as associated algorithms. For type-safe representation and\nmanipulation of /non-empty algebraic graphs/, see\n<http://hackage.haskell.org/package/algebraic-graphs/docs/Algebra-Graph-NonEmpty.html Algebra.Graph.NonEmpty>.\nFurthermore, /algebraic graphs with edge labels/ are implemented in\n<http://hackage.haskell.org/package/algebraic-graphs/docs/Algebra-Graph-Labelled.html Algebra.Graph.Labelled>.\n\nThe library also provides conventional graph data structures, such as\n<http://hackage.haskell.org/package/algebraic-graphs/docs/Algebra-Graph-AdjacencyMap.html Algebra.Graph.AdjacencyMap>\nalong with its various flavours:\n\n* adjacency maps specialised to graphs with vertices of type 'Int'\n(<http://hackage.haskell.org/package/algebraic-graphs/docs/Algebra-Graph-AdjacencyIntMap.html Algebra.Graph.AdjacencyIntMap>),\n* non-empty adjacency maps\n(<http://hackage.haskell.org/package/algebraic-graphs/docs/Algebra-Graph-NonEmpty-AdjacencyMap.html Algebra.Graph.NonEmpty.AdjacencyMap>),\n* adjacency maps for undirected bipartite graphs\n(<http://hackage.haskell.org/package/algebraic-graphs/docs/Algebra-Graph-Bipartite-AdjacencyMap.html Algebra.Graph.Bipartite.AdjacencyMap>),\n* adjacency maps with edge labels\n(<http://hackage.haskell.org/package/algebraic-graphs/docs/Algebra-Graph-Labelled-AdjacencyMap.html Algebra.Graph.Labelled.AdjacencyMap>),\n* acyclic adjacency maps\n(<http://hackage.haskell.org/package/algebraic-graphs/docs/Algebra-Graph-Acyclic-AdjacencyMap.html Algebra.Graph.Acyclic.AdjacencyMap>),\n\nA large part of the API of algebraic graphs and adjacency maps is available\nthrough the 'Foldable'-like type class\n<http://hackage.haskell.org/package/algebraic-graphs/docs/Algebra-Graph-ToGraph.html Algebra.Graph.ToGraph>.\n\nThe type classes defined in\n<http://hackage.haskell.org/package/algebraic-graphs/docs/Algebra-Graph-Class.html Algebra.Graph.Class>\nand\n<http://hackage.haskell.org/package/algebraic-graphs/docs/Algebra-Graph-HigherKinded-Class.html Algebra.Graph.HigherKinded.Class>\ncan be used for polymorphic construction and manipulation of graphs.\n\nThis is an experimental library and the API is expected to remain unstable until version 1.0.0.\nPlease consider contributing to the on-going\n<https://github.com/snowleopard/alga/issues discussions on the library API>.";
      buildType = "Simple";
    };
    components = {
      "library" = {
        depends = [
          (hsPkgs."array" or (errorHandler.buildDepError "array"))
          (hsPkgs."base" or (errorHandler.buildDepError "base"))
          (hsPkgs."containers" or (errorHandler.buildDepError "containers"))
          (hsPkgs."deepseq" or (errorHandler.buildDepError "deepseq"))
          (hsPkgs."transformers" or (errorHandler.buildDepError "transformers"))
        ];
        buildable = true;
      };
      tests = {
        "test-alga" = {
          depends = [
            (hsPkgs."array" or (errorHandler.buildDepError "array"))
            (hsPkgs."base" or (errorHandler.buildDepError "base"))
            (hsPkgs."containers" or (errorHandler.buildDepError "containers"))
            (hsPkgs."deepseq" or (errorHandler.buildDepError "deepseq"))
            (hsPkgs."transformers" or (errorHandler.buildDepError "transformers"))
            (hsPkgs."algebraic-graphs" or (errorHandler.buildDepError "algebraic-graphs"))
            (hsPkgs."extra" or (errorHandler.buildDepError "extra"))
            (hsPkgs."inspection-testing" or (errorHandler.buildDepError "inspection-testing"))
            (hsPkgs."QuickCheck" or (errorHandler.buildDepError "QuickCheck"))
          ];
          buildable = true;
        };
      };
    };
  } // {
    src = pkgs.lib.mkDefault (pkgs.fetchurl {
      url = "http://hackage.haskell.org/package/algebraic-graphs-0.6.1.tar.gz";
      sha256 = "2d64982591929cbc9a2f184eeb7271b8a4096672fe725c928ea4b97aeac40a99";
    });
  }) // {
    package-description-override = "cabal-version: 2.2\r\nname:          algebraic-graphs\r\nversion:       0.6.1\r\nx-revision: 1\r\nsynopsis:      A library for algebraic graph construction and transformation\r\nlicense:       MIT\r\nlicense-file:  LICENSE\r\nauthor:        Andrey Mokhov <andrey.mokhov@gmail.com>, github: @snowleopard\r\nmaintainer:    Andrey Mokhov <andrey.mokhov@gmail.com>, github: @snowleopard,\r\n               Alexandre Moine <alexandre@moine.me>, github: @nobrakal\r\ncopyright:     Andrey Mokhov, 2016-2022\r\nhomepage:      https://github.com/snowleopard/alga\r\nbug-reports:   https://github.com/snowleopard/alga/issues\r\ncategory:      Algebra, Algorithms, Data Structures, Graphs\r\nbuild-type:    Simple\r\ntested-with:   GHC==9.2, GHC==9.0, GHC==8.10, GHC==8.8, GHC==8.6, GHC==8.4\r\ndescription:\r\n    <https://github.com/snowleopard/alga Alga> is a library for algebraic construction and\r\n    manipulation of graphs in Haskell. See <https://github.com/snowleopard/alga-paper this paper>\r\n    for the motivation behind the library, the underlying theory and implementation details.\r\n    .\r\n    The top-level module\r\n    <http://hackage.haskell.org/package/algebraic-graphs/docs/Algebra-Graph.html Algebra.Graph>\r\n    defines the main data type for /algebraic graphs/\r\n    <http://hackage.haskell.org/package/algebraic-graphs/docs/Algebra-Graph.html#t:Graph Graph>,\r\n    as well as associated algorithms. For type-safe representation and\r\n    manipulation of /non-empty algebraic graphs/, see\r\n    <http://hackage.haskell.org/package/algebraic-graphs/docs/Algebra-Graph-NonEmpty.html Algebra.Graph.NonEmpty>.\r\n    Furthermore, /algebraic graphs with edge labels/ are implemented in\r\n    <http://hackage.haskell.org/package/algebraic-graphs/docs/Algebra-Graph-Labelled.html Algebra.Graph.Labelled>.\r\n    .\r\n    The library also provides conventional graph data structures, such as\r\n    <http://hackage.haskell.org/package/algebraic-graphs/docs/Algebra-Graph-AdjacencyMap.html Algebra.Graph.AdjacencyMap>\r\n    along with its various flavours:\r\n    .\r\n    * adjacency maps specialised to graphs with vertices of type 'Int'\r\n    (<http://hackage.haskell.org/package/algebraic-graphs/docs/Algebra-Graph-AdjacencyIntMap.html Algebra.Graph.AdjacencyIntMap>),\r\n    * non-empty adjacency maps\r\n    (<http://hackage.haskell.org/package/algebraic-graphs/docs/Algebra-Graph-NonEmpty-AdjacencyMap.html Algebra.Graph.NonEmpty.AdjacencyMap>),\r\n    * adjacency maps for undirected bipartite graphs\r\n    (<http://hackage.haskell.org/package/algebraic-graphs/docs/Algebra-Graph-Bipartite-AdjacencyMap.html Algebra.Graph.Bipartite.AdjacencyMap>),\r\n    * adjacency maps with edge labels\r\n    (<http://hackage.haskell.org/package/algebraic-graphs/docs/Algebra-Graph-Labelled-AdjacencyMap.html Algebra.Graph.Labelled.AdjacencyMap>),\r\n    * acyclic adjacency maps\r\n    (<http://hackage.haskell.org/package/algebraic-graphs/docs/Algebra-Graph-Acyclic-AdjacencyMap.html Algebra.Graph.Acyclic.AdjacencyMap>),\r\n    .\r\n    A large part of the API of algebraic graphs and adjacency maps is available\r\n    through the 'Foldable'-like type class\r\n    <http://hackage.haskell.org/package/algebraic-graphs/docs/Algebra-Graph-ToGraph.html Algebra.Graph.ToGraph>.\r\n    .\r\n    The type classes defined in\r\n    <http://hackage.haskell.org/package/algebraic-graphs/docs/Algebra-Graph-Class.html Algebra.Graph.Class>\r\n    and\r\n    <http://hackage.haskell.org/package/algebraic-graphs/docs/Algebra-Graph-HigherKinded-Class.html Algebra.Graph.HigherKinded.Class>\r\n    can be used for polymorphic construction and manipulation of graphs.\r\n    .\r\n    This is an experimental library and the API is expected to remain unstable until version 1.0.0.\r\n    Please consider contributing to the on-going\r\n    <https://github.com/snowleopard/alga/issues discussions on the library API>.\r\n\r\nextra-doc-files:\r\n    AUTHORS.md\r\n    CHANGES.md\r\n    README.md\r\n\r\nsource-repository head\r\n    type:     git\r\n    location: https://github.com/snowleopard/alga.git\r\n\r\ncommon common-settings\r\n    build-depends:      array        >= 0.4     && < 0.6,\r\n                        base         >= 4.11    && < 5,\r\n                        containers   >= 0.5.5.1 && < 0.8,\r\n                        deepseq      >= 1.3.0.1 && < 1.5,\r\n                        transformers >= 0.4     && < 0.7\r\n    default-language:   Haskell2010\r\n    default-extensions: ConstraintKinds\r\n                        DeriveFunctor\r\n                        DeriveGeneric\r\n                        FlexibleContexts\r\n                        FlexibleInstances\r\n                        GADTs\r\n                        GeneralizedNewtypeDeriving\r\n                        MultiParamTypeClasses\r\n                        RankNTypes\r\n                        ScopedTypeVariables\r\n                        TupleSections\r\n                        TypeApplications\r\n                        TypeFamilies\r\n    other-extensions:   CPP\r\n                        OverloadedStrings\r\n                        RecordWildCards\r\n                        ViewPatterns\r\n    ghc-options:        -Wall\r\n                        -Wcompat\r\n                        -Wincomplete-record-updates\r\n                        -Wincomplete-uni-patterns\r\n                        -Wredundant-constraints\r\n                        -fno-warn-name-shadowing\r\n                        -fno-warn-unused-imports\r\n                        -fspec-constr\r\n\r\nlibrary\r\n    import:             common-settings\r\n    hs-source-dirs:     src\r\n    exposed-modules:    Algebra.Graph,\r\n                        Algebra.Graph.Undirected,\r\n                        Algebra.Graph.Acyclic.AdjacencyMap,\r\n                        Algebra.Graph.AdjacencyIntMap,\r\n                        Algebra.Graph.AdjacencyIntMap.Algorithm,\r\n                        Algebra.Graph.AdjacencyMap,\r\n                        Algebra.Graph.AdjacencyMap.Algorithm,\r\n                        Algebra.Graph.Bipartite.AdjacencyMap,\r\n                        Algebra.Graph.Bipartite.AdjacencyMap.Algorithm,\r\n                        Algebra.Graph.Class,\r\n                        Algebra.Graph.Example.Todo,\r\n                        Algebra.Graph.Export,\r\n                        Algebra.Graph.Export.Dot,\r\n                        Algebra.Graph.HigherKinded.Class,\r\n                        Algebra.Graph.Internal,\r\n                        Algebra.Graph.Label,\r\n                        Algebra.Graph.Labelled,\r\n                        Algebra.Graph.Labelled.AdjacencyMap,\r\n                        Algebra.Graph.Labelled.Example.Automaton,\r\n                        Algebra.Graph.Labelled.Example.Network,\r\n                        Algebra.Graph.NonEmpty,\r\n                        Algebra.Graph.NonEmpty.AdjacencyMap,\r\n                        Algebra.Graph.Relation,\r\n                        Algebra.Graph.Relation.Preorder,\r\n                        Algebra.Graph.Relation.Reflexive,\r\n                        Algebra.Graph.Relation.Symmetric,\r\n                        Algebra.Graph.Relation.Transitive,\r\n                        Algebra.Graph.ToGraph,\r\n                        Data.Graph.Typed\r\n\r\ntest-suite test-alga\r\n    import:             common-settings\r\n    hs-source-dirs:     test\r\n    type:               exitcode-stdio-1.0\r\n    main-is:            Main.hs\r\n    other-modules:      Algebra.Graph.Test,\r\n                        Algebra.Graph.Test.API,\r\n                        Algebra.Graph.Test.Acyclic.AdjacencyMap,\r\n                        Algebra.Graph.Test.AdjacencyIntMap,\r\n                        Algebra.Graph.Test.AdjacencyMap,\r\n                        Algebra.Graph.Test.Arbitrary,\r\n                        Algebra.Graph.Test.Bipartite.AdjacencyMap,\r\n                        Algebra.Graph.Test.Example.Todo\r\n                        Algebra.Graph.Test.Export,\r\n                        Algebra.Graph.Test.Generic,\r\n                        Algebra.Graph.Test.Graph,\r\n                        Algebra.Graph.Test.Undirected,\r\n                        Algebra.Graph.Test.Internal,\r\n                        Algebra.Graph.Test.Label,\r\n                        Algebra.Graph.Test.Labelled.AdjacencyMap,\r\n                        Algebra.Graph.Test.Labelled.Graph,\r\n                        Algebra.Graph.Test.NonEmpty.AdjacencyMap,\r\n                        Algebra.Graph.Test.NonEmpty.Graph,\r\n                        Algebra.Graph.Test.Relation,\r\n                        Algebra.Graph.Test.Relation.Symmetric,\r\n                        Algebra.Graph.Test.RewriteRules,\r\n                        Data.Graph.Test.Typed\r\n    build-depends:      algebraic-graphs,\r\n                        extra              >= 1.4     && < 2,\r\n                        inspection-testing >= 0.4.6.0 && < 0.5,\r\n                        QuickCheck         >= 2.14    && < 2.15\r\n    other-extensions:   ConstrainedClassMethods\r\n                        TemplateHaskell\r\n";
  }