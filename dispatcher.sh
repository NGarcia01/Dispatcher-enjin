while IFS= read -r OUT;
 do


if [[ $OUT = *"BDispatch"* ]]; then
SERVER=$(echo $OUT  | grep "BDispatch" |awk -F '-' '{print $2}')
TODO=$(echo $OUT  | grep "BDispatch" |awk -F '-' '{print $3}')

echo $SERVER - $TODO

tmux send-keys -t $SERVER "$TODO" ENTER


fi


 done < <(tail -f -n 1 logs/latest.log )
