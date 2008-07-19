Message-ID: <48819761.7000702@domain.hid>
Date: Sat, 19 Jul 2008 09:27:29 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1216282324.3472.29.camel@domain.hid>
	<48804E28.80906@domain.hid>
In-Reply-To: <48804E28.80906@domain.hid>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai-help] Generel problem with realtime-tops(like adeos)
 over	linux-kernel
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?UTF-8?B?IlNjaGzDpGdsIFwiTWFuZnJlZCBqdW4uXCIi?= <manfred.schlaegl@domain.hid>
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
> Schlägl Manfred jun. wrote:
>> But... Linux is able to provide hard-realtime while interrupts are
>> locked. And many services(driver) use this.
>>
>> abstract example:
>> {{{
>> spin_lock_irqsave
>> if(hardware_data_valid())
>> 	process_hardware_data()
>> spin_lock_irqrestore
>> }}}
> 
> Well, real-time is not about allowing this handler to perform un-preempted, but
> rather to guarantee that the highest priority code will always get the CPU at
> any point in time. If that handler is the most time-critical work to do on your
> box, that's fine. But if it's not, this code is wrong, because it basically
> wrecks real-time behaviour.
> 
> Actually, your basic assumption is flawed on a regular SMP kernel: what if the
> lock is currently held by a task running on another CPU, that ends up being
> preempted by an IRQ,

e.g. due to a mixed spin_lock(CPU #0) vs spin_lock_irq*(cpu #1) construct,
protecting two different accesses to the same critical resource. We could make
sure that such construct never involves time-critical code, but that would still
require to identify the potentially problematic code, and fix it accordingly.
IOW, we would have to go through the very same audit process than for a
virtualized IRQ system like Adeos.

In the former case (vanilla non-RT kernel), we would have to always use the
spin_lock_irq*() form to serialize accesses, in the latter case (Adeos-enabled
kernel), we would have to convert regular locks to raw Adeos locks
(ipipe_spin_lock_t).

Another scenario which comes to mind involves 3 CPUs and two locks on a vanilla
kernel, i.e.:

CPU #0                 CPU #1                        CPU #2
spin_lock(&lockB);     spin_lock_irqsave(&lockA);
                       spin_lock(&lockB);            spin_lock_irqsave(&lockA);

In that case, and despite the locking sequence seems fine, the driver code on
CPU #2 that attempts to grab lockA will wait until lockB is released on CPU #0,
which can induce significant delay, while CPU #2 spins with hw interrupts off.
Again, that kind of nested construct could be banned, but how would you know it
is never used without actually auditing the code?

 or any higher priority task?

i.e. on a native preemption kernel, because spinlocks are turned into rt-mutexes
that allow rescheduling in what used to be truly atomic sections on vanilla kernels.

What I mean with those examples, is that your analysis is right when it comes to
the potential issue introduced by interrupt virtualization, but other problems
leading to the same consequence can appear with regular or native preemption
kernels as well. Therefore, the only reasonable answer is to address each
time-critical aspect specifically (e.g. MTD and such), and from that point, one
can fix them - such as introducing raw locks in Adeos-enabled kernels or
re-ordering task priorities with native preemption ones - regardless of the
underlying real-time infrastructure.

I'm not saying that such task is an easy one, all I'm saying is that there is no
Linux kernel that is virtuous by essence when it comes to predictable behaviour,
so we have to help them a bit by knowing about our real-time constraints in any
case.

-- 
Philippe.

