$workspace=$clone_folder

# $pyvers = @("36", "36-x64", "36", "36-x64", "37", "37-x64", "37", "37-x64", "37", "37-x64", "38", "38-x64", "38", "38-x64")
$pyvers = @("36")
ls c:\Python36\
foreach ($ver in $pyvers)
{
    $python = c:\Python${ver}\python
    ls c:\Python${ver}
    # $python -m pip install cython
    # $python -m pip install numpy

    if ($python.contains("-x64"))
    {
        $vc="64"
    }
    else
    {
        $vc="32"
    }

    "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvars${vc}.bat"

    $python setup.py build_ext --inplace
    pwd
    ls .\evaluator\backend\cpp\
    md ..\compiled_pyd
    xcopy .\*.pyd ..\compiled_pyd /s /y
}

7z a .\compiled_pyd-b%APPVEYOR_BUILD_NUMBER%.zip ..\compiled_pyd\*

