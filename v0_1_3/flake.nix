{
  description = ''nim package manager'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-slim-v0_1_3.flake = false;
  inputs.src-slim-v0_1_3.ref   = "refs/tags/v0.1.3";
  inputs.src-slim-v0_1_3.owner = "bung87";
  inputs.src-slim-v0_1_3.repo  = "slim";
  inputs.src-slim-v0_1_3.type  = "github";
  
  inputs."hmisc".owner = "nim-nix-pkgs";
  inputs."hmisc".ref   = "master";
  inputs."hmisc".repo  = "hmisc";
  inputs."hmisc".dir   = "v0_14_6";
  inputs."hmisc".type  = "github";
  inputs."hmisc".inputs.nixpkgs.follows = "nixpkgs";
  inputs."hmisc".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-slim-v0_1_3"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-slim-v0_1_3";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}