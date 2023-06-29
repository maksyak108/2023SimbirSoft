# 2023SimbirSoft
Необходимо написать мобильное приложение, представляющее из себя ежедневник
# MainViewController
MainViewController - отвечает за отображение главного экрана приложения и взаимодействие с пользователем. Данный экран отображает список заметок в виде таблицы, присутствует возможность выбора даты с помощью кнопки в навигационной панели. При нажатии на кнопку отображается диалоговое окно (UIAlertController) с UIDatePicker, где пользователь может выбрать дату. В зависимости от версии iOS, используется стиль колесика или стандартный стиль выбора даты. При выборе строки таблицы пользователем, происходит переход на экран ViewViewController. Возможность добавления новой заметки с помощью кнопки добавления. При нажатии на кнопку открывается экран EntryViewController, где пользователь может создать новую заметку. Присутствует возможность удаления заметки.
# EntryViewController
EntryViewController - отвечает за создание заметки. На данном экране требуется ввести название, описание, выбрать дату и временной промежуток.
# ViewViewController
ViewViewController - предоставляет пользователю возможность просматривать подробную информацию о выбранной заметке. На этом экране представлена полная информация о заметке, включая название, описание, дату и временной промежуток. Кроме того, пользователь может удалить заметку, используя соответствующую функцию на экране.
Приложение поддерживает темную тему.
