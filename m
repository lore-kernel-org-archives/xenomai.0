From: "Daniel Merrill" <daniel.merrill@psware.com>
Date: Fri, 13 Sep 2013 13:48:55 -0700 (MST)
Message-ID: <a61ffb56.00001e48.00000008@dmerrill_win764.PERF.PERFORMANCESOFTWARE>
MIME-Version: 1.0
Content-Language: en-us
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] psos t_delete causing a SIGSEGV in suspended task.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

All,

 

I'm running into an issue I'm having trouble explaining. I'm hoping you
all will be able to clear it up for me. From my understanding of psos
(which could be wrong) I should be able to call t_delete from either
myself or another task. However, in the xenomai implementation it only
works if I call it from the original "main" thread. If I create two tasks
and one calls t_delete on the other I get a SIGSEGV and the application
dies. Can anyone explain if this is intended behavior and maybe I'm just
not doing it correctly, or possibly a bug in t_delete? Any and all help is
appreciated. I'm using xenomai 2.6.2.1 and Linux 3.5.7. If there are more
details needed I will gladly provide them. TIA.

 

Here is an example app that demonstrates the issue I'm seeing.

 

#include <stdlib.h>

#include <unistd.h>

#include <sys/mman.h>

#include <psos.h>

 

void suspended_task()

{

               printf("Suspending myself\n");

               t_suspend(0);

}

 

void deleter(u_long targs[])

{

               tm_wkafter(1000);

               t_delete(targs[0]);

               t_suspend(0);

}

 

void main()

{

    mlockall(MCL_CURRENT | MCL_FUTURE);

    u_long TID, TID2;

    u_long args[4] = {TID, 0, 0, 0};

    u_long Status = 0;

    t_create("TSK1", 55, 10000, 0, T_LOCAL | T_NOFPU, &TID);

    t_start(TID, T_PREEMPT | T_TSLICE, &suspended_task, NULL);

    t_create("TSK2", 56, 10000, 0, T_LOCAL | T_NOFPU, &TID2);

    t_start(TID2, T_PREEMPT | T_TSLICE, &deleter, args);

    tm_wkafter(1000);

//    Status = t_delete(TID);

//    printf("Status of Delete is %lu\n", Status);

    while(1)

       tm_wkafter(5000);

}

 

Regards,

 

Dan Merrill

 

 

