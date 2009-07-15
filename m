Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2009 15:00:34 +0200
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2A01B1A843@domain.hid>
From: <roderik.wildenburg@domain.hid>
Subject: [Xenomai-help] rtdm_lock_init does not compile with ppc-ipipe-patch
	2.0.1
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

When I try to compile RTnet (for PPC, Xenomai 2.4.8, Ipipe 2.0.1, Kernel
2.4.25) I get the following error message :

In file included from rtdev.c:33:
../stack/include/rtskb.h: In function `rtskb_queue_init':
../stack/include/rtskb.h:289: error: parse error before '{' token
../stack/include/rtskb.h: At top level:
../stack/include/rtskb.h:290: error: parse error before '->' token
../stack/include/rtskb.h: In function `rtskb_prio_queue_init':
../stack/include/rtskb.h:301: error: parse error before '{' token
rtdev.c: In function `rtdev_alloc':
rtdev.c:243: error: parse error before '{' token

I followed the error through a whole bunch of macros and this is what I
figured out:

1) Startpoint of the error is rtdm_lock_init(&queue->lock) which is used
in RTnet (rtskb.h)
2) rtdm_lock_init() is defined in rtdm_driver.h :
   #define rtdm_lock_init(lock) rthal_spin_lock_init(lock)
3) rthal_spin_lock_init(lock) is defined in hal.h :  =20
   #define rthal_spin_lock_init(lock) *(lock) =3D =
IPIPE_SPIN_LOCK_UNLOCKED
   !!(as spin_lock_hw is not defined any more in the 2.0.1 patch !)!!=20
4) IPIPE_SPIN_LOCK_UNLOCKED is defined in spinlock.h (patched by the
Ipipe-patch) :
   #define IPIPE_SPIN_LOCK_UNLOCKED { .__lock =3D SPIN_LOCK_UNLOCKED }
5) SPIN_LOCK_UNLOCKED is defined in spinlock.h :
   #define SPIN_LOCK_UNLOCKED (spinlock_t) { }

so, if I expanded the whole thing correctly I get :
rtdm_lock_init(&queue->lock) -> =20
rthal_spin_lock_init(&queue->lock) -> *(&queue->lock) =3D
IPIPE_SPIN_LOCK_UNLOCKED ->
*(&queue->lock) =3D { .__lock =3D SPIN_LOCK_UNLOCKED } ->

*(&queue->lock) =3D { .__lock =3D (spinlock_t) { } }
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D


Unfortunately my preprocessor knowledge is too poor to decode this line
of code, but I think this is not what is intented by the inventor for
the macro expansion.
Could somebody help me to understand what is going on here or, even
better, correct the Ipipe 2.0.1 patch?

Thank you in advance
Roderik

--------------------------------------------------------
manroland AG
Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus =
Rall, Paul Steidle  =20
Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht =
Offenbach HRB-Nr. 42592
USt-Ident-Nr. DE 250200933

