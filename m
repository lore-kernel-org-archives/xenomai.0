Message-ID: <441C5562.7000800@domain.hid>
Date: Sat, 18 Mar 2006 19:45:54 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: get the simulator running...
References: <441C2574.4030901@domain.hid> <441C4279.10800@domain.hid>
	<441C4460.9030103@domain.hid> <441C5371.1080208@domain.hid>
In-Reply-To: <441C5371.1080208@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Philippe Gerum wrote:
> 
>>Philippe Gerum wrote:
>>
>>>Jan Kiszka wrote:
>>> Fortunately, I had that demo I once produced
>>>
>>>
>>>>(last year), but that one was easier to build. I first had to drag in
>>>>the libs and includes of both the simulator and a regular xenomai
>>>>installation (I think to remember this once worked without this
>>>>add-ons). Then I need this additional trick in the simulators include
>>>>dir:
>>>>
>>>>mkdir asm
>>>>ln -s <xeno-inst-dir>/include/asm-sim asm/xenomai
>>>>
>>>>This maps #include <asm/xenomai/system.h> to the correct "arch".
>>>>Shouldn't this be created automatically during the simulator
>>>>installation? Or is something else broken on my box?
>>>>
>>>
>>>You clearly should not need this trick to compile apps against the
>>>simulation environment; the instrumenter (gcic) sets the proper flags.
>>>I'm going to rebuild one and let you know.
>>
>>Confirmed. You don't need this hand-made link.
>>
> 
> 
> Err, "confirmed" means that it works for you without the link and the
> extra paths for gcic?

Yes (actually, it has always worked for me this way).

  The compilation of the simulator runs fine with
> latest SVN here, but gcic still does not know any include paths.
> Attached is the native skin demo I tried.

gcic explicitely sets -I<install-dir>/include/asm-sim before invoking 
the gcc toolchain. Try adding --verbose to see what's passed.

> 
> Jan
> 
> 
> ------------------------------------------------------------------------
> 
> /*
>  * nat-demo.c
>  *
>  * Simple demonstration for a native-skin application inside the MVM simulator
>  * (C) 2005-2006 by Jan Kiszka <jan.kiszka@domain.hid>
>  *
>  * This program is free software; you can redistribute it and/or modify
>  * it under the terms of the GNU General Public License as published by
>  * the Free Software Foundation; either version 2 of the License, or
>  * (at your option) any later version.
>  *
>  * This program is distributed in the hope that it will be useful,
>  * but WITHOUT ANY WARRANTY; without even the implied warranty of
>  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>  * GNU General Public License for more details.
>  *
>  * You should have received a copy of the GNU General Public License
>  * along with this program; if not, write to the Free Software
>  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>  */
> 
> #include <native/task.h>
> #include <native/sem.h>
> 
> RT_TASK demo_task1;
> RT_TASK demo_task2;
> RT_SEM sem;
> 
> void demo1(void *arg)
> {
>     RTIME now, previous;
> 
>     rt_task_set_periodic(NULL, TM_NOW, 1000000000);
>     previous = rt_timer_read();
> 
>     while (1) {
>         rt_task_wait_period(NULL);
>         now = rt_timer_read();
> 
>         printk("%s: delay since last invocation:: %ld.%06ld ms\n",
>                __FUNCTION__,
>                (long)(now - previous) / 1000000,
>                (long)(now - previous) % 1000000);
>         previous = now;
> 
>         rt_sem_v(&sem);
>     }
> }
> 
> 
> void demo2(void *arg)
> {
>     RTIME now, previous;
> 
>     previous = rt_timer_read();
> 
>     while (1) {
>         rt_sem_p(&sem, TM_INFINITE);
>         now = rt_timer_read();
> 
>         printk("%s: delay since last invocation:: %ld.%06ld ms\n",
>                __FUNCTION__,
>                (long)(now - previous) / 1000000,
>                (long)(now - previous) % 1000000);
>         previous = now;
>     }
> }
> 
> 
> /* Note: simulator requires exactly this function name! */
> int __xeno_user_init(void)
> {
>     rt_task_create(&demo_task1, "kdemo1", 0, 99, 0);
>     rt_task_create(&demo_task2, "kdemo2", 0, 98, 0);
>     rt_sem_create(&sem, NULL, 0, S_PRIO);
> 
>     rt_task_start(&demo_task1, &demo1, NULL);
>     rt_task_start(&demo_task2, &demo2, NULL);
> 
>     return 0;
> }
> 
> 
> /* Note: simulator requires exactly this function name! */
> void __xeno_user_exit(void)
> {
>     rt_task_delete(&demo_task1);
>     rt_task_delete(&demo_task2);
>     rt_sem_delete(&sem);
> }
> 
> module_init(__xeno_user_init);
> module_exit(__xeno_user_exit);
> 
> MODULE_LICENSE("GPL");


-- 

Philippe.

