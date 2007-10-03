Message-Id: <200710030658.l936wbwS020794@domain.hid>
From: "Patrick" <kpa_info@domain.hid>
Date: Wed, 3 Oct 2007 08:58:40 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2ff1a98a0710020529y44e79653id63ad9cf0419ceb9@domain.hid>
Subject: Re: [Xenomai-help] rt_task crash kernel
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org


No I have not a JTAG probe.

But I found that the system crashes when the xnlock_put_irqrestore =
function
is called in the task.c file at (in rt_task_create function).

Thanks

-----Message d'origine-----
De=A0: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org
Envoy=E9=A0: mardi, 2. octobre 2007 14:29
=C0=A0: Patrick
Objet=A0: Re: [Xenomai-help] rt_task crash kernel

On 10/2/07, Patrick <kpa_info@domain.hid> wrote:
> > -----Message d'origine-----
> > De: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
> > Envoy=E9: mardi, 2. octobre 2007 11:46
> > =C0: Patrick
> > Cc: xenomai-core
> > Objet: Re: [Xenomai-help] rt_task crash kernel
> >
> > On 10/2/07, Patrick <kpa_info@domain.hid> wrote:
> > >
> > >
> > >
> > >
> > > Yes, I have tried with bin/latency user space application and the
system
> > > crashes.
> >
> > latency appears to crash on ARM when launched with the default 100us
> > period, the system is just too busy. Do you observe the crash with a =
1
> > ms period ?
>
> Yes, I have tried with latency -p 1000 and the issues is the same.

Ok, so I-pipe for PXA has a problem. Next question: do you have a JTAG =
probe
?

--=20
                                               Gilles Chanteperdrix


