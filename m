Message-ID: <457310FA.90706@domain.hid>
Date: Sun, 03 Dec 2006 19:01:30 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] [PATCHES] cleanup minor quirks for 1.6-01
References: <4572DB9F.7040505@domain.hid> <1165157023.4952.361.camel@domain.hid>	
	<4572E7D1.5020103@domain.hid> <1165160855.4952.415.camel@domain.hid>
In-Reply-To: <1165160855.4952.415.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8E19AABC2D1F1DE326F40227"
Sender: jan.kiszka@domain.hid
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: rpm@xenomai.org
Cc: adeos-main@gna.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8E19AABC2D1F1DE326F40227
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Sun, 2006-12-03 at 16:05 +0100, Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> On Sun, 2006-12-03 at 15:13 +0100, Jan Kiszka wrote:
>>>> Hi,
>>>>
>>>> I came across a few things in latest 2.6.19-i386-1.6-01 patch:
>>>>
>>>> The usage of __ipipe_pipelock in __ipipe_common_info_proc is broken =
(raw lock used as
>>>> Linux lock here), and I do not see any volatile data it could protec=
t anyway. So let's
>>>> remove it.
>>> The interrupt status word, and whether any virtual interrupt is
>>> allocated or not, are the volatile data protected by this lock on a S=
MP
>>> system. Since this is a common spinlock with no interrupt control
>>> required which is only used over the Linux domain (/proc handler), yo=
u
>>> don't need to go for the _hw() form of it.
>> As far as I see, nothing prevents the other users of __ipipe_pipelock =
to
>> be executed over non-root domain (IRQ registration in Xenomai context =
is
>> allowed, no?).
>>
>=20
> Indeed, this is also the sense of my second reply:
> https://mail.gna.org/public/adeos-main/2006-12/msg00004.html
>=20
> Which means that our problem is more an issue regarding preemption by
> interrupts.
>=20
>> But I have to re-check what data for __ipipe_common_info_proc actually=

>> can be released (I'm not considering inconsistency a problem here). I
>> didn't see anything on first review.
>>
>> Still, this kind of merging of _hw with non-_hw spinlock operations is=

>> fishy in my eyes.
>>
>=20
> It's not without interrupt control, provided you accept the possible
> side-effects regarding kernel preemption, which /proc handlers do. What=

> would have been really problematic is a mismatch between
> spin_lock_irqsave_hw and spinlock_irqsave forms, and what is really a
> bug is the current lack of protection wrt interrupt.

I re-checked the code, and I can only repeat that I see ZERO need for
this lock here. All we are reading is the control mask from static IRQ
arrays + some bits from the related I-pipe domain.

If there is actually something to protect, than it should be calling
this proc handler vs. unregistering the domain (and it's proc entry) -
but that is only feasible with something like synchronize_sched, i.e.
waiting a grace period after unregistering so that all handlers are
through. A really uncritical race which exists with a lot of /proc code.

Jan


--------------enig8E19AABC2D1F1DE326F40227
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFcxD6niDOoMHTA+kRApxyAJwJPsx2V265i5/OjzFGP71eyr9d3QCeMOLl
a2Ct1cIv0QI+Rwku4qrTmPE=
=SPO1
-----END PGP SIGNATURE-----

--------------enig8E19AABC2D1F1DE326F40227--

