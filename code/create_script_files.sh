for i in {1..1000}
    do
        cp code/script_for_multimedusa_in_cluster.sh "script_$i.sh"
        sed -i -r "s/set_8/set_$i/g" "script_$i.sh"
        echo "$i"
    done
