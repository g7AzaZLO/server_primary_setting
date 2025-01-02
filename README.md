# Server Primary Setting

Этот репозиторий предоставляет удобный способ автоматической начальной настройки сервера. С помощью одной команды вы можете обновить систему и установить все необходимые пакеты без лишних усилий.

## Особенности

- Полностью автоматизированный процесс.
- Обновление системы и установка пакетов без конфликтов.
- Простота использования: одна команда для запуска.

## Установка

Для автоматической настройки сервера выполните следующую команду:

```bash
. <(wget -qO- https://raw.githubusercontent.com/g7AzaZLO/server_primary_setting/refs/heads/main/server_primary_setting)
```

## Что делает скрипт

1. Обновляет список пакетов и устанавливает последние обновления операционной системы.
2. Устанавливает следующие пакеты:
   - **curl**: Инструмент для передачи данных с URL.
   - **git**: Система контроля версий.
   - **jq**: Утилита для работы с JSON.
   - **lz4**: Утилита для сжатия данных.
   - **build-essential**: Инструменты для сборки программ.
   - **unzip**: Утилита для распаковки архивов.
   - **make, gcc**: Компиляторы и утилиты сборки.
   - **ncdu**: Интерактивный анализатор дискового пространства.
   - **cmake, clang, pkg-config, libssl-dev**: Инструменты для разработки.
   - **python3-pip**: Менеджер пакетов Python.
   - **protobuf-compiler**: Компилятор для Protocol Buffers.
   - **docker.io**: Платформа для контейнеризации.
   - **dos2unix**: Утилита для преобразования текстовых файлов.
   - **screen**: Мультиплексор терминала

3. Обрабатывает конфликты пакетов и продолжает установку остальных компонентов.

## Сообщество

Если у вас есть вопросы или вы хотите присоединиться к обсуждению, заходите в наше Telegram сообщество:  
[**Telegram Community**](https://t.me/g7team_ru)

---

Автор: [g7AzaZLO](https://github.com/g7AzaZLO)  
Лицензия: MIT
```
