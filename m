Message-ID: <43EB737A.3010704@domain.hid>
Date: Thu, 09 Feb 2006 17:53:14 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] RTDM mmap alternative
References: <20060203192739.87567.qmail@domain.hid>
	<200602081928.17224.lbocseg@domain.hid> <43EB02F5.4040001@domain.hid>
	<200602091404.11342.lbocseg@domain.hid>
In-Reply-To: <200602091404.11342.lbocseg@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA4039F1586ACFE2BE7D5D9D5"
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
To: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA4039F1586ACFE2BE7D5D9D5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Rodrigo Rosenfeld Rosas wrote:
> Em Quinta 09 Fevereiro 2006 06:53, Jan Kiszka escreveu:
>=20
>> Rodrigo Rosenfeld Rosas wrote:
>>> One more doubt: how would I munmap that memory? do_munmap and passing=

>>> current->mm as the first parameter and the physical address as start?=
 I'm
>>> not
>> Yes, but better save current->mm at mmap time and pass *this* value on=

>> unmap. I'm thinking about a way to include this in RTDM.
>=20
> Why should I make a backup of mm? Why would it change? Just for curiosi=
ty...

Because current may change, at least with the currently lacking
auto-cleanup of RT objects (including devices and sockets) on process
termination. If we then invoke an enforced closure (e.g. via "echo
<fildes> > /proc/xenomai/rtdm/open_fildes"), mm or current has to be know=
n.

>=20
>>> sure... Maybe the user can call munmap directly since it doesn't need=
 the
>>> file descriptor. But which address should (s)he pass to start paramet=
er,
>>> the virtual or the physical one?
>> This is also an option. The user would have to pass the virtual addres=
s
>> the driver returned.
>=20
> I'm curious. How do you know in which circunstances should one pass the=
=20
> virtual or the physical address? I never know which to use...

The user typically only knows the virtual one, at least when looking at
mmap/munmap. Only if there is some specific agreement between driver and
user (see /dev/mem), the physical address behind it may be known as
well. Still, [do_]munmap takes the virtual one.

>=20
>> But I think we still need a cleanup on RTDM device closure to avoid
>> access to the mapped physical buffers after that point. I wonder how
>> this is done in standard drivers, will have to look at some of them.
>=20
> Sorry, I can't help here, since the user munmap don't pass through the =

> driver... :( I don't know if it is even done by the drivers. The mmap m=
an=20
> page states:
>=20
> "The  munmap()  system  call deletes the mappings for the specified add=
ress=20
> range, and causes further references to addresses within the range to=20
> generate invalid memory references.  The region is  also automatically =

> unmapped when the process is terminated.  On the other hand, closing th=
e file=20
> descriptor does not unmap the region."
>=20
> So, the mmap will be undone when the program finishes, I think.

Indeed, this is also what I quickly verified in practice. E.g., if you
do not munmap the region I provided in my test driver, the user-space
tool will still be able to access the physical memory behind it. In that
case, the user kmalloc'ing (or whatever) that region again after a kfree
would access memory that is probably used in a totally different way
meanwhile. Dangerous!

If it is just RAM, you may track the releases (register vma_fops) and
call kfree only when the last user finished. But when it's physical
device memory, you may want to have access earlier. Thus we need
"enforced" munmap on rt_dev_close, maintained by the individual driver.
Therefore, I will introduce also rtdm_munmap() or so.

Jan


--------------enigA4039F1586ACFE2BE7D5D9D5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD63N6niDOoMHTA+kRAlVNAJ98S7RTrOKuXCOHjnf9U2BCvHfe8QCfZIHd
zjRoU8EIkhYg2/o74HEk7kk=
=Laqd
-----END PGP SIGNATURE-----

--------------enigA4039F1586ACFE2BE7D5D9D5--

