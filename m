Message-ID: <44140395.7090702@domain.hid>
Date: Sun, 12 Mar 2006 12:18:45 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] user mode vs. kernel module
References: <44113E39.1010902@domain.hid>
In-Reply-To: <44113E39.1010902@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-1?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
Cc: xenomai@xenomai.org

Ignacio Garc=EDa P=E9rez wrote:
> Hi,
>=20
> So far I've had my application implemented entirely as a kernel module=20
> with some user mode helper programs. I've had in mind changing to user=20
> mode but never felt compelled enough.
>=20
> Now, having a new requirement to implement, I think it's the moment to=20
> give it a try, and I'm porting it. I have a couple of questions:
>=20
> 1- How significative, in real world terms, is the overhead involved in=20
> operaing in user mode?. As far as I know all operations are executed vi=
a=20
> "pods" which involve one or more system calls and context switches. I'm=
=20
> using a Geode board right now but there are plans to move to a more=20
> low-end platform (486).
>=20
> 2- ioperm. This is a true headache. I've spent countless hours debuggin=
g=20
> this and banging my head agaist the wall. I'm not 100% sure of what's=20
> going on here, but it looks like the ioperm call must be issued from=20
> primary mode if you are doing the I/O from primary mode. Something like=
=20
> this would segfault:
>=20
> ioperm(0x443, 0x01, 1);
> rt_mutex_lock(...)
> outb(0x01, 0x443)
>=20
> While this works fine:
>=20
> rt_mutex_lock(...)
> ioperm(0x443, 0x01, 1);
> outb(0x01, 0x443);
>=20
> While leads me to think that the rt_mutex_lock puts the task in primary=
=20
> mode and then both ioperm and outb are executed in the same mode so=20
> everything works.
>=20
> Is this right?

No.

. If so, I find this extremely inconvenient...
>=20

Fixed in the repository. Use iopl(3) as a work-around, or resync.

> Nacho.
>=20
>=20
>=20
>=20
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>=20


--=20

Philippe.

