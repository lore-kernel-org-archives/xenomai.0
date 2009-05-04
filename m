Message-ID: <49FEAC15.5060502@domain.hid>
Date: Mon, 04 May 2009 10:49:25 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5D63919D95F87E4D9D34FF7748CE2C2A018D48CC@ARVMAIL1.mra.roland-man.biz>
	<49FDFCC7.6000009@domain.hid>
	<20090504072304.A7E2483420E8@domain.hid>
In-Reply-To: <20090504072304.A7E2483420E8@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Some problems with shared memory
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Denk <wd@domain.hid>
Cc: xenomai@xenomai.org

Wolfgang Denk wrote:
> Dear Gilles,
>=20
> in message <49FDFCC7.6000009@domain.hid> you wrote:
>>> 1.) If I don=B4t page align the size of shared memory (multiple of 40=
96)
>> I get the following error message :
>>> "createshm mmap: No such device or address"
> ...
>> Are you sure this issue is specific to xenomai, do not you have the sa=
me
>> effect with plain Linux shared memories ?
>=20
> To avoid misunderstandings, we should first point  out  that  we  are
> here  in  fact *not* discussing classic shared memory in the sense of
> the SysV SHM code, but the creation of shared memory regions by using
> the mmap() system call.

Yes, obviously.

>=20
>=20
> For completeness: shmget(2) *does* allow to allocate sizes which are
> not a multiple of pages sizes; but it then rounds up internally:
>=20
> SHMGET(2) ... DESCRIPTION:
>=20
>         ... A new shared memory segment, with size equal to the value
>         of size rounded up to a multiple of PAGE_SIZE, is created ...
>=20
> As far as mmap()  is  concerned,  there  is  no  restriction  on  the
> "length"  parameter  (though  it  is  clear  that  internally this is
> rounded up to a multiple of pages, too, but only "length"  bytes  are
> visible to the user).
>=20
> The restrictions for page allignments affect the addr and offset
> paraemters only.
>=20
>=20
> To me it seems clear that mmap() in plain Linux and Xenomai behave
> differently.

It will be clear to me when someone will have run the tests.

--=20
					    Gilles.


