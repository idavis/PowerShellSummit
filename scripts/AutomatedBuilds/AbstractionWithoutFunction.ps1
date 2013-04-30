$solution = @{}
$build = @{}
$solution.name = " SomeProject"
$build.directory = Resolve-Path .
$build.configuration = "Release"
$solution.file = “$($base.directory)\$($solution.name).sln"
msbuild /p:Configuration=$build.configuration $solution.file