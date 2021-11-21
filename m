Date: Sun, 21 Nov 2021 11:58:33 +0000 (UTC)
From: zared kamal <zaredkam@yahoo.fr>
Message-ID: <397361391.4928176.1637495913018@mail.yahoo.com>
Subject: error: Building the x86 libraries (32/64bit)
MIME-Version: 1.0
References: <397361391.4928176.1637495913018.ref@mail.yahoo.com>
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
To: Philippe Gerum via Xenomai <xenomai@xenomai.org>

Dear sir,I try to build libraries for Xenomai kernel 3.1 installtion.
configuartion:linux kernel 4.9.90xenomai 3.1

with command:=20
sicom3@sicom3-VirtualBox:/usr/src/xenomai-3.1$ ./configure --with-core=3Dco=
balt --enable-smp --enable-pshared=C2=A0 --host=3Di686-linux CFLAGS=3D"-m32=
 -O2" LDFLAGS=3D"-m32"

i have a message error:checking whether we build for Cobalt or Mercury core=
... cobalt
checking build system type... x86_64-pc-linux-gnu
checking host system type... i686-pc-linux-gnu
checking for a BSD-compatible install... /usr/bin/install -c
checking for i686-linux-gcc... no
checking for gcc... gcc
checking whether the C compiler works... no
configure: error: in `/usr/src/xenomai-3.1':
configure: error: C compiler cannot create executables
See `config.log' for more details
can help me please.
many thanks
best regards

Zared Kamal
D=C3=A9partement de G=C3=A9nie Electrique,Laboratoire Signaux Syst=C3=A8mes=
 & Composants=C2=A0Facult=C3=A9 des Sciences & Techniques,=C2=A0BP 2202, 30=
000 F=C3=A8s=C2=A0=C2=A0 http://www.fstusmba.ac.ma/e-mail kamal.zared@usmba=
.ac.ma, zaredkam@yahoo.fr
