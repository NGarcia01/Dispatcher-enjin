BOTNAME=SpudLauncher
DISCORDHOOK=


webhook(){
curl -X POST \
  $DISCORDHOOK \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -d '{
  "username":"'"$BOTNAME"'",
  "avatar_url": "https://pm1.narvii.com/5879/46cfe46aec55ae81343c9fa96b04487a87a01f3d_hq.jpg",
  "content":"'"$TOSEND"'"
  
}'
echo " "
}


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

TOSEND="$SERVER - $Test"
webhook


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


