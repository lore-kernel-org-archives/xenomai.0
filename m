Message-ID: <46A3897A.6030703@domain.hid>
Date: Sun, 22 Jul 2007 18:44:42 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <469BF43D.1040704@domain.hid> <46973753.6010206@domain.hid>	
	<4694ED98.6000000@domain.hid>	<46937E70.10903@domain.hid>	<469345EB.6060302@domain.hid>	
	<22554361.1184054457326.JavaMail.ngmail@domain.hid>	
	<2026261.1184070574283.JavaMail.ngmail@domain.hid>	
	<1982070.1184078400928.JavaMail.ngmail@domain.hid>	<4693A702.1010604@domain.hid>	
	<913919.1184311634860.JavaMail.ngmail@domain.hid>	
	<21969019.1184569651818.JavaMail.ngmail@domain.hid>	
	<29054475.1184842736562.JavaMail.ngmail@domain.hid>	
	<469F4A98.3080307@domain.hid> <1184847549.28303.46.camel@domain.hid>	
	<469F5BA5.1030407@domain.hid> <1184858093.28303.85.camel@domain.hid>	
	<469F84B3.6070104@domain.hid> <1184861035.28303.108.camel@domain.hid>	
	<469F9CE2.9080603@domain.hid> <1184869450.28303.155.camel@domain.hid>	
	<469FC65E.7070508@domain.hid> <1184880955.28303.235.camel@domain.hid>	
	<46A0C4B6.5070706@domain.hid> <1185007792.5998.100.camel@domain.hid>
In-Reply-To: <1185007792.5998.100.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig37F5C998F958E5B1A0CE840C"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [Xenomai-help] Sporadic PC
	freeze	after	rt_task_start
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
Cc: mathias_koehrer@domain.hid, xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig37F5C998F958E5B1A0CE840C
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Fri, 2007-07-20 at 16:20 +0200, Jan Kiszka wrote:
>=20
>> OK, let's go through this another time, this time under the motto "get=

>> the locking right". As a start (and a help for myself), here comes an
>> overview of the scheme the final version may expose - as long as there=

>> are separate locks:
>>
>> gatekeeper_thread / xnshadow_relax:
>> 	rpilock, followed by nklock
>> 	(while xnshadow_relax puts both under irqsave...)
>>
>=20
> The relaxing thread must not be preempted in primary mode before it
> schedules out but after it has been linked to the RPI list, otherwise
> the root thread would benefit from a spurious priority boost. This said=
,
> in the UP case, we have no lock to contend for anyway, so the point of
> discussing whether we should have the rpilock or not is moot here.
>=20
>> xnshadow_unmap:
>> 	nklock, then rpilock nested
>>
>=20
> This one is the hardest to solve.
>=20
>> xnshadow_start:
>> 	rpilock, followed by nklock
>>
>> xnshadow_renice:
>> 	nklock, then rpilock nested
>>
>> schedule_event:
>> 	only rpilock
>>
>> setsched_event:
>> 	nklock, followed by rpilock, followed by nklock again
>>
>> And then there is xnshadow_rpi_check which has to be fixed to:
>> 	nklock, followed by rpilock (here was our lock-up bug)
>>
>=20
> rpilock -> nklock in fact.

Yes, meant it the other way around: The invocation of
xnpod_renice_root() must be moved out of nklock - which should be
trivial, correct?

> The last lockup was rather likely due to the
> gatekeeper's dangerous nesting of nklock -> rpilock -> nklock.

This path - as one of three with this ordering - surely triggered the
bug. But given the fact that the other two nestings of this kind are yet
unresolvable while our reversely ordered nesting in xnshadow_rpi_check
is, it is clear that the latter one is the weak point. So far we only
have a fix for Mathias' test case which stresses just a subset of all
rpilock paths appropriately.

>=20
>> That's a scheme which /should/ be safe. Unfortunately, I see no way to=

>> get rid of the remaining nestings.
>>
>=20
> There is one, which consists of getting rid of the rpilock entirely. Th=
e
> purpose of such lock is to protect the RPI list when fixing the
> situation after a task migration in secondary mode triggered from the
> Linux side. Addressing the latter issue differently may solve the
> problem more elegantly than figuring out how to combine the two locks,
> or hammering the hot path with the nklock. Will look at this.

Even the better! Looking forward.

Jan


--------------enig37F5C998F958E5B1A0CE840C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGo4l6niDOoMHTA+kRAkrOAJ9xJgM7cAjrQzQh1Gxr2wFpAKj9FgCfcNs+
F8Y0TyCXRKpcQO16pKNINT4=
=9xg+
-----END PGP SIGNATURE-----

--------------enig37F5C998F958E5B1A0CE840C--

