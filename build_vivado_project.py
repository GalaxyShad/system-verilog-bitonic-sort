import shutil

try:
    shutil.copytree('./activecore/designs/rtl/udm/syn/NEXYS4_DDR', './vivado_project_build')
except FileExistsError:
    raise FileExistsError("Проект Vivado уже существует")

print("Проект Vivado успешно собран")