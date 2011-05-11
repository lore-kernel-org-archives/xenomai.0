Message-ID: <4DCA69F0.9040104@domain.hid>
Date: Wed, 11 May 2011 12:50:24 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4DC2962B.9060802@domain.hid> <4DC299F2.40700@domain.hid>
	<4DC2A315.8030707@domain.hid> <4DC2ADE1.9000301@domain.hid>
	<4DC2B06B.9020303@domain.hid> <4DC2B75C.8030503@domain.hid>
	<4DC2C10C.9080102@domain.hid> <4DC2C411.60109@domain.hid>
	<4DC2D0C9.3020605@domain.hid> <4DC2DDC6.8090909@domain.hid>
	<4DC3BF3C.2030405@domain.hid> <4DC3C076.7010203@domain.hid>
	<4DCA6525.6010401@domain.hid>
In-Reply-To: <4DCA6525.6010401@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] mini2440: ipipe kernel stuck in idle loop after
 xenomai init
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Alexey Galakhov <agalakhov@domain.hid>
Cc: adeos-main@gna.org

On 05/11/2011 12:29 PM, Alexey Galakhov wrote:
> On 05/06/2011 03:33 PM, Gilles Chanteperdrix wrote:
>> Ok, so there is a timer interrupt which does not result in reprogramming
>> the timer, all you need to find out is why... Could you print the tsc
>> value for each of these printks?
>> Also, have you tried putting the call to the tsc update function in the
>> acktimer function?
> I did some more investigations and found what actually happens. The call
> to xntimer_next_local_shot does not result in a call to
> rthal_timer_program_shot due to "if (h == NULL)" condition. Does it mean
> empty queue?
> 
> Xenomai: real-time nucleus v2.5.6 (Wormhole Wizards) loaded.
> rthal_timer_request[non-generic]
> go
> rthal_irq_request 30
> ipipe_virtualize_irq 30 c0066bcc
> rthal_timer_set_oneshot 1
> _mach_set_dec 42187 3035818
> _tsc_update
> xenomai- steal_timer 1
> xntimer_next_local_shot
> xnarch_program_timer_shot 0
> rthal_timer_program_shot 0
> xntimer_tick_aperiodic
> xntimer_next_local_shot
> - return xntimerq_it_begin == NULL
> Xenomai: starting native API services.
> Xenomai: starting POSIX services.
> Xenomai: starting RTDM services.
> _mach_acktimer 0
> xntimer_tick_aperiodic
> xntimer_next_local_shot
> - return xntimerq_it_begin == NULL
> msgmni has been set to 119
> Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
> io scheduler noop registered (default)

I was going to check this real soon (tonight probably). At this point
the only timer which should be in the list is the host timer. From
memory, the host timer is or was installed in ksrc/nucleus/timer.c or
ksrc/nucleus/pod.c depending on the return value of rthal_timer_request.
rthal_timer_request implementation depends on CONFIG_GENERIC_CLOCKEVENTS.

So, since we have not checked for some time the code in the case where
this option is disabled, rthal_timer_request return value is probably
now interpreted as meaning that we do not need a host timer, whereas we
need one.

This is my hypothesis at least, but I need to check exactly what happens.

-- 
                                                                Gilles.

