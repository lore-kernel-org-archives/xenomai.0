Message-ID: <BLU166-W4A69C62ECABBCDFC603B5C4700@domain.hid>
From: Jan-Erik Lange <jan0385@domain.hid>
Date: Thu, 2 Feb 2012 09:51:52 +0100
In-Reply-To: <4EFC7AD7.2030202@domain.hid>
References: <BLU166-W4963DB0BDCBFDED1A1EF5CC4AD0@domain.hid>,
	<4EFC7AD7.2030202@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai-core] general questions
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org





> Date: Thu=2C 29 Dec 2011 15:36:07 +0100
> From: rpm@xenomai.org
> To: jan0385@domain.hid
> CC: xenomai@xenomai.org
> Subject: Re: [Xenomai-core] general questions
>=20
> On 12/29/2011 01:04 PM=2C Jan-Erik Lange wrote:
> > Hello=2C
> > I'm new in the topic about the Xenomai co-kernel approach and I have
> > some questions to the primary mode and secondary mode.
> >
> > I have trouble with the imagination of the fact in general=2C that one
> > task (process oder thread) can be processed by two kernels (Xenomai
> > nucleus and standard kernel)=2C and treated by the one in real time and=
 by
> > the other in non real-time.
> >
> > 1. So far I understood this approach=2C the primary and secondary mode =
is
> > an abstract description of the fact=2C that threads or processes can be
> > scheduled by the Xenomai nucleus or by the standard Linux kernel
> > scheduler. Is this correct?
>=20
> Yes. A Xenomai thread in user-space is attached a "shadow" control area=20
> in addition to the regular linux context data=2C which enables both linux=
=20
> and the nucleus to schedule it in a mutually exclusive manner.
>=20
> >
> > 2. Now supose=2C that I have chosen the VxWork-skin and I started a tas=
k
> > in the primary mode. Is it correct that when this task is calling a non
> > VxWork-API-funtion=2C there will a change of the context from primary t=
o
> > the secondary mode? Or what is the exact condition of the switching of
> > the context?
> >
>=20
> - invoking a regular linux syscall
> - receiving a linux signal (e.g. kill(2) and GDB)
> - causing a CPU trap (e.g. invalid memory access)=2C hitting a breakpoint=
=20
> (e.g. GDB)
>=20
> all these situations cause the switch from primary to secondary mode. We=
=20
> say that such thread "relaxes" in Xenomai parlance.
>=20
> A common caveat is to call a glibc routine=2C which eventually issues a=20
> linux syscall under the hood. Think of malloc() detecting a process=20
> memory shortage=2C which then calls mmap or sbrk to extend the process=20
> data. Or=2C running into a mutex contention once in a while=2C forcing th=
e=20
> calling thread to issue a syscall for sleeping on the mutex.=20
> Fortunately=2C we have a tool to detect these situations.
=20
=20
=20
=20
What is the name of the tool to detect these migrations? I thought there is=
 only the possibility to react on this SIGXCPU signal with a signal handler=
.
=20
=20

>=20
> > It would be very nice=2C if you could tell me a little bit about these
> > questions?
> >
> > Best regards
> > Jan
> >
> >
> >
> > _______________________________________________
> > Xenomai-core mailing list
> > Xenomai-core@domain.hid
> > https://mail.gna.org/listinfo/xenomai-core
>=20
>=20
> --=20
> Philippe. 		 	   		  =

