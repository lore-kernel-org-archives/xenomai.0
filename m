From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Date: Tue, 4 Apr 2006 16:23:47 -0300
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200604041623.47796.lbocseg@domain.hid>
Subject: [Xenomai-core] Manual interrupt handling by cli/sti instructions
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>, xenomai-core <xenomai@xenomai.org>

Hi Philippe,

Actually I think it is an Adeos issue, but it is also relevant for Xenomai.

Does Adeos have any protection (I do not know if it is even possible to)=20
against a Linux module issuing a cli/sti code directly through arch specifi=
c=20
code instead of through some Linux API. Putting it in other way, is it=20
possible that a third-party module breaks out the determinism in the Xenoma=
i=20
domain?

Thanks in advance,

Rodrigo.

	=09
_______________________________________________________=20
Novo Yahoo! Messenger com voz: Instale agora e fa=E7a liga=E7=F5es de gra=
=E7a.=20
http://br.messenger.yahoo.com/


