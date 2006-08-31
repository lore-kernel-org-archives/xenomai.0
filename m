Message-ID: <44F73D61.3010603@domain.hid>
Date: Thu, 31 Aug 2006 21:49:53 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [patch, RFC] detect unhandled interrupts
References: <b647ffbd0608291228i58bfa3fex5e8f3e18dc0ecc0@domain.hid>	
	<1157013092.4359.11.camel@domain.hid> <44F7346D.20602@domain.hid>
	<1157052719.4359.70.camel@domain.hid>
In-Reply-To: <1157052719.4359.70.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1CFC890AFFE650642032983F"
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
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1CFC890AFFE650642032983F
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Thu, 2006-08-31 at 21:11 +0200, Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> On Tue, 2006-08-29 at 21:28 +0200, Dmitry Adamushko wrote:
>>>> Hello,
>>>>
>>>> Jan has rised this question initially and I was struggling last week=

>>>> to get his request eventually done :)
>>>>
>>>> The main idea is to prevent system lockups when the cross domain IRQ=

>>>> sharing isn't properly used (there were a number of reports recently=
).
>>>>
>>>> So here is an initial patch as well as some related critics (yep, I
>>>> critisize my own patch).
>>> [...]
>>>
>>> Applied, thanks.
>>>
>> Unless I'm currently doing something completely wrong, it looks like i=
t
>> doesn't work as it should. :(
>>
>> I attached a xeno_16550A to the Ethernet NIC's IRQ line and opened the=

>> serial port - lock-up.
>>
>> Ok, and now I enabled shared IRQ support:
>>
>> kernel/xenomai/nucleus/intr.c: In function 'xnintr_irq_handler':
>> kernel/xenomai/nucleus/intr.c:399: error: 'xnintr_t' has no member nam=
ed
>> 'unhandled'
>> kernel/xenomai/nucleus/intr.c:404: error: 'xnintr_t' has no member nam=
ed
>> 'unhandled'
>>
>> Looks like our patch review failed... :-/
>>
>=20
> I've just committed two trivial fixes concerning the declaration and
> initialization of xnintr::unhandled in the !shared case.
>=20

And I found the other bug (which was not in the version I suggested BTW
;) ), see SVN.

Ok, the world is round again, the conflict is correctly detected now!

Jan


--------------enig1CFC890AFFE650642032983F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE9z1hniDOoMHTA+kRAp3AAKCE3s5ZFNmDiaT04I1rE9s33OEwpQCfXUEC
7pIFah9/4scUtAbykFLD/bM=
=jtVs
-----END PGP SIGNATURE-----

--------------enig1CFC890AFFE650642032983F--

