MIME-Version: 1.0
Message-ID: <OF3EB5637C.BE58E83A-ONC1257E9F.0042D131-C1257E9F.0042E65D@marposs.com>
From: Cristiano.Mantovani@marposs.com
Date: Wed, 12 Aug 2015 14:10:42 +0200
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] rt_task_sleep returns -38
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

I have just started to use Xenomai and I'm using Linux kernel version 
3.10.17-1.0.2 released for Freescale i.MX6Q with Xenomai 2.6.3 (I-pipe 
patch: ipipe-core-3.10.18-arm-1.patch).
I have seen a behavior that I don't understand, it is in this simple 
example:

#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>

#include <sys/mman.h>
#include <native/task.h>
#include <native/timer.h>
#include <native/pipe.h>

#define TASK_PRIO      9
#define TASK_MODE      0
#define TASK_STKSZ     (2*8192)

static RT_TASK main_task_desc, task_desc1, task_desc2, task_desc3;

static void task_func1(void *arg)
{
    int r;
    while (1)
    {
        r = rt_task_sleep(20000000000); // 20sec
        rt_printf("Hello task1! %d\n", r);
    }
}

static void task_func2(void *arg)
{
    int r;
    while (1)
    {
        r = rt_task_sleep(1000000000); // 1sec
        rt_printf("Hello task2! %d\n", r);
    }
}

static void task_func3(void *arg)
{
    int r;
    while (1)
    {
        r = rt_task_sleep(4000000000); // 4sec
        rt_printf("Hello task3! %d\n", r);
    }
}

int main()
{
    int r;

    mlockall(MCL_CURRENT|MCL_FUTURE) ;
    rt_print_auto_init(1) ;

    rt_task_shadow(&main_task_desc, "main", 5, 0);

    r = rt_task_create(&task_desc1, "task1", TASK_STKSZ, TASK_PRIO, 
TASK_MODE);
    if (r == 0)
    {
        r = rt_task_start(&task_desc1, &task_func1, 0);
        if (r == 0)
        {
            r = rt_task_create(&task_desc2, "task2", TASK_STKSZ, 
TASK_PRIO-1, TASK_MODE);
            if (r == 0)
            {
                r = rt_task_start(&task_desc2, &task_func2, 0);
                if (r == 0)
                {
                    r = rt_task_create(&task_desc3, "task3", TASK_STKSZ, 
TASK_PRIO-2, TASK_MODE);
                    if (r == 0)
                    {
                        r = rt_task_start(&task_desc3, &task_func3, 0);
                        if (r == 0)
                        {
                            while (1)
                            {
                                r = rt_task_sleep(5000000000); // 5sec
                                rt_printf("Hello main! %d\n", r);
                                r = system("ls -l &") ;
                                rt_printf("System result %d\n", r);
                            }
                         }
                    }
                }
            }
        }
    }

    return 0;
}

I have three tasks that do a "rt_printf" after sleep, and the main task 
that does a "system" after sleep.
When the main task does the "system", the rt_task_sleep in task1 exits 
with code -38.
This is the output of the simple program:

Hello task2! 0
Hello task2! 0
Hello task2! 0
Hello task2! 0
Hello task3! 0
Hello task2! 0
Hello main! 0
total 8
-rw-r--r-- 1 root root 12 Aug 12 11:54 file1.dat
-rw-r--r-- 1 root root  4 Aug 12 11:54 file2.dat
Hello task1! -38
System result 0
Hello task2! 0
Hello task2! 0
Hello task2! 0
Hello task3! 0
Hello task2! 0
Hello task2! 0
total 8
-rw-r--r-- 1 root root 12 Aug 12 11:54 file1.dat
-rw-r--r-- 1 root root  4 Aug 12 11:54 file2.dat
Hello main! 0
Hello task1! -38
System result 0
Hello task2! 0

Do you have some suggestions for this issue?

Best regards
Cristiano Mantovani.


Cristiano Mantovani
R&D Measuring Systems - Software Designer
phone +39 051 899 389 | fax +39 051 899 802
Cristiano.Mantovani@marposs.com


______________________________________________________

MARPOSS S.p.A., with a sole shareholder
Via Saliceto, 13 - 40010 BENTIVOGLIO (BO) - ITALY

Share Capital euro 14,126,000 paid in full - Tax Code and Registration No. at 
Business Register of Bologna 02759341205
Economic and Administrative Index No. 464925 - VAT IT 02759341205
 



______________________________________________________



The   information  contained  in  this e-mail  and  any  attachments is 
confidential  and  may  also  be  privileged. If you have received the e-mail 
and any attachments by mistake, please inform us  immediately, destroy them 
without storing or copying them on any medium, and do not disclose or use the 
contents for any purpose.
Although our systems implement reasonable precautions against viruses and other 
threats, we cannot accept responsibility for any loss or damage arising from 
managing the contents of this e-mail. 

P  Please consider the environment before printing this e-mail
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: image/jpeg
Size: 20961 bytes
Desc: not available
URL: <http://xenomai.org/pipermail/xenomai/attachments/20150812/2980bb63/attachment.jpe>
