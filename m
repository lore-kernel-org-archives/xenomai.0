Message-ID: <466EF3CE.4040306@domain.hid>
Date: Tue, 12 Jun 2007 21:28:14 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <30228710.1181630552942.JavaMail.ngmail@domain.hid>	
	<1181630207.7354.20.camel@domain.hid> <466ED96E.4050806@domain.hid>	
	<466EDC2C.3020200@domain.hid> <466EDF1F.5050103@domain.hid>
	<1181671708.6792.9.camel@domain.hid>
In-Reply-To: <1181671708.6792.9.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC5CBC8151167B065498358BF"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] CONFIG_SMP in switchtest
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
--------------enigC5CBC8151167B065498358BF
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Tue, 2007-06-12 at 19:59 +0200, Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> Philippe Gerum wrote:
>>>>
>>>>> On Tue, 2007-06-12 at 08:42 +0200, M. Koehrer wrote:
>>>>>
>>>>>> Hi everybody,
>>>>>>
>>>>>> I want to know why the --enable-smp option for "configure" of Xeno=
mai is used when there
>>>>>> is already the corresponding option selected with the kernel confi=
guration?
>>>>> --enable-smp is only used when you want the user-space side to _req=
uire_
>>>>> SMP support to be present into the running kernel; i.e. for some (w=
eird)
>>>>> reason, your application really needs this. Xenomai libraries don't=
 care
>>>>> whether SMP support is enabled or not, they are not sensitive to th=
at
>>>>> issue (see the "weak" status of this option in README.INSTALL)
>>>> Switchtest bases some compile-time decisions on CONFIG_SMP. Nitpicki=
ng,
>>>> OK, but I wonder if this is required. Gilles?
>>> If you do not enable the smp option, switchtest will only use one cpu=
=2E
>>> The reason why I made this is that, on some UP machine, (probably arm=
,
>>> but I do no longer remember) sysconf(_SC_NPROCESSORS_ONLN) did not wo=
rk.
>> Welcome to embedded hell :-/. What was the effect precisely? Can we
>> detect this during runtime? The point is I see people trying this test=

>> on SMP without providing the right switch to configure. Would be a pit=
y
>> IMHO.
>>
>> At this chance: I also noticed problems with our sched_setscheduler
>> detection and bfin's uClibc. Compilations works, linking fails - they
>> provide headers, but lack implementations. Patch suggestion will follo=
w.
>>
>> And my pthread_spin_lock detection got nicely vaporised on bfin once
>> again. I'm considering to switch back to the original configure-based
>> detection.
>=20
> Notice that you have no atomic ops available on Blackfin CPUs, and to
> emulate them, you would have to mask interrupts, which you can't do in
> user-space (privileged instruction). So you will always end up issuing =
a
> syscall under the hood (bfin_spinlock), that does some kind of spinlock=

> emulation from kernel space. Next kernel releases might improve things
> by allowing to jump to atomic emulation routines directly from
> user-space, but this is not yet available AFAIK. IOW, don't expect
> performance improvements from user-space locking, yet.

For now my point was the old uClibc issue "define _POSIX_SPIN_LOCKS, but
avoid to implement it". Blackfin's toolchain managed to do the second
part differently, and no longer detectable without configure's help.

>=20
>> Enough of the moaning.
>>
>=20
> Still, this is quite a fun architecture to work with.

Yeah, it basically worked here already (with latest release, to answer
your other mail), some Xenomai tests (non-POSIX) used to run. But now
I'm a bit off-road (SVN head) to apply patches and fix quirks I came
across. That's where the fun really starts... :)

Jan


--------------enigC5CBC8151167B065498358BF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGbvPOniDOoMHTA+kRAgBMAJ4ogx757QqTI7Mb3R1Ue0m+fw3yzgCeKaoM
zwI2xfioZ5Ay9LMCPtIk4jI=
=7pxQ
-----END PGP SIGNATURE-----

--------------enigC5CBC8151167B065498358BF--

