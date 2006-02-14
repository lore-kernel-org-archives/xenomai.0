Message-ID: <43F22BDA.9030506@domain.hid>
Date: Tue, 14 Feb 2006 20:13:30 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] provide rtdm_mmap_to_user / rtdm_munmap
References: <200602141114.23856.lbocseg@domain.hid>
In-Reply-To: <200602141114.23856.lbocseg@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Rodrigo Rosenfeld Rosas wrote:
> Em Ter=E7a 14 Fevereiro 2006 05:55, voc=EA escreveu:
>=20
>>Rodrigo Rosenfeld Rosas wrote:
>>
>>>Jan Kiszka escreveu:
>>>
>>>>Rodrigo Rosenfeld Rosas wrote:
>>>>
>>>>>Jan Kiszka escreveu:
>>>>>
>>>>>>Ok, but even if you decide to let rt-mmap be non-deterministic, you
>>>>>>still need some means to prevent the scenario you described above.
>>>>>>Actually, all you need is some callback when the mapped memory bloc=
k
>>>>>>was
>>>>>>actually released (munmap/application exit). Such a callback can be
>>>>>>registered inside the rtdm_mmap handler as a vma_fileop.
>>>>>
>>>>>I have never worked with vma_fileop... I would need to learn it firs=
t.
>>>>
>>>>Here is the patch to offer you access to those ops. Revert the previo=
us
>>>>version, then apply this one.
>>>
>>>Actually I would have to revert the modifications I had to do for the
>>>patch to apply (some rejected chunks). But I think I'll update to the
>>>last SVN xenomai. BTW, is this patch for the SVN or 2.1 or 2.0.2
>>>xenomai? Or it would apply for all of them?
>>
>>Developed and tested against 2.1. The current patch will not cleanly
>>apply against 2.0.
>=20
>=20
> Ok, it already applied cleanly on last svn version. I'll reboot my comp=
uter
> and test it. That is something I didn't like in 2.1 series... I always =
have
> to recompile the kernel and to reboot when a new xenomai release is ava=
ilable
> (unless I'm missing something)... On the previous series I just compile=
d it
> as modules and it was only necessary to recompile the kernel when a new=
 adeos
> (ipipe) version was available...

What about building the Xenomai support as modules instead of statically =
into the=20
kernel?

>=20
>=20
>>>>It still needs some final documentation
>>>>notes and a test on kernel 2.4. But is should already work on 2.6.
>>>
>>>I forgot to mention, I have one more problem. Since I call mmap on
>>>driver initialization (thus before any rtdm_dev_open), I do not have a=
ny
>>>rtdm_user_info_t, so I need to use current instead, but I'm not sure i=
f
>>>this will work. Maybe mmap needs the 'current' struct of the user
>>>program... I don't know this very well... If that is true, so I'll hav=
e
>>>to do the maps in a non-rt context anyway...
>>
>>You cannot mmap before you know precisely for which user this should
>>take place.
>=20
>=20
> Do you mean that if I use the 'current' and current->mm struct of the d=
river,
> when mmaping, the user won't be able to use the returned pointer?
>=20
>=20
>>During init, it's the insmod/modprobe process - likely not
>>the one you are interested in.
>=20
>=20
> Actually, that is the way I was planning for making the maping in a
> deterministic way...
>=20
>=20
>>So the earliest point for mmap is device
>>open. If this is too late for you, then now finally forget about this
>>pre-mmapping and turn it into a normal function for secondary mode. It
>>will be hard anyway to find a user who will notice the difference.
>=20
>=20
> That is not a question of noting any difference or not... An applicatio=
n can
> works great most of the time but it can fail under some not common
> circunstances. The user will need to know, at least, that he will can n=
ot
> rely on rt-capabilities when doing that and will be forced to do that o=
nly on
> initialization. But that is ok for most cases. I think I'll do that (I =
do not
> have other options at all :) ).
>=20
> Thanks,
>=20
> Rodrigo.
>=20
> 	=09
> _______________________________________________________
> Yahoo! Acesso Gr=E1tis - Internet r=E1pida e gr=E1tis. Instale o discad=
or agora!
> http://br.acesso.yahoo.com
>=20
>=20
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
>=20


--=20

Philippe.

