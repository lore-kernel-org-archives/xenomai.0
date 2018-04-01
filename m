From: Steve Freyder <steve@freyder.net>
Message-ID: <5AC116C9.6040809@freyder.net>
Date: Sun, 1 Apr 2018 12:28:41 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Possible Xenomai fuse filesystem/registry queue status
	files issue?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Greetings again.

As I understand it, for each rt_queue there's supposed to be a
"status file" located in the fuse filesystem underneath the
"/run/xenomai/user/session/pid/alchemy/queues" directory, with
the file name being the queue name.  This used to contain very
useful info about queue status, message counts, etc.  I don't know
when it broke or whether it's something I'm doing wrong but I'm
now getting a "memory exhausted" message on the console when I
attempt to do a "cat" on the status file.

Here's a small C program that just creates a queue, and then does
a pause to hold the accessor count non-zero.

----------qc.c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/mman.h>
#include <errno.h>
#include <alchemy/queue.h>
#include <alchemy/task.h>

int main(
     int argc,
     char *argv[]
){
     RT_QUEUE q ;
     char *name = argv[1] ;
     int err ;

{
     static RT_TASK MyShadow ;

     mlockall(MCL_CURRENT|MCL_FUTURE);
     err = rt_task_shadow(&MyShadow,NULL,1,0) ;
     if (err < 0)  {
         fprintf(stderr,"shadow: %s\n",strerror(-err)) ;
         exit(-err) ;
     }
}
     err = rt_queue_create(&q,name,1024*1024,1024,Q_FIFO) ;
     if (err < 0)  {
         fprintf(stderr,"rtqc %s: %s\n",name,strerror(-err)) ;
         return(1) ;
     }
     for (int nerrno = 2 ; pause() < 0 && errno == EINTR && --nerrno > 0 
;) ;
     return(0) ;
}
----------qc.c end

A shell script to conduct the test:

----------qtest.sh
#!/bin/sh

set -x
./qc --mem-pool-size=64M --session=mysession foo &
sleep 1
find /run/xenomai
qfile=/run/xenomai/*/*/*/alchemy/queues/foo
cat $qfile
----------qtest.sh

The resulting output (logged in via the system console):

# sh qtest.sh
+ sleep 1
+ ./qc --mem-pool-size=64M --session=mysession foo
+ find /run/xenomai
/run/xenomai
/run/xenomai/root
/run/xenomai/root/mysession
/run/xenomai/root/mysession/821
/run/xenomai/root/mysession/821/alchemy
/run/xenomai/root/mysession/821/alchemy/tasks
/run/xenomai/root/mysession/821/alchemy/tasks/task@1[821]
/run/xenomai/root/mysession/821/alchemy/queues
/run/xenomai/root/mysession/821/alchemy/queues/foo
/run/xenomai/root/mysession/system
/run/xenomai/root/mysession/system/threads
/run/xenomai/root/mysession/system/heaps
/run/xenomai/root/mysession/system/version
+ qfile='/run/xenomai/*/*/*/alchemy/queues/foo'
+ cat /run/xenomai/root/mysession/821/alchemy/queues/foo
memory exhausted

At this point, it hangs, although SIGINT usually terminates it.

I've seen some cases where SIGINT won't terminate it, and a reboot is
required to clean things up.  I see this message appears to be logged
in the obstack error handler.  I don't think I'm running out of memory,
which makes me think "heap corruption".  Not much of an analysis!  I did
try varying queue sizes and max message counts - no change.

Thanks in advance,
Best regards,
Steve


