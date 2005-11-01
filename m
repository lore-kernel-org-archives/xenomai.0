Message-ID: <43675780.1050100@domain.hid>
Date: Tue, 01 Nov 2005 12:54:40 +0100
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [RFC] support for sharing IRQs
References: <OF52EBEF44.18C1609B-ONC12570AB.004913D2-C12570AB.004F9693@domain.hid>
	<4367543F.9050700@domain.hid>
In-Reply-To: <4367543F.9050700@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig05530AAF51EC03B89B1999DE"
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
--------------enig05530AAF51EC03B89B1999DE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Dmitry Adamushko wrote:
>>
>> Hi Jan,
>>
>>  >
>>  > I have some code hanging around here which implements IRQ sharing a=
t
>>  > skin level for an experimental in-house development over Xenomai. T=
he
>>  > code is smart enough to register an IRQ sharing trampoline handler
>> only
>>  > in case sharing is actually practiced for a specific line.
>>
>> Could you be a bit more specific on what is meant by "...sharing is
>> actually practiced for a specific line"?
>>
>> To my knowledge, the matter is only about whether a certain device
>> (driver) permits the earlier obtained irq line to be shared with other=

>> devices.
>> i.e. a driver [1] may succeed with an irq registration request in case=

>> another driver [2] already holds this line but both [1] and [2] have
>> specified a SA_SHIRQ flag.
>>
>>
>>  > I think it would be possible to break this out and generate a mainl=
ine
>>  > patch. Anyway, the question for me is where to put this best, at sk=
in
>>  > (RTDM?) or at nucleus level? Both is technically feasible, but
>> which way
>>  > is desired? (I would vote for the nucleus...)
>>
>> If we have a policy that all the drivers should be implemented on top
>> of RTDM, then, it can be done there. If no (and I guess so), this
>> feature should be common and I'd vote for the nucleus.
>=20
> Actually, now that we have a decent driver model built in, I will
> enforce the rule that all Xenomai mainline drivers must be based on
> RTDM, because we do need such a common platform to prevent braindamage
> calling interfaces hysteria. This will be a good opportunity to see how=

> flexible the thing is when confronted to the needs of various hw and
> semantics.
>=20

So far the rtdm_irq_xxx API consists of pure static inlines. If we
decide to move IRQ sharing support only into that layer, it would
materialise into real code and another trampoline. So, I still vote for
a generic support at nucleus level. :)

Jan




--------------enig05530AAF51EC03B89B1999DE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDZ1eAncNeS9Q0k+IRAlolAJ0aR31IfCZLO6AjnAGlmLalv8idHACfbhW1
yfxsaWYMkqCWz6INCJIumoY=
=XXYz
-----END PGP SIGNATURE-----

--------------enig05530AAF51EC03B89B1999DE--

