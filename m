Message-ID: <4C6ACA50.3080108@domain.hid>
Date: Tue, 17 Aug 2010 19:43:44 +0200
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <4C45539B.70204@domain.hid>
	<4C6932E8.7050701@domain.hid>	<4C694AB3.8050407@domain.hid>
	<4C698E16.5050806@domain.hid>
	<1282040830.1730.232.camel@domain.hid>
In-Reply-To: <1282040830.1730.232.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig80D00B87F79FE0DADCCF3EE3"
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
To: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig80D00B87F79FE0DADCCF3EE3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 17.08.2010 12:27, Philippe Gerum wrote:
> On Mon, 2010-08-16 at 21:14 +0200, Theo Veenker wrote:
>  =20
>> On 08/16/2010 04:26 PM, Theo Veenker wrote:
>>    =20
>>> Gilles Chanteperdrix wrote:
>>>      =20
>>>> Theo Veenker wrote:
>>>>        =20
>>>>> Hi,
>>>>>
>>>>> I want to upgrade all our PC's from Ubuntu hardy to lucid and in th=
e
>>>>> process
>>>>> I'm also going from kernel 2.6.29.5 with Xenomai 2.4.8 to kernel
>>>>> 2.6.32.11
>>>>> with Xenomai 2.5.3.
>>>>>
>>>>> I first built and tested the 2.6.32.11 kernel with 2.5.3 on my hard=
y
>>>>> system
>>>>> and all went fine. But the problem is it just doesn't run on the
>>>>> lucid distro.
>>>>>          =20
>>>> This, I do not understand, the kernel does not need any support from=
 the
>>>> distribution for booting, how can the same kernel boot with one
>>>> distribution, and not with the other? When you say the "same kernel"=
, do
>>>> you mean the exact same zImage or bzImage, or do you mean the kernel=

>>>> with the same configuration, but with a different compiler, or only =
the
>>>> version is identical?
>>>>
>>>>        =20
>>> It is a complete mystery to me either. I compiled my kernel into a de=
b
>>> package
>>> and installed the very same deb package on three machines:
>>> MSI p45 neo3 with Hardy on it -> works OK
>>> MSI p45 neo3 with Ludid on it -> nothing (works fine with regular ker=
nel)
>>> MSI 945P with Lucid on it: -> nothing (works fine with regular kernel=
)
>>>
>>> I'll try the suggestions posted and keep you informed.
>>>      =20
>> OK. Connected a terminal to catch early kernel messages. Still no outp=
ut
>> unfortunately (with the regular kernel I do get output on the terminal=
,
>> so the connection works).
>>
>> Meanwhile also built and tested kernel 2.6.32.15 + xenomai 2.5.4. Stil=
l nothing.
>> I'm clueless. I'm running Xenomai for years on dozens of systems and I=
've
>> never run into problems like this. I think I'll have to sit down and t=
ake a
>> close look at what I'm doing. I've always built my kernels using make-=
kpkg,
>> maybe that somehow introduces a problem here. I'll try without it.
>>
>> (unfortunately/luckily I have to work from home for a few days so I ca=
n't
>> get to the test system until later this week)
>>    =20
> I failed to reproduce the issue yet, but it very much looks like an
> I-pipe bug. Could you try the following config variants when time
> allows:
>  =20

I installed the kernel (2.6.32.15 2.5.4 x86 32bit) which is working on
my laptop in a kvm machine.
In the virtual machine the kernel never starts and hangs.
I attached gdb to kvm and according to the cpu registers and system.map
it hangs in 'doublefault_fn'. As I'm not really familiar with gdb i'm
thankful if someone has a hint how to proceed. Thanks

Stefan

> - on 2.6.32.11 or .15, disable CONFIG_SMP, enable CONFIG_X86_UP_APIC
> only (*).
> - on 2.6.32.11 or .15, disable CONFIG_SMP, enable CONFIG_X86_UP_APIC an=
d
> CONFIG_X86_UP_IOAPIC (*).
> - on 2.6.32.7, use your normal CONFIG_SMP config, with this patch in:
> http://download.gna.org/adeos/patches/v2.6/x86/older/adeos-ipipe-2.6.32=
=2E7-x86-2.5-01.patch
>
> (*) you need to switch off CONFIG_SMP first, to see those knobs appear
> in the "processor type and features" menu.
>
> The fact that you did see the panic blinking signal at least once tends=

> to point the finger at some access fault the kernel tries to recover
> without success, rather than a sudden freeze. It must happen early
> enough during the boot process, for the console not to be available yet=

> for reporting what the kernel whines about.
>
> We don't know yet if that bug is either the consequence of some
> interrupt delivery, and/or induced by code only involved in SMP. Those
> test configs may help in discovering this.
>
> TIA,
>
>  =20



--------------enig80D00B87F79FE0DADCCF3EE3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkxqylcACgkQIPTw9rIdn6qYYQCcDtXmAemNj25ElcRVbLPUbLzy
udkAnjjCqvTbGnPoOzPZOe2zx42ckzo8
=kVOg
-----END PGP SIGNATURE-----

--------------enig80D00B87F79FE0DADCCF3EE3--

