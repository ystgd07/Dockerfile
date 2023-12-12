result=`ps -U jenkins  | wc -l` 
username="yangsungsoo"

echo " existing jekins process count ${result}"

if [ $result -ge 2 ]
then
echo "jenkins service is running..."

else
echo "jenkins service is not running.."

curl -X POST --data-urlencode "payload={\"channel\": \"#docker-jenkins\", \"username\": \"${username}\", \"text\": \"jenkins is stop... restart\", \"icon_emoji\": \":ghost:\"}" https://hooks.slack.com/services/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

service jenkins start

ps aux | grep -e jenkins | wc -l

echo "jenkins service started"

fi
