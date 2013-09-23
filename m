Message-ID: <5240004A.6070703@mitrol.it>
Date: Mon, 23 Sep 2013 10:48:10 +0200
From: Paolo Minazzi <Paolo.Minazzi@mitrol.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] rt_intr_wait bug during debugging
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi to all,
the problem arise when I debug an application that uses an external 
interrupt.
Below there is a sample (pseudo) code that show how I can see the problem.
The irq stuff is related on my specific machine, so I think it is not 
important
give details about GPIO programming and interrupt clear (CLEAR_IRQ).

To see the problem :
1. I put a breakpoint on the usleep
2. I countinue to send "c" to stop always in the breakpoint.

When all is OK the cnt grows up.

Sometime, after several "c", I encounter the bug.
At this point the cnt is always the same and stops to grow up.
This happen because the irq line is disabled ! I check it seeing the VIC 
register.

I verified that if I put only a breakpoint in the
     asm("nop")
the irq line in the VIC register is disabled. This means that xenomai 
disable the irq line because
I enabled the irq line before with
     rt_intr_enable(&int_desc);
When restart with "c", xenomai is able to enable again the irq line.

For some reason xenomai sometimes does not enable irq line anymore and 
the code
in blocked in the
     rt_intr_wait(&int_desc, TM_INFINITE);
line.

If I enter in the bug condition and manually enable the irq line 
(programming the VIC register)
all works again without problem. If I continue my test I will re-enter 
in the bug condition ...

Only a dubt : in the xenomai example

http://www.xenomai.org/documentation/xenomai-2.4/html/api/user__irq_8c-example.html#a1 


there is not the rt_intr_enable in the irq_server. I don't know if it is 
out problem or not.

I tried to debug and I have some log, but for me it is difficult 
understand the real source of the
bug. I have a system on which I can see the problem with a minimal effort.

To be clear, there is no problem executing the xenomai application 
without debugger.

Regards
Paolo Minazzi






######################################################################################### 

void irq_server(void *cookie)
{
         while (1)
         {
                 rt_intr_enable(&int_desc);

                 asm("nop");

                 rt_intr_wait(&int_desc, TM_INFINITE);

                 CLEAR_IRQ();

                 cnt++;
         }
}
void InitIrq(void)
{
         init_irq_fujitsu();

         rt_intr_create(&int_desc, IRQNAME, IRQNUMBER, I_PROPAGATE );

         rt_task_create(&server_desc, "Irq2ms", TASK_STKSZ, TASK_PRIO, 
TASK_MODE);

         rt_task_start(&server_desc, &irq_server, NULL);

         enable_irq_fujitsu();
}

int main(int argc, char* argv[])
{
         mlockall(MCL_CURRENT|MCL_FUTURE);

         rt_timer_set_mode ( 0 );
         rt_task_set_mode(0, 0, /* T_WARNSW ,*/ NULL);

         MapRegistersARM();

         InitIrq();

         while(1)
         {
                 printf("[ %4d ]\n",cnt);
  ======>        usleep(10000);
         }
}
######################################################################################### 


