Message-ID: <4C7262A4.5030607@domain.hid>
Date: Mon, 23 Aug 2010 13:59:32 +0200
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <4C45539B.70204@domain.hid> <4C6932E8.7050701@domain.hid>	
	<4C694AB3.8050407@domain.hid> <4C698E16.5050806@domain.hid>	
	<1282040830.1730.232.camel@domain.hid>	
	<4C6ACA50.3080108@domain.hid>	
	<1282120049.1730.304.camel@domain.hid>	
	<4C6BCDE5.6050607@domain.hid> <4C6BE610.7020507@domain.hid>
	<1282498940.1961.43.camel@domain.hid>
In-Reply-To: <1282498940.1961.43.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6F9DDF7D8447C341D1D04007"
Subject: Re: [Xenomai-help] kernel 2.6.32.11 with xenomai 2.5.3 fails to
 boot on ubuntu lucid system
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6F9DDF7D8447C341D1D04007
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 22.08.2010 19:42, Philippe Gerum wrote:
> On Wed, 2010-08-18 at 15:54 +0200, Stefan Kisdaroczi wrote:
>  =20
>> On 18.08.2010 14:11, Stefan Kisdaroczi wrote:
>>    =20
>>> [...]
>>> hi philippe, hope this helps:
>>>
>>>
>>> (gdb) bt
>>> #0  doublefault_fn () at arch/x86/kernel/doublefault_32.c:47
>>> #1  0x00000000 in ?? ()
>>>
>>> I set two breakpoints:
>>> 1) do_test_wp_bit()
>>> 2) zap_low_mappings()
>>>
>>> The second breakpoint is never reached, the fault seems to happen in
>>> do_test_wp_bit().
>>> arch/x86/mm/init_32.c : mem_init() -> test_wp_bit() -> do_test_wp_bit=
()
>>>  =20
>>>      =20
>> If I got it right, do_test_wp_bit() should fault, and then
>> ipipe_handle_exception gets called.
>> At this point, ipipe_init_early() was called, but ipipe_init() not.
>> So, I currently guess the bug is somewhere in ipipe_handle_exception()=
=2E
>>    =20
> As mentioned below, you were right:
> http://git.denx.de/?p=3Dipipe-2.6.git;a=3Dcommit;h=3Dd7ed9ab34a265d6486=
504d20ee794548ce6011d3
>
> Your assumption that the bootloader was involved in this bug was correc=
t
> as well. This is the reason why I could not reproduce the issue over
> kvm, I was bypassing the installed bootloader, passing -kernel to qemu
> to directly load an external image, so no IRQ pending on entry to the
> kernel, ever...
>
> Thanks for your help.
>
>  =20

Tested with 2.6.32.20 and debian squeeze, boots fine, laptop and virtual
machine.
Thanks Philippe.

Stefan



--------------enig6F9DDF7D8447C341D1D04007
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkxyYq4ACgkQIPTw9rIdn6qBjACfVvCuKb2SoaoHcHcbiBhTCaw9
1EsAnjh9uDzKAOo2IqjolKD9LB0LSIP8
=B12W
-----END PGP SIGNATURE-----

--------------enig6F9DDF7D8447C341D1D04007--

