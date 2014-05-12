Message-ID: <DUB121-W46C9486728000C328B0F9481350@phx.gbl>
From: mobin Motallebizadeh <mobin.seven@live.com>
Date: Mon, 12 May 2014 17:19:26 +0000
In-Reply-To: <536A1529.8070508@xenomai.org>
References: <DUB121-W7067785C23E81792E6879816E0@phx.gbl>,
 <533FED48.6000409@xenomai.org>, <DUB121-W25E81E35147A9FAF3D07D81690@phx.gbl>
 <DUB121-W28D0B56879463825E4F1B281690@phx.gbl>,<53418206.1040601@xenomai.org>
 <DUB121-W24F26324C941C6D102E58A814C0@phx.gbl>,<53676B5B.3020409@xenomai.org>
 <DUB121-W500004F6EF131A61A88C03814E0@phx.gbl>,<536A1529.8070508@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] problem with Task management services: Synchronous
 message passing
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>


=20
> Date: Wed=2C 7 May 2014 13:12:41 +0200
> From: gilles.chanteperdrix@xenomai.org
> To: mobin.seven@live.com=3B xenomai@xenomai.org
> Subject: Re: [Xenomai] problem with Task management services: Synchronous=
 message passing
>=20
> On 05/07/2014 01:07 PM=2C mobin Motallebizadeh wrote:
> >=20
> >=20
> >> Date: Mon=2C 5 May 2014 12:43:39 +0200 From:
> >> gilles.chanteperdrix@xenomai.org To: mobin.seven@live.com=3B
> >> xenomai@xenomai.org Subject: Re: [Xenomai] problem with Task
> >> management services: Synchronous message passing
> >>=20
> >> On 05/05/2014 11:01 AM=2C mobin Motallebizadeh wrote:
> >>>=20
> >>>=20
> >>>> Date: Sun=2C 6 Apr 2014 18:34:14 +0200 From:
> >>>> gilles.chanteperdrix@xenomai.org To: mobin.seven@live.com CC:
> >>>> xenomai@xenomai.org Subject: Re: [Xenomai] problem with Task
> >>>> management services: Synchronous message passing
> >>>>=20
> >>>> On 04/06/2014 06:19 PM=2C mobin Motallebizadeh wrote:
> >>>>> I dont know what to do with kernel console.please explain
> >>>>> more. I'm running a x86_64 mint Linux pc (core i7)
> >>>>=20
> >>>> Send us to us what the kernel console tell you... we can not
> >>>> guess what the issue is if you do not send us information about
> >>>> it.
> >>>>=20
> >>>> Also=2C the xenomai mailing list is an old fashioned mailing list
> >>>> where we do not top post. So please=2C no top posting.
> >>>>=20
> >>>> -- Gilles.
> >>>=20
> >>> The attachment is the log from netconsole.Thanks in advance
> >>=20
> >> The error is on the first line of the logs:
> >>=20
> >> [  111.023581] Watchdog detected hard LOCKUP on cpu 0 [
> >> 128.060170] BUG: soft lockup - CPU#1 stuck for 23s! [satch:2028]
> >>=20
> >> Your program has spinned 23s without relinquishing cpu.
> >>=20
> >>=20
> >> -- Gilles.
> >=20
> > I changed the code with bounding  tasks running time with TIMEOUT.
> > this time log says its a bug at task.c . why this is happening? is it
> > a real bug?
>=20
> Do you have the same bug if you sleep a reasonable time between sending
> messages instead of sleeping 40 nanoseconds?
>=20
> --=20
>                                                                 Gilles.
Thanks. fixed . sorry for being noob! 		 	   		  =
