Date: Tue, 15 May 2012 16:34:14 +0200 (CEST)
From: aubin.rebillat@domain.hid
Message-ID: <2032488254.158228581.1337092454641.JavaMail.root@domain.hid>
In-Reply-To: <4FB154F9.3030807@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai on the TS-7553 ARM SBC
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

> To summarize, there are two states in the system:
> 
> Either Linux is handling the timer, in which case:
> - ipipe_mach_timerstolen == 0
> - ipipe_mach_acktimer is called to acknowledge the linux timer
> interrupt
> - linux timer interrupt routine is called for each timer interrupt,
> HZ
> times a second, and in charge to reprogram the timer hardware if it
> needs to be reprogrammed
> 
> Either xenomai is handling the timer, in which case:
> - ipipe_mach_timerstolen == 1
> - ipipe_mach_acktimer is called to acknowledge the xenomai timer
> interrupt
> - ipipe_mach_set_dec is called by xenomai to program the next timer
> interrupt
> 
> linux timer interrupt is called HZ times a second, but should not
> touch
> anything related to the timer hardware, because that part is handled
> by
> xenomai now (vie ipipe_mach_set_dec).
> 
> if CONFIG_IPIPE is enabled and CONFIG_XENOMI is disabled, only the
> first
> state happens.
> 
> if CONFIG_XENOMAI is enabled, as soon as xenomai is started, we enter
> the second state.
> 

Ok this is pretty much what I understood but my problem was that 
ipipe_mach_set_dec was never called once the skin services were started. 

I really didn't see how my code could influence this so I checked the 
bug fixes for Xenomai 2.5 and i found one which was not fixed in my 
version of xenomai. The bug was the return value of rthal_timer_request.

I applied the fix and Xenomai is now booting fine on my TS-7553.

I will now perform tests on it to insure the stability of the system and 
the latency.

Thank you very much for your help,

Best regards,

-- 
Aubin REBILLAT

