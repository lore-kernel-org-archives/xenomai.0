Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Subject: AW: AW: [Xenomai-help] prepare kernel fails
Date: Mon, 18 Dec 2006 15:33:14 +0100
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2A6F92E2@domain.hid>
From: <Roderik_Wildenburg@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: jan.kiszka@domain.hid
Cc: xenomai@xenomai.org

> > With 2.3-rc3 I get a new problem preparing the kernel :
> >=20
> > "Can't open perl script=20
> "/home/user/xenomai-2.3-rc3/scripts/help_from_kconfig.pl":=20
> Datei oder Verzeichnis nicht gefunden "
> >=20
> > Any suggestions how I can get around this ?
>=20
> Please copy that file from an SVN checkout for now.

This helped! I successfully prepared the kernel and "make menuconfig"
works again.

Thanks a lot !
Roderik

