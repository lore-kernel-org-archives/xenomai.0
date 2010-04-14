Message-ID: <4BC61915.3090907@domain.hid>
Date: Wed, 14 Apr 2010 21:35:49 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4B97BA0C.9000702@domain.hid> <4B9BB9B1.5050003@domain.hid>	
	<1268498034.27899.167.camel@domain.hid>	
	<4B9C2100.6090806@domain.hid>	
	<1268584465.27899.197.camel@domain.hid>	
	<4BB4F857.5020906@domain.hid> <4BB50C8B.2000405@domain.hid>	
	<1270156940.2418.403.camel@domain.hid>
	<4BB50F7C.1020102@domain.hid>	
	<1270157507.2418.409.camel@domain.hid>
	<4BB511C7.1050507@domain.hid>	
	<1270158532.2418.420.camel@domain.hid>
	<4BB51631.5030609@domain.hid>	
	<1270159246.2418.432.camel@domain.hid>
	<4BB51931.3080307@domain.hid>	 <4BB523E8.705@domain.hid>
	<4BB5250F.1040409@domain.hid>	 <4BB52769.4080702@domain.hid>
	<4BB5348B.2070805@domain.hid>	 <4BB5C95E.9060502@domain.hid>
	<4BB5D0D4.40908@domain.hid>	 <4BB5D1A0.8030007@domain.hid>
	<4BB5D4FB.4010901@domain.hid>	
	<1271191271.2365.436.camel@domain.hid>
	<4BC4F8CA.4080202@domain.hid>	
	<1271229750.2365.444.camel@domain.hid. org>
	<4BC570A4.1090203@domain.hid>
	<1271235874.2365.483.camel@domain.hid >
In-Reply-To: <1271235874.2365.483.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8C7BC9D5219206BDBBBA3472"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [Xenomai-help] Analogy cmd_write example
	explanation
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Alexis Berlemont <berlemont.hauw@domain.hid>, xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8C7BC9D5219206BDBBBA3472
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Wed, 2010-04-14 at 09:37 +0200, Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> On Wed, 2010-04-14 at 01:05 +0200, Jan Kiszka wrote:
>>>> Philippe Gerum wrote:
>>>>> The steps now:
>>>>>
>>>>> - we implement the automatic switchback of shadow nrt threads to
>>>>> secondary mode, upon return from Xenomai (primary) syscalls. I am
>>>>> working on this. The most significant impact is on userland, due to=
 the
>>>>> fastsynch support, actually. Kernel-wise, it's rather straightforwa=
rd.
>>>>> The only exception to this would be when the caller owns an exclusi=
ve
>>>>> resource (like a mutex), in which case the mode downgrade should be=

>>>>> postponed until the syscall releasing the last resource held return=
s.
>>>> Kernel is clear, but user space sounds indeed interesting. I guess w=
e
>>>> need an out-of-band channel to tell the kernel about pending
>>>> user-space-only lock ownerships when calling some unrelated syscall.=
 How
>>>> does your current approach look like?
>>> I want to keep things simple: shadow nrt will go through the syscalls=

>>> for acquisition/release of owned resources, instead of fastsynchs.
>> Then I'll have to pick this up as that will very likely create unhappy=

>> customers. In fact, the majority of our Xenomai threads are nrt (yeah,=

>> that happens if you convert existing applications).
>=20
> I would understand that people do not want to bother that much with
> using the right kind of threads between shadow nrt and plain linux
> within the context of an initial port, but at some point, the code
> should be made consistent with respect to the real use.
>=20
> If there is a problem with auto-shadowing in the POSIX skin, or
> sched_setscheduler() or whatever, then it should be addressed, but we
> just can't pile up code only to satisfy such a corner case, i.e.
> situations where applications create Xenomai nrt threads without actual=

> need for this, to make them run in secondary mode only, without
> requiring a single primary-mode service (hence wanting hard to keep
> __xn_exec_current for RTDM).

The scenario is not that simple - unfortunately.

>=20
> So, I will merge the bits I have in mind as a first step, because they
> satisfy the normal usage of Xenomai threads. I will certainly ACK any
> improvement to this code which keeps the original fastsynch optimizatio=
n
> for nrt threads, provided the feature/code overhead ratio seems correct=
=2E

Fine with me.

>>>>  For the use case of an enforced primary
>>>> mode switch-back, add a new service - if it is really required.
>>>> rt_task_set_mode is about static property switching, so adding T_PRI=
MARY
>>>> here was already a bad idea from that perspective.
>>>>
>>> There is no such limitation to rt_task_set_mode(), and T_CONFORMING i=
s
>>> not meant to be used blindly. So, I will stick with this interface.
>> T_CONFORMING is a mini-me of T_PRIMARY. If we already clean up the
>> latter, it is a unique chance to finally drop that misplaced interface=

>> from rt_task_set_mode. It's asymmetric and does not really fit into th=
e
>> "true" modes that this interface controls.
>>
>=20
> So, basically T_LOCK is a static switch for you? You mean that locking
> the scheduler is a static property of any thread? Same for T_NOSIG and
> blocking asynchronous calls? Look, I designed this interface after the
> pSOS equivalent, and I can assure you that this was indeed meant to be =
a
> mean to control dynamic properties.

Those modes are not static but they can be applied symmetrically and do
not change due to other influences.

Jan


--------------enig8C7BC9D5219206BDBBBA3472
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkvGGRsACgkQitSsb3rl5xR7rQCfeO5jyLXIn/eVeHa1jfvvnBlI
vloAnR1bEivKI4bKsWmjrwdqbwOdKNT8
=SIvi
-----END PGP SIGNATURE-----

--------------enig8C7BC9D5219206BDBBBA3472--

