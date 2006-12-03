Message-ID: <4572E4FD.1040208@domain.hid>
Date: Sun, 03 Dec 2006 15:53:49 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [ANNOUNCE] Xenomai Example Repository
References: <457002EB.8080106@domain.hid> <45705C11.2010502@domain.hid>
	<457064F3.5050300@domain.hid> <4570AE1C.8050008@domain.hid>
In-Reply-To: <4570AE1C.8050008@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigEF6272B7212AAA148AEDF849"
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
--------------enigEF6272B7212AAA148AEDF849
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:

> Jan Kiszka wrote:
>  =20
>> Wolfgang Grandegger wrote:
>>    =20
>>> Jan Kiszka wrote:
>>>      =20
>>>> Hi,
>>>>        =20
>>>> the new Xenomai example repository has been created. I don't want to=

>>>>        =20
>>>> repeat here what is explained already on the related wiki page, plea=
se
>>>>        =20
>>>> have a look at
>>>>        =20
>>>>     http://www.xenomai.org/index.php/Examples
>>>>        =20
>>>> Instead, let me sketch what could be done next:
>>>>        =20
>>>>  o Port existing examples, snippets, demos from ksrc/skins/* over, m=
ake
>>>>        =20
>>>>    them compilable and runnable if required.
>>>>        =20
>>>>  o Identify what kind of examples are lacking. You, the user, is nee=
ded
>>>>        =20
>>>>    here. What do *you* think is missing, what would be helpful to sh=
ow?
>>>>        =20
>>>>  o Check what is needed to compile kernel-based examples over PPC 2.=
4.
>>>>        =20
>>>>    Philippe indicated that some switches are likely missing (x86 is =
fine
>>>>        =20
>>>>    already, other archs are 2.6-only).
>>>>        =20
>>> Some time ago I sent a patch for RTnet using the "kernel CFLAGS
>>>      =20
>>> capturing" trick to get proper switches for 2.4:
>>>      =20
>>> http://sourceforge.net/mailarchive/forum.php?thread_id=3D9493711&foru=
m_id=3D24610
>>>      =20
>>>      =20
>>> We could do the same trick here.
>>>      =20
>> Yeah, I had a look at this before. The point is that I would prefer to=

>>    =20
>> keep things _simple_ and self-contained. This capturing requires some
>>    =20
>> helper Makefile and complex call nestings that likely only people with=

>>    =20
>> advanced make and shell skills can understand and adopt to their proje=
cts.
>>    =20
>> But maybe things are that complicated already, and this is just
>>    =20
>> different complexity. How do you compile simple out-of-tree modules
>>    =20
>> against 2.4 PPC kernels? Are there any standard flags? Or is it
>>    =20
>> different for each board or each compiler version or whatever?
>>    =20
> I just cut and paste the flags from a kernel module make. For PPC, ther=
e=20
> are plenty of flags, not board but some are processor depended, but I'm=
=20
> unable to tell which one are really required. For this reason I like th=
e=20
> module capturing trick.
>  =20
What about this patch? I /seems/ to work (yeah, only tested on x86...), m=
erging the
whole capturing stuff into the same Makefile. Please give it hell on PPC.=


Index: rtdm/driver-api/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- rtdm/driver-api/Makefile	(Revision 1916)
+++ rtdm/driver-api/Makefile	(Arbeitskopie)
@@ -47,23 +47,23 @@ ifneq ($(MODULES),)
=20
 OBJS     :=3D ${patsubst %, %.o, $(MODULES)}
 CLEANMOD :=3D ${patsubst %, .%*, $(MODULES)}
+PWD      :=3D $(shell if [ "$$PWD" !=3D "" ]; then echo $$PWD; else pwd;=
 fi)
=20
-# Kernel 2.6
+### Kernel 2.6
 ifeq ($(findstring 2.6,$(KSRC)),2.6)
=20
 obj-m        :=3D $(OBJS)
 EXTRA_CFLAGS :=3D -I$(KSRC)/include/xenomai -I$(KSRC)/include/xenomai/po=
six $(ADD_CFLAGS)
-PWD          :=3D $(shell pwd)
=20
 all::
 	$(MAKE) -C $(KSRC) SUBDIRS=3D$(PWD) modules
=20
-# Kernel 2.4
+### Kernel 2.4
 else
=20
+ARCH    ?=3D $(shell uname -i)
 INCLUDE :=3D -I$(KSRC)/include -I$(KSRC)/include/xenomai -I$(KSRC)/inclu=
de/xenomai/compat -I$(KSRC)/include/xenomai/posix
-CFLAGS  +=3D -O2 -Wall -Wstrict-prototypes -Wno-trigraphs -DMODULE -D__K=
ERNEL__ -DLINUX \
-           -fno-strict-aliasing -fno-common $(INCLUDE) $(ADD_CFLAGS)
+CFLAGS  +=3D $(shell $(MAKE) -s -C $(KSRC) CC=3D$(CC) ARCH=3D$(ARCH) SUB=
DIRS=3D$(PWD) modules) $(INCLUDE) $(ADD_CFLAGS)
=20
 all:: $(OBJS)
=20
@@ -74,3 +74,7 @@ clean::
 	$(RM) -R .tmp*
=20
 endif
+
+## Target for capturing 2.4 module CFLAGS
+modules:
+	@echo "$(CFLAGS)"


Jan



--------------enigEF6272B7212AAA148AEDF849
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFcuT9niDOoMHTA+kRApfSAJsEDreAhPH8uxMtA5vsuvLvqb29kQCeJKvh
1pZBDUlwejlHosa4PE5vvTU=
=3lfk
-----END PGP SIGNATURE-----

--------------enigEF6272B7212AAA148AEDF849--

