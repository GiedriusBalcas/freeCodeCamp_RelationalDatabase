#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=number_guess --tuples-only -c"

SECRET_NUMBER=$(( $RANDOM % 1000 + 1 ))
echo $SECRET_NUMBER

echo "Enter your username:"
read USERNAME

PLAYER_INFO=$($PSQL "SELECT games_played, best_game FROM number_game WHERE username='$USERNAME';")

if [[ -z $PLAYER_INFO ]]
then
  # new player arrived
  echo "Welcome, $USERNAME! It looks like this is your first time here."
  GAMES_PLAYED=0
  ADD_PLAYER_RESULT=$($PSQL "INSERT INTO number_game(username,games_played) VALUES('$USERNAME', $GAMES_PLAYED);")
  
else
  echo $PLAYER_INFO | while read GAMES_PLAYED BAR BEST_GAME
  do
    echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
  done
fi


echo "Guess the secret number between 1 and 1000:"

NUMBER_OF_GUESSES=0
IS_PLAYING=TRUE

while [[ $IS_PLAYING = TRUE ]]
do
  ((NUMBER_OF_GUESSES++))
  read GUESS

  if [[ ! $GUESS =~ ^[0-9]+$ ]]
  then
    echo "That is not an integer, guess again:"
  else
    if [[ $GUESS = $SECRET_NUMBER ]]
    then
      echo "You guessed it in $NUMBER_OF_GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"
      IS_PLAYING=FALSE
    else
      if [[ $GUESS > $SECRET_NUMBER ]]
      then
        echo "It's lower than that, guess again:"
      else
        echo "It's higher than that, guess again:"
      fi
    fi
  fi
done

PLAYER_INFO=$($PSQL "SELECT games_played, best_game FROM number_game WHERE username='$USERNAME';")
echo $PLAYER_INFO | while read GAMES_PLAYED BAR BEST_GAME
do
  ((GAMES_PLAYED++))
  if [[ -z $BEST_GAME ]] || [[ $NUMBER_OF_GUESSES < $BEST_GAME ]]
  then
    BEST_GAME=$NUMBER_OF_GUESSES
  fi
  UPDATE_PLAYER_RESULT=$($PSQL "UPDATE number_game SET games_played = $GAMES_PLAYED, best_game = $BEST_GAME WHERE username='$USERNAME';")
done

