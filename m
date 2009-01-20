Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Jan 2009 07:34:44 -0700
Message-ID: <51CAD0CE1504444DBE77CBBE51A0135D533FB0@domain.hid>
In-Reply-To: <49757B25.8020500@domain.hid>
References: <51CAD0CE1504444DBE77CBBE51A0135D533F9A@slcmail.slc.mew.int>
	<49757B25.8020500@domain.hid>
From: "Steven Seeger" <sseeger@domain.hid>
Subject: Re: [Xenomai-help] fpu issue
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

I can do that. I have to be careful where I use printk, though. I
noticed my board freezes if I try to do a printk in
__xnpod_fault_init_fpu() so that makes it harder. I am not exactly sure
what to look for because I've never done any assembler with the 387. Any
pointers would be helpful!

Steven

> -----Original Message-----
> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
> Sent: Tuesday, January 20, 2009 12:20 AM
> To: Steven Seeger
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai-help] fpu issue
>=20
> Steven Seeger wrote:
> > Guys, the FPU issue I've been having with a Geode GX1 and an AMD
> Geode
> > LX800 still persists. It seems that we have always had this bug, and
> > it's timing related. I am pretty sure that the issue revolves around
> the
> > fact that xenomai doesn't initialize the FPU in a userspace created
> > thread until the FPU is actually used. I realize there is a
> performance
> > gain to be had here by not having to switch it every time, but to
> > confirm I would like to make a patch that initializes the FPU when a
> > thread is created. Can someone please point me in the right
> direction?
> >
> >
> >
> > Thanks,
> >
> > Steven
> >
> >
> >
> > PS - Sorry to Gilles for all the bother. J
>=20
> No problem, really, the only reason why I did not answer is that I was
> busy. But having this discussion on the list is better anyway.
>=20
> I suggest you use the code I sent you to dump the FPU state in various
> places. The first place to try is before the initialization of the two
> volatile double variables in the user-space real-time thread. At this
> point you should have a clean fpu state, if it is not the case, then
> you
> will have to start dumping the FPU state in kernel-space.
>=20
> --
> 					    Gilles.

> -----Original Message-----
> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
> Sent: Tuesday, January 20, 2009 12:20 AM
> To: Steven Seeger
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai-help] fpu issue
>=20
> Steven Seeger wrote:
> > Guys, the FPU issue I've been having with a Geode GX1 and an AMD
> Geode
> > LX800 still persists. It seems that we have always had this bug, and
> > it's timing related. I am pretty sure that the issue revolves around
> the
> > fact that xenomai doesn't initialize the FPU in a userspace created
> > thread until the FPU is actually used. I realize there is a
> performance
> > gain to be had here by not having to switch it every time, but to
> > confirm I would like to make a patch that initializes the FPU when a
> > thread is created. Can someone please point me in the right
> direction?
> >
> >
> >
> > Thanks,
> >
> > Steven
> >
> >
> >
> > PS - Sorry to Gilles for all the bother. J
>=20
> No problem, really, the only reason why I did not answer is that I was
> busy. But having this discussion on the list is better anyway.
>=20
> I suggest you use the code I sent you to dump the FPU state in various
> places. The first place to try is before the initialization of the two
> volatile double variables in the user-space real-time thread. At this
> point you should have a clean fpu state, if it is not the case, then
> you
> will have to start dumping the FPU state in kernel-space.
>=20
> --
> 					    Gilles.

