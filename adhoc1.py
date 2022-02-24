import os
file_names = []
for path, dirs, files in os.walk(PATH): for filename in files: fullpath = os.path.join(path, filename) file_names.append(fullpath) filenames=file_names[1:] print(file_names)