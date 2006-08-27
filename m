Message-ID: <44F17616.9080701@domain.hid>
Date: Sun, 27 Aug 2006 12:38:14 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Timer problems?
References: <1903864415@domain.hid> <1154964748.4322.31.camel@domain.hid>
	<44EF17E8.5040606@domain.hid> <44EF37BE.70207@domain.hid>
	<44F0B06B.6050102@domain.hid>
In-Reply-To: <44F0B06B.6050102@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig009E53B77045B5CACDAB4DE9"
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
To: Steve Kreyer <steve.kreyer@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig009E53B77045B5CACDAB4DE9
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Steve Kreyer wrote:
> Hi Jan,
>=20
> first of all thanks for your answer.
> Jan Kiszka wrote:
>> Your example (with slight modifications) works fine, and the other
>> effect you listed here clearly indicates some fundamental problem of
>> your box. Does the kernel log contain any suspicious messages,
>>   specifically after that input lock-up?=20
> No the kernel log says nothing on this lock...
>> If not, please provide a precise
>> setup description: Xenomai version,
> cat /proc/xenomai/version
> 2.2
> I have also attached the config.log of the xenomai configuration to thi=
s
> email, if this
> could be meaningful to figure out the problem...
>>  kernel version + ipipe revision,
>>  =20
> cat /proc/ipipe/version
> 1.3-07
>=20
> uname -a
> Linux euklid 2.6.152.6.15 #6 SMP PREEMPT Sun Aug 6 17:02:34 CEST 2006
> i686 GNU/Linux

Any particular reason to use 2.6.15? Though this should not be the
problem here, it's generally better to use a patch that comes with the
particular Xenomai version - it gained a better test coverage.

>=20
>> hardware description (e.g. the architecture),=20
> It is a x86 system, Pentium 4 (~ 3 years old)

=2E..but you have configured your processor to be from the pre-Pentium er=
a
(CONFIG_M586). Suboptimal because TSC support is disabled, TSC emulation
is enabled.

Moreover, and that's likely another reason for troubles here, you have
CONFIG_VT on. This normally unproblematic features collides with the TSC
emulation of Xenomai. SVN head warns you about this conflict, 2.2 not
yet. Solution: pick a more appropriate processor type.

> cat /proc/cpuinfo
> processor       : 0
> vendor_id       : GenuineIntel
> cpu family      : 15
> model           : 1
> model name      : Intel(R) Pentium(R) 4 CPU 1.60GHz
> stepping        : 2
> cpu MHz         : 1600.244
> cache size      : 256 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 2
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
> mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
> bogomips        : 3207.69
>=20
>> and the .config of your
>> system (zipped please).
>>  =20
> Ok, it is attached...
>> Jan
>>
>>  =20
>=20
> Regards,
> Steve

There are a two more suboptimal (but unproblematic settings):

 o CONFIG_SMP: unless your system can be enhanced with more CPUs, switch
   it off
 o CONFIG_XENO_OPT_TIMING_PERIODIC: this is only required, if you
   actually need periodic timer mode (instead of one-shot mode)

And, again, I would take the chance when recompiling anyway to upgrade
the kernel version.

HTH,
Jan


--------------enig009E53B77045B5CACDAB4DE9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE8XYWniDOoMHTA+kRAn3QAJ4xdD4Q2QyKbPtKzQzu229Ci5vabQCcDwpJ
2IjBdwi5SbM91+Uxgo0nm64=
=Uh02
-----END PGP SIGNATURE-----

--------------enig009E53B77045B5CACDAB4DE9--

