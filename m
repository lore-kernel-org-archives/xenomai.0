Date: Mon, 14 May 2012 18:13:10 +0200 (CEST)
From: aubin.rebillat@domain.hid
Message-ID: <2037196635.155333961.1337011990782.JavaMail.root@domain.hid>
In-Reply-To: <4FABFE02.6080509@domain.hid>
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

Hi Gilles,

I've followed your advices and reimplemented the timer management. 
Now it's an up counter wrapping to 0 on overflow, it uses a match 
register to trigger the interrupt and it's never disabled.

I've also cleaned the code : suppressed linux specific calls, move 
update_tsc to linux handler, etc... as you advised me.

Then, I tested this with both CONFIG_IPIPE and CONFIG_XENOMAI 
disabled, and it's working fine.
I also tested with only CONFIG_XENOMAI disabled and it's still
working as expected.

Nevertheless, the issue is still the same. It hangs after starting
the init program. 

After investigations, the problem is that __ipipe__mach_set_dec is 
never called after Xenomai has taken control of the  timer. The last 
timer update was done in rthal_timer_calibrate and it effectively 
triggers an interrupt after MAXINT ticks (I've put a printk in the 
linux timer handler and it's displayed after a few time).

My problem is that i don't really understand the timer management by
Xenomai. As i understood each skin has its own timers and Xenomai
manages to trigger them when expected. But what code is managing the
linux timer ?
I'm expecting to probably have errors in my ipipe code that's why i'm
asking this, to follow the execution and see where it is broken.

Thank you very much,

-- 
Aubin REBILLAT

