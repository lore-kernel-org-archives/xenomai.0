Message-ID: <4C5A631B.1040604@domain.hid>
Date: Thu, 05 Aug 2010 09:07:07 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4C5A26C4.3050702@domain.hid>
In-Reply-To: <4C5A26C4.3050702@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] RTDM driver structure
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bob Feretich <bob.feretich@domain.hid>
Cc: xenomai@xenomai.org

Bob Feretich wrote:
>   I want to verify that my understanding of the RTDM driver structure is 
> correct.
> 
> My driver is created as a module that is loaded by Linux insmod. Given 
> that...
> 
> My module_init routine (and module_exit)...
> *  is executed in the Linux driver context.
> *  should use Linux spin locks and events instead of rt_locks and events.
> *  can call rtdm_irq_request (rtrm_irq_free) to register my interrupt 
> handlers
>        for rt interrupts.
> *  can call rtdm_device_register (rt_dm_device_unregister) to register 
> my rt device.
> *  can call Linux omap dm_timer routines to reserve general purpose timers,
>        so that Linux will not give my timers to others. (these routines 
> call Linux locks)
> 
> My driver's open_nrt close_nrt entry points... (open_rt & close_rt are 
> deprecated)
> *  are executed in the caller's Linux user context, if the caller is a 
> standard Linux
>        user process.
> *  are executed in the caller's Xenomai user context (secondary mode), 
> if the caller
>        is a rt user process.
> *  can use Linux spin locks and events instead of rt_locks and events, 
> if I know
>        that protection is not needed from rt tasks and interrupt handlers.
> *  should use rt locks and events, if protection is needed from rt tasks 
> and
>        interrupt handlers.
> 
> My driver's ioctl_rt, read_rt, and write_rt entry points...
> *  are executed in the caller's Xenomai user context (primary mode), if 
> the caller
>        is a rt user process running in primary mode.
> *  are executed in the caller's Xenomai user context (secondary mode), 
> if the caller
>        is a rt user process running in secondary mode.
> *  must use rt locks and events.
> 
> My driver's ioctl_nrt, read_nrt, and write_nrt entry points...
> *  are executed in the caller's Linux user context, if the caller is a 
> standard
>        Linux user process.
> *  I should use rt locks and events, for protection from rt tasks and
>        interrupt handlers.
> 
> My driver's rt interrupt handler entry points...
> *  are executed in the Xenomai interrupt context.
> *  must use rt locks and events.
> 
> Is the above correct?

Hi,

Yes, this is correct. Note however, that if you need to lock something
in the init_module or an nrt callback, and you use a linux lock, you
will not be able to use this lock from rt context, so, the only way to
solve this will be to use an rtdm lock.

> 
> The OMAP3 chip has a collection of hardware timers that must be shared 
> between the Linux and Xenomai environments. I want to allocate/reserve 5 
> timers for my use in the real time environment for the creation of pulse 
> width modulation output signals, but the rest of the timers should be 
> available for general Linux use. Being able to call omap dm_timer 
> routines in the module_init and module_exit routines make this much easier.

Another remark: Xenomai uses, as, a system timer, a timer in one-shot
mode (same as Linux so-called "high resolution timers"), so, if you
program several periodic software timers, Xenomai timer subsystem will
arrange for your timer callbacks to be called at the right time, so it
looks like you will not gain much by using several hardware timers. If
you fear that Xenomai timing subsystem will not scale well with many
timers, you can enable the heap-based or wheel-based timer management.

Regards.

-- 
					    Gilles.

