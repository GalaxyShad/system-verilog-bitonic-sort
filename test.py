import re
import os

def find_comments(file_path):
    with open(file_path, 'r') as file:
        lines = file.readlines()

    comments = []
    found_build_udm_params = False

    for line in lines:
        if found_build_udm_params:
            stiped_line = line.strip()
            
            if stiped_line.startswith('//'):
                stiped_line = stiped_line.replace('//', '').strip()
                comments.append(stiped_line)
            else:
                break
        elif 'build-udm-params' in line:
            found_build_udm_params = True

    return comments

def insert_comments(source_file_path, target_file_path, comments):
    with open(source_file_path, 'r') as file:
        lines = file.readlines()

    LOCAL_PARAM_LINE = 92
    
    localparam_section = [('localparam ' + comment + '\n') for comment in comments] + ['\n']
    logic_section = ['`include bitonic_udm_include.sv`'] + ['\n']

    header_section = localparam_section + logic_section

    new_lines = lines[:LOCAL_PARAM_LINE] + header_section  + lines[LOCAL_PARAM_LINE:]

    with open(target_file_path, 'w') as file:
        file.writelines(new_lines)


def main():
    source_file = os.path.join(os.getcwd(), 'bitonic_comb_implementation/bitonic.sv')
    target_file = os.path.join(os.getcwd(), 'activecore/designs/rtl/udm/syn/NEXYS4_DDR/NEXYS4_DDR.sv')

    comments = find_comments(source_file)
    insert_comments(target_file, "./new.sv", comments)

if __name__ == "__main__":
    main()
