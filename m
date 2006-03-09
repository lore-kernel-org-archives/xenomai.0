Message-ID: <441028B3.5020001@domain.hid>
Date: Thu, 09 Mar 2006 14:08:03 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Xenomai as module changing bzImage
References: <200603081433.02339.lbocseg@domain.hid>
In-Reply-To: <200603081433.02339.lbocseg@domain.hid>
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
Cc: xenomai-core <xenomai@xenomai.org>

Rodrigo Rosenfeld Rosas wrote:
> Hi Philippe,
>=20
> I disabled the kernel .config support, recompiled the kernel with lates=
t ipipe=20
> patch and rebooted my system (Xenomai configured as a module).
>=20
> Then I downloaded last svn Xenomai. Compiled it (after correcting drvli=
b.c of=20
> rtdm skin) and noted that it has changed the kernel bzImage too, beside=
s=20
> building the modules. Although I can use the new Xenomai modules withou=
t=20
> rebooting my system, I can not understand why should bzImage change. Ha=
ve you=20
> any idea?

Some changes might impact arch-level headers the static portion of the HA=
L depends on.

>=20
> Thanks in advance,
>=20
> Rodrigo.
>=20
> 	=09
> _______________________________________________________
> Yahoo! Acesso Gr=E1tis - Internet r=E1pida e gr=E1tis. Instale o discad=
or agora!
> http://br.acesso.yahoo.com
>=20
>=20
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
>=20


--=20

Philippe.

