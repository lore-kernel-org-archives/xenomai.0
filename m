Message-ID: <4B104F96.5090200@domain.hid>
Date: Fri, 27 Nov 2009 23:15:50 +0100
From: =?ISO-8859-15?Q?Michael_L=F6ffler?= <ml+xenomai@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Bug in rt_task_sleep() ?
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hello List!

I have an application running rt_task_sleep() in a loop. After a more or
less random number of loops, something up to 5000 cycles, the system
reboots with the following error message:

Kernel panic - not syncing:
BUG!
<4>BUG: failure at kernel/ipipe/core.c:319/__ipipe_restore_root()!

For me it's not a bigger issue, as I can replace it with usleep() and
everything works fine, but maybe it's something, someone could have a
closer look at. On my system (blackfin537-stamp, uclinux2008, xenomai
2.4.0) it can be reproduced with the following code:

#include <stdio.h>
#include <unistd.h>
#include <rtdm/rtdm.h>
#include <native/task.h>
#include <linux/delay.h>

RT_TASK _rtTask;

int main(int argc, char *argv[]) {
    rt_task_shadow(&_rtTask, "whatever", 1, 0);
    rt_task_set_mode(0, T_PRIMARY, NULL); // primary

    uint32_t n = 0;
    while (1) {
        printf("Loop %u OK. Waiting....\n", n++);
        rt_task_sleep(100000000); // 500MHZ -> 0.2s
        //usleep(100000);
    }
}


