import shutil
import os

BUILD_DIR = './vivado_project_build'
LAB_DIR = './bitonic_comb_implementation '

try:
    shutil.copytree('./activecore/designs/rtl/udm/syn/NEXYS4_DDR', BUILD_DIR)
except FileExistsError:
    print("Проект Vivado уже существует")


shutil.copy(os.path.join(LAB_DIR, 'bitonic.sv'), BUILD_DIR)

print("Проект Vivado успешно собран")