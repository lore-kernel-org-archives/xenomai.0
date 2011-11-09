MIME-Version: 1.0
In-Reply-To: <CAEhuWcW0RS=r-U1W3Ciyw7Wmpvdp3A4GBJzvxa_qV7xmyNPgDw@domain.hid>
References: <CAEhuWcW0RS=r-U1W3Ciyw7Wmpvdp3A4GBJzvxa_qV7xmyNPgDw@domain.hid>
Date: Wed, 9 Nov 2011 22:07:44 +0800
Message-ID: <CAEhuWcWJ39Zqk-BvUT0ix5qxVRa-K=bSmJS=7CVVORMEFf4DYg@domain.hid>
From: xinxin wei <weixinxin63@domain.hid>
Content-Type: multipart/alternative; boundary=20cf307f3296de547304b14dcfad
Subject: [Xenomai-help] Fwd: problem in installing xenomai on arm
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--20cf307f3296de547304b14dcfad
Content-Type: text/plain; charset=ISO-8859-1

---------- Forwarded message ----------
From: xinxin wei <weixinxin63@domain.hid>
Date: 2011/11/9
Subject: problem in installing xenomai on arm
To: gilles.chanteperdrix@xenomai.org


now i have a new  problem
i compile xenomai-2.6.0 for arm

cross compile toolchain is arm-none-linux-gnueabi-gcc   and

./configure CC="arm-none-linux-gnueabi-gcc"    --build=i686-pc-linux-gnu
--host=arm-none-linux-gnueabi  --enable-arm-mach=omap4430 --enable-arm-tsc

but the result is

configure: WARNING: unrecognized options: --enable-arm-mach
checking build system type... i686-pc-linux-gnu
checking host system type... arm-none-linux-gnueabi
checking for a BSD-compatible install... /usr/bin/install -c
checking for arm-none-linux-gnueabi-gcc... arm-none-linux-gnueabi-gcc
checking whether the C compiler works... no
configure: error: in `/root/xenomai-2.6.0':
configure: error: C compiler cannot create executables
See `config.log' for more details


and  i change the  configure


./configure     --build=i686-pc-linux-gnu  --host=arm-linux
--enable-arm-mach=omap4430

it can  configure  successfull
but  when  i make  install

make DESTDIR=/opt/nfs/angstrom_minimal-fs/usr/xenomai  install


the  result is  error:

In file included from ../../../src/include/asm/xenomai/atomic.h:26,
                 from ../../../include/nucleus/system.h:26,
                 from ../../../src/include/asm/xenomai/system.h:247,
                 from ../../../include/nucleus/types.h:36,
                 from ../../../include/nucleus/thread.h:25,
                 from assert_context.c:24:
../../../src/include/asm/xenomai/features.h:73:2: error: #error "Could not
find current ARM architecture"


who can resolve  this problem  ?

--20cf307f3296de547304b14dcfad
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">---------- Forwarded message ----------<=
br>From: <b class=3D"gmail_sendername">xinxin wei</b> <span dir=3D"ltr">&lt=
;<a href=3D"mailto:weixinxin63@domain.hid">weixinxin63@domain.hid</a>&gt;</sp=
an><br>
Date: 2011/11/9<br>Subject: problem in installing xenomai on arm<br>To: <a =
href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org=
ai.org</a><br><br><br><span style=3D"font-family:arial, sans-serif;font-siz=
e:13px;background-color:rgb(255, 255, 255)">now i have a new =A0problem<div=
>
<span style=3D"font-family:arial, sans-serif;font-size:13px;background-colo=
r:rgb(255, 255, 255)">i compile xenomai-2.6.0 for arm<br>
<br>cross compile toolchain is arm-none-linux-gnueabi-gcc=A0=A0 and=A0<br><=
br>./configure CC=3D&quot;arm-none-linux-gnueabi-gcc&quot;=A0=A0=A0 --build=
=3Di686-pc-linux-gnu=A0 --host=3Darm-none-linux-gnueabi=A0 --enable-arm-mac=
h=3Domap4430 --enable-arm-tsc<br>

<br>but the result is=A0=A0<br><br>configure: WARNING: unrecognized options=
: --enable-arm-mach<br>checking build system type... i686-pc-linux-gnu<br>c=
hecking host system type... arm-none-linux-gnueabi<br>checking for a BSD-co=
mpatible install... /usr/bin/install -c<br>

checking for arm-none-linux-gnueabi-gcc... arm-none-linux-gnueabi-gcc<br>ch=
ecking whether the C compiler works... no<br>configure: error: in `/root/xe=
nomai-2.6.0&#39;:<br>configure: error: C compiler cannot create executables=
<br>

See `config.log&#39; for more details<br><br><br>and=A0 i change the=A0 con=
figure=A0=A0=A0<br><br><br>./configure=A0=A0=A0=A0 --build=3Di686-pc-linux-=
gnu=A0 --host=3Darm-linux=A0 --enable-arm-mach=3Domap4430<br><br>it can=A0 =
configure=A0 successfull<br>

but=A0 when=A0 i make=A0 install<br><br>make DESTDIR=3D/opt/nfs/angstrom_mi=
nimal-fs/usr/xenomai=A0 install<br>=A0=A0<br><br>the=A0 result is=A0 error:=
<br><br>In file included from ../../../src/include/asm/xenomai/atomic.h:26,=
<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 from ../../../include/=
nucleus/system.h:26,<br>

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 from ../../../src/include/=
asm/xenomai/system.h:247,<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 from ../../../include/nucleus/types.h:36,<br>=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 from ../../../include/nucleus/thread.h:25,<br>=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 from assert_context.c:24:<br>

../../../src/include/asm/xenomai/features.h:73:2: error: #error &quot;Could=
 not find current ARM architecture&quot;<br><br><br>who can resolve=A0 this=
 problem=A0 ?</span></div></span>
</div><br>

--20cf307f3296de547304b14dcfad--

