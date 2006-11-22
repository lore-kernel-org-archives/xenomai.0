Message-ID: <45645FC0.2060605@domain.hid>
Date: Wed, 22 Nov 2006 15:33:36 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] What returns rt_task_self in
References: <1164204035.5006.305.camel@domain.hid>
	<20403318.1164195534169.JavaMail.ngmail@domain.hid>	
	<45643CC4.1000201@domain.hid> <1164199940.5006.270.camel@domain.hid>	
	<45644D39.10007@domain.hid>
	<29258254.1164204998593.JavaMail.ngmail@domain.hid>
In-Reply-To: <29258254.1164204998593.JavaMail.ngmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigAF0DB047F2D007A0086501C5"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAF0DB047F2D007A0086501C5
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

M. Koehrer wrote:
>> On Wed, 2006-11-22 at 14:14 +0100, Jan Kiszka wrote:
>>
>> [...]
>>
>>
>> Well, it actually does in intra-kernel calls, where rt_task_self()
>> returns the container object of the base nucleus thread present in the=

>> RT_TASK struct the user passed us, even if nobody should rely on this
>> fact. I would try to clear any confusion like this:
>> "The address returned points at a descriptor identifying the calling
>> task, which might be different from the descriptor address passed to
>> rt_task_create()."
>>
>>> Jan
>>>
>>>
>>> PS: Who's supposed to free the descriptor allocated by rt_task_self?
>>> Would some check for pthread_getspecific(__native_tskey) + free() on
>>> task self-destruction make sense? Will not catch all cases, I know.
>>>
>> We could add that, and the same stuff upon return from the task body
>> inside the trampoline call, but the only way to solve this with no lea=
k
>> would be to call the nucleus at each invocation, and not use any cache=
d
>> descriptor here. Since TLS requires to be operated by the owning task,=

>> there is no point in trying to have a deleted task clean those up
>> thoroughly.
> What about the idea that it is possible to retrieve the cookie that is =
used with
> rt_task_start() ?
> E.g. this could be provided with rt_task_inquire()?

Will require a syscall that is orders of magnitude slower than any
__thread variable.

Nevertheless, I don't see a reason why we shouldn't provide such trivial
service via rt_task_inquire. Could serve as a kind of fallback then for
weird architectures with lacking native TLS support. And might be useful
for other purposes as well.

> The rt_task_info struct has to be expanded for that.
>=20
> The main use case for this is that some user specific, task related dat=
a
> has to be stored. One pointer should be sufficient.
> I think, an approach that uses the Xenomai API for that is better than
> to rely on TLS or NPTL as it is unclear if related actions lead to an u=
nwanted syscall.

The only reason to not rely on TLS support provided by recent NPTL is
that there is no NPTL. I don't share your concerns for the reasons I
wrote in the reply to Daniel.

>=20
> One (very ugly) approach could be to code an address into the name of t=
he task.
> This name could be retrieved via rt_task_inquire()...
>=20
> Mathias
>=20

Jan


--------------enigAF0DB047F2D007A0086501C5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFZF/AniDOoMHTA+kRAoyFAJoCr6hMPb/2O97C9as7/UwNQUJiqQCfZtMI
PkWcWMqb6lpxG0xm+3HGhOM=
=wXyA
-----END PGP SIGNATURE-----

--------------enigAF0DB047F2D007A0086501C5--

