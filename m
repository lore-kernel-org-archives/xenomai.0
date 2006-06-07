In-Reply-To: <4486D39F.4020607@domain.hid>
Subject: Re: [Xenomai-core] Porting xenomai to AT91RM9200
Message-ID: <OF63DA82CD.5D290237-ONC1257186.00524ADB-C1257186.0054CC4F@wavecom.fr>
From: Yann.LEPROVOST@wavecom.fr
Date: Wed, 7 Jun 2006 17:20:03 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
Content-Transfer-Encoding: quoted-printable
To: rtai@domain.hid
Cc: xenomai@xenomai.org, xenomai-core-bounces@domain.hid

Hi marco,

There is an issue with porting adeos to AT91RM9200. As i understood, adeos
handles system timer interrupt directly to keep real time "tsc" up to date.
To do that, porting xenomai to AT91RM9200 means coding the correct tsc
handling functions in arch/arm/mach-at91rm9200/time.c (in the same way as
integrator board).
That's what i tried to do...

But on AT91RM9200, the system interrupt timer line is shared among other
system peripherals such as watchdog, serial debug unit, memory controller,
...
I try to demux the interrupt sharing by modifying code of adeos irq
handling but there are specificities with the interrupt controller I can't
deal with...
I have lots of difficulties to understand the overall architecture of the
adeos/xenomai source code...

At this time, I have an adeos/xenomai patched kernel which freezes when
launching the idle process... and I 'm a bit lost !?!
Probably something wrong with the interrupt timer handling...
I'd like to continue to work on xenomai port to AT91RM9200 but I need
support from people with good knowledge of adeos internals... or a good
documentation starting point on adeos internal.

I currently stopped working on xenomai/adeos to study ingo molnar
patches...

Regards

Yann

xenomai-core-bounces@domain.hid a =E9crit sur 07/06/2006 15:24:47 :

> Yann.LEPROVOST@wavecom.fr ha scritto:
> > Hi all,
> >
> > I try to port xenomai/adeos to CSB637 Cogent Board featuring an
AT91RM9200
> > cpu.
> > My work is based on the integrator and the recent freescale port of
adeos
> > 2.6.14 patch.
>
> Hi Yann,
> Any news about such port ?
>
> Ciao
>
> /marco
>
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


