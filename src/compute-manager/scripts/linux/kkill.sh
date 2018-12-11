	
#!/bin/bash

ps axf | grep $1 | grep -v grep | awk '{print "kill -9 " $1}' | sh