{pkgs, ...}: {
  home.packages = [
    (pkgs.writeScriptBin "create-project"
      /*
      nu
      */
      ''
        #!${pkgs.nushell}/bin/nu

        def main [
          type?: string
          name?: string
          --local (-l)
        ] {
        if $name == null or $type == null {
          print "Usage: create-project <name> <type> [Options: -l]"
          exit 1
        }

        if ($name | str contains "/") or ($name | str contains ".") {
          print "This is not a valid name for a project"
          exit 1
        }

        if ($type | str contains "/") or ($type | str contains ".") {
          print "This is not a valid project type"
          exit 1
        }

        if ($"~/.nix-config/home/modules/create-project/project-blueprints/($type)" | path type) != "dir" {
          print "This project type doesn't exist"
          exit 1
        }

        mkdir $name
        cd $name

        pwd

        if ($"~/.nix-config/home/modules/create-project/project-blueprints/($type)" | path expand | ls $in | length) > 0 {
          glob $"~/.nix-config/home/modules/create-project/project-blueprints/($type)/*" | each { |file| cp $file . }
        }

        if ($"./init.sh" | path type) == "file" {
          bash $"./init.sh" $name
          rm "init.sh"
        }

        if $local {
          exit 0
        }

        ssh $"admin@silvers.fun" $"sudo -S -u git git init --bare ~/($name).git"
        #print $"Repository ($name) created successfully!"

        #git init .
        #git add .
        #git commit -m "Project setup"
        #git $"remote add origin git@silvers.fun:($name).git"
        #git push origin main

        print "You are all done"

        exit 0
        }
      '')
  ];
}
