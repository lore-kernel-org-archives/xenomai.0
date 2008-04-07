In-Reply-To: <2ff1a98a0804070547w1695b78dp2a3ed1ce87595855@domain.hid>
MIME-Version: 1.0
From: Thomas Wiedemann <Thomas.Wiedemann@domain.hid>
Message-ID: <OF6D5F47BF.2D764233-ONC1257424.0047BBF6-C1257424.00482F9C@retarus.de>
Date: Mon, 7 Apr 2008 15:08:28 +0200
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-core] Antwort: Re: posix-skin: unexpected scheduler
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
07.04.2008 14:47:05:

> Forget it, it will not work. What you are trying to do can not work as
> long as Xenomai and Linux are two distinct schedulers: Xenomai tasks
> running in secondary mode are suspended from Xenomai scheduler point
> of view, so, you can yield as much as you want, this will never let
> them run.

But the behaviour is still the same, when i put a

         pthread=5Fset=5Fmode=5Fnp(PTHREAD=5FPRIMARY, 0);=20

in the thread function. Thereafter, only the xenomai-scheduler is=20
responsible for the threads running in primary mode, or am i completely=20
wrong?


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
=20

