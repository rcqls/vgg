import os

const(
	tp = "thirdparty"
	ui = "ui"
)
args := os.args.clone()
// println("args: $args")

mut branch := "-b master"
if args.any(it == "-b") {
	branch = "-b " + args[args.index("-b") + 1]
}

mut repo := "https://github.com/vlang/ui"
if args.any(it == "-r") {
	repo = args[args.index("-r") + 1]
	if repo in ["vlang", "rcqls"] {
		repo = "https://github.com/$repo/ui"
	} else if repo in ["dev", "devel"] {
		repo = getenv("HOME") + "/Github/ui"
	}
}

if !exists(tp) {mkdir(tp) ?}

// Inside thirdparty folder
chdir(tp)

if (("--clean" in args) || ("-c" in args)) && exists("ui") {
	rmdir_all("ui") ?
}

if exists(ui) {
	chdir(ui)
	println("git pull")
	execute("git pull")
	chdir("..")
} else {
	println("git clone $branch $repo $ui")
	execute("git clone $branch $repo $ui")
}

// Inside root dir
chdir("..")
// remove ui folder
if exists(ui) { rmdir_all(ui) ? }

walk("$tp/$ui", fn (f string) {
	if !f.starts_with("$tp/$ui/.git") {
		print("file:$f dir: ${dir(f)} base: ${base(f)} -> ")
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

