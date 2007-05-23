Message-ID: <4654386C.6060309@domain.hid>
Date: Wed, 23 May 2007 14:49:48 +0200
From: Rodolfo <rolfetas@domain.hid>
MIME-Version: 1.0
References: <46543091.3040308@domain.hid> <465434B9.6010805@domain.hid>
In-Reply-To: <465434B9.6010805@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] loading module
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

here's the source of the testing module.

#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/proc_fs.h>
#include <native/task.h>
#include <native/types.h>
#include <native/timer.h>
#include <rtdm/rtdm_driver.h>
#include <nucleus/pod.h>

MODULE_LICENSE("GPL");
MODULE_DESCRIPTION("Hello World Xenomai Application");

/************************* Global Variables ******************************/

RT_TASK thread;
RTIME timer_period_ns;
RTIME task_period_ns;
RTIME expected;
int timer_period_counts;
unsigned long overrun; // rt_task_wait_period() writes here overrun
count.0 if everything OK

/************************* Periodic realtime thread **********************/

void fun(int dummy) {
    int count = 0;
    while(1) {
        ++count;
        rt_task_wait_period(&overrun);
        if ((count%100)==0) {
            rtdm_printk("Periode %d ist abgelaufen\n",count);
        }
    }
}

/************************* Initialisation *******************************/

static int hello_init(void)
{
    //testing rt_task_create(...);
    int count = 0;
    printk("task create");
    rt_task_create(&thread,"fun_task",3000,1,0);
    printk("created..");
    printk("task start");
    rt_task_start(&thread,fun,0);
    printk("started........");



    //timer_period_ns = 10000000;/*10ms*/
    /*timer_period_counts = start_rt_timer(nano2count(timer_period_ns));*/

//timer_period_counts=rt_timer_set_mode(rt_timer_ns2tsc(timer_period_ns));
    /* Calculate the start time for the task. */
    /* We set this to "now plus 10 periods"   */
    //expected = xnpod_get_time()  + 10 * timer_period_counts;

    /* Task period initialization */
    //task_period_ns =50000000;/*5ms*/
    /*rt_task_make_periodic(&thread, expected,
nano2count(task_period_ns));*/
    //rt_task_set_periodic(&thread, expected,
rt_timer_ns2tsc(task_period_ns));
    return 0;
}

/************************* Cleanup *********************************/

static void hello_exit(void)
{
  /*stop_rt_timer();*/

  /* Now delete our task */
 // rt_task_delete(&thread);
}

module_init(hello_init);
module_exit(hello_exit);


Gilles Chanteperdrix wrote:
> Rodolfo wrote:
>   
>> Hi,
>> I am totally new to Xenomai and have no experience with RTAI. I'm trying
>> to load a kernel module that uses the native API for testing, but I get
>> the following segmentation fault. Can anyone help me out??
>>     
>
> Please post here the sources of your module.
>
>   



