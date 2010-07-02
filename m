Message-ID: <4C2DD007.4090300@domain.hid>
Date: Fri, 02 Jul 2010 13:39:51 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1278061090.2358.33.camel@domain.hid>	
	<4C2DAF63.4040708@domain.hid>
	<1278066286.8669.9.camel@domain.hid>	
	<4C2DC68C.1040306@domain.hid>
	<1278069874.8669.25.camel@domain.hid>
In-Reply-To: <1278069874.8669.25.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] Adeos I-PIPE NS9215 port problem
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Iker Amescua <iamescua@domain.hid>
Cc: adeos-main@gna.org

Iker Amescua wrote:
> 
> Changing to handle_ir_level make the system boot a bit further, but
> still locks.
> 
> In the ns921x_timer_init function there is a  call to to
> clocksource_register(&ns921x_clocksource) and it is configured (timer 0)
> in enabled mode REGSET(tc, SYS_TCx, TE, EN), up counter, 32 bits
> autoreload, so I think this is the clocksource. I attach full
> time-ns921x.c (I hope I haven't missed anything).

Yes, you register the clocksource and clockevents, but that does not
make the Linux kernel use them. If it has other clocksources, it may
decide to use them. Or maybe the clockevents support is not even
compiled because the GENERIC_CLOCKEVENTS and GENERIC_CLOCKSOURCE are not
in your kernel configuration.

Anyway, you should do things step by step:
- run the I-pipe patch alone, without Xenomai
- try and get the kernel booting, find where it is stuck, (I would say
probably somewhere in the handling of interrupts, if that is the case,
you need to check some doc about how your interrupt controller works,
how the EOI works, etc...)
- when it boots, try cat /proc/timer_list and see what is the status of
clockevents/clocksource, try to get it to use the clocksource and
clockevents you implemented.
- enable Xenomai.

-- 
					    Gilles.

