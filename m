Message-ID: <45733F72.8030209@domain.hid>
Date: Sun, 03 Dec 2006 22:19:46 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [ANNOUNCE] Xenomai Example Repository
References: <457002EB.8080106@domain.hid> <45705C11.2010502@domain.hid>
	<457064F3.5050300@domain.hid> <4570AE1C.8050008@domain.hid>
	<4572E4FD.1040208@domain.hid> <45733E1D.8090605@domain.hid>
In-Reply-To: <45733E1D.8090605@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigEBB648D8007145283BB8DDE3"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>, xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEBB648D8007145283BB8DDE3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> Hi Jan,
>=20
> Jan Kiszka wrote:
>> Wolfgang Grandegger wrote:
>>
>>> Jan Kiszka wrote:
>>> =20
>>>> Wolfgang Grandegger wrote:
>>>>   =20
>>>>> Jan Kiszka wrote:
>>>>>     =20
>>>>>> Hi,
>>>>>>         the new Xenomai example repository has been created. I
>>>>>> don't want to
>>>>>>         repeat here what is explained already on the related wiki
>>>>>> page, please
>>>>>>         have a look at
>>>>>>             http://www.xenomai.org/index.php/Examples
>>>>>>         Instead, let me sketch what could be done next:
>>>>>>          o Port existing examples, snippets, demos from
>>>>>> ksrc/skins/* over, make
>>>>>>            them compilable and runnable if required.
>>>>>>          o Identify what kind of examples are lacking. You, the
>>>>>> user, is needed
>>>>>>            here. What do *you* think is missing, what would be
>>>>>> helpful to show?
>>>>>>          o Check what is needed to compile kernel-based examples
>>>>>> over PPC 2.4.
>>>>>>            Philippe indicated that some switches are likely
>>>>>> missing (x86 is fine
>>>>>>            already, other archs are 2.6-only).
>>>>>>        =20
>>>>> Some time ago I sent a patch for RTnet using the "kernel CFLAGS
>>>>>       capturing" trick to get proper switches for 2.4:
>>>>>     =20
>>>>> http://sourceforge.net/mailarchive/forum.php?thread_id=3D9493711&fo=
rum_id=3D24610
>>>>>
>>>>>             We could do the same trick here.
>>>>>      =20
>>>> Yeah, I had a look at this before. The point is that I would prefer =
to
>>>>     keep things _simple_ and self-contained. This capturing requires=

>>>> some
>>>>     helper Makefile and complex call nestings that likely only
>>>> people with
>>>>     advanced make and shell skills can understand and adopt to their=

>>>> projects.
>>>>     But maybe things are that complicated already, and this is just
>>>>     different complexity. How do you compile simple out-of-tree modu=
les
>>>>     against 2.4 PPC kernels? Are there any standard flags? Or is it
>>>>     different for each board or each compiler version or whatever?
>>>>    =20
>>> I just cut and paste the flags from a kernel module make. For PPC,
>>> there are plenty of flags, not board but some are processor depended,=

>>> but I'm unable to tell which one are really required. For this reason=

>>> I like the module capturing trick.
>>>  =20
>> What about this patch? I /seems/ to work (yeah, only tested on
>> x86...), merging the
>> whole capturing stuff into the same Makefile. Please give it hell on P=
PC.
>=20
> The attached Makefile works. I had to fix two problems. First, cross
> compilation was not supported. I now take the CC from "xeno-config --cc=
"
> for user space applications. I think "xeno-config" is intended only for=

> making user space applications and therefore CC should be specified on
> the command line for kernel modules:
>=20
> $ make KSRC=3D/devel/linuxppc_2_4_devel ARCH=3Dppc CC=3Dppc-linux-gcc

Yes, this is the intended usage. I also have to apply this here to build
against good-old gcc3 (looking forward to 2.4.34 supporting gcc4).

> ppc-linux-gcc -D__KERNEL__ -I/devel/linuxppc_2_4_devel/include -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common=

> -fomit-frame-pointer -I/devel/linuxppc_2_4_devel/arch/ppc -fsigned-char=

> -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -g=

> -ggdb -DMODULE
> -I/devel/linuxppc_2_4_devel-2006_11_21_1134/include/xenomai
> -I/devel/linuxppc_2_4_devel-2006_11_21_1134/include/xenomai/compat
> -I/devel/linuxppc_2_4_devel-2006_11_21_1134/include/xenomai/posix    -c=

> -o heartbeat-x86.o heartbeat-x86.c
>=20
> Furthermore I removed "-I$(KSRC)/include", it is already included in th=
e
> captured CFLAGS.

Good point.

Ok, I will merge these changes into all existing Makefiles and commit
the stuff "later".

Thanks,
Jan


--------------enigEBB648D8007145283BB8DDE3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFcz9yniDOoMHTA+kRApcBAJ493HeJT/8QXiYMFHgOyaN/Rj1ZMgCghHd1
1id/VsSxXVWYMevRsoZZ3hY=
=0IqC
-----END PGP SIGNATURE-----

--------------enigEBB648D8007145283BB8DDE3--

