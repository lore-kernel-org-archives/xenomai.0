Message-ID: <456193E2.8030605@domain.hid>
Date: Mon, 20 Nov 2006 12:39:14 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <DD39B5C3F4963040ADC9768BE7E430CB0154E8D7@domain.hid>	
	<1163784779.4980.47.camel@domain.hid> <455E025B.5030906@domain.hid>	
	<1163790315.4980.73.camel@domain.hid> <455E0940.7070705@domain.hid>	
	<1163800682.4980.81.camel@domain.hid> <45617342.8020504@domain.hid>	
	<1164015493.5006.44.camel@domain.hid> <45617CED.1030605@domain.hid>
	<1164019575.5006.51.camel@domain.hid>
In-Reply-To: <1164019575.5006.51.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig165E8E16A91F1C352A3A2F14"
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
--------------enig165E8E16A91F1C352A3A2F14
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Mon, 2006-11-20 at 11:01 +0100, Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> On Mon, 2006-11-20 at 10:20 +0100, Jan Kiszka wrote:
>>>> Philippe Gerum wrote:
>>>>> On Fri, 2006-11-17 at 20:10 +0100, Jan Kiszka wrote:
>>>>>> Philippe Gerum wrote:
>>>>>>> On Fri, 2006-11-17 at 19:41 +0100, Jan Kiszka wrote:
>>>>>>>> I'm currently seeing two potential "misuses" of the common switc=
h:
>>>>>>>>
>>>>>>>>  - the posix skin (Gilles, how heavy-weighted are those checks?)=

>>>>>>>>    =3D> CONFIG_XENO_OPT_DEBUG_POSIX
>>>>>>>>
>>>>>>>>  - CONFIG_XENO_SPINLOCK_DEBUG =3D> CONFIG_XENO_OPT_DEBUG_SPINLOC=
K
>>>>>>>>
>>>>>>>> Both should be explicitly controllable in Kconfig.
>>>>>>>>
>>>>>>> Nack for CONFIG_XENO_OPT_DEBUG_SPINLOCK. Most of the issue we tra=
cked
>>>>>>> with Gilles regarding the domain migration code had side-effects =
on the
>>>>>>> nucleus lock. So having CONFIG_XENO_OPT_DEBUG enabled for identif=
ying
>>>>>>> internal state weirdnesses - like those triggered by migration bu=
gs -
>>>>>>> implies enabling the spinlock watchdogs too.
>>>>>> Ok, if it only makes sense to have both enabled at the same time, =
then
>>>>>> let us create XENO_OPT_DEBUG_NUCLEUS. It should include both, but =
it
>>>>>> shall not be automatically on when, say, only XENO_OPT_DEBUG_RTDM =
is
>>>>>> required.
>>>>> No objection.
>>>>>
>>>> Looking at the spinlock debugging code: it serves two inseparable
>>>> purposes, a watchdog for stuck locks + lock statistics. The latter m=
ake
>>>> this feature pop up when XENO_OPT_STATS are set on a SMP box - rathe=
r
>>>> surprising effect. Do we still need the stats? If not, I would kick =
them
>>>> out in favour of using the latency tracer for such analysis, making
>>>> spinlock debugging a real pure debug feature.
>>>>
>>> The spinlock stats are about uncovering a problem, the latency tracer=
 is
>>> about finding where the problem lies. Both are orthogonal.
>> Not fully true: the tracer provides the same information when you enab=
le
>> CONFIG_IPIPE_TRACE_IRQSOFF. When you disable CONFIG_IPIPE_TRACE_MCOUNT=
,
>> you even get this at comparable (if not lower) costs. I once played wi=
th
>> the spinlock debug code before decided to invest time into the tracer.=
 I
>> think I even posted a patch to enable that code on UP. But I didn't fi=
nd
>> the spinlock stats useful enough, even for the scenario "lock length
>> analysis".
>>
>> We basically have now two ways to get the same information (or please
>> explain what is missing with the tracer). Besides the redundancy, ther=
e
>> is the problem that one of this way comes in via two different,
>> orthogonal paths (STATS+SMP || DEBUG). That's not very consistent IMHO=
=2E
>>
>=20
> Nothing is missing in the tracer. The point is that you don't
> immediately know that you are having a spinlock issue which would make
> you build the tracer support, and having those stats is a cheap way to
> detect such problem in a lightweight manner.=20

If it were cheap, we wouldn't discuss it here. Actually, due to its
inline nature, this instrumentation is fairly costly. That's ok, as long
as you can explicitly ask for such a feature.

But now we have the situation that the (default y!) XENO_OPT_STAT
feature on UP is far more costly than on SMP. You know that the stats
are very useful already without any spinlock instrumentation, i.e. for
analysing the RT-system load. My feeling is that, for SMP, we currently
have a huge config mess here. And this is what I'm trying to address,
/maybe/ also by removing redundant instrumentation means.

> Running with the tracer
> enabled usually means that you are chasing an issue you have already
> detected.

Again, tracer !=3D mcount. It can be used just like that spinlock stats:
to *detect* long locking periods. Have a look.

Jan


--------------enig165E8E16A91F1C352A3A2F14
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFYZPiniDOoMHTA+kRAhytAJ9pamI2yemjPZ0nUC9e6cKCN4DLfACeMgnw
gqzPQjrD/kWDBZKx4yuQlEA=
=7/6d
-----END PGP SIGNATURE-----

--------------enig165E8E16A91F1C352A3A2F14--

