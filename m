Message-ID: <2ff1a98a0710050130j7e0db84dq838aab0417c8bd3f@domain.hid>
Date: Fri, 5 Oct 2007 10:30:22 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <4705ED3B.4070600@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4705ED3B.4070600@domain.hid>
Subject: Re: [Xenomai-help] awful latencies (~110us)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: CHABAL David <david.chabal@domain.hid>
Cc: xenomai@xenomai.org

On 10/5/07, CHABAL David <david.chabal@domain.hid> wrote:
> Hello all,
>
> My box is a Pentium III 733 Mhz/256Mo with Linux 2.6.20 and Xenomai 2.3.3.
>
> When I run the latency test included in the testsuite, I get some
> horrible results like:
>
> RTT|  00:01:04  (periodic user-mode task, 100 us period, priority 99)
> RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat
> worst
> RTD|       4.640|      12.243|      80.454|       0|       3.716|
> 110.990
> RTD|       8.652|      13.133|      86.014|       0|       3.716|     ...
> RTD|       4.050|      13.324|      89.186|       0|       3.716|
> 110.990
> ---|------------|------------|------------|--------|-------------------------
> RTS|       3.716|      11.499|     110.990|       0|    00:01:22/00:01:22
>
> I expect about 30us.
>
> I have tried many kernel configurations without significant results
> (always about 120us).
>
> - BIOS USB Legacy is disabled.
> - idle=pool is added to the boot line.
It is idle=poll, not idle=pool

> - linux kernel is minimalist

You should enable ACPI except the ACPI "processor" module.

> - Ipipe/xenomai debug features have a minor impact
> - sometimes, the latency is negative.
>
> I have noticed a better latency (max: ~31us) with the network disabled
> (ifdown eth0), and a deterioration immediatly after typing ifup (~120us,
> like above).  (Usually, I connect this box through Exceed. I have other
> PC with Xenomai and it is without consequence on their latency tests).

I do not know what is Exceed, but if you are running an X-server, you
may try the noaccel option, as explained in the TROUBLESHOOTING guide.

-- 
                                               Gilles Chanteperdrix

