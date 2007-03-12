Message-ID: <bc4264770703121117i2f8648dep853a2ef30301ab67@domain.hid>
Date: Mon, 12 Mar 2007 18:17:41 +0000
From: "roland Tollenaar" <rolandtollenaar@domain.hid>
Subject: Re: [Xenomai-help] your pending RT-Socket-CAN problems (was rtcan
	driver. rtcan_sja_interrupt made interruptible)
In-Reply-To: <45F471A9.1040005@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45F2B8BB.6060804@domain.hid> <45F2DE0A.1010207@domain.hid>
	<bc4264770703110035g6625e8a1t4f195507d72aaf66@domain.hid>
	<45F3CD2C.5000400@domain.hid>
	<bc4264770703110402x55f7b13chca39ed02f983feac@domain.hid>
	<45F3F013.5000400@domain.hid> <45F471A9.1040005@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Hi,

I need some tutoring again if anyone cares to.

> Threaded IRQs are no magic bullet. They can only help to push a problem
> down the priority ladder, curing a problem symptom where possible.

I keep going on about "interruptible" ISR's. Yet I never see the
phrase used by anyone else. This either means that "Threaded IRQ's" or
"service-tasks" are implicitly interruptible, i.e. do not hog the CPU
for themselves exclusively, or I am missing something a lot more
fundamental? Is a "threaded IRQ" a possible solution because threads
(even real-time ones) will automatically share the CPU according to
priority? Is this different to a "service task" as mentioned by
Wolfgang or are the two basically the same?

>
> Nevertheless, threaded IRQs for RTDM are planned. The yet open design
> challenge is how to support driver writers best when they have to switch
> between both models, e.g. during compile-time (keep in mind, you also
> have to switch the locking: spinlock<->mutex).
What is a mutex?

This is slightly off the topic but is it ridiculous to ask whether it
is possible to suppress interrupts from user space?

A possible work-around to the long reading spell occurred to me in the
following. I turn my 1ms task into for example a 0.5ms task. By
releasing interrupt IRQ7 every second time the task is run and
suppressing it on the other, then by using a corresponding toggle I
can alternately read-out the can and calculate and set control outputs
on every second time the task is run.
I might have a bit of trouble preventing the FIFO buffer on the chip
to overflow but it would be interesting to know what it takes to
suppress an interrupt anyway.

?

Regards,

Roland.

>
> Jan
>
>
>

