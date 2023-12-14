result=`ps -U jenkins  | wc -l`
username="yangsungsoo"
today=`date`
run_message="jekins service is running ${today}"
notrunning_message="jenkins service is not running ${today}"
restart_message="jenkins serivce is restart success!! ${today}"
restart_fail_message="jenkins serivce is restart fail!! ${today}"

function MESSAGE {

        curl -X POST --data-urlencode "payload={\"channel\": \"#docker-jenkins\", \"username\": \"yangsungsoo\", \"text\":  \"$1\" , \"icon_emoji\": \":ghost:\"}" "https://hooks.slack.com/services/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"

}




if [ $result -ge 2 ]
then
echo "jenkins service is running..."
ret_val=$(MESSAGE "$run_message")
echo $ret_val


else
echo "jenkins service is not running.."
ret_val=$(MESSAGE "$notrunning_message")
echo $ret_val

service jenkins start

        if [ `ps -U jenkins | wc -l`  -ge 2 ]
        then
        echo "jenkins serivce restart success!"
        MESSAGE "$restart_message"
        else
        echo "jenkins serivce restart fail..!"
        MESSAGE "$restart_fail_message"

        fi

echo "jenkins service started"

fi

