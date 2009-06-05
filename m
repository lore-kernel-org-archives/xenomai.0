Message-ID: <4A29332C.6080204@domain.hid>
Date: Fri, 05 Jun 2009 17:01:00 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4A28F029020000F80002DB14@domain.hid>	<4A28FAD4020000F80002DB27@domain.hid>
	<4A28FAD7.3E52.00F8.0@domain.hid><4A28FAD7.3E52.00F8.0@domain.hid>
	<4A28E5E0.9020805@domain.hid>
	<4A2907EF.3E52.00F8.0@domain.hid><4A2907EF.3E52.00F8.0@domain.hid>
	<4A2920C7.40200@domain.hid>
	<4A294359.3E52.00F8.0@domain.hid><4A294359.3E52.00F8.0@domain.hid>
	<4A29290E.7050609@domain.hid> <4A294CAB.3E52.00F8.0@domain.hid>
In-Reply-To: <4A294CAB.3E52.00F8.0@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] IRQ-Latency when in idle State on ARM
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Karl Tyss <tyss.k@domain.hid>
Cc: xenomai@xenomai.org

Karl Tyss wrote:
> Disabling the I- or D-cache is available as an option by using
> menuconfig under system-type.

Ok. I misread the configuration file. Also note that the idle function
for arm926 core only disables the I-cache if it was not already
disabled. So, if you are running with I-cache disabled, fiddling with
this code should not change anything.

> 
> As to the Jitters - I didn't describe it correctly what i was doing. I
> disabled the both caches as a trick to test if there is a difference.
> The 2 us timing difference was without the caches. With I- and D-cache
> online i had a difference of 13 us as average value (15us idle and 3 us
> with user space load)

13us or 15us is still ridiculous on ARM. 3us even more. Average values
are irrelevant, what matters is the worst case. If you only get a 3us
difference when loading the system, then you are not loading the system
enough. You should see latencies above 100us when properly loading the
system. As I already told you, the way to proper load the system is to
run LTP.

> I have to estimate a critical path in order to decide if a timer
> interrupt driven periodic task or a xenomai periodic task is better for
> my system. As I noticed this effect of the idle task I had to know why
> in order to document it or to change the part of the code.

Xenomai latency test is made for that. Run latency -t 2 to measure the
timer interrupt latency, use latency -t 1 to use a Xenomai kernel-space
periodic task, or latency -t 2 to use a Xenomai user-space periodic
task. And I repeat, the only meaningful result of these tests is the
worst case latency, and only when properly loading the system, and when
running this test for a long time (one or two full runs of LTP).

> 
> Well, now I know what to do and I have to find out if disabling the
> I-cache is critical at this point and if so, how one can avoid it. My
> system doesn't have  to save power if its online and I suppose that
> disabling this kind of idleness could be a nice feature in the kernel or
> xenomai.

Disabling the cache is not recommended.

-- 
					    Gilles.

