Message-ID: <4BC7923B.1090809@domain.hid>
Date: Fri, 16 Apr 2010 00:24:59 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <t2w95dbcd241004151500ne05d5991q4a8f6463f2b37ba1@domain.hid>
	<4BC790B0.7090604@domain.hid>
In-Reply-To: <4BC790B0.7090604@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5963DF3BEC0FABF86AEF2146"
Sender: jan.kiszka@domain.hid
Subject: Re: [Adeos-main] [Vortx86DX] What's wrong with kernels upper than
 2.6.30.10 ?
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Gilles DOFFE <g.doffe@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5963DF3BEC0FABF86AEF2146
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Gilles DOFFE wrote:
>> Hello,
>>
>> I try to install a real-time Linux kernel on a Roboard based on a Vort=
ex86DX
>> (a x486 with TSC).
>>
>> All works fine with :
>> Linux Kernel 2.6.30.10
>> Xenomai 2.5.1
>> Adeos patch adeos-ipipe-2.6.30.8-x86-2.4-09.patch
>>
>> But, for all kernels upper or equal to 2.6.31, I always get a double f=
ault
>> when testing WP bit. I have this double fault just after that :
>>
>> *Checking if this processor honours the WP bit even in supervisor mode=
=2E..*
>>
>> I traced with some simple printk that the problem occurs in this funct=
ion,
>> at the end or after the call of fix_to_virt  :
>>
>> *static noinline int do_test_wp_bit(void)
>> {
>>         char tmp_reg;
>>         int flag;
>>
>>         __asm__ __volatile__(
>>                 "       movb %0, %1     \n"
>>                 "1:     movb %1, %0     \n"
>>                 "       xorl %2, %2     \n"
>>                 "2:                     \n"
>>                 _ASM_EXTABLE(1b,2b)
>>                 :"=3Dm" (*(char *)fix_to_virt(FIX_WP_TEST)),
>>                  "=3Dq" (tmp_reg),
>>                  "=3Dr" (flag)
>>                 :"2" (1)
>>                 :"memory");
>>
>>         return flag;
>> }*
>>
>> I'm (quasi) sure that the problem is not that function, due to it work=
s when
>> the kernel is not patched.
>> But where should I search ?
>>
>> Can you give me some indications ?
>=20
> Does applying this patch [1] happen to change the picture?

To answer myself: As the Vortex is 32-bit, this patch cannot make a
difference.

>=20
> If not, please provide your .config.

So this is now important. Probably reproducible in a VM, thus also
easily debuggable.

Jan


--------------enig5963DF3BEC0FABF86AEF2146
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkvHkjsACgkQitSsb3rl5xSU8QCgtowv4o0i3tL2hW3NCuYGkIWi
3YkAn0k2/UWJN83ygDDZcb3cZJ/zX8rL
=aG19
-----END PGP SIGNATURE-----

--------------enig5963DF3BEC0FABF86AEF2146--

