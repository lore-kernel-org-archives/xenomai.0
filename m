Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Jul 2008 10:44:13 +0200
Message-ID: <0B45E93C5FF65740AEAE690BF3848B7AD38309@domain.hid>
From: "Fillod Stephane" <stephane.fillod@domain.hid>
Subject: Re: [Xenomai-help] Generel problem with realtime-tops(like adeos)
	overlinux-kernel
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?iso-8859-1?Q?Schl=E4gl_=22Manfred_jun=2E?= <manfred.schlaegl@domain.hid>, xenomai@xenomai.org

Schl=E4gl "Manfred jun. wrote:
[...]
>works fine without adeos, but with adeos there may be a relative long=20
>interruption between validation and processing. The hardware may =
overrun and=20
>process_hardware_data is called without valid data...

You're right. But I hope everybody is already aware of this side effect
of adeos.

>I think it is possible that there could be many such (latent) problems
>in linux-kernel. For example USB which itself has =
realtime-requirements,
>or eventually mtd (lost data as cause of wrong flash-write/erase
>timings), ...

This is indeed the case with MTD, and some zealously "optimized" =
timeouts that are too short. The other time sensitive cases can =
generally be=20
addressed with bigger buffering or explicit adeos/ipipe irq locking: =
local_irq_disable() vs. local_irq_disable_hw(). Of course, the latter =
comes=20
at some RT latency expense.

Best Regards,
--=20
Stephane

