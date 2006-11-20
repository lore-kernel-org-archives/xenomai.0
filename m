Message-ID: <45617CED.1030605@domain.hid>
Date: Mon, 20 Nov 2006 11:01:17 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <DD39B5C3F4963040ADC9768BE7E430CB0154E8D7@domain.hid>	
	<1163784779.4980.47.camel@domain.hid> <455E025B.5030906@domain.hid>	
	<1163790315.4980.73.camel@domain.hid> <455E0940.7070705@domain.hid>	
	<1163800682.4980.81.camel@domain.hid> <45617342.8020504@domain.hid>
	<1164015493.5006.44.camel@domain.hid>
In-Reply-To: <1164015493.5006.44.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8EC3F71110DC12D0EA51EAE4"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: XENO_OPT_DEBUG impact
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
--------------enig8EC3F71110DC12D0EA51EAE4
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Mon, 2006-11-20 at 10:20 +0100, Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> On Fri, 2006-11-17 at 20:10 +0100, Jan Kiszka wrote:
>>>> Philippe Gerum wrote:
>>>>> On Fri, 2006-11-17 at 19:41 +0100, Jan Kiszka wrote:
>>>>>> I'm currently seeing two potential "misuses" of the common switch:=

>>>>>>
>>>>>>  - the posix skin (Gilles, how heavy-weighted are those checks?)
>>>>>>    =3D> CONFIG_XENO_OPT_DEBUG_POSIX
>>>>>>
>>>>>>  - CONFIG_XENO_SPINLOCK_DEBUG =3D> CONFIG_XENO_OPT_DEBUG_SPINLOCK
>>>>>>
>>>>>> Both should be explicitly controllable in Kconfig.
>>>>>>
>>>>> Nack for CONFIG_XENO_OPT_DEBUG_SPINLOCK. Most of the issue we track=
ed
>>>>> with Gilles regarding the domain migration code had side-effects on=
 the
>>>>> nucleus lock. So having CONFIG_XENO_OPT_DEBUG enabled for identifyi=
ng
>>>>> internal state weirdnesses - like those triggered by migration bugs=
 -
>>>>> implies enabling the spinlock watchdogs too.
>>>> Ok, if it only makes sense to have both enabled at the same time, th=
en
>>>> let us create XENO_OPT_DEBUG_NUCLEUS. It should include both, but it=

>>>> shall not be automatically on when, say, only XENO_OPT_DEBUG_RTDM is=

>>>> required.
>>> No objection.
>>>
>> Looking at the spinlock debugging code: it serves two inseparable
>> purposes, a watchdog for stuck locks + lock statistics. The latter mak=
e
>> this feature pop up when XENO_OPT_STATS are set on a SMP box - rather
>> surprising effect. Do we still need the stats? If not, I would kick th=
em
>> out in favour of using the latency tracer for such analysis, making
>> spinlock debugging a real pure debug feature.
>>
>=20
> The spinlock stats are about uncovering a problem, the latency tracer i=
s
> about finding where the problem lies. Both are orthogonal.

Not fully true: the tracer provides the same information when you enable
CONFIG_IPIPE_TRACE_IRQSOFF. When you disable CONFIG_IPIPE_TRACE_MCOUNT,
you even get this at comparable (if not lower) costs. I once played with
the spinlock debug code before decided to invest time into the tracer. I
think I even posted a patch to enable that code on UP. But I didn't find
the spinlock stats useful enough, even for the scenario "lock length
analysis".

We basically have now two ways to get the same information (or please
explain what is missing with the tracer). Besides the redundancy, there
is the problem that one of this way comes in via two different,
orthogonal paths (STATS+SMP || DEBUG). That's not very consistent IMHO.

Jan


--------------enig8EC3F71110DC12D0EA51EAE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFYXztniDOoMHTA+kRAtz7AJwOLLRakNjd09+M5dI0XbCA37I0CQCcCroS
jzIhkGHGZWe/RAGfwTrMwgI=
=AULS
-----END PGP SIGNATURE-----

--------------enig8EC3F71110DC12D0EA51EAE4--

