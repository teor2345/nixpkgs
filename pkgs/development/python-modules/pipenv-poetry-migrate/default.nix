{ lib
, buildPythonPackage
, fetchFromGitHub
, pytestCheckHook
, pythonOlder
, poetry-core
, tomlkit
, typer
, setuptools
}:

buildPythonPackage rec {
  version = "0.3.1";
  pname = "pipenv-poetry-migrate";
  format = "pyproject";
  disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "yhino";
    repo = "pipenv-poetry-migrate";
    rev = "refs/tags/v${version}";
    hash = "sha256-HYzKp7ZYvJZX2CiHmR8wIeuL2a1xdk0Y87HLs9EP2tM=";
  };

  nativeBuildInputs = [
    poetry-core
  ];

  propagatedBuildInputs = [
    setuptools # for pkg_resources
    tomlkit
    typer
  ];

  postPatch = ''
    substituteInPlace pyproject.toml --replace 'typer = "^0.4.0"' 'typer = ">=0.4"'
  '';

  nativeCheckInputs = [
    pytestCheckHook
  ];

  meta = with lib; {
    description = "This is simple migration script, migrate pipenv to poetry";
    homepage = "https://github.com/yhino/pipenv-poetry-migrate";
    license = licenses.asl20;
    maintainers = with maintainers; [ gador ];
  };
}
