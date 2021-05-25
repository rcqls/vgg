## vgg as a gg version for vsokol

The goal is to propose several versions of sokol and gg since sokol is evolving a lot.

Also these versions allows the integration of imgui playing with `v ui` after fetching it as a submodule `gvv.ui`.

### fetch ui from official repo

1. **Only once**: create binary `v run get_vui.sh` (`get_vui` created)
1. `./get_vui`fetchs `v ui` from `https://github.com/vlang/ui` branch `master`.
1. **rcqls repo**:`./get_vui -b devel12 -r rcqls` is equivalent to `./get_vui -b devel12 -r https://github.com/rcqls/ui`) 
1. **locally**: `./get_vui -b devel12 -r dev` is equivalent to  `./get_vui -b devel12 -r ~/Github/ui`
1. `./get_vui` (if already used once) updates `v ui` (`git pull`)
1. `./get_vui -c -b <branch> -r <repo>` or `./get_vui --clean -b <branch> -r <repo>` to remove first the thirdparty ui source folder.