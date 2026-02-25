import os

###  строим дерево проекта


def get_readme_description(folder_path):
    """
    Пытается найти README файл в папке и вернуть его первую строку.
    """
    # Возможные варианты названия файла
    readme_names = ['README.md', 'readme.md', 'README.txt', 'readme.txt', 'README']

    target_file = None
    try:
        files = os.listdir(folder_path)
        for name in readme_names:
            if name in files:
                target_file = name
                break

        if not target_file:
            # Поиск без учета регистра, если точное совпадение не найдено
            for f in files:
                if f.lower().startswith('readme'):
                    target_file = f
                    break
    except OSError:
        return "(ошибка доступа)"

    if target_file:
        try:
            with open(os.path.join(folder_path, target_file), 'r', encoding='utf-8') as f:
                # Читаем строки и берем первую непустую
                for line in f:
                    cleaned_line = line.strip().strip('#').strip()
                    if cleaned_line:
                        # Обрезаем, если строка слишком длинная
                        return f"({cleaned_line[:50] + '...' if len(cleaned_line) > 50 else cleaned_line})"
                return "(README пуст)"
        except Exception:
            return "(ошибка чтения README)"

    return "(файл README отсутствует)"

def print_tree(startpath):
    print(f"Структура проекта: {os.path.basename(os.path.abspath(startpath))}")

    for root, dirs, files in os.walk(startpath):
        # Фильтрация системных папок (начинающихся с точки)
        # Изменяем список dirs на месте, чтобы os.walk не заходил в них
        dirs[:] = [d for d in dirs if not d.startswith('.')]
        dirs.sort()

        level = root.replace(startpath, '').count(os.sep)
        indent = ' ' * 4 * level

        # Получаем имя текущей папки
        folder_name = os.path.basename(root)

        # Пропускаем корневую папку в цикле, так как она уже обозначена
        if root == startpath:
            continue

        description = get_readme_description(root)
        print(f'{indent}|-- {folder_name}/ {description}')

        # Если нужно выводить и файлы, раскомментируйте строки ниже:
        # subindent = ' ' * 4 * (level + 1)
        # for f in files:
        #     if not f.startswith('.'):
        #         print(f'{subindent}|-- {f}')

if __name__ == "__main__":
    # Запуск для текущей директории
    print_tree('.')
