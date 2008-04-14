Message-ID: <4802D074.3080102@domain.hid>
Date: Sun, 13 Apr 2008 23:33:08 -0400
From: Tomas Kalibera <kalibera@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080203010500070006070701"
Subject: [Xenomai-help] problem with rt_task_delete/pthread_cancel
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------080203010500070006070701
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I'm trying to terminate a program from a child task. The idea is that a 
joinable child task kills itself, unblocking its parent which exits the 
application. However, the program crashes when the child calls 
rt_task_delete.

Inspecting the core file by gdb shows this:

Program terminated with signal 11, Segmentation fault.
#0  0xb7f014cd in pthread_cancel () from /lib/tls/i686/cmov/libpthread.so.0

A simple program which triggers the problem is attached. Is this a bug, 
or the API should not be used in this way ?

Thanks,

Tomas

--------------080203010500070006070701
Content-Type: text/x-csrc;
 name="e.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="e.c"


#include <stdio.h>
#include <unistd.h>
#include <sys/mman.h>

#include <native/task.h>
#include <rtdk.h>

RT_TASK child;

void child_body(void *cookie) {
  int rc;
  
  fprintf(stderr,"In child..\n");

  rc=rt_task_delete(rt_task_self());
  if (rc!=0) {
    fprintf(stderr,"rt_task_delete returned %d\n");
  }

}

int main(int argc, char **argv) {

  int rc;
  
  mlockall(MCL_CURRENT|MCL_FUTURE);
  
  rc=rt_task_create(&child,"ovmtask",0,11,T_JOINABLE);  
  if (rc!=0) {
    fprintf(stderr,"rt_task_create returned %d\n");
  }  

  rc=rt_task_start(&child,&child_body,NULL);
  if (rc!=0) {
    fprintf(stderr,"rt_task_start returned %d\n");
  }  

  rc=rt_task_join(&child);
  if (rc!=0) {
    fprintf(stderr,"rt_task_join returned %d\n");
  }  
  
  return 0;
}

--------------080203010500070006070701--

