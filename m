Message-ID: <4BA9E71C.4000908@domain.hid>
Date: Wed, 24 Mar 2010 11:19:08 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1269389915.1931.3.camel@domain.hid>
In-Reply-To: <1269389915.1931.3.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] gpio-keys with xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: peter.breuer@domain.hid
Cc: xenomai@xenomai.org

Peter Breuer wrote:
> Hello, 
> I finally had the time to test some different settings...
> 
> I wrote the following program:
> #include <sys/mman.h>
> #include <native/task.h>
> #include <native/intr.h>
> 
> #define IRQ_NUMBER 100  /* Intercept interrupt */
> #define IRQ_MODE   I_NOAUTOENA //I_PROPAGATE //0
> #define TASK_PRIO  99 /* Highest RT priority */
> #define TASK_MODE  T_FPU  /*  */
> #define TASK_STKSZ 0  /* Stack size (use default one) */
> #define PIPE_MINOR 0
> 
> RT_INTR intr_desc;
> 
> RT_TASK server_desc;
> 
> 
> void irq_server (void *cookie)
> 
> {
>         int err =
> rt_intr_create(&intr_desc,"MyIrq",IRQ_NUMBER,IRQ_MODE);
>         printf("int create: %d\n", err);
>         err = rt_intr_enable(&intr_desc);
>         printf("enable int: %d\n", err);
>         printf("begin..\n");
>         err = rt_intr_wait(&intr_desc,TM_INFINITE);
>         printf("int wait:%d\n", err);
> 
> }
> 
> int main (int argc, char *argv[])
> 
> {
>         int err;
>         int a;
>         printf("Programmstart\n");
>         mlockall(MCL_CURRENT|MCL_FUTURE);
> 
>         err = rt_task_create(&server_desc,
>                                 "MyIrqServer",
>                                 TASK_STKSZ,
>                                 TASK_PRIO,
>                                 TASK_MODE);
>         printf("task create: %d\n", err);
>         rt_task_start(&server_desc,&irq_server,NULL);
> }
> 
> void cleanup (void)
> 
> {
>     rt_intr_delete(&intr_desc);
>     rt_task_delete(&server_desc);
> }
> 
> When I start it with the compiled xenomai, it runs until the
> rt_intr_wait() and then quits, without any message. It doesnt even
> execute printf("int wait:%d\n", err)
> create_task, create_intr and enable_intr all return 0. 
> When I start the programm with a kernel, where xenomai isnt compiled in,
> then it quits and complains about it. 
> When I start the programm with xenomai debug settings compiled in the
> kernel, the system freezes at task creating. Heres the output:
> Programmstart
> taskXenomai: fatal: bug at kernel/xenomai/nucleus/shadow.c
> :1128 (!irqs_disabled_hw())
> CPU PID PRI TIMEOUT STAT NAME
> 0 0 -1 0 00400088 ROOT
>> 0 923 99 0 00300180 MyIrqServer
> Master time base: clock=114327768
> [<c002bde4>] (show_stack+0x0/0x48) from [<c006e69c>] (xnshadow_harden
> +0x1d0/0x21c)
> [<c006e4cc>] (xnshadow_harden+0x0/0x21c) from [<c006ec00>]
> (xnshadow_wait_barrier+0x124/0x138)
> [<c006eadc>] (xnshadow_wait_barrier+0x0/0x138) from [<c006fbe4>]
> (xnshadow_sys_barrier+0x14/0x18)
> r6:c309a000 r5:c309bfb0 r4:00000001
> [<c006fbd0>] (xnshadow_sys_barrier+0x0/0x18) from [<c006ff70>]
> (losyscall_event+0xb4/0x1ac)
> [<c006febc>] (losyscall_event+0x0/0x1ac) from [<c0061214>]
> (__ipipe_dispatch_event+0xd0/0x1c8)
> [<c0061144>] (__ipipe_dispatch_event+0x0/0x1c8) from [<c002cc5c>]
> (__ipipe_syscall_root+0x80/0x100)
> [<c002cbdc>] (__ipipe_syscall_root+0x0/0x100) from [<c0028108>]
> (vector_swi+0x68/0xa8)
> 
> Any ideas? 
> is the irq-number, that I need for the rt_intr_create() the same number
> that is shown in /proc/interrupts?
> thx, greetings, 
> Peter

You are using a too old patch. Please use an I-pipe patch for linux
2.6.28 or above.



-- 
					    Gilles.

