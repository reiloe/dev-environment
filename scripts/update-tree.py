#!/usr/bin/env python3
import re
from pathlib import Path

ROOT_NAME = "dev-environment"
IGNORE = {
    ".git", ".gradle", ".idea", ".vscode", "target", "build",
    ".DS_Store", "__pycache__", "out", "bin", "wrapper"
}
MAX_DEPTH = 8

def get_visible_entries(directory: Path) -> list[Path]:
    entries = [
        e for e in directory.iterdir()
        if e.name not in IGNORE and not e.name.endswith(".class")
    ]
    entries.sort(key=lambda e: (not e.is_dir(), e.name.lower()))
    return entries

def compact_dir(directory: Path) -> tuple[Path, str]:
    """Fasst leere Einzel-Unterordner (z. B. de/reilo/countdown) kompakt zusammen."""
    parts = [directory.name]
    current = directory
    while True:
        children = get_visible_entries(current)
        if len(children) == 1 and children[0].is_dir():
            current = children[0]
            parts.append(current.name)
        else:
            break
    return current, "/".join(parts) + "/"


def build_tree(directory: Path, prefix: str = "", depth: int = 0) -> list[str]:
    if depth >= MAX_DEPTH:
        return []
    entries = get_visible_entries(directory)
    lines = []
    for index, entry in enumerate(entries):
        is_last = index == len(entries) - 1
        connector = "└── " if is_last else "├── "
        extension = "    " if is_last else "│   "

        if entry.is_dir():
            target_dir, display_name = compact_dir(entry)
            lines.append(f"{prefix}{connector}{display_name}")
            lines.extend(build_tree(target_dir, prefix + extension, depth + 1))
        else:
            lines.append(f"{prefix}{connector}{entry.name}")
    return lines

def main():
    root = Path(__file__).resolve().parent.parent
    readme_path = root / "README.md"
    if not readme_path.exists():
        return

    tree_lines = [f"{ROOT_NAME}/"] + build_tree(root)
    tree_block = "<!-- TREE_START -->\n```text\n" + "\n".join(tree_lines) + "\n```\n<!-- TREE_END -->"

    content = readme_path.read_text(encoding="utf-8")
    new_content, count = re.subn(
        r"<!-- TREE_START -->.*?<!-- TREE_END -->",
        tree_block,
        content,
        flags=re.DOTALL
    )

    if count > 0 and new_content != content:
        readme_path.write_text(new_content, encoding="utf-8")
        print("README.md: Project Structure wurde automatisch aktualisiert.")

if __name__ == "__main__":
    main()
