Message-ID: <452125A4.4010705@domain.hid>
Date: Mon, 02 Oct 2006 16:43:48 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] SH4 port
References: <003e01c6e6ee$d0ba19e0$1501a8c0@domain.hid> <45211492.6080109@domain.hid>
	<003101c6e6f6$1fa52de0$1501a8c0@domain.hid>
In-Reply-To: <003101c6e6f6$1fa52de0$1501a8c0@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig030808CD616D9DFE3AD8B7E4"
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
To: Kiichi Kameda <k-kameda@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig030808CD616D9DFE3AD8B7E4
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Kiichi Kameda wrote:
>> [ksrc/arch/sh/switch.c]
>>
>> void rthal_switch_to(xnarchtcb_t *prev, xnarchtcb_t *next)
>> {
>> ...
>>         /*
>>          * Restore the kernel mode register
>>          *      k7 (r7_bank1)
>>          */
>>  if(next->user_task) {
>>
>>             asm volatile("ldc       %0, r5_bank"
>>                      : /* no output */
>>                      : "r" (next->user_task->thread_info));
>>  }
>>
>> Is there a particular reason why comment and reality diverge regarding=

>> the thread_info register? Could this cause your troubles?
>>
>=20
> I'm sorry, the comment is wrong.
> The code that uses r7_bank  results in overwriting "current".

What code is it?

> To avoid this,  I changed  from r7_bank to r5_bank for Xenomai context
> switch .

Wouldn't it be better to avoid that overwriting in the first place
instead of escaping from it? You may not be safe from code running on
behalf of a Xenomai user-space thread that assumes current is still in
r7_bank.

> Also, I added to the Linux context switch code  so that thread_info is =
set
> in r5_bank register  as well as in r7_bank regsiter.
> r5_bank register is referenced in the page fault handling code.

The handling code of Xenomai or Linux?

The goal must be that the environment for a shadowed Xenomai thread
looks (almost) like that of a normal Linux thread. If there is Xenomai
code that messes this up on SH4, this has to be fixed. Patching Linux
Linux outside the I-pipe context indicates that something is wrong with
the design. This is what I can say from my distant POV without knowing
the specific issues of SH4.

Jan


--------------enig030808CD616D9DFE3AD8B7E4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFISWkniDOoMHTA+kRAhFBAJoDWGPfy5usoy6U0T4MNi51ywG0BACaA0I/
6xsCRb4lkuH84etuiw2XeK0=
=M3a9
-----END PGP SIGNATURE-----

--------------enig030808CD616D9DFE3AD8B7E4--

