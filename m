Message-ID: <46D57F2F.5030006@domain.hid>
Date: Wed, 29 Aug 2007 16:14:07 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <904710.33097.qm@domain.hid>	<2ff1a98a0708290232p1fdbc479i878225139da6fc3c@domain.hid>	<2ff1a98a0708290620r38e7fad4q81405ee5f06fb615@domain.hid>
	<200708291447.21741.paul_c@domain.hid>
In-Reply-To: <200708291447.21741.paul_c@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig142CA1F8FD42264E8B2225B7"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Re : sqrt() function in xenomai kernel module
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Paul <paul_c@domain.hid>
Cc: Xenomai <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig142CA1F8FD42264E8B2225B7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Paul wrote:
> On Wednesday 29 August 2007 14:20, Gilles Chanteperdrix wrote:
>> On 8/29/07, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrot=
e:
>>> On 8/29/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>>>> Mathieu JOINIE-MAURIN wrote:
>>>>> The application I used is a small controller for robot developped b=
y
>>>>> people in the lab. Before it used to be in RTAI. But now they are
>>>>> trying to use Xenomai. The application is splitted in two parts: th=
e
>>>>> user side which saves data, manages interfaces and the kernel modul=
e
>>>>> which realise all the real time tisk (sampling, writing to electron=
ic
>>>>> card, controler). The communications between the two is made by 5
>>>>> pipes (command, parameters, acknowledgment, save, status).
>>>>>
>>>>> This is why i need to make my sqrt() function (of double variables)=
=20
>>>>> into my kernel modul part.
>>>> Given that this is also a "small" application, I bet it will be far
>>>> easier for you to port it to user-space (POSIX or native skin) than
>>>> porting a math lib into kernel space.
>>> Compiling a libm in kernel-space is not hard at all, especially since=

>>> a libm does not use any system call. But Mathieu could even do a
>>> simpler thing: if the only math function used is sqrt, he could simpl=
y
>>> add an implementation of this function into his kernel module.
>> Actually the rtai_math module seems to have no external dependency.
>> So, you can use it freely with Xenomai. If you want to port it a bit
>> more cleanly to xenomai, all you have to do is replacing libm_errno
>> with *xnthread_get_errno_location() (defined in nucleus/thread.h).
>=20
> Running the x86_64 build here, I found a GCC flag (-mno-sse IIRC) being=
 used=20
> by the kernel make that prevents any floating point instructions from b=
eing=20
> used. So a port/cleanup of rtai_math would most likely only work for i3=
86 &=20
> ppc architectures..
>=20

And that rtai_math stuff is arch-independent, i.e. the slower your CPU
is, the less efficient that code gets. Back in the old days when we used
RTAI kernel space modules (LXRT was unstable), we had to hack our own
i386 math lib with inline assembly for accelerated hw support, thus
acceptable performance.

Kernel-space math remains a dead end, just the point where it ends may
vary. We should really encourage people to port away from it whenever
possible.

Jan


--------------enig142CA1F8FD42264E8B2225B7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFG1X8vniDOoMHTA+kRAuWJAJ4wZWMhYqdoIp3fLlUAKulIlx9gFQCaAktq
ewINQaJnZebrFpffDhkQQuA=
=aNG6
-----END PGP SIGNATURE-----

--------------enig142CA1F8FD42264E8B2225B7--

