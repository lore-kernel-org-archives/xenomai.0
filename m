From: GUGLIELMO NAVARRA <guglielmo.navarra@studenti.uniparthenope.it>
Date: Sat, 15 Dec 2012 14:42:31 +0000
Message-ID: <7385E066AECB78449EEDFA7EE2A2B2B60A052DCB@DB3PRD0410MB355.eurprd04.prod.outlook.com>
References: <7385E066AECB78449EEDFA7EE2A2B2B60A052D7D@DB3PRD0410MB355.eurprd04.prod.outlook.com>,
	<50CC6B1E.8070102@xenomai.org>
	<7385E066AECB78449EEDFA7EE2A2B2B60A052DA8@DB3PRD0410MB355.eurprd04.prod.outlook.com>
	<50CC819F.7010009@xenomai.org>,<50CC83E8.1070408@xenomai.org>
In-Reply-To: <50CC83E8.1070408@xenomai.org>
Content-Language: it-IT
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] [Xenomai-help] Latency calculation on da850 (Omap
 L138)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Reply for FCSE: Omap L138 is based on ARM926ejs (FCSE supported)
Reply for tsc_info hardcode:=20
The DAVINCI_TIMER0_BASE macro represents the physical address of the timer =
0 (corrected), which is 64bit timer that i use (unchained mode) 32bit for c=
lockevent (BOTTOM) and 32bit for clocksource (TOP) .=20
Instead "t->base" represents the virtual address obtained from ioremap.
I made the changes that you asked me (GPIO and verify physical address), th=
e result obtained is that the latency is not more negative but still very h=
igh.
Question : If the address in the tsc_info struct were incorrect, there woul=
d be a hang?

I noticed that if I read tracer with cat /proc/ipipe/trace/max, I find !
:|   #func                   2! 8895.678  __ipipe_restore_root_nosync+0x10 =
(__ipipe_preempt_schedule_irq+0x84)



root@Board ~>./usr/xenomai/bin/latency -t 0
=3D=3D Sampling period: 1000 us
=3D=3D Test mode: periodic user-mode task
=3D=3D All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 1000 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat w=
orst
RTD| 370370.370|-636832.807|-137332.808|       0|     0| 370370.370|-137332=
.808
RTD| 370370.370|-1636832.807|-1137332.807|       0|     0| 370370.370|-1373=
32.80
8
RTD| 370370.370|1658134.490|-2137332.806|       0|     0| 370370.370|-13733=
2.808
RTD| 370370.370| 658134.490|1157634.490|       0|     0| 370370.370|-137332=
.808
RTD| 370370.370|-341865.509| 157634.491|       0|     0| 370370.370|-137332=
.808
RTD| 370370.370|-1341865.508|-842365.509|       0|     0| 370370.370|-13733=
2.808
RTD| 370370.370|1953101.788|-1842365.508|       0|     0| 370370.370|-13733=
2.808
RTD| 370370.370| 953101.789|1452601.789|       0|     0| 370370.370|-137332=
.808
RTD| 370370.370| -46898.211| 452601.789|       0|     0| 370370.370|-137332=
.808
RTD| 370370.370|-1046898.210|-547398.210|       0|     0| 370370.370|-13733=
2.808
RTD| 370370.370|-2046898.209|-1547398.210|       0|     0| 370370.370|-1373=
32.80
8
RTD| 370370.370|1248069.087|1747569.087|       0|     0| 370370.370|-137332=
.808
RTD| 370370.370| 248069.088| 747569.088|       0|     0| 370370.370|-137332=
.808
RTD| 370370.370|-751930.912|-252430.912|       0|     0| 370370.370|-137332=
.808
RTD| 370370.370|-1751930.911|-1252430.911|       0|     0| 370370.370|-1373=
32.80
8
RTD| 370370.370|1543036.386|2042536.385|       0|     0| 370370.370|-137332=
.808
RTD| 370370.370| 543036.386|1042536.386|       0|     0| 370370.370|-137332=
.808
RTD| 370370.370|-456963.613|  42536.387|       0|     0| 370370.370|-137332=
.808
RTD| 370370.370|-1456963.613|-957463.613|       0|     0| 370370.370|-13733=
2.808
RTD| 370370.370|1838003.684|-1957463.612|       0|     0| 370370.370|-13733=
2.808
?---|-----------|-----------|-----------|--------|------|------------------=
-----
--
RTS| 370370.370|-1546898.210|-137332.808|       0|     0|    00:00:21/00:00=
:21
root@Board ~>


Idea?


________________________________________
Da: Gilles Chanteperdrix [gilles.chanteperdrix@xenomai.org]
Inviato: sabato 15 dicembre 2012 15.06
A: guglielmo.navarra@studenti.uniparthenope.it
Cc: Xenomai
Oggetto: Re: [Xenomai] [Xenomai-help] Latency calculation on da850 (Omap L1=
38)

On 12/15/2012 02:56 PM, Gilles Chanteperdrix wrote:

> On 12/15/2012 02:31 PM, GUGLIELMO NAVARRA wrote:
>
>> Thanks for your reply,
>> my tsc_info definition is:
>>
>> /*------------------------------------------------
>>   Timer che utilizza IPIPE
>>  -------------------------------------------------*/
>> #ifdef CONFIG_IPIPE
>> static struct __ipipe_tscinfo tsc_info =3D {
>>         .type =3D IPIPE_TSC_TYPE_FREERUNNING,
>>        .u =3D {
>>                 {
>>                         .mask =3D 0xffffffff,
>>                 },
>>         },
>> };
>>
>> static void l138_xenomai_tsc_init(void)
>> {
>>    struct timer_s *t =3D &timers[TID_CLOCKSOURCE];
>>
>>    tsc_info.type =3D IPIPE_TSC_TYPE_FREERUNNING;
>>    tsc_info.freq =3D l138_clock_tick_rate;
>
>>    tsc_info.counter_vaddr =3D (unsigned long)(t->base + t->tim_off);
>
>>    tsc_info.u.counter_paddr =3D DAVINCI_TIMER0_BASE + TIM12;
>
>
> What about t->tim_off ?


Also, if t->base can be something else than the result of an
ioremap(DAVINCI_TIMER0_BASE), then you should not hardcode
DAVINCI_TIMER0_BASE, as other boards may pass a different value, rather,
you should add a phys_base to "struct timer_s", and set it correctly for
each possible physical address.

--
                                                                Gilles.=


