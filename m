Message-ID: <47F62C46.4080003@domain.hid>
Date: Fri, 04 Apr 2008 15:25:26 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20080402012645.506e53ef.Cornelius.Koepp@domain.hid>	
	<47F37BF8.6000401@domain.hid> <47F3AD14.4090306@domain.hid>	
	<2ff1a98a0804020905v7019574ai927f213ab6603e41@domain.hid>	
	<47F3B348.1090102@domain.hid> <47F4CAD1.3090002@domain.hid>	
	<47F4D87F.7080204@domain.hid> <47F551AD.9030509@domain.hid>	
	<47F5E57C.6020309@domain.hid> <47F606AE.6080800@domain.hid>
	<2ff1a98a0804040618r2717c5efrb852bcbc76e6bd0c@domain.hid>
In-Reply-To: <2ff1a98a0804040618r2717c5efrb852bcbc76e6bd0c@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigFB32985090908A928B3D26DF"
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
--------------enigFB32985090908A928B3D26DF
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> On Fri, Apr 4, 2008 at 12:45 PM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>> Sebastian Smolorz wrote:
>>
>>> Jan Kiszka wrote:
>>>
>>>> Sebastian Smolorz wrote:
>>>>
>>>>> Jan Kiszka wrote:
>>>>>
>>>>>> This patch may do the trick: it uses the inverted tsc-to-ns functi=
on
>> instead of the frequency-based one. Be warned, it is totally untested =
inside
>> Xenomai, I just ran it in a user space test program. But it may give a=
n
>> idea.
>>>>> Your patch needed two minor corrections (ns instead of ts in functi=
ons
>> xnarch_ns_to_tsc()) in order to compile. A short run (30 minutes) of l=
atency
>> -t1 seems to prove your bug-fix: There seems to be no drift.
>>>> That's good to hear.
>>>>
>>>>
>>>>> If I got your patch correctly, it doesn't make xnarch_tsc_to_ns mor=
e
>> precise but introduces a new function xnarch_ns_to_tsc() which is also=
 less
>> precise than the generic xnarch_ns_to_tsc(), right?
>>>> Yes. It is now precisely the inverse imprecision, so to say. :)
>>>>
>>>>
>>>>> So isn't there still the danger of getting wrong values when callin=
g
>> xnarch_tsc_to_ns()  not in combination with xnarch_ns_to_tsc()?
>>>> Only if the user decides to implement his own conversion. Xenomai wi=
th
>> all its skins and both in kernel and user space should always run thro=
ugh
>> the xnarch_* path.
>>> OK, would you commit the patch?
>>>
>>  Will do unless someone else has concerns. Gilles, Philippe? ARM and
>> Blackfin then need to be fixed similarly, full patch attached.
>=20
> Well, I am sorry, but I do not like this solution;
> - the aim of scaled math is to avoid divisions, and with this patch we
> end up using divisions;

Please check again, no new division due to my patch, just different=20
parameters for the existing one.

> - with scaled math we do wrong calculations, and making a wrong
> xnarch_ns_to_tsc only works for values which should be passed to
> xnarch_tsc_to_ns.

IMHO, the error is within the range of the clock's precision, if not=20
even below. So struggling for mathematically precise conversion of=20
imprecise physical values makes no sense to me. Therefore I once=20
proposed the scaled-math optimization.

Jan


--------------enigFB32985090908A928B3D26DF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFH9ixGniDOoMHTA+kRAsXjAJwK5UCiwS2W6Wx5koue4xHfXcsv6ACfVF7M
+cawuDiNKyKrIHXeKGfJeQM=
=jJP1
-----END PGP SIGNATURE-----

--------------enigFB32985090908A928B3D26DF--

