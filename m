Message-ID: <b647ffbd0612200340had5a21ajd1bcb7cd871d06fb@domain.hid>
Date: Wed, 20 Dec 2006 12:40:26 +0100
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-help] install an interrupt-handler from a kernel module
In-Reply-To: <458915DB.80909@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <458915DB.80909@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Markus.Franke@domain.hid
Cc: Xenomai help <xenomai@xenomai.org>

On 20/12/06, Markus Franke <Markus.Franke@domain.hid> wrote:
> Dear Xenomai-Users/Developers,
>
> I have a basic question. Installing an interrupt handler is possible via
> "rt_intr_create()", both from user-space and from a kernel module.
> What happens when I do a "rt_intr_create()" from the module_init()
> routine? By which priority, interrupts are delegated to my ISR? Do I
> need to create an extra realtime task via "rt_task_create()" in order to
> achieve hard realtime response, or is it enough to install the
> interrupt-handler from module_init().

The key difference is in what context your ISR is executed.
If you register your ISR in kernel-space, the ISR will be called
asynchronously (when a dedicated interrupt occurs and interrupts are
on for this domain; otherwise - at the next point when interrupts will
be on again) preempting some running context. Sure, you shouldn't
access the preempted context or make any assumptions on its nature.

In this scheme per-ISR priorities are not supported. Of course, your
CPU may (and likely do) have some priority scheme (e.g. low-numbered
irqs are scheduled before higher numbered in case both are pending)
and, in fact, ipipe also has something similar (but you shoudn't rely
on this behaviour).

IOW, you don't need to create a separate task.

Another thing is registering an ISR in the user-space. In this case,
your ISR function "belongs" to your process'es address space and must
be called only in this context (on behalf of one of the threads of
your application). That's why normally one should create a dedicated
task to handle the ISR. As tasks may have different priorities, it
looks like ISRs (== a task) have priorities and may preempt each
other.


p.s. if you are about to write a real-time driver, consider using the
RTDM interface instead of the native skin.


-- 
Best regards,
Dmitry Adamushko

