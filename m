Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: AW: AW: [Xenomai-help] memset of heap crashes Xenomai-Task
Date: Tue, 11 Jul 2006 11:31:43 +0200
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2A3F92BA@ARVMAIL1.mra.roland-man.biz>
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

The description of overcommit_memory wasn=B4t the right one=20
for a 2.4.25 Kernel. See below for the description for a
2.4.25 kernel. So 0 should be the correct Value for a 2.4.25.
(obviously it does not work very reliable !?)

overcommit_memory:

This value contains a flag that enables memory overcommitment.
When this flag is 0, the kernel checks before each malloc()
to see if there's enough memory left. If the flag is nonzero,
the system pretends there's always enough memory.

This feature can be very useful because there are a lot of
programs that malloc() huge amounts of memory "just-in-case"
and don't use much of it.

Look at: mm/mmap.c::vm_enough_memory() for more information.




> -----Urspr=FCngliche Nachricht-----
> Von: xenomai-help-bounces@domain.hid
> [mailto:xenomai-help-bounces@domain.hid] Im Auftrag von=20
> Roderik_Wildenburg@domain.hid
> Gesendet: Dienstag, 11. Juli 2006 10:39
> An: xenomai@xenomai.org
> Betreff: AW: AW: [Xenomai-help] memset of heap crashes Xenomai-Task
>=20
> > >=20
> > > The are some long delays (approx. 40 secs) around __alloc_pages.=20
> > > Finally it crashes in memset. With the attached xenomai
> > patch, which
> > > touches the reserved page once, memset works fine. Let's=20
> wait what=20
> > > Philippe says. I remember that the "touch" was needed for
> > RTAI shared memory as well.
> >=20
> > What is the difference between touching the page in kernel=20
> space and=20
> > in user space? Is there no risk that the kernel will oops=20
> then at some=20
> > point? Do we get the same result when touching the heap=20
> pages in user=20
> > space immediately after rt_help_alloc'ing them? Roderik's demo=20
> > allocates first and then touches/memsets. [I have no=20
> problem with the=20
> > patch, I'm just trying to understand the mechanism.]
> >=20
>=20
> Presumed that touch means "use it" (=3Dmemset) I tried to=20
> allocate a block
>=20
> and immediatelly use it (use memset before new heap is created).
> But this causes a segmentation fault too.
> Inspired by Gilles I set /proc/sys/vm/overcommit_memory to 2,=20
> which worsens the task behaviour (it crashes every time, not=20
> just some times).
> Do you have any further suggestions ?
>=20
> overcommit_memory:
> =09
> 	This value contains a flag that enables memory overcommitment.
> =09
> 	When this flag is 0, the kernel attempts to estimate the amount
> 	of free memory left when userspace requests more memory.
> =09
> 	When this flag is 1, the kernel pretends there is always enough
> 	memory until it actually runs out.
> =09
> 	When this flag is 2, the kernel uses a "never overcommit"
> 	policy that attempts to prevent any overcommit of memory. =20
> =09
> 	This feature can be very useful because there are a lot of
> 	programs that malloc() huge amounts of memory "just-in-case"
> 	and don't use much of it.
> =09
> 	The default value is 0.
> =09
> 	See Documentation/vm/overcommit-accounting and
> 	security/commoncap.c::cap_vm_enough_memory() for more=20
> information.
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>=20

