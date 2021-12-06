import sys

# -------------------------------------------------------
# change config file default dataset config path
# -------------------------------------------------------
# https://stackoverflow.com/questions/4128144/replace-string-within-file-contents

def inplace_change(filename, old_string, new_string):
    # Safely read the input filename using 'with'
    with open(filename) as f:
        s = f.read()
        if old_string not in s:
            print('"{old_string}" not found in {filename}.'.format(**locals()))
            return

    # Safely write the changed content, if found in the file
    with open(filename, 'w') as f:
        print('Changing "{old_string}" to "{new_string}" in {filename}'.format(**locals()))
        s = s.replace(old_string, new_string)
        f.write(s)

inputName=sys.argv[1]
datasetName=sys.argv[2]
oldString='../../../../_base_/datasets/'+datasetName+'.py'
newString=datasetName+'.py'
inplace_change(inputName, oldString, newString)



