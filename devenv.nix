{ pkgs, ... }: {

  packages = [
    pkgs.grass

    # qgis currently works only on linux
  ] ++ pkgs.lib.optionals pkgs.stdenv.isLinux [
    pkgs.qgis
  ];

  languages.python = {
    enable = true;
    package = pkgs.python3.withPackages (p: [
      p.rasterio
      p.fiona
    ]);
  };

  services = {
    postgres = {
      enable = true;
      extensions = e: [ e.postgis ];
    };
  };
}
