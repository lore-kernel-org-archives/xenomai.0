Message-ID: <43F2FABE.7070305@domain.hid>
Date: Wed, 15 Feb 2006 10:56:14 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] separate queue debugging switch
References: <43F1C095.8030805@domain.hid>
	<43F2161D.9000906@domain.hid>	<43F219C9.2030903@domain.hid>
	<43F21F56.4080602@domain.hid>
In-Reply-To: <43F21F56.4080602@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6C28F14A0F8159FC7FE35CB0"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6C28F14A0F8159FC7FE35CB0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>
>>> Jan Kiszka wrote:
>>>
>>>> Hi,
>>>>
>>>> while XENO_OPT_DEBUG is generally a useful switch for tracing potent=
ial
>>>> issues in the core and the skins, it also introduces high latencies =
via
>>>> the queue debugging feature (due to checks iterating over whole
>>>> queues).
>>>>
>>>> This patch introduces separate control over queue debugging so that =
you
>>>> can have debug checks without too dramatic slowdowns.
>>>>
>>>
>>> Maybe it's time to introduce debug levels, so that we could reuse the=
m
>>> in order to
>>> add more (selectable) debug instrumentation; queue debugging could th=
en
>>> be given a
>>> certain level (likely something like CONFIG_XENO_DEBUG_LEVEL=3D8712 f=
or
>>> this one...), instead of going for a specific conditional each time w=
e
>>> introduce new checks?
>>>
>>
>>
>> Hmm, this means someone have to define what should be printed at which=

>> level - tend to be hard decisions... Often it is at least as much usef=
ul
>> to have debug groups so that specific parts can be excluded from
>> debugging. I'm pro such groups (one would be those queues e.g.) but
>> contra too many levels (2, at most 3).
>>
>=20
> Ack, selection by increasingly verbose/high-overhead groups is what I
> have in mind.
>=20
>> At this chance, I would also suggest to introduce some ASSERT macro (p=
er
>> group, per level). That could be used to instrument the core with
>> runtime checks. But it could also be quickly removed at compilation
>> time, reducing the code size (e.g. checks at the nucleus layer against=

>> buggy skins or at RTDM layer against rough drivers).
>>
>=20
> I'm not opposed to that, if we keep the noise / signal ratio of those
> assertions at the reasonable low-level throughout the code, and don't
> use this to enforce silly parametrical checks.
>=20

Then let's discuss how to implement and control this. Say we have some
macros for marking code as "depends on debug group X":

#if XENO_DEBUG_GROUP(group)
code;
#endif /* XENO_DEBUG_GROUP(group) */

XENO_IF_DEBUG_GROUP(group, code);

(or do you prefere XNPOD_xxx?)

Additionally, we could introduce that assertion macro:

XENO_ASSERT(group, expression, failure_code);

But how to control the groups now? Via Kconfig bool options? And what
groups to define? Per subsytem? Or per disturbance level (latency
regression)? If we control the group selection via Kconfig, we could
define pseudo bool options like "All debug groups" or "Low-intrusive
debug groups" that select the fitting concrete groups.

Alternatively, we could make the group selection a runtime switch,
controlled via a global bitmask that can be modified through /proc e.g.
Only switching of CONFIG_XENO_OPT_DEBUG would then remove all debugging
code, otherwise the execution of the checks would depend on the current
bitmask content.

Jan


--------------enig6C28F14A0F8159FC7FE35CB0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD8vq+niDOoMHTA+kRAsBVAJsGMZmmZYBHlqc1G7A2dtjYI8TVDQCfXrGK
o5HPJ6khKiBxd64dZh2Zl0c=
=fj0A
-----END PGP SIGNATURE-----

--------------enig6C28F14A0F8159FC7FE35CB0--

