Message-ID: <5016B61F.5050702@xenomai.org>
Date: Mon, 30 Jul 2012 18:28:15 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <6B3AC2788014DD49B43AF9611365BBAA21B0B94DE9@mary.at.omicron.at>	<5009902B.7070705@xenomai.org>	<6B3AC2788014DD49B43AF9611365BBAA21B0B954F3@mary.at.omicron.at>	<500D298C.6080601@xenomai.org>	<6B3AC2788014DD49B43AF9611365BBAA21B0B9550A@mary.at.omicron.at>	<6B3AC2788014DD49B43AF9611365BBAA21B0B95718@mary.at.omicron.at>
	<500E4603.2000002@xenomai.org> <5011A6ED.2080303@xenomai.org>
	<6B3AC2788014DD49B43AF9611365BBAA21B0C0D253@mary.at.omicron.at>
In-Reply-To: <6B3AC2788014DD49B43AF9611365BBAA21B0C0D253@mary.at.omicron.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xenomai 2.6.1 on ixp4xx hangs on boot
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Lausch <michael.lausch@omicron.at>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/30/2012 06:03 PM, Michael Lausch wrote:
> Sorry for the delay, but holiday season takes its toll (needed to cover a 2nd project as well). 
> I've successfully booted a kernel with userspace tsc emulation enabled.
> The output from the "tsc" testprogram looks like:
> 	
> 	min: 12, max: 21, avg: 12
> 	min: 12, max: 21, avg: 12
> 	min: 12, max: 18, avg: 12
> 	min: 12, max: 21, avg: 12
> 	min: 12, max: 21, avg: 12
> 	min: 12, max: 21, avg: 12
> 	......
> 	Min: 12, max: 26, avg: 12 ->0.180002 us
> 
> Does this look correct to you?

Yes, it means that there were no problems when the counter wrapped (if
you ran the tsc program with the "-w" argument). A 180ns latency does
not look bad.

> 
> I have one question though:
> What is the meaning of the min_delay_tick element of the ipipe_timer struct? i just
> Used a random value here. 

It is not related with the tsc. It is the ipipe_timer implementation,
and it is normally already set. For ixp4xx, there is normally:

#ifdef CONFIG_IPIPE
static struct ipipe_timer ixp4xx_itimer = {
        .irq = IRQ_IXP4XX_TIMER1,
        .min_delay_ticks = 333, /* 5 usec with the 66.66 MHz system clock */
};
#endif /* CONFIG_IPIPE */

min_delay_ticks is explained here:
http://www.xenomai.org/index.php/I-pipe-core:ArmPorting#The_general_case

It is the delay below which the timer can not be programmed successfully
(this happens for timers based on free-running counters and match
registers, but also as a documented limitation of some other hardware
timers).

> 
> If the result of the test program looks good to you, i'm going to clean up the patch and i can post it against a 
> xenomai 2.6.1 patched 3.2.23 vanilla linux kernel.

Please stay with 3.2.21, as the update to 3.2.23 may bring new conflicts.

-- 
					    Gilles.

