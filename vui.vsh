import os

const(
	tp = "thirdparty"
	ui = "ui"
)
args := os.args.clone()
println("args: $args")


if !exists(tp) {mkdir(tp) ?}

chdir(tp)
// println(os.execute("pwd").output)

if ("--new-src" in args) && exists("ui") {
	rmdir_all("ui") ?
}

branch := "-b devel12"
repo := "https://github.com/rcqls/ui"

if !exists(ui) {
	execute("git clone $branch $repo $ui")
}

chdir("..")
// if ("--new-tgt" in args) && exists(ui) {
	rmdir_all(ui) ?
// }

// cp_all("ui", "vui", true) ?
walk("$tp/$ui", fn (f string) {
	if !f.starts_with("$tp/$ui/.git") {
		println("file:$f dir: ${dir(f)} base: ${base(f)} ")
		mut txt := read_file(f) or {panic(err.msg)}
		txt = txt.replace_each([
			'import ui', "import vgg.ui"
			"import gg", "import vgg as gg"
			"import sokol.", "import vsokol."
			"ui_mode: true", "ui_mode: true\n\t\timgui: true"
		])
		// txt = txt.replace("import vsokol.", "import vimgui\nimport vsokol.")
		new_f := f.replace("$tp/$ui", ui)
		println(new_f)
		mkdir_all(dir(new_f)) or {panic(err.msg)}
		write_file(new_f, txt) or {
			panic(err.msg)
		}
	}
	
})

