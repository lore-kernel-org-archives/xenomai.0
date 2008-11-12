Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Nov 2008 12:16:09 +0100
Message-ID: <406CC9939904F143B9D42CEEA3E56E566514C0@domain.hid>
References: <406CC9939904F143B9D42CEEA3E56E565DA7FA@oab1mx1.oneaccess.intra>
	<4918560D.2000306@domain.hid>
From: "Filip Van Rillaer" <Filip.VanRillaer@domain.hid>
Subject: Re: [Xenomai-help] xenomai on blackfin svn4240
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

Hello Philippe,

Thank you for upgrading the blackfin code.  I upgraded to rev 4369 and
the compilation + booting the image works fine.
However, I am still having problems running programs with rt_task_shadow
(e.g. in examples/native/rtprint.c example).  Are you seeing similar
problems? (my platform is BF537 on Stamp)

Best regards,
Filip

-----Original Message-----
From: Philippe Gerum [mailto:rpm@xenomai.org
Sent: 10 November 2008 16:41
To: Filip Van Rillaer
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] xenomai on blackfin svn4240

Filip Van Rillaer wrote:
> Hello,
> =20
> Starting from subversion revision 4240, xenomai is not compiling=20
> anymore for blackfin.
> I think that part of the problem is the absence of following parts in=20
> usermode (I mean not __KERNEL__) in the file asm-blackfin/atomic.h :
>  - typedef for xnarch_atomic_t is missing
>  - xnarch_atomic_get is missing
>  - xnarch_atomic_set is missing
>  - xnarch_atomic_cmpxchg is missing
> =20
> I also had to make the function xeno_init_current_mode (file bind.h)=20
> as <<static inline>> to avoid a problem with multiple definitions when

> linking my user-application (it includes functions of native and rtdm=20
> library).
> =20
> Finally rt_task_shadow fails and returns  EFAULT (but that problem can

> be caused by my own dummy implementation for the functions mentioned)
>

The build woes should be fixed, but I still need to validate the trunk
on a
bf561 here.

> Best regards,
> Filip
>=20
>=20
> ----------------------------------------------------------------------
> --
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


--
Philippe.

