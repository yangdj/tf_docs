# hadoop command

before starting hadoop, you have to format filesystem first:

    hadoop namenode -format

and then start hadoop:

    sbin/start-dfs.sh
    sbin/start-yarn.sh

you can stop hadoop using:
    
    sbin/stop-dfs.sh
    sbin/stop-yarn.sh

## file operation

* `hadoop fs -mkdir /hdfsinput` - creates directory
* `hadoop fs -rm -r dirname` - removes directory
* `hadoop fs -put testfiles/test*.txt /hdfsinput` - puts the local files to hadoop filesystem
* `hadoop fs -get from-hadoop-file to-local-file` - gets files from hadoop filesystem to local
* `hadoop fs -ls hdfsoutput` - lists hadoop filesystem files. `hdfsoutput` is in `/user/username` of hadoop filesystem by default
* `hadoop fs -cat hdfsoutput/part-r-00000` - shows the file content

## running jobs supported by hadoop

    hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.1.jar wordcount /hdfsinput hdfsoutput 
    hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.3.jar pi 2 5

## running your own programs

configures `CLASSPATH` to comile your hadoop-java program. in linux, e.g., 

    export CLASSPATH=/usr/lib/jvm/jdk1.8.0_65/lib
    export CLASSPATH=$CLASSPATH:/usr/lib/jvm/jdk1.8.0_65/jre/lib
    export CLASSPATH=$CLASSPATH:/usr/local/hadoop/hadoop-2.7.1/share/hadoop/mapreduce/hadoop-mapreduce-client-core-2.7.1.jar
    export CLASSPATH=$CLASSPATH:/usr/local/hadoop/hadoop-2.7.1/share/hadoop/mapreduce/hadoop-mapreduce-client-common-2.7.1.jar
    export CLASSPATH=$CLASSPATH:/usr/local/hadoop/hadoop-2.7.1/share/hadoop/common/hadoop-common-2.7.1.jar
    export CLASSPATH=$CLASSPATH:/usr/local/hadoop/hadoop-2.7.1/lib/*      

and then configures `HADOOP_CLASSPATH`: 

    export HADOOP_CLASSPATH=your-jar-file.jar or
    export HADOOP_CLASSPATH=/containing/your/class/dir

then executes:

    hadoop your-class [args]
    hadoop your-class hdfs://Master:54310/user/me/inputfile/test.txt

if you use local file, not the hadoop filesystem file, you will get some error, e.g., `connecton refused`. or:
    
    jar cf you-class.jar your-class.class
    hadoop jar you-class.jar your-class [args]
