From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Wed, 25 Oct 2006 23:46:33 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_6s9PFaGvQIKuK45"
Message-Id: <200610252346.34150.niklaus.giger@domain.hid>
Subject: [Xenomai-core] Bug in taskSuspend for user mode vxworks
Reply-To: niklaus.giger@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

--Boundary-00=_6s9PFaGvQIKuK45
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi

While trying to make a small demo app for Xenomai's registry I stumbled about 
the following bug of the vxWorks skin.

taskSuspend provokes (sometimes) a switch to the secondary mode, e.g. the 
output of the attached demo gives:
>  reg_demo &
> ~ $ Xenomai: Switching ConsumerTask to secondary mode after exception #1025
> from user-space at 0xfe5cff8 (pid 27) consumer_task: 13129 Started
> producer_task: 13258 Started  xx
> lockForward: 13259 Started
> producer_task: 13260 msg sent 0
> lockForward: 13260 got both mutexes
> lockBackward: 13260 Started
> producer_task: 13261 msg sent 0
> producer_task: 13261 done
> Now playing first msg...
> consumer_task: 13262 Suspending myself. After receiving sz 16
>
> This is a small demo for the debugging option CONFIG_XENO_EXPORT_REGISTRY.
> If you compile the xenomai kernel with CONFIG_XENO_EXPORT_REGISTRY=y
> in your kernel .config you will find files under /proc/xenomai/registry.
> tasks/*:      gives information about running vxworks tasks
> semaphores/*: gives information about the vxworks semaphores
> msgqs/*:      gives information about the vxworks message queues
>
> Some vxWorks tasks should be blocked. Now enter:
> ls -R /proc/xenomai/registry/vxworks/* && cat
> /proc/xenomai/registry/vxworks/*/* lockForward: 13271 will give both
> mutexes
> lockForward: 13271 Done

Running the same program under the simulator gave me the expected output

I had not yet time to track down the error, but any help would be appreciated.

Thanks in advance

Best regards

-- 
Niklaus Giger

--Boundary-00=_6s9PFaGvQIKuK45
Content-Type: text/x-csrc;
  charset="iso-8859-1";
  name="reg_demo.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="reg_demo.c"

/*
 * Copyright (C) 2006 Niklaus Giger <niklaus.giger@domain.hid>.
 *
 * VxWorks is a registered trademark of Wind River Systems, Inc.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 */

#include <vxworks/vxworks.h>

#define ROOT_TASK_PRI        100
#define ROOT_STACK_SIZE      16*1024

#define CONSUMER_TASK_PRI    115
#define CONSUMER_STACK_SIZE  24*1024

#define PRODUCER_TASK_PRI    110
#define PRODUCER_STACK_SIZE  24*1024

#define CONSUMER_WAIT 150
#define PRODUCER_TRIG 40

int root_thread_init(void);
void root_thread_exit(void);

#if !defined(__KERNEL__) && !defined(__XENO_SIM__)

#include <sys/mman.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

#define MODULE_LICENSE(x)

#define xnprintf printf

int main (int argc, char *argv[])
{
    int tid;
    mlockall(MCL_CURRENT|MCL_FUTURE);

    atexit(&root_thread_exit);

    tid = taskSpawn("RootTask",
		    ROOT_TASK_PRI,
		    0,
		    ROOT_STACK_SIZE,
		    (FUNCPTR)&root_thread_init,
		    0,0,0,0,0,0,0,0,0,0);
    if (tid)
	pause();

    return 1;
}

#endif /* Native, user-space execution */

MODULE_LICENSE("GPL");

static int producer_tid,
           consumer_tid,
           message_qid,
           emptySema,
           fullSema,
           countingSema,
           mutexForward,
           mutexBackward;

void lockForward (int a0, int a1, int a2, int a3, int a4,
		    int a5, int a6, int a7, int a8, int a9)
{
    xnprintf("%s: %d Started\n",__FUNCTION__, tickGet());
    semTake(mutexForward,  WAIT_FOREVER);
    semTake(mutexBackward, WAIT_FOREVER);
    xnprintf("%s: %d got both mutexes\n",__FUNCTION__, tickGet());
    taskDelay(10);
    xnprintf("%s: %d will give both mutexes\n",__FUNCTION__, tickGet());
    semGive(mutexBackward);
    semGive(mutexForward);
    xnprintf("%s: %d Done\n",__FUNCTION__, tickGet());
    taskExit(0);
}

