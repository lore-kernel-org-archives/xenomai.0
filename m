Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: AW: AW: [Xenomai-help] memset of heap crashes Xenomai-Task
Date: Tue, 11 Jul 2006 10:39:28 +0200
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2A3F9283@domain.hid>
From: <Roderik_Wildenburg@domain.hid>
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

> >=20
> > The are some long delays (approx. 40 secs) around __alloc_pages.=20
> > Finally it crashes in memset. With the attached xenomai=20
> patch, which=20
> > touches the reserved page once, memset works fine. Let's wait what=20
> > Philippe says. I remember that the "touch" was needed for=20
> RTAI shared memory as well.
>=20
> What is the difference between touching the page in kernel=20
> space and in user space? Is there no risk that the kernel=20
> will oops then at some point? Do we get the same result when=20
> touching the heap pages in user space immediately after=20
> rt_help_alloc'ing them? Roderik's demo allocates first and=20
> then touches/memsets. [I have no problem with the patch, I'm=20
> just trying to understand the mechanism.]
>=20

Presumed that touch means "use it" (=3Dmemset) I tried to allocate a =
block

and immediatelly use it (use memset before new heap is created).
But this causes a segmentation fault too.
Inspired by Gilles I set /proc/sys/vm/overcommit_memory to 2, which
worsens
the task behaviour (it crashes every time, not just some times).
Do you have any further suggestions ?

overcommit_memory:
=09
	This value contains a flag that enables memory overcommitment.
=09
	When this flag is 0, the kernel attempts to estimate the amount
	of free memory left when userspace requests more memory.
=09
	When this flag is 1, the kernel pretends there is always enough
	memory until it actually runs out.
=09
	When this flag is 2, the kernel uses a "never overcommit"
	policy that attempts to prevent any overcommit of memory. =20
=09
	This feature can be very useful because there are a lot of
	programs that malloc() huge amounts of memory "just-in-case"
	and don't use much of it.
=09
	The default value is 0.
=09
	See Documentation/vm/overcommit-accounting and
	security/commoncap.c::cap_vm_enough_memory() for more
information.

