MIME-Version: 1.0
Date: Fri, 17 Jan 2014 15:42:52 +0100
Message-ID: <CAOm2F2aZbA3kKgU1LTjF+Y_qNiU2jhKm6BNXj3ZTr+uAjxcKRg@mail.gmail.com>
From: Simone Chiale <zimbo2288@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Timing problem
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,
Can someone help me with my xenomai problem?
I've patched correctly xenomai 2.6.3 on a vanilla kernel 3.8.13 on a
Pentium M 740 (1.73 GHz) 1 Gb RAM with last Xubuntu OS.
I've used an rt_task_set_periodic() timer to create a loop in which every 2
ms my thread does something. It works well but i ve some problem with RTIME
stamp.
Following an example found in the xenomai help forum  i've tried a simple
program to print every second with rt_printf using rt_timer_read():

---------------------------------------------------------------------------=
-----------------------------------------------------------------

#include <signal.h>
#include <sys/mman.h>
#include <native/task.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <sys/types.h>
#include <unistd.h>
#include <rtdk.h>

RT_TASK demo_task;
int count =3D 0;
RTIME k_time;

void demo(void *arg)
{

rt_task_set_periodic(NULL, TM_NOW, 1000000000);

while (count<10) {

    rt_printf("%llu\n", k_time);

    rt_task_wait_period(NULL);

    k_time =3D rt_timer_read();

    count++;

    }
}

void catch_signal(int sig) {
rt_task_delete(&demo_task);
printf("In ::catch_signal(), sig =3D=3D %d\n",sig);

}

int main(int argc, char* argv[])
{
signal(SIGINT, catch_signal);
rt_print_auto_init(1);
mlockall(MCL_CURRENT | MCL_FUTURE);
rt_task_create(&demo_task, "mydemo", 0, 99, 0);
rt_task_start(&demo_task, &demo, NULL);
pause();
rt_task_delete(&demo_task);
return 0;
}
---------------------------------------------------------------------------=
---------------------------------------------------------------------

My results are very strange so i suppose that something in my TSC is not so
good.
Results:
-----------------------------------------------------------
0
18446744073446329852
736770608
1736771638
18446744072151357874
18446744073151357892
441806040
1441805091
18446744071856389894
18446744072856387160
-------------------------------------------------------------

How is it possible? Can someone help me to fix it?
Thank you,

Simone

ps: I attach my config file.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: config-3.8.13
Type: application/octet-stream
Size: 149238 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140117/99288f9=
2/attachment.obj>
