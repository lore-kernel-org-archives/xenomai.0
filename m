Message-ID: <43F4B48D.5040809@domain.hid>
Date: Thu, 16 Feb 2006 18:21:17 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] no-brainer realtime issue
References: <C019E68B.23F6%steve@domain.hid> <43F4AB33.5080904@domain.hid>
In-Reply-To: <43F4AB33.5080904@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Jan Kiszka wrote:
> Steven Seeger wrote:
> 
>>I have a xenomai userspace application that does the following:
>>
>>A thread of priority 90 toggles a bit (outb) to move a stepper motor.
>>
>>A thread of priority 10 updates the display once a second.
>>
>>The motor thread is periodic and uses rt_task_wait_period(). The display
>>thread just uses sleep(1).
>>
>>My question is this: the priority 90 thread is higher priority, and doesn't
>>do anything relating to linux system calls. Whenever the display thread
>>updates the display, the motor thread stalls momentarily.
>>
>>Any idea why this is?
> 
> 
> If your motor thread really looks like
> 
> while (1) {
> 	toggle_bit();
> 	rt_task_wait_period();
> }
> 
> you may suffer from contentions of the related bus towards your motor
> (what kind of interface do you use?).
> 
> To test this, just put some instrumentation around the toggle_bit()
> (take timestamps and look for abnormal delays). What frequency is your
> motor thread running at?
> 
> If there is more code in your loop, please post the program (or a
> simplified but still failing version).

Additionally, the output of /proc/xenomai/stat for a failing run might give some 
useful information.

> 
> Jan
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 

Philippe.

