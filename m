Message-ID: <4D3D8C67.1070406@domain.hid>
Date: Mon, 24 Jan 2011 15:27:51 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <28136729.01295877908562.JavaMail.SYSTEM@PC-MRINALDI>
In-Reply-To: <28136729.01295877908562.JavaMail.SYSTEM@PC-MRINALDI>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problems with rt_task_create and rt_task_join
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Michel Rinaldi <automation.03@domain.hid>
Cc: xenomai@xenomai.org

Michel Rinaldi wrote:
>> A reason for the service being so slow the first time it is called
>> may be the on-demand libraries loading. But for this to take a long
>> time, the native skin library would have to be stored on a really
>> slow storage device, or compressed and the processor you are using
>> being a really slow one. Anyway, you do not tell us on what
>> architecture you get this issue? What processor are you using?
>> Where is the library stored?
>> 
>> -- Gilles.
> 
> Hi to all, and thank you for your support.
> 
> First of all, I'm running Xenomai on an Intel Celeron M 600MHz CPU
> with 512 MB RAM. This embedded PC has its storage unit onto a 2GB
> compact flash, connected to motherboard via ATA interface. Xenomai
> libraries are into default /usr/xenomai path, and seems not
> compressed. Linux distro is Ubuntu 10.04. Attached to this message
> there's my vanilla kernel configuration.
> 
> I tried to check all Xenomai calls, they return no errors. 
> rt_intr_wait() call returns -EIDRM only when interrupt object was
> deleted, no errors otherwise.
> 
> I checked /proc/<pid>/maps to see if libraries are loaded correctly,
> and all seems to be OK.
> 
> To deeply explain my software, some Xenomai syscalls are done into
> shared objects thata are loaded dinamically at runtime with
> dlopen()-dlclose() calls. Particularly, I launch my application, and
> at a certain time I dinamically load into my app an external piece of
> software contained into a shared object. This piece of software
> creates a rt task with rt_task_shadow() and contains a function that
> creates an IRQ handler: to do this, latter function calls
> rt_intr_create(), rt_task_create() and rt_task_start(). Next, I
> attach to my app another shared object that also creates a rt task
> with rt_task_shadow(). Then, if I call my function that creates IRQ
> handler into first loaded object (where function to create IRQ was
> contained), execution time is quick. Instead, if I call this function
> from latter shared object loaded, execution was horribly long (at
> least 500ms). These behaviours are independent from the fact that it
> is or not the first rt_task_create() into application. Could be this
> an issue related to dynamic loading?
> 
> Another strange behaviour that I observed is that if I create IRQ
> handling thread not as joinable, if my call sequence is:
> 
> rt_intr_delete(&myIntrHandler); rt_task_delete(&myIntrTask);
> 
> I still see task into /proc/xenomai/sched (with X state), and
> rt_printf() strings subsequent to rt_task_delete() that are into same
> function don't appear. It seems to be that rt_task_delete() call
> destroys calling task instead target task.
> 
> Instead, If sequence call is:
> 
> rt_intr_delete(&myIntrHandler); rt_task_sleep(1000000000); 
> rt_task_delete(&myIntrTask);
> 
> I don't see at all task into /proc/xenomai/sched, and rt_printf()
> strings subsequent to rt_task_delete() was printed normally. Note
> that these calls are done when an object was dinamically unloaded
> with dlclose().


You explanations are hard to follow and understand, and what is more,
ambiguous. Send us a piece of code which allows us to reproduce this
issue. Trying to make it as simple as possible. For instance seeing if
registering the interrupt causes any difference (if it does not make any
difference, then remove it, you get the idea).

As usual, we do not know what version of Xenomai, Adeos, Linux, etc...
you are using. See:
http://www.xenomai.org/index.php/Request_for_information

> 
> One more question, on rt_task_join(): manual says that the joined
> task must have been created by the same process that wants to join
> it: into this assertion, process means "a task" (then, a PID) or "a
> process composed by tasks"? I think the former. And if the process
> that calls rt_task_join() is not the same, could this cause the
> function doesn't returns?

process means process. process has a very precise meaning in the context
of posix operating systems, we mean exactly that. Talking about PID is
ambiguous, because unfortunately, with past versions of the glibc,
different threads belonging to the same process had different PIDs. A
task is a thread.

> 
> Finally, if this can help, I also observed these messages into dmesg:
>  Clocksource tsc unstable (delta = 2636104979 ns) Switching to
> clocksource pit They appears when rt_task_create() is slow.

That is bad. One more question: what happens when you run the "latency"
test, do you get strange results? Also, I see that you have the SMI
workaround enabled, does it detect your chipset?

-- 
                                                                Gilles.

