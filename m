Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2009 10:30:39 +0200
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2A01B1AB89@domain.hid>
In-Reply-To: <1247761364.4228.75.camel@domain.hid>
From: <roderik.wildenburg@domain.hid>
Subject: Re: [Xenomai-help] rtdm_lock_init does not compile with
	ppc-ipipe-patch 2.0.1
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Problem solved!
RTnet compiles without problems now.
Thank you very much for your rapid help!

Best regards
Roderik

> -----Urspr=FCngliche Nachricht-----
> Von: Philippe Gerum [mailto:rpm@xenomai.org
> Gesendet: Donnerstag, 16. Juli 2009 18:23
> An: Wildenburg, Roderik RAEK3 MRA
> Cc: xenomai@xenomai.org
> Betreff: Re: [Xenomai-help] rtdm_lock_init does not compile=20
> with ppc-ipipe-patch 2.0.1
>=20
> On Wed, 2009-07-15 at 15:16 +0200, Philippe Gerum wrote:
> > On Wed, 2009-07-15 at 15:00 +0200, roderik.wildenburg@domain.hid
> > wrote:
> > > When I try to compile RTnet (for PPC, Xenomai 2.4.8,=20
> Ipipe 2.0.1, Kernel
> > > 2.4.25) I get the following error message :
> > >=20
> > > In file included from rtdev.c:33:
> > > ../stack/include/rtskb.h: In function `rtskb_queue_init':
> > > ../stack/include/rtskb.h:289: error: parse error before '{' token
> > > ../stack/include/rtskb.h: At top level:
> > > ../stack/include/rtskb.h:290: error: parse error before '->' token
> > > ../stack/include/rtskb.h: In function `rtskb_prio_queue_init':
> > > ../stack/include/rtskb.h:301: error: parse error before '{' token
> > > rtdev.c: In function `rtdev_alloc':
> > > rtdev.c:243: error: parse error before '{' token
> > >=20
>=20
> > In UP mode, you should not even have any expansion for a=20
> spinlock init.
> > I will have a look at this.
> >=20
>=20
> You need this on top of 2.0-01:
>=20
> diff --git a/include/asm-ppc/spinlock.h b/include/asm-ppc/spinlock.h
> index 855b815..f50df97 100644
> --- a/include/asm-ppc/spinlock.h
> +++ b/include/asm-ppc/spinlock.h
> @@ -30,6 +30,7 @@ typedef struct {
>  #endif
> =20
>  #define SPIN_LOCK_UNLOCKED	(spinlock_t) { 0 SPINLOCK_DEBUG_INIT }
> +#define __SPIN_LOCK_UNLOCKED	{ 0 SPINLOCK_DEBUG_INIT }
> =20
>  #define spin_lock_init(x) 	do { *(x) =3D SPIN_LOCK_UNLOCKED;=20
> } while(0)
>  #define spin_is_locked(x)	((x)->lock !=3D 0)
> diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
> index 1462732..fe56f59 100644
> --- a/include/linux/spinlock.h
> +++ b/include/linux/spinlock.h
> @@ -120,9 +120,11 @@ do {				=09
> 				\
>  #if (__GNUC__ > 2 || __GNUC_MINOR__ > 95)
>    typedef struct { } spinlock_t;
>    #define SPIN_LOCK_UNLOCKED (spinlock_t) { }
> +  #define __SPIN_LOCK_UNLOCKED { }
>  #else
>    typedef struct { int gcc_is_buggy; } spinlock_t;
>    #define SPIN_LOCK_UNLOCKED (spinlock_t) { 0 }
> +  #define __SPIN_LOCK_UNLOCKED { 0 }
>  #endif
> =20
>  #define spin_lock_init(lock)	do { } while(0)
> @@ -138,6 +140,7 @@ typedef struct {
>  	volatile unsigned long lock;
>  } spinlock_t;
>  #define SPIN_LOCK_UNLOCKED (spinlock_t) { 0 }
> +#define __SPIN_LOCK_UNLOCKED { 0 }
> =20
>  #define spin_lock_init(x)	do { (x)->lock =3D 0; } while (0)
>  #define spin_is_locked(lock)	(test_bit(0,(lock)))
> @@ -155,6 +158,7 @@ typedef struct {
>  	const char *module;
>  } spinlock_t;
>  #define SPIN_LOCK_UNLOCKED (spinlock_t) { 0, 25, __BASE_FILE__ }
> +#define __SPIN_LOCK_UNLOCKED { 0, 25, __BASE_FILE__ }
> =20
>  #include <linux/kernel.h>
> =20
> @@ -202,7 +206,7 @@ typedef struct {
>  } __ipipe_spinlock_t;
> =20
>  #ifdef CONFIG_IPIPE
> -#define IPIPE_SPIN_LOCK_UNLOCKED	{ .__lock =3D SPIN_LOCK_UNLOCKED }
> +#define IPIPE_SPIN_LOCK_UNLOCKED	(__ipipe_spinlock_t) {=20
> .__lock =3D __SPIN_LOCK_UNLOCKED }
>  #define ipipe_spinlock_t		__ipipe_spinlock_t
>  #define IPIPE_DEFINE_SPINLOCK(x)	ipipe_spinlock_t x =3D=20
> IPIPE_SPIN_LOCK_UNLOCKED
>  #define IPIPE_DECLARE_SPINLOCK(x)	extern ipipe_spinlock_t x
> @@ -219,7 +223,7 @@ void=20
> __ipipe_spin_unlock_irqcomplete(unsigned long x);
>  	spin_unlock_irqrestore(lock, flags)
>  #else /* !CONFIG_IPIPE */
>  #define ipipe_spinlock_t		spinlock_t
> -#define IPIPE_SPIN_LOCK_UNLOCKED	SPIN_LOCK_UNLOCKED
> +#define IPIPE_SPIN_LOCK_UNLOCKED	__SPIN_LOCK_UNLOCKED
>  #define IPIPE_DEFINE_SPINLOCK(x)	spinlock_t x
>  #define IPIPE_DECLARE_SPINLOCK(x)	extern spinlock_t x
> =20
> --=20
> Philippe.
>=20
>=20
>=20

