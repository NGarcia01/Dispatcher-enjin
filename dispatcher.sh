
_tmux_send_keys_all_panes_ () {
  for _pane in $(tmux list-panes -F '#P'); do
    tmux send-keys -t ${_pane} "$@"
  done
}


while IFS= read -r OUT;
do


echo $OUT | grep "BDispatch"

if [[ $OUT = *"BDispatch"* ]]; then



SERVER=$(echo $OUT  | grep "BDispatch"|awk -F '-' '{print $2}') 
Test="$(echo $OUT  | grep "BDispatch"|awk -F '-' '{print $3}')"
 

echo $SERVER - $Test


if [[ $SERVER = *"ALL"* ]]; then

echo all

for _pane in $(tmux list-panes -a -F '#{pane_id}'); do \


echo ${_pane}
  tmux send-keys -t ${_pane} "$Test" ENTER 

 done

else 
if [[ $OUT = *"-/"* ]]; then

Test="$(echo $OUT  | grep "BDispatch"|awk -F '-/' '{print $2}')"



fi


tmux send-keys -t $SERVER "$Test" ENTER

fi

fi

LAST=$Test

 done < <( tail -f -n 0 --follow=name --retry logs/*.log )


