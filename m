Message-ID: <46B04DEA.6040000@domain.hid>
Date: Wed, 01 Aug 2007 11:10:02 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <46AF5F1E.7030009@domain.hid> <1185899217.6611.246.camel@domain.hid>	
	<46AF63F8.70207@domain.hid> <1185900471.6611.249.camel@domain.hid>	
	<1185900717.6611.251.camel@domain.hid> <46AF69BC.6030109@domain.hid>
	<1185902177.6611.253.camel@domain.hid>
In-Reply-To: <1185902177.6611.253.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3471DB2EB1267D45B3818138"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [BUG] 2.4-rc1: modular nucleus	cannot	be	unloaded
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
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3471DB2EB1267D45B3818138
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Tue, 2007-07-31 at 18:56 +0200, Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> On Tue, 2007-07-31 at 18:47 +0200, Philippe Gerum wrote:
>>>> On Tue, 2007-07-31 at 18:31 +0200, Jan Kiszka wrote:
>>>>> Philippe Gerum wrote:
>>>>>> On Tue, 2007-07-31 at 18:11 +0200, Jan Kiszka wrote:
>>>>>>> Already a plain command sequence causes this problem:
>>>>>>>
>>>>>>> # modprobe xeno_nucleus
>>>>>>> # rmmod xeno_nucleus
>>>>>>> rmmod: xeno_nucleus: Resource temporarily unavailable
>>>>>>>
>>>>>>> Can anyone confirm?
>>>>>> Cannot reproduce it here. However, I got another report saying tha=
t
>>>>>> /proc/xenomai/stat would return -ENOMEM. Cannot reproduce it here
>>>> Correction: it would return -EAGAIN, so maybe the status leaks when =
a
>>>> restart condition has been encountered in the stat loop. Seems minor=
,
>>>> compared to ENOMEM.
>>>>
>>> Btw, you will likely need a large number of threads to make this happ=
en
>>> (~40), at least this is the case for the reporting site.
>>> =20
>> I think you need a large number of _fluctuating_ threads, as EAGAIN
>> should only be returned if something (thread count, IRQ assignments)
>> changes while dumping the list.
>=20
> This was implied.
>=20
>>  But I would have to re-check this thing
>> as well. I assume there is no hope for a test case then?
>>
>=20
> Nope.

The whole issue remains mysterious: None of the Xenomai handlers
involved in the output of "sched" should be able to return EAGAIN. Only
if seq_open returned such error (which it shouldn't according to the
kernel code), this code would be imaginable.

Jan


--------------enig3471DB2EB1267D45B3818138
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGsE3qniDOoMHTA+kRAr6GAJ9G11mb4LgfC2z2flabIDgyc2dakACeJ0on
6CHJa0hRJRXfnOaYfHLV8aA=
=u85s
-----END PGP SIGNATURE-----

--------------enig3471DB2EB1267D45B3818138--

