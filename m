Message-ID: <559E65FB.8080904@sigmatek.at>
Date: Thu, 09 Jul 2015 14:15:55 +0200
From: Johann Obermayr <johann.obermayr@sigmatek.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] usage of rtdm_task_sleep_abs
Reply-To: johann.obermayr@sigmatek.at
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai@xenomai.org

Hello,

we have follow situation

u64 lrtdrv_time_of_irq_ns ;
void worker_task()
{
while(1)
     {
     rtdm_task_sleep_abs(lrtdrv_time_of_irq_ns + 950000ull, 
RTDM_TIMERMODE_ABSOLUTE);
     do_something();
     }
}

_kernel_rtdm_irq_handler()
{
     lrtdrv_time_of_irq_ns = rtdm_clock_read_monotonic();
}

the  _kernel_irq_callback() is called every 1ms.
we will , that the worker_task begin 50us before next irq

But sometime, the worker task start ~50us after irq. Why ?

Sometime we call xntbase_adjust_time to sync external RTC with internal 
clocks.
can this be a problem ?

Hardware & Software
X86 SMP Dual celeron
Linux Kernel 3.10.0
Xenomai 2.6.3

Regards
   Johann

