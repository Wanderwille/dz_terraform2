# Домашнее задание  «Основы Terraform. Yandex Cloud» - Подус Сергей

### Задание 1
В качестве ответа всегда полностью прикладывайте ваш terraform-код в git.  Убедитесь что ваша версия **Terraform** =1.5.Х (версия 1.6.Х может вызывать проблемы с Яндекс провайдером) 

1. Изучите проект. В файле variables.tf объявлены переменные для Yandex provider.
2. Создайте сервисный аккаунт и ключ. [service_account_key_file](https://terraform-provider.yandexcloud.net).
4. Сгенерируйте новый или используйте свой текущий ssh-ключ. Запишите его открытую(public) часть в переменную **vms_ssh_public_root_key**.
5. Инициализируйте проект, выполните код. Исправьте намеренно допущенные синтаксические ошибки. Ищите внимательно, посимвольно. Ответьте, в чём заключается их суть.
6. Подключитесь к консоли ВМ через ssh и выполните команду ``` curl ifconfig.me```.
Примечание: К OS ubuntu "out of a box, те из коробки" необходимо подключаться под пользователем ubuntu: ```"ssh ubuntu@vm_ip_address"```. Предварительно убедитесь, что ваш ключ добавлен в ssh-агент: ```eval $(ssh-agent) && ssh-add``` Вы познакомитесь с тем как при создании ВМ создать своего пользователя в блоке metadata в следующей лекции.;
8. Ответьте, как в процессе обучения могут пригодиться параметры ```preemptible = true``` и ```core_fraction=5``` в параметрах ВМ.

В качестве решения приложите:

- скриншот ЛК Yandex Cloud с созданной ВМ, где видно внешний ip-адрес;
- скриншот консоли, curl должен отобразить тот же внешний ip-адрес;
- ответы на вопросы.


### Задание 2

1. Замените все хардкод-**значения** для ресурсов **yandex_compute_image** и **yandex_compute_instance** на **отдельные** переменные. К названиям переменных ВМ добавьте в начало префикс **vm_web_** .  Пример: **vm_web_name**.
2. Объявите нужные переменные в файле variables.tf, обязательно указывайте тип переменной. Заполните их **default** прежними значениями из main.tf. 
3. Проверьте terraform plan. Изменений быть не должно. 


### Задание 3

1. Создайте в корне проекта файл 'vms_platform.tf' . Перенесите в него все переменные первой ВМ.
2. Скопируйте блок ресурса и создайте с его помощью вторую ВМ в файле main.tf: **"netology-develop-platform-db"** ,  ```cores  = 2, memory = 2, core_fraction = 20```. Объявите её переменные с префиксом **vm_db_** в том же файле ('vms_platform.tf').  ВМ должна работать в зоне "ru-central1-b"
3. Примените изменения.


### Задание 4

1. Объявите в файле outputs.tf **один** output , содержащий: instance_name, external_ip, fqdn для каждой из ВМ в удобном лично для вас формате.
2. Примените изменения.

В качестве решения приложите вывод значений ip-адресов команды ```terraform output```.


### Задание 5

1. В файле locals.tf опишите в **одном** local-блоке имя каждой ВМ, используйте интерполяцию ${..} с НЕСКОЛЬКИМИ переменными по примеру из лекции.
2. Замените переменные внутри ресурса ВМ на созданные вами local-переменные.
3. Примените изменения.


### Задание 6

1. Вместо использования трёх переменных  ".._cores",".._memory",".._core_fraction" в блоке  resources {...}, объедините их в единую map-переменную **vms_resources** и  внутри неё конфиги обеих ВМ в виде вложенного map.  
   ```
   пример из terraform.tfvars:
   vms_resources = {
     web={
       cores=
       memory=
       core_fraction=
       ...
     },
     db= {
       cores=
       memory=
       core_fraction=
       ...
     }
   }
   ```
3. Создайте и используйте отдельную map переменную для блока metadata, она должна быть общая для всех ваших ВМ.
   ```
   пример из terraform.tfvars:
   metadata = {
     serial-port-enable = 1
     ssh-keys           = "ubuntu:ssh-ed25519 AAAAC..."
   }
   ```  
  
5. Найдите и закоментируйте все, более не используемые переменные проекта.
6. Проверьте terraform plan. Изменений быть не должно.

## Ответ: 

## Задание 1

Файл variables.tf нужен для того, чтобы определить типы переменных и при необходимости, установить их значения по умолчанию.

Ошибки в блоке: ***resource "yandex_compute_instance" "platform" {***.

Ошибки были следующие:

* В строке ***platform_id = "standart-v4"*** должно быть слово standard
* Версия v4 неправильная. Согласно документации (https://cloud.yandex.ru/docs/compute/concepts/vm-platforms) платформы могут быть только v1, v2 и v3.
* В строке ***cores         = 1*** указано неправильное количество ядер процессора. Согласно документации (https://cloud.yandex.ru/docs/compute/concepts/performance-levels) минимальное количество виртуальных ядер процессора для всех платформ равно двум.

![Скриншот 1](https://github.com/Wanderwille/scrinshot/blob/main/vm%20terraform.png)

![Скриншот 2](https://github.com/Wanderwille/scrinshot/blob/main/ssh%20terraform.png)

![Скриншот 3](https://github.com/Wanderwille/scrinshot/blob/main/ipconfig.png)

Параметр ```preemptible = true``` применяется в том случае, если нужно сделать виртуальную машину прерываемой, то есть возможность остановки ВМ в любой момент.

Параметр ```core_fraction=5``` указывает базовую производительность ядра в процентах. Указывается для экономии ресурсов.


## Задание 2

![Скриншот 4](https://github.com/Wanderwille/scrinshot/blob/main/переменные%20terraform.png)

![Скриншот 5](https://github.com/Wanderwille/scrinshot/blob/main/замена%20переменных.png)

![Скриншот 6](https://github.com/Wanderwille/scrinshot/blob/main/terraform_plan.png)

## Задание 3

Создал файл 'vms_platform.tf', перенес в него старые переменные, написал новые:

![Скриншот 7](https://github.com/Wanderwille/scrinshot/blob/main/Переменные%20db.png)

![Скриншот 8](https://github.com/Wanderwille/scrinshot/blob/main/переменные%203.png)

![Скриншот 9](https://github.com/Wanderwille/scrinshot/blob/main/обьявление%20переменных2.png)

Так же обьявил переменные для создания новой подсети, что бы ВМ работала в зоне "ru-central1-b"

Но появились проблемы в виде того, что подсети создаются, но при ***terraform apply*** появляется ошибка: 

![Скриншот 10](https://github.com/Wanderwille/scrinshot/blob/main/Ошибка.png)

Terraform plan

![Скриншот 11](https://github.com/Wanderwille/scrinshot/blob/main/terraform%20plan.png)

Возможно проблема в этом месте 
```
  network_interface {
    subnet_id = yandex_vpc_subnet.develop1.id
    nat       = true
  }
```
Если ***yandex_vpc_subnet.develop1.id*** изменить на ***yandex_vpc_subnet.develop.id***, то все работает

Так же пробовал создать отдельную сеть, но это так же не помогло

## Задание 4

## Ответ:

![Скриншот 12](https://github.com/Wanderwille/scrinshot/blob/main/output22.png)

![Скриншот 13](https://github.com/Wanderwille/scrinshot/blob/main/jasoi%3Bfhsdef%20ahfawnfsa.png)

## Задание 5

## Ответ:

![Скриншот 12](https://github.com/Wanderwille/scrinshot/blob/main/local.png)

![Скриншот 13](https://github.com/Wanderwille/scrinshot/blob/main/local2.png)

![Скриншот 14](https://github.com/Wanderwille/scrinshot/blob/main/Переменные%204.png)

## Задание 6

## Ответ:

![Скриншот 15](https://github.com/Wanderwille/scrinshot/blob/main/zd6.png)

![Скриншот 16](https://github.com/Wanderwille/scrinshot/blob/main/db_vm.png)

![Скриншот 17](https://github.com/Wanderwille/scrinshot/blob/main/web_vm.png)

![Скриншот 18](https://github.com/Wanderwille/scrinshot/blob/main/terraform%20plan.png)
