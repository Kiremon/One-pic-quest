**Внимание!** Godot 4.0.2 может болезненно реагировать на отсутствие папки ".godot" при первом запуске из репозитория. Рекомендую отказываться от загрузки main.tscn при первом запуске, пока редактор не произведёт реимпорт.

Это исходный код (Godot4-проект) игры One Picture Quest версии 0.1. Функционал из диздока реализован пока ещё не полностью, потому местами в коде встречаются "подготовленные", но недоделанные места. Играбельную версию и список владельцев авторских прав на использованные здесь ресурсы можно найти по ссылке:<br>
https://kotomaru.itch.io/one-picture-quest<br>
Дизайнерская документация:<br>
https://www.chitalnya.ru/work/3529463/

Публикую всю эту штуку как пример моего программного кода и архитектурного подхода. Весь код, содержащийся здесь, разработан мною.

<h3>Краткий путеводитель</h3>
Базовая сцена "main.tscn" содержит основную игровую оболочку: интерфейс и "scenario_handler.gd" обеспечивающий базовый запуск игры. Сам игровой процесс начинается внутри глав - отдельных сцен, которые подгружаются в основную "main.tscn" по мере необходимости.

Через синглтоны организован доступ к общим для всего проекта службам:

* thesaurus.gd - справочник констант, встречающихся в несвязанный напрямую объектах.
* story_singleton.gd - всё, что нужно для управления сюжетом.
* sound_singleton.gd - всё для воспроизведения и контроля звуков.
* ui_singleton.gd - доступ к разным аспектам интерфейса.

В целом по коду, файлы с постфиксом "_handler" обычно обозначают скрипты присоединённые к ключевым узлам сцены и отвечающие за первичный функционал сцены.

Многие игровые объекты проявляются в двух слоях: локальном, в масштабах главы, и глобальном, действующем на все главы. Это нужно для того, чтобы объекты, существование которых осмысленно только внутри главы, благополучно выгружались из памяти при её завершении. Все интерфейсы, запрашивающие такие объекты, обычно настроены на поиск требуемой сущности и в слое главы, и в глобальном слое.

Главы и глобальный слой (т.е. "chapter_handler.gd" и "scenario_handler.gd" соответственно) имеют узел "DB_objects", хранящий в списке детей собственно игровые предметы ("объекты" в контексте диздока). Класс GameObject оформляется узлом, поскольку так проще настраивать и хранить данные. Этот класс отвечает за всю логику предметов. Его потомки реализуют предметы со специфическим поведением: особыми правилами осмотра, инструкциями для результативного комбинирования и т.д. Классы "object_handler.gd" и "obj_inv_handler.gd", отвечающие за графическое проявление предметов (на локации и в инвентаре соответственно), во всём обращаются к "DB_objects", от детей которого ожидают типичного поведения GameObject.

Хендлеры глав и глобальный хендлер имеют в своём подчинении экземпляр потомка класса GameScenario. Это не узел, но он выполняет свои специфические задачи, связанные с управлением сюжетом. Каждый потомок имеет специфические для своего сюжета функции и сюжетные флаги, но использует стандартизированный интерфейс GameScenario.

По той же логике указанные хандлеры имеют в подчинении экземпляр класса "DB_sounds.gd", который отвечает за доступ к звукам, но работает не через отдельного потомка для каждой главы, а через обращение к папке со звуками, выделенной для каждой главы. В такой папке обязательно должен находиться файл "sounds.json", в котором сведены названия файлов с их идентификаторами, которыми уже можно пользоваться в коде при вызове нужных звуков. Такой подход показался удобным сочетанием простоты хранения данных и созданием прослойки между логикой применения звуков и их физическим хранением.

Главы, кроме прочего, состоят из локаций, по которым и между которыми может перемещаться персонаж игрока. В общей структуре локации следует выделить два аспекта:

1. Деление визуальных хандлеров предметов на три разряда: "obj_back", которые всегда на заднем плане; "obj_sort", которые должны меняться с игроком слоями прорисовки; и "obj_front", которые всегда на переднем плане. В остальном хендлеры ведут себя одинаково.
2. Понятия "walkzone" и "obstacles", которые работают в связке с классом "player_mover.gd" и обеспечивают механику перемещения персонажа по локации. Если вкратце, эта система, когда будет закончена, предполагает высокую гибкость и настраиваемость правил перемещения под "любой" стиль изображения локации.

---

**Caution!** Godot 4.0.2 may painfully react on absence of ".godot" folder during first load of the project from repository. Be advised to avoid loading main.tscn before editor made a reimport.

This is source code (Godot4-project) of "One Picture Quest" game, version 0.1. GDD's functionality yet not fully implemented, so there are "prepared" but not finished pieces. Playable version and full credits list with copyrights of resources used here can be found at the link:<br>
https://kotomaru.itch.io/one-picture-quest<br>
Game design document (in Russian):<br>
https://www.chitalnya.ru/work/3529463/

I'm publishing all that stuff as an example of my code and program architecture. All the code, listed here, is written by me.

<h3>Short guide</h3>
Base scene "main.tscn" contains main game shell: user interface and "scenario_handler.gd", which handles the game start. Gameplay itself begins inside chapters - separate scenes, loaded in "main.tscn" when needed.

Common services for whole project are accessible through singletons:

* thesaurus.gd - dictionary of constants, shared by indirectly related objects.
* story_singleton.gd - everything to manage the story.
* sound_singleton.gd - everything for playback and control over sound.
* ui_singleton.gd - access to different parts of UI.

In common for project: files with "_handler" postfix usually attached to root node of a scene and implements primary functionality of the scene.

Some game objects are implemented in two layers: local, for specific chapter, and global, for all chapters. So, objects, which are meaningful only for it's chapter, can free the memory when chapter is finished. All the interfaces, that works with such objects, searches them both in local and global layers.

Chapters and the global layer ("chapter_handler.gd" and "scenario_handler.gd" respectively) has node "DB_objects" that contains (as children) game items (definition "object" used for items in GDD). Class "GameObject" is a Node, for it simpler to manage data that way. This class is responsible for all item logics. His subclasses implements items with specific behaviour: special rule for examination, instruction for successful combination, etc. Classes "object_handler.gd" and "obj_inv_handler.gd", that are responsible for visual behaviour (on location and in inventory respectively), for any information addresses "DB_objects" node, and expects his children to be "GameObject".

Chapter's and global handlers has in submission an instance of a subclass of "GameScenario" class. It's not a Node, but it implements specific functions, related to managing of the story. Each subclass, unique to it's chapter, contains specific functions and story flags, but uses standardised interface of "GameScenario" class.

In same manner the handlers has in submission an instance of "DB_sounds.gd" class. It's responsible for accessing sounds. Not through subclasses, specific for a chapter, but by addressing chapter's own folder with sounds. Any such folder must contain "sounds.json" file. Inside is linkage between sound file and it's ID, which in turn can be used in code to invoke the sound. Such an approach seemed reasonable combination of data simplicity and interfacing between code logic and file storage.

Among other things, chapter contains locations for player to walk though. In location layout I should outline two points of interest:

1. Item's visual handlers are split in three groups: "obj_back", which are always in background; "obj_sort", which are sorted with player in terms of visual order; and "obj_front", which are always in front of others. Visual handlers themselves works identically.
2. Concept of "walkzone" and "obstacles". In relation with "player_mover.gd" class they allows player to move by location. Presumably, when it's done, the system will have simple and flexible configurations, so character will be able to move coherently in background of any art style.
