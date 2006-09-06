Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: AW: [Xenomai-help] resubmission : memset of heap crashes Xenomai-Task
Date: Wed, 6 Sep 2006 14:08:01 +0200
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2A4E9CDD@ARVMAIL1.mra.roland-man.biz>
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
To: gilles.chanteperdrix@xenomai.org
Cc: xenomai@xenomai.org

Dear Gilles,

I admit, the mechanism for allocating all memory of the target is not =
very sophisticated. The idea was, that MAXHEAPBLOCKS*MEMORYCHUNKSIZE is =
much much more, than memory available (at least with my target (128MB) =
this is true). I should have mentioned this in the source code, sorry. =
If your target has more then =
(MAXHEAPBLOCKS*MEMORYCHUNKSIZE=3D320MB(approcimate)) memory, you should =
increase MAXHEAPBLOCKS.

If this condition is fulfiled, I think, there should be no illegal =
memory access. Do you agree ?

Roderik
=20

> -----Urspr=FCngliche Nachricht-----
> Von: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org
> Gesendet: Dienstag, 5. September 2006 17:18
> An: Wildenburg, Roderik RAEK3 MRA
> Cc: xenomai@xenomai.org
> Betreff: Re: [Xenomai-help] resubmission : memset of heap=20
> crashes Xenomai-Task
>=20
> Roderik_Wildenburg@domain.hid wrote:
>  > Some times ago (2006.07.06) I had the problem described below.=20
>  > As far as I can see, there is no solution for this till now.=20
>  > I think, it is worth a second go, as I believe, a=20
> industrial strength application can=B4t accept this behavior.
>  > Therefore I would like to ask the Xenomai-PPC gurus (as=20
> far as I can see, it could only be reproduced on PPC (not=20
> Qemu)) again, to judge, whether this is a serios problem or=20
> just something I have to live with.
>  >
>  > Thank you in advance
>  > Roderik
>  >
>  >
>  > Xenomai Version : 2.2-rc2
>  > Skin : native
>  > Kernel : 2.4.25
>  > Arch.: PPC
>  >
>  > I try to allocate as much memory as possible with the functions :
>  > rt_heap_create and
>  > rt_heap_alloc.
>  > (see source attached)
>  >
>  > When I try to use the allocated memory with memset, the=20
> Xenomai-task crashes with a "Segmentation fault".
>=20
> You are doing:
>=20
> RT_HEAP bigheap[MAXHEAPBLOCKS];
>   =20
>=20
>    for(i=3D0;i<MAXHEAPBLOCKS;i++)
>    {
>        /* some treatment */
>    }
>=20
>    /* access bigheap[i] */
>=20
> After the for loop, i is MAXHEAPBLOCKS, so, you are accessing=20
> the bigheap array beyond its end, probably overriding the=20
> bigbuf array.
>=20
> --=20
>=20
>=20
> 					    Gilles Chanteperdrix.
>=20

