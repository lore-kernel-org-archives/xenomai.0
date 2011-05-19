From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <201105191537542034180@domain.hid>
References: <BANLkTim1tWxvzUx2gUwLbQVbob4tRqbCFw@domain.hid>
	<201105191537542034180@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 19 May 2011 10:03:43 +0200
Message-ID: <1305792223.2118.22.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] I suspect the shared memory of Xenomai has bug.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "arethe.rtai" <arethe.rtai@domain.hid>
Cc: xenomai@xenomai.org

On Thu, 2011-05-19 at 15:37 +0800, arethe.rtai wrote:
> =EF=BB=BF=20
> I solved the problem of the shared memory cannot be allocated in the
> user space.=20
> Because the shared memory space are allocated from the kheap, but the
> kheap is not a mapped heap, i.e. its pages are not reserved.
> I init the kheap by xnheap_init_mapped rather than xnheap_init. The
> problem is solved.
> =20

You have just turned the global system heap to a shared heap, which is
badly wrong. If anywhere, the issue is in create_new_heap(), or in the
_compat_shm_alloc() interface in userland, or a combination of both.

As Gilles told you already, such a 100% reproducible allocation/mapping
issue can not be a generic one, involving the core heap system,
otherwise no skin would ever work. We do depend on the system heap
internally, for almost everything in the system. It is much more likely
a local RTAI skin bug, because this code has bit rot over time, due to
lack of interest and users.

PS: Please keep the list CCed.

> Qin Chenggang
> =20
> 2011-05-19=20
>=20
> ______________________________________________________________________
> arethe.rtai=20
>=20
> ______________________________________________________________________
> =E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9A Philippe Gerum=20
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A 2011-05-13  14:50:06=20
> =E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9A arethe rtai=20
> =E6=8A=84=E9=80=81=EF=BC=9A Xenomai-core=20
> =E4=B8=BB=E9=A2=98=EF=BC=9A Re: [Xenomai-core] I suspect the shared memor=
y of Xenomai has
> bug.=20
>=20
> On Fri, 2011-05-13 at 09:25 +0800, arethe rtai wrote:
> > HI all:
> >        I always got null while I request a shared memory through RTAI
> > skins in the user space.
> >        Some bugs maybe exist in the sub-system. I traced the execution
> > stream of rt_shm_alloc, and found the mmap() operation always return
> > -22. I suspect the problem should be same while we use other skins,
> > because the mmap operation is implemented in /ksrc/nucleus/heap.c.
> >        Is there anyone encountered this problem?
>=20
> No. The fact is that the RTAI skin has not been actively maintained for
> years now, so a local bug there is possible. Due to the lack of users
> and interest, this skin was removed from the upcoming 2.6.x series.
>=20
> > Regards Arethe.
> >=20
> > _______________________________________________
> > Xenomai-core mailing list
> > Xenomai-core@domain.hid
> > https://mail.gna.org/listinfo/xenomai-core
>=20
> --=20
> Philippe.
>=20
>=20

--=20
Philippe.



