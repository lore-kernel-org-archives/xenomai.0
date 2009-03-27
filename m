MIME-version: 1.0
Content-disposition: inline
Content-type: text/plain; charset=iso-8859-1
From: Peter =?iso-8859-1?q?W=E4chtler?= <pwaechtler@domain.hid>
Date: Fri, 27 Mar 2009 16:17:42 +0100
References: <200903271538.10434.pwaechtler@domain.hid>
	<943F8CE6-B103-4ED5-99CA-29F84AD90593@domain.hid>
In-reply-to: <943F8CE6-B103-4ED5-99CA-29F84AD90593@domain.hid>
Content-transfer-encoding: quoted-printable
Message-id: <200903271617.42331.pwaechtler@domain.hid>
Subject: Re: [Xenomai-core] use case: possible to boot Posix subsystem in
 <50ms and then Linux?
Reply-To: pwaechtler@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Steven Seeger <steven.seeger@domain.hid>
Cc: xenomai@xenomai.org

Am Friday 27 March 2009 15:41:46 schrieb Steven Seeger:
> Peter,
>
> Please tell us more about your hardware platform. I know this is not
> possible on convention x86 boards with a PC compatible BIOS.
>

Well the hardware should not matter and the startup code should be finished=
 in=20
several milli seconds, of course.
Most probably are ARM. PPC or SH4 platforms used in automotive devices.

In the automation industry the boot time is not that important - therefore =
a=20
lot of PC compatible boards are used.

	Peter

>
> On Mar 27, 2009, at 10:38 AM, Peter W=E4chtler wrote:
> > Hi Xenomai developers,
> >
> > for automotive control units the boot time is essential. After power-
> > up the
> > first status message has to be sent in about 50ms. This is usually
> > achieved
> > by a RTOS with boot times far below.
> >
> > Is it possible to construct a system with Xenomai that boots the
> > POSIX (or
> > whatever) subsystem first and then start Linux. Or is there a
> > dependency that
> > the subsystem can't run until Linux is up?
> >


