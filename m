Message-ID: <1317667467.43274.YahooMailNeo@domain.hid>
Date: Tue, 4 Oct 2011 00:14:27 +0530 (IST)
From: Alex Martin <alex.martin92@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] xenomai 2.6.0-rc4 build debian
Reply-To: Alex Martin <alex.martin92@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

=0A=0AI am getting following error while compiling xenomai-2.6.0-rc4=0A=0Au=
sing debuild -uc -us=0A=0Aa. xeno-config.1 no such file=0Ab. Also path not =
correct. debian/libxenomai-dev//usr/share/man/man1/=A0=A0 '//usr/'=0A=0A=0A=
Couple of other places also '//usr/share/'=A0 double '//' is appearing.=0A=
=0A=0Adh_install --sourcedir=3D/home/alex/Dev/xenomai-2.6.0-rc4/debian/tmp=
=0Acp: cannot stat `debian/tmp/usr/share/man/man1/xeno-config.1': No such f=
ile or directory=0Adh_install: cp -a debian/tmp/usr/share/man/man1/xeno-con=
fig.1 debian/libxenomai-dev//usr/share/man/man1/ returned exit code 1=0Amak=
e: *** [install] Error 2=0Adpkg-buildpackage: error: fakeroot debian/rules =
binary gave error exit status 2=0Adebuild: fatal error at line 1340:=0A=0A=
=0AAlex.

