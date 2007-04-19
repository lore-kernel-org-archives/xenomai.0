Message-ID: <4627589B.6020909@domain.hid>
Date: Thu, 19 Apr 2007 13:55:07 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <s62756bc.018@domain.hid>
In-Reply-To: <s62756bc.018@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig883458611CDB7CE8E89149FA"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] [RTDM] IRQ lock problem ?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Nicolas BLANCHARD <n.blanchard@domain.hid>
Cc: "<xenomai-help" <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig883458611CDB7CE8E89149FA
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Nicolas BLANCHARD wrote:
> Hi,
> =20
> I've write an rtdm driver and i have a problem.
> I use ioctl (rt_dev_ioctl) to read and write data (RTC time) on cmos.=20
> (I know it could better to use _rt_dev_read or rt_dev_write=20
>  but it was my first rtdm driver, and i' think that it's not the cause
> of my problem).
> =20
> My user application (Native xenomai task) use this rt_dev_ioctl each
> 100 ms to read data on cmos.
> But, sometime (each 3 or 4 days), i read bad values.
> =20
> this is the code to read the cmos (call in an rt_dev_ioctl) :=20
> =20
> //---------------------------------------------------------------------=
------------------------
> static unsigned char get_cmos_time(struct rtc146818drv_context *ctx,
>            struct rtc_time *rtc_tm)
> {
>  unsigned char uip;
>  rtdm_lockctx_t  lock_ctx;
> =20
>  rtdm_lock_get_irqsave(&ctx->lock, lock_ctx);=20
> =20
>  uip =3D (CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP);
> =20
>  if(uip =3D=3D 0)
>  {
>       rtc_tm->tm_year =3D CMOS_READ(RTC_YEAR);
>       rtc_tm->tm_mon =3D CMOS_READ(RTC_MONTH);
>       rtc_tm->tm_mday =3D CMOS_READ(RTC_DAY_OF_MONTH);
>       rtc_tm->tm_hour =3D CMOS_READ(RTC_HOURS);
>       rtc_tm->tm_min =3D CMOS_READ(RTC_MINUTES);
>       rtc_tm->tm_sec =3D CMOS_READ(RTC_SECONDS);
>       rtc_tm->tm_wday =3D CMOS_READ(RTC_DAY_OF_WEEK);
> }
> rtc_tm->tm_yday =3D 0;
> rtc_tm->tm_isdst =3D 0;
>=20
> rtdm_lock_put_irqrestore(&ctx->lock, lock_ctx);=20
> =20
> return uip;
> }
> //---------------------------------------------------------------------=
------------------------
> =20
> Data are read on MC146818A chipset, documentaton of this chipset
> explain that an update cycle is execute
> once per second and during this update  RTC_values or not fully
> available.
> So, we test the uip,when uip=3D=3D0 the update cycle is not in progress=
 and
> will not be for at least 244 us (for all time bases).
> =20
> So to be sure that in thoses 244 us i've time to execute my code, i've
> disable the premption with rtdm_lock_get_irqsave.
> But sometime, like if the update cycle begin in the midle of my code, i=

> read bad value (value 165 exactly).
> =20
> For example i read this bad time :=20
> "19/04/07 11:165:165 day 165" (like if i've been prempt after
> CMOS_READ(RTC_HOURS) instructions).
> or
> "19//04/165 165:165:165 day 165" (like if i've been prempt after
> CMOS_READ(RTC_MONTH) instructions).
> =20
> We use the same hardware with other system (RTLinux), with same test on=

> uip bit and we have no problem ( problem isn't on the chipset .. ).
> =20
> So Is my rtdm_lock_get_irqsave and restore use correct ?
> Is it sure that my critical section is protected from any premption
> with this lock ?

rtdm_lock_get_irqsave protects against preemption, but did you check

 o how CMOS_READ is realised internally?
 o if there are other CMOS_xxx users in the stock kernel that can bite
   you?

As I already explained to you earlier, the CMOS access itself is
problematic because it contains non-atomic operations that must be
protected against re-entrance. Linux does this via
local_irq_save/restore etc. Xenomai breaks this mechanism by making
Linux fully preemptible. Even worse, your invocation of CMOS_READ in
Xenomai context also invokes Linux local_irq_restore, potentially
causing unwanted side effects.

The Linux preemptibility issue applies to RTLinux as well, just how
local_irq_save/restore behaves when being invoked from incorrect
context may differ and explain the observed behaviour.

Jan


--------------enig883458611CDB7CE8E89149FA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGJ1ieniDOoMHTA+kRAizrAJ90mGMNUB8XMxyKC795GXRkMLgNjwCcCAb8
QdWx0M4ovSkN2RrG2LtKbL8=
=HJxG
-----END PGP SIGNATURE-----

--------------enig883458611CDB7CE8E89149FA--

