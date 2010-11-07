Message-ID: <4CD6DE9F.7000100@domain.hid>
Date: Sun, 07 Nov 2010 18:15:11 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTinQotwe=EwATsmdKnanN-ZwT8c+CobzBRDqptEj@domain.hid>	<4CCB4573.30607@domain.hid>
	<4CD68353.6030600@domain.hid>
	<AANLkTinfxNrqc0VZh=RAzpFzPBPVhPmzDC1zviDdwr=0@domain.hid>
In-Reply-To: <AANLkTinfxNrqc0VZh=RAzpFzPBPVhPmzDC1zviDdwr=0@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] High resolution timers disabled on AT91SAM9G20
 board after patching
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: at91_enthus <nwromania@domain.hid>
Cc: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai@xenomai.org

at91_enthus wrote:
> Yes, it solved the issue.
> 
> There is  one thing that bothers me, though. When I run  "xeno-test", the
> average and minimal  latencies are constant all the time.
> 
> The unpatched version of the xeno kernel seems more consistent when it comes
> to minimum, maximum and average latencies.
> 
> I attached a couple of snippets of  xeno-test outputs .

Do not trust xeno-test too much. Are you sure the only difference
between the two runs is the patch, for instance, have you not played
with the CONFIG_ARM_FCSE option? Also, good benchmarks are done with
running a separate load, and not with xeno-test, in fact.

Also, using the high-res timers configuration has a high overhead on
such low-end configurations as AT91s, so has CONFIG_PREEMPT. So, if you
are looking for a configuration with the lowest overhead possible, I
would recommend disabling CONFIG_HIGH_RES_TIMERS and using
CONFIG_PREEMPT_NONE or CONFIG_PREEMPT_VOLUNTARY, and relying on Xenomai
for the low latency and high resolution timer features. (You can measure
the overhead of kernel options with the hackbench test for instance).

On the AT91 I have (AT91SAM9263), the minimum and average latencies
oscillate much less than for your unpatched kernel, either with or
without the patch so I wonder if you would not have another issue. Do
you have FCSE enabled?

To give you an idea of the figures here, with FCSE enabled, the minimal
latency is around 15us and the average latency around 50us. And they
vary in a 5us range, they do not make big jumps.


-- 
                                                                Gilles.

