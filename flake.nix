{
  description = "repopack";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = inputs: {
    packages = builtins.mapAttrs
      (system: _:
        let pkgs = inputs.nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.buildNpmPackage rec {
            pname = "repopack";
            version = "0.1.34";

            src = pkgs.fetchFromGitHub {
              owner = "yamadashy";
              repo = pname;
              rev = "v${version}";
              hash = "sha256-F0ifOOA66gGyBJvQl9JAjLD8R7g3lf6NHA2OQ4v8y6A=";
            };

            npmDepsHash = "sha256-S70qCR8II/33C27qs9t2kOM8ZjM4sSh4V3X7cobsSL4=";

            # The prepack script runs the build script, which we'd rather do in the build phase.
            npmPackFlags = [ "--ignore-scripts " ];

            NODE_OPTIONS = "--openssl-legacy-provider ";

            buildPhase = ''
              runHook preBuild
              npm run build
              runHook postBuild
            '';

            installPhase = ''
              runHook preInstall
              mkdir -p $out/lib/node_modules/${pname}
              cp -r . $out/lib/node_modules/${pname}
              mkdir -p $out/bin
              ln -s $out/lib/node_modules/${pname}/bin/${pname}.js $out/bin/${pname}
              runHook postInstall
            '';

            meta = {
              description = "A tool that packs your entire repository into a single, AI-friendly file";
              homepage = "https://github.com/yamadashy/repopack";
              license = pkgs.lib.licenses.mit;
              maintainers = with pkgs.lib.maintainers; [ nebunebu ];
            };
          };
        }
      )
      inputs.nixpkgs.legacyPackages;
  };
}