void lockBackward (int a0, int a1, int a2, int a3, int a4,
		    int a5, int a6, int a7, int a8, int a9)
{
    xnprintf("%s: %d Started\n",__FUNCTION__, tickGet());
    semTake(mutexBackward, WAIT_FOREVER);
    semTake(mutexForward,  WAIT_FOREVER);
    xnprintf("%s: %d got both mutexes\n",__FUNCTION__, tickGet());
    taskDelay(10);
    xnprintf("%s: %d will give both mutexes\n",__FUNCTION__, tickGet());
    semGive(mutexForward);
    semGive(mutexBackward);
    xnprintf("%s: %d Done\n",__FUNCTION__, tickGet());
    taskExit(0);
}

#define MSG_SIZE 16
void consumer_task (int a0, int a1, int a2, int a3, int a4,
		    int a5, int a6, int a7, int a8, int a9)
{
    char msg[MSG_SIZE];
    int sz;
    xnprintf("%s: %d Started\n",__FUNCTION__, tickGet());
    if ((sz = msgQReceive(message_qid,(char *)&msg,sizeof(msg), 100)) != ERROR)
	    xnprintf("Now playing %s...\n",msg);
    xnprintf("%s: %d Suspending myself. After receiving sz %d\n",__FUNCTION__, tickGet(), sz);
    taskSuspend(taskIdSelf());
    xnprintf("%s: %d Done\n",__FUNCTION__, tickGet());
    taskExit(0);
}

void producer_task (int a0, int a1, int a2, int a3, int a4,
		    int a5, int a6, int a7, int a8, int a9)
{
    int res;
    const char s1[MSG_SIZE] = "first msg";
    const char s2[MSG_SIZE] = "second msg";
    xnprintf("%s: %d Started  xx\n",__FUNCTION__, tickGet());
    res = msgQSend(message_qid,(char *)&s1,sizeof(s1),WAIT_FOREVER,MSG_PRI_NORMAL);
    xnprintf("%s: %d msg sent %d\n",__FUNCTION__, tickGet(), res);
    res = msgQSend(message_qid,(char *)&s2,sizeof(s2),WAIT_FOREVER,MSG_PRI_NORMAL);
    xnprintf("%s: %d msg sent %d\n",__FUNCTION__, tickGet(), res);
    xnprintf("%s: %d done\n",__FUNCTION__, tickGet());
    taskExit(0);
}

int root_thread_init (void)
{
    emptySema     = semBCreate(SEM_EMPTY, 0);
    fullSema      = semBCreate(SEM_FULL,  SEM_Q_FIFO);
    countingSema  = semCCreate(10,        SEM_Q_PRIORITY);
    mutexForward  = semMCreate(SEM_Q_PRIORITY);
    mutexBackward = semMCreate(SEM_Q_PRIORITY | SEM_INVERSION_SAFE | SEM_DELETE_SAFE);

    message_qid  = msgQCreate(16, MSG_SIZE, MSG_Q_FIFO);
    consumer_tid = taskSpawn("ConsumerTask",
			     CONSUMER_TASK_PRI,
			     0,
			     CONSUMER_STACK_SIZE,
			     (FUNCPTR)&consumer_task,
			     0,0,0,0,0,0,0,0,0,0);

    producer_tid = taskSpawn("ProducerTask",
			     PRODUCER_TASK_PRI,
			     0,
			     PRODUCER_STACK_SIZE,
			     (FUNCPTR)&producer_task,
			     0,0,0,0,0,0,0,0,0,0);
    producer_tid = taskSpawn("LockForward",
			     PRODUCER_TASK_PRI,
			     0,
			     PRODUCER_STACK_SIZE,
			     (FUNCPTR)&lockForward,
			     0,0,0,0,0,0,0,0,0,0);
    producer_tid = taskSpawn("LockBackward",
			     PRODUCER_TASK_PRI,
			     0,
			     PRODUCER_STACK_SIZE,
			     (FUNCPTR)&lockBackward,
			     0,0,0,0,0,0,0,0,0,0);
//    taskDelay(40);
    xnprintf("\n\
This is a small demo for the debugging option CONFIG_XENO_EXPORT_REGISTRY. \n\
If you compile the xenomai kernel with CONFIG_XENO_EXPORT_REGISTRY=y \n\
in your kernel .config you will find files under /proc/xenomai/registry.  \n\
tasks/*:      gives information about running vxworks tasks \n\
semaphores/*: gives information about the vxworks semaphores \n\
msgqs/*:      gives information about the vxworks message queues \n\
\n\
Some vxWorks tasks should be blocked. Now enter:\n\
ls -R /proc/xenomai/registry/vxworks/* && cat /proc/xenomai/registry/vxworks/*/* \n");

    return 0;
}

void root_thread_exit (void)

{
    xnprintf("%s: Done\n",__FUNCTION__);
}

--Boundary-00=_6s9PFaGvQIKuK45--

