# README

Se puede utilizar en Windows WSL o en Linux (Ubuntu). 1
Los pasos para instalar el ambiente de desarrollo estan en https://gorails.com/setup/
Importante: asegurarse de anotar el usuario y contrasenha de postgres

Versiones:

* Ruby 3.2.2
* Rails 7.1.3
* Postgres 15.6

Pasos:

* Preparar el ambiente de desarrollo y asegurarse de tener acceso a git por ssh
* Clonar el repositorio, ir a museum-app/
* Ir a config/database.yml y actualizar el usuario y contrasenha de la db
* Hacer rails db:create
* Hacer rails db:migrate
* Hacer rails db:seed
* Levantar la app con rails s
