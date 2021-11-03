Date: Wed, 3 Nov 2021 08:45:29 +0000 (UTC)
From: zared kamal <zaredkam@yahoo.fr>
Message-ID: <2092994816.180587.1635929129115@mail.yahoo.com>
Subject: cc1: error: code model kernel does not support PIC mode
MIME-Version: 1.0
References: <2092994816.180587.1635929129115.ref@mail.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

dear sir,sources:=20
xenomai 3.0.8
linux-4.1.18ipipe-4.1.18
i try to compile the kernel with command make && make moules_install instal=
lbut i get the error=20
[sudo] password for sicom3:=20
=C2=A0 CHK=C2=A0=C2=A0=C2=A0=C2=A0 include/config/kernel.release
=C2=A0 CHK=C2=A0=C2=A0=C2=A0=C2=A0 include/generated/uapi/linux/version.h
=C2=A0 CHK=C2=A0=C2=A0=C2=A0=C2=A0 include/generated/utsrelease.h
=C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel/bounds.s
cc1: error: code model kernel does not support PIC mode
Kbuild:43: recipe for target 'kernel/bounds.s' failed
make[1]: *** [kernel/bounds.s] Error 1
Makefile:990: recipe for target 'prepare0' failed
make: *** [prepare0] Error 2

many thanks for your helpbest regards
Zared Kamal
D=C3=A9partement de G=C3=A9nie Electrique,Laboratoire Signaux Syst=C3=A8mes=
 & Composants=C2=A0Facult=C3=A9 des Sciences & Techniques,=C2=A0BP 2202, 30=
000 F=C3=A8s=C2=A0=C2=A0 http://www.fstusmba.ac.ma/e-mail kamal.zared@usmba=
.ac.ma, zaredkam@yahoo.fr
