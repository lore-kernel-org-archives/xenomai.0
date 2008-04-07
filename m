In-Reply-To: <2ff1a98a0804070626w486964a2kd56232bbeaddecaf@domain.hid>
MIME-Version: 1.0
From: Thomas Wiedemann <Thomas.Wiedemann@domain.hid>
Message-ID: <OF7021D846.5D25EAC0-ONC1257424.004A60DE-C1257424.004A9045@domain.hid>
Date: Mon, 7 Apr 2008 15:34:26 +0200
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-core] Antwort: Re: Re: posix-skin: unexpected scheduler
	behaviour
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

"Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org> schrieb am=20
07.04.2008 15:26:58:

> >  The thread remains in primary mode as long as you do not call a
> >  secondary mode service, such as pthread=5Fbarrier=5Fwait or fprintf.
>=20
> Besides, the correct syntax is:
> pthread=5Fset=5Fmode=5Fnp(0, PTHREAD=5FPRIMARY)

Ah, that was just a typo :)


Thanks for the clarification,

Thomas Wiedemann

Entwicklungsingenieur / Funktionsentwicklung (EF-F33), Fahrzeug Elektronik

IAV GmbH=20
Ingenieurgesellschaft Auto und Verkehr
Kauffahrtei 45
09120 Chemnitz
Germany

Telefon:   +49  (371) 2373-4045
Fax:          +49  (371) 2373-4112

Email: <mailto:thomas.wiedemann@domain.hid>
Internet: http://www.iav.de


IAV GmbH
Sitz/Registered Office: Berlin
Registergericht/Registration Court: Amtsgericht Charlottenburg
Registernummer/Company Registration Number: HRB 21 280
Gesch=E4ftsf=FChrer/Managing Directors: Kurt Blumenr=F6der, Michael Schubert

