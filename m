Message-ID: <48F6E3E9.3070100@domain.hid>
Date: Thu, 16 Oct 2008 08:49:13 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48F6195C.7070801@domain.hid> <48F6492C.4090500@domain.hid>
	<48F64BD6.6050803@domain.hid>
In-Reply-To: <48F64BD6.6050803@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3DA1A651E5DF3685B448B033"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] rt_task_info.status encoding
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3DA1A651E5DF3685B448B033
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
>> Jan Kiszka wrote:
>>> Hi,
>>>
>>> the documentation refers to the Native Task Status (T_*) when it come=
s
>>> to documenting rt_task_info.status. That is not correct. That field
>>> contains far more flags than T_* is describing and, even worse, comes=

>>> with two collisions: T_PRIMARY and T_JOINABLE are not reported by
>>> rt_task_inquire, rather T_RELAX (!T_PRIMARY, arrrg...) and T_HELD.
>>>
>> T_PRIMARY is NOT meant to be reported by rt_task_inquire(), and actual=
ly, its
>> value was picked to collide, to reflect the fact that it was a one-way=

>> specifier. You can't use T_RELAX because what is needed is a bit to fo=
rce a
>> transition to primary mode using rt_task_set_mode(), which is the actu=
al source
>> of all uglinesses. Aside of this, the nucleus naturally wants a "relax=
ed state"
>> bit, and would not get any help from a "primary mode" bit for threads.=

>>
>> We could have used a T_RELAX bit to clear in rt_task_set_mode() instea=
d of
>> T_PRIMARY to set, but unfortunately, such a negative logic would have =
been
>> somewhat confusing to users, since what is provided is the secondary -=
> primary
>> mode switch.
>>
>> Sending back the current mode in rt_task_inquire() would lead to two a=
dditional
>> issues:
>> 1) if for some reason, we would like to switch the caller to secondary=
 mode at
>> some point to be able to provide a more complete status, the primary/s=
econdary
>> status returned would make no sense at all. The fact that we don't do =
it now
>> does not preclude the need to do it in future releases.
>> 2) rt_task_set_mode(..., T_PRIMARY) is already vastly misused in a num=
ber of
>> applications, sometimes uselessly, most of the time in a way that even=
t kills
>> performances. Giving an interface to get back the current mode would c=
lose the
>> loop, triggering a whole set of new terminally silly usage of that hac=
k.
>> Applications should NEVER use that feature, it was initially designed =
for
>> internal code (i.e. RTDM if my memory serves me well). Actually, the m=
ore I
>> think of it, the more I convinced that I'm going to slaughter this cra=
p in 2.5,
>> providing an internal syscall from the XENOMAI_SYS class instead for u=
se only in
>> proper contexts.
>>
>> T_JOINABLE might be reported, though, that is a different story.
>>
>>> I see two ways out of this:
>>>
>>>  a) Redirect the documentation to the nucleus thread state flags.
>>>
>> Which means that the documentation of the skin depends on the implemen=
tation of
>> the core. Bad idea.
>=20
> We also have a difficulty: when pdf documentations are generated, the
> nucleus and native skin documentation end up in different documents. So=
,
> we can not redirect the native skin documentation to nucleus.

Then even more fixing is required here:

#define T_BLOCKED  XNPEND     /**< See #XNPEND    */
=2E..

Will take the chance.

Jan


--------------enig3DA1A651E5DF3685B448B033
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkj24+0ACgkQniDOoMHTA+nKtACeM20l5gDmb1h6HREAGaAT69HU
mpcAn3pGhTmHKy5ZVewDYzyOSDx1mllj
=5RbA
-----END PGP SIGNATURE-----

--------------enig3DA1A651E5DF3685B448B033--

