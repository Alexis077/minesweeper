# Code Trial


## Description 

This game is an api rest version of the popular minesweeper game

## Requirements

* Ruby 2.7.x 
* Rails 6.0.x 
* Postgresql
 
## Project development

To carry out this project was to start with the development of the logic of the game.
the game logic was adapted from a console execution environment to a mode adapted to the nature of a REST API.
## Relevant points of logic to highlight
the minesweeper game has particular characteristics that must be considered

* Generation of the game matrix
* Generation of empty cells, mine cells
* Logic generation for the number generation around the mines
* Logic to reveal neighboring empty cells

## Other considerations

* Rwsag implemented
* Data representation by serializers

## Access to the Api documentation

To see the definition of the Api go to the following url

```
POST http://<hostname>/api-docs/index.html
```

