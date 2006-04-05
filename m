Message-ID: <44343D99.1060900@domain.hid>
Date: Wed, 05 Apr 2006 23:58:49 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <200604041623.47796.lbocseg@domain.hid>
In-Reply-To: <200604041623.47796.lbocseg@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-core] Re: Manual interrupt handling by cli/sti instructions
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
Cc: xenomai-core <xenomai@xenomai.org>

Rodrigo Rosenfeld Rosas wrote:
> Hi Philippe,
>=20
> Actually I think it is an Adeos issue, but it is also relevant for Xeno=
mai.
>=20
> Does Adeos have any protection (I do not know if it is even possible to=
)=20
> against a Linux module issuing a cli/sti code directly through arch spe=
cific=20
> code instead of through some Linux API. Putting it in other way, is it=20
> possible that a third-party module breaks out the determinism in the Xe=
nomai=20
> domain?

Yes, we cannot do much about misbehaving binary-only module or code=20
which does not use the kernel API to control the interrupt mask at CPU=20
level.

A way to deal with this on x86 would be to move the kernel code to a=20
different protection ring than #0, so that using protected insns like=20
cli/sti would beget an exception (provided no one fiddles with the iopl=20
though), and route the hw masking/unmasking requests to the virtualized=20
Adeos pipeline stall/unstall ops instead. Obviously, an awful lot of=20
other issues would be raised by such move, such as dealing with other=20
protected insns/accesses, and beyond that, all the mess people doing=20
full O/S virtualization have to deal with on a daily basis.

Another way would be to play the "afterburing" game I guess, searching=20
for cli/sti opcodes in the kernel/driver image and poking replacement=20
code to do the same virtualization stuff, but the original opcodes are=20
only 1-byte long, so some additional trickery would likely be needed,=20
along with other issues the afterburning technique raises (e.g. you=20
don't want to replace _all_ hw interrupt masking/unmasking in the image=20
blindly).

>=20
> Thanks in advance,
>=20
> Rodrigo.
>=20
> 	=09
> _______________________________________________________=20
> Novo Yahoo! Messenger com voz: Instale agora e fa=E7a liga=E7=F5es de g=
ra=E7a.=20
> http://br.messenger.yahoo.com/
>=20


--=20

Philippe.

