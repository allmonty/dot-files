function alarm {
  sleep `expr $1 \* 60` && afplay ~/Music/submarine.mp3
}

### mac only?
function alarm2 {
  sleep `expr $1 \* 60`
  for j in {1..5}
  do
    say -v luciana $2
    sleep 1
  done
}
