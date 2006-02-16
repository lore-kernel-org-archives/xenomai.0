Message-ID: <43F4A98E.7060508@domain.hid>
Date: Thu, 16 Feb 2006 17:34:22 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] no-brainer realtime issue
References: <C019E68B.23F6%steve@domain.hid>
In-Reply-To: <C019E68B.23F6%steve@domain.hid>
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
To: Steven Seeger <steve@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Steven Seeger wrote:
> I have a xenomai userspace application that does the following:
> 
> A thread of priority 90 toggles a bit (outb) to move a stepper motor.
> 
> A thread of priority 10 updates the display once a second.
> 
> The motor thread is periodic and uses rt_task_wait_period(). The display
> thread just uses sleep(1).
> 
> My question is this: the priority 90 thread is higher priority, and doesn't
> do anything relating to linux system calls. Whenever the display thread
> updates the display, the motor thread stalls momentarily.

X-window graphic card driver masking hw IRQs? You should see that too when running 
the latency tests while moving windows around the desktop.

Btw, how to you measure/observe the stalled state?

> 
> Any idea why this is?
> 
> Steven
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 

Philippe.

