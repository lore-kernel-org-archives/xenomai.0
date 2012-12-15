From: GUGLIELMO NAVARRA <guglielmo.navarra@studenti.uniparthenope.it>
Date: Sat, 15 Dec 2012 15:56:47 +0000
Message-ID: <7385E066AECB78449EEDFA7EE2A2B2B60A052E25@DB3PRD0410MB355.eurprd04.prod.outlook.com>
References: <7385E066AECB78449EEDFA7EE2A2B2B60A052E16@DB3PRD0410MB355.eurprd04.prod.outlook.com>
In-Reply-To: <7385E066AECB78449EEDFA7EE2A2B2B60A052E16@DB3PRD0410MB355.eurprd04.prod.outlook.com>
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

>GUGLIELMO NAVARRA [guglielmo.navarra@studenti.uniparthenope.it]
>Inviato: sabato 15 dicembre 2012 16.47
>A: xenomai@xenomai.org
>Oggetto: Re: [Xenomai] [Xenomai-help] Latency calculation on da850 (Omap L=
138)

>Da: Gilles Chanteperdrix [gilles.chanteperdrix@xenomai.org]
>Inviato: sabato 15 dicembre 2012 15.54
> Anyway, I also asked you to run the "tsc" test, what does this test tell
> you?

>In the structure tsc_info must assign addresses (phy and virt) of timer as=
signed to clocksource or clockevent?
>I have assigned the offset of timer assigned to clockevent (base address i=
s the same because the timer is 64-bit)


>static void l138_xenomai_tsc_init(void)
>{
>struct davinci_soc_info *soc_info =3D &davinci_soc_info;
>struct davinci_timer_instance *dtip =3D soc_info->timer_info->timers;
>void __iomem *base;
>base =3D ioremap(dtip[0].base, SZ_4K);
>tsc_info.type =3D IPIPE_TSC_TYPE_FREERUNNING;
>tsc_info.freq =3D l138_clock_tick_rate;
>tsc_info.counter_vaddr =3D (unsigned long)(base + TIM12);
>tsc_info.u.counter_paddr =3D dtip[0].base + TIM12;
>tsc_info.u.fr.mask =3D 0xffffffff;
>__ipipe_tsc_register(&tsc_info);
>}


The changes above I changed the offset from TIM12 to TIM34 (clocksource) an=
d when run latency shows good results:

root@Board ~>./usr/xenomai/bin/latency -t 0
=3D=3D Sampling period: 1000 us
=3D=3D Test mode: periodic user-mode task
=3D=3D All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 1000 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat w=
orst
RTD|     89.407|    102.592|    163.481|       0|     0|     89.407|    163=
.481
RTD|     91.518|    103.296|    161.370|       0|     0|     89.407|    163=
.481
RTD|     91.296|    103.185|    173.814|       0|     0|     89.407|    173=
.814
RTD|     88.962|    103.037|    165.555|       0|     0|     88.962|    173=
.814
RTD|     91.259|    102.370|    163.444|       0|     0|     88.962|    173=
.814
RTD|     91.962|    103.111|    162.555|       0|     0|     88.962|    173=
.814
RTD|     91.592|    103.148|    174.518|       0|     0|     88.962|    174=
.518
RTD|     91.370|    103.037|    173.444|       0|     0|     88.962|    174=
.518
RTD|     92.148|    102.629|    161.777|       0|     0|     88.962|    174=
.518
RTD|     92.851|    103.296|    167.370|       0|     0|     88.962|    174=
.518
RTD|     91.888|    103.148|    173.777|       0|     0|     88.962|    174=
.518
RTD|     91.629|    103.370|    176.629|       0|     0|     88.962|    176=
.629
RTD|     92.037|    102.814|    164.777|       0|     0|     88.962|    176=
.629
RTD|     92.518|    102.592|    160.851|       0|     0|     88.962|    176=
.629
RTD|     91.481|    103.148|    165.962|       0|     0|     88.962|    176=
.629
RTD|     91.037|    102.851|    161.740|       0|     0|     88.962|    176=
.629
RTD|     91.444|    102.666|    164.333|       0|     0|     88.962|    176=
.629
RTD|     91.407|    102.740|    164.037|       0|     0|     88.962|    176=
.629
RTD|     78.481|    102.962|    164.703|       0|     0|     78.481|    176=
.629
RTD|     92.481|    103.333|    163.481|       0|     0|     78.481|    176=
.629
RTD|     91.999|    102.814|    167.074|       0|     0|     78.481|    176=
.629
RTT|  00:00:22  (periodic user-mode task, 1000 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat w=
orst
RTD|     91.222|    103.074|    169.481|       0|     0|     78.481|    176=
.629
RTD|     91.518|    103.444|    164.037|       0|     0|     78.481|    176=
.629
RTD|     92.074|    103.296|    167.185|       0|     0|     78.481|    176=
.629
?---|-----------|-----------|-----------|--------|------|------------------=
-----
--
RTS|     78.481|    102.962|    176.629|       0|     0|    00:00:24/00:00:=
24
root@Board ~>


Thank you for your advice Gilles.=20
Now I will test hard with a load.=


