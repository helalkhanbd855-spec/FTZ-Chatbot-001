
import os

EXCLUDE_DIRS = {
    '__pycache__', 'node_modules', 'venv', '.git', '.idea', '.vscode', 'dist', 'build'
}
EXCLUDE_FILES = {
    '.DS_Store', '.env', '.gitignore', 'package-lock.json'
}

def print_tree(startpath, prefix=""):
    items = [item for item in os.listdir(startpath) if item not in EXCLUDE_FILES]
    items.sort()
    for index, item in enumerate(items):
        path = os.path.join(startpath, item)
        connector = "└── " if index == len(items) - 1 else "├── "
        if os.path.isdir(path) and item not in EXCLUDE_DIRS:
            print(prefix + connector + f"[{item}]")
            new_prefix = prefix + ("    " if index == len(items) - 1 else "│   ")
            print_tree(path, new_prefix)
        elif os.path.isfile(path):
            if not item.startswith('.') and not item.endswith(('.pyc', '.log')):
                print(prefix + connector + item)

if __name__ == "__main__":
    print("📁 Powerell Folder Structure\n")
    print_tree(".")
