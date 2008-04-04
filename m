Message-ID: <47F62DDF.5010309@domain.hid>
Date: Fri, 04 Apr 2008 15:32:15 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20080402012645.506e53ef.Cornelius.Koepp@domain.hid>	
	<47F37BF8.6000401@domain.hid> <47F3AD14.4090306@domain.hid>	
	<2ff1a98a0804020905v7019574ai927f213ab6603e41@domain.hid>	
	<47F3B348.1090102@domain.hid> <47F4CAD1.3090002@domain.hid>	
	<47F4D87F.7080204@domain.hid> <47F551AD.9030509@domain.hid>	
	<47F5E57C.6020309@domain.hid> <47F606AE.6080800@domain.hid>
	<2ff1a98a0804040618r2717c5efrb852bcbc76e6bd0c@domain.hid>
	<47F62C46.4080003@domain.hid>
In-Reply-To: <47F62C46.4080003@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9AD530FB7C66E389621521B2"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] latencys drifting into negative (Xenomai
	2.4.2/2.4.3)
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
Cc: xenomai-core <xenomai@xenomai.org>, =?ISO-8859-15?Q?Cornelius_K=F6pp?= <Cornelius.Koepp@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9AD530FB7C66E389621521B2
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> On Fri, Apr 4, 2008 at 12:45 PM, Jan Kiszka <jan.kiszka@domain.hid> wrote:=

>>> Sebastian Smolorz wrote:
>>>
>>>> Jan Kiszka wrote:
>>>>
>>>>> Sebastian Smolorz wrote:
>>>>>
>>>>>> Jan Kiszka wrote:
>>>>>>
>>>>>>> This patch may do the trick: it uses the inverted tsc-to-ns funct=
ion
>>> instead of the frequency-based one. Be warned, it is totally untested=
=20
>>> inside
>>> Xenomai, I just ran it in a user space test program. But it may give =
an
>>> idea.
>>>>>> Your patch needed two minor corrections (ns instead of ts in=20
>>>>>> functions
>>> xnarch_ns_to_tsc()) in order to compile. A short run (30 minutes) of =

>>> latency
>>> -t1 seems to prove your bug-fix: There seems to be no drift.
>>>>> That's good to hear.
>>>>>
>>>>>
>>>>>> If I got your patch correctly, it doesn't make xnarch_tsc_to_ns mo=
re
>>> precise but introduces a new function xnarch_ns_to_tsc() which is=20
>>> also less
>>> precise than the generic xnarch_ns_to_tsc(), right?
>>>>> Yes. It is now precisely the inverse imprecision, so to say. :)
>>>>>
>>>>>
>>>>>> So isn't there still the danger of getting wrong values when calli=
ng
>>> xnarch_tsc_to_ns()  not in combination with xnarch_ns_to_tsc()?
>>>>> Only if the user decides to implement his own conversion. Xenomai w=
ith
>>> all its skins and both in kernel and user space should always run=20
>>> through
>>> the xnarch_* path.
>>>> OK, would you commit the patch?
>>>>
>>>  Will do unless someone else has concerns. Gilles, Philippe? ARM and
>>> Blackfin then need to be fixed similarly, full patch attached.
>>
>> Well, I am sorry, but I do not like this solution;
>> - the aim of scaled math is to avoid divisions, and with this patch we=

>> end up using divisions;
>=20
> Please check again, no new division due to my patch, just different=20
> parameters for the existing one.
>=20
>> - with scaled math we do wrong calculations, and making a wrong
>> xnarch_ns_to_tsc only works for values which should be passed to
>> xnarch_tsc_to_ns.
>=20
> IMHO, the error is within the range of the clock's precision, if not=20
> even below. So struggling for mathematically precise conversion of=20
> imprecise physical values makes no sense to me. Therefore I once=20
> proposed the scaled-math optimization.

But this does not mean that I'm opposing even faster division-less=20
ns_to_tsc with scaled-math parameters, i.e. combining best of both worlds=
!

Jan


--------------enig9AD530FB7C66E389621521B2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFH9i3fniDOoMHTA+kRAixxAJ4teKjKjdIGrDx47xaF7spqGAMYSwCfR8Mw
opIyn0EAHHOynpjXgEvEQwI=
=lvKu
-----END PGP SIGNATURE-----

--------------enig9AD530FB7C66E389621521B2--

