~w(rel plugins *.exs)
|> Path.join()
|> Path.wildcard()
|> Enum.map(&Code.eval_file(&1))

use Mix.Releases.Config,
  default_release: :default,
  default_environment: Mix.env()

environment :dev do
  set dev_mode: true
  set include_erts: false
  set cookie: :"^G?uX_t/1kT&@B;psH|G;AMwv.}k5FB$(&0NW{{a(Z*>2qw0Jk]zJ~Mx{T<NW0jA"
end

environment :prod do
  set include_erts: true
  set include_src: false
  # Ideally take this from environment variable
  # set cookie: "${COOKIE}"
  set cookie: :"2!=?~eZx3p.QT;E49_!~Cm8pd7/b6S/(}=MbUn3a{&2)lo|S7arZM?wj*p6*[2!e"
  set vm_args: "rel/vm.args"
end

release :acm_bot do
  set version: current_version(:acm_bot)

  set applications: [
        :runtime_tools
      ]

  set config_providers: [ConfigTuples.Provider]
end
