From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Date: Wed, 8 Mar 2006 14:33:02 -0300
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200603081433.02339.lbocseg@domain.hid>
Subject: [Xenomai-core] Xenomai as module changing bzImage
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Hi Philippe,

I disabled the kernel .config support, recompiled the kernel with latest ip=
ipe=20
patch and rebooted my system (Xenomai configured as a module).

Then I downloaded last svn Xenomai. Compiled it (after correcting drvlib.c =
of=20
rtdm skin) and noted that it has changed the kernel bzImage too, besides=20
building the modules. Although I can use the new Xenomai modules without=20
rebooting my system, I can not understand why should bzImage change. Have y=
ou=20
any idea?

Thanks in advance,

Rodrigo.

	=09
_______________________________________________________
Yahoo! Acesso Gr=E1tis - Internet r=E1pida e gr=E1tis. Instale o discador a=
gora!
http://br.acesso.yahoo.com


