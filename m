Message-ID: <4422AE91.3060402@domain.hid>
Date: Thu, 23 Mar 2006 15:20:01 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Interrupt priorities
References: <20060323023533.70822.qmail@domain.hid>
In-Reply-To: <20060323023533.70822.qmail@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Cc: Xenomai-core <xenomai@xenomai.org>

Rodrigo Rosenfeld Rosas wrote:
> --- Philippe Gerum <rpm@xenomai.org> escreveu:
>=20
>>...=20
>>A way to pull the brake when some interrupt channel goes wild is to=20
>>activate Xenomai's NMI watchdog, which is never pipelined on any Adeos=20
>>implementation.
>=20
>=20
> Where can I find more information about this feature?
>=20

Machine menu from the Xenomai configuration panel, NMI watchdog feature.

>=20
>>This requires an APIC to be available on your x86 CPU=20
>>though.
>=20
>=20
> I need to verify that on college. My PC is a P4 1.7Ghz, Intel motherboa=
rd I guess.
>=20

Should be ok.

>=20
>>...=20
>>Having a reusable template would already be nice, and likely appreciate=
d=20
>>by the RTDM people too, since that's precious on hand information.
>=20
>=20
> Ok, I'll probably do that after finishing my master thesis, probably af=
ter June. Or if I got
> permission from Data Translation until there I could send the code as i=
t is... :) But as I'm not
> counting on this, we'll have to wait until I have time to reorganize th=
e code and remove the
> specific Data Translation code...
>=20
> Thanks for the explanations,
>=20
> Rodrigo.
>=20
>=20
> __________________________________________________
> Fa=E7a liga=E7=F5es para outros computadores com o novo Yahoo! Messenge=
r=20
> http://br.beta.messenger.yahoo.com/=20
>=20


--=20

Philippe.

