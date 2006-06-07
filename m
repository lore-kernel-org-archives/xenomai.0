Message-ID: <4486F497.8060201@domain.hid>
Date: Wed, 07 Jun 2006 17:45:27 +0200
From: Marco Cavallini <rtai@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Porting xenomai to AT91RM9200
References: <OF63DA82CD.5D290237-ONC1257186.00524ADB-C1257186.0054CC4F@wavecom.fr>
In-Reply-To: <OF63DA82CD.5D290237-ONC1257186.00524ADB-C1257186.0054CC4F@wavecom.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Reply-To: rtai@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Yann.LEPROVOST@wavecom.fr
Cc: xenomai@xenomai.org

Yann.LEPROVOST@wavecom.fr ha scritto:
> Hi marco,
> 
> There is an issue with porting adeos to AT91RM9200. As i understood, adeos
> handles system timer interrupt directly to keep real time "tsc" up to date.
> To do that, porting xenomai to AT91RM9200 means coding the correct tsc
> handling functions in arch/arm/mach-at91rm9200/time.c (in the same way as
> integrator board).
> That's what i tried to do...
> 
> But on AT91RM9200, the system interrupt timer line is shared among other
> system peripherals such as watchdog, serial debug unit, memory controller,
> ...
> I try to demux the interrupt sharing by modifying code of adeos irq
> handling but there are specificities with the interrupt controller I can't
> deal with...
> I have lots of difficulties to understand the overall architecture of the
> adeos/xenomai source code...
> 
> At this time, I have an adeos/xenomai patched kernel which freezes when
> launching the idle process... and I 'm a bit lost !?!

Could I please try testing your patch here ?

TIA
-- 
Marco Cavallini
Koan s.a.s. - Bergamo - ITALIA
Embedded and Real-Time Software Engineering
www.KoanSoftware.com   |    www.KaeilOS.com

