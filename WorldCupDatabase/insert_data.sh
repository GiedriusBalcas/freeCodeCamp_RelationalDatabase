#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

echo $($PSQL "TRUNCATE TABLE games, teams;")

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOAL OPPONENT_GOAL 
do

  if [[ $WINNER != winner ]]
  then
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER';")
    if [[ -z $WINNER_ID ]]
    then
      INSERT_TEAM_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
      if [[ $INSERT_TEAM_RESULT == "INSERT 0 1" ]]
      then
        echo Inserted into teams, $WINNER
      fi
      WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER';")
    fi
  fi

  if [[ $OPPONENT != opponent ]]
  then
    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT';")
    if [[ -z $OPPONENT_ID ]]
    then
      INSERT_TEAM_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
      if [[ $INSERT_TEAM_RESULT == "INSERT 0 1" ]]
      then
        echo Inserted into teams, $OPPONENT
      fi
      OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT';")
    fi
  fi

done


cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOAL OPPONENT_GOAL 
do
  #exclude the first line
  if [[ $WINNER != winner ]]
  then
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER';")
    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT';")
    INSERT_GAME_RESULT=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR,'$ROUND',$WINNER_ID,$OPPONENT_ID,$WINNER_GOAL,$OPPONENT_GOAL);")
    if [[ $INSERT_GAME_RESULT == "INSERT 0 1" ]]
    then
      echo Inserted into games
    else
      echo $INSERT_GAME_RESULT
    fi

  fi
done



: '
echo $($PSQL "TRUNCATE students, majors, courses, majors_courses")

cat courses.csv | while IFS="," read MAJOR COURSE
do
if [[ $MAJOR != major ]]
then
  #get major_id
  MAJOR_ID=$($PSQL "SELECT major_id FROM majors WHERE major='$MAJOR'")
  #if not found
  if [[ -z $MAJOR_ID ]]
  then
  #insert major
  INSERT_MAJOR_RESULT=$($PSQL "INSERT INTO majors(major) VALUES('$MAJOR')")
  if [[ $INSERT_MAJOR_RESULT == "INSERT 0 1" ]]
  then
    echo Inserted into majors, $MAJOR
  fi
  #get new major_id
  MAJOR_ID=$($PSQL "SELECT major_id FROM majors WHERE major='$MAJOR'")
  fi
  #get course_id
  COURSE_ID=$($PSQL "SELECT course_id FROM courses WHERE course='$COURSE'")
  #if not found
  if [[ -z $COURSE_ID ]]
  then
  #insert course
  INSERT_COURSE_RESULT=$($PSQL "INSERT INTO courses(course) VALUES('$COURSE')")
  if [[ $INSERT_COURSE_RESULT == "INSERT 0 1" ]]
  then
    echo Inserted into courses, $COURSE
  fi
  #get new course_id
  COURSE_ID=$($PSQL "SELECT course_id FROM courses WHERE course='$COURSE'")
  fi
  #insert into majors_courses
  INSERT_MAJORS_COURSES_RESULT=$($PSQL "INSERT INTO majors_courses(major_id,course_id) VALUES($MAJOR_ID,$COURSE_ID);")
  if [[ $INSERT_MAJORS_COURSES_RESULT == "INSERT 0 1" ]]
  then
    echo Inserted into majors_courses, $MAJOR : $COURSE
  fi
fi
done
 '
