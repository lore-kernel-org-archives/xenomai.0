MIME-Version: 1.0
Date: Wed, 13 Jul 2011 11:29:26 +0200
Message-ID: <CAL+uwv_Zig=48i16KYbpT+iv2+am8gapSOebSDQ0oq2kAS7X_w@domain.hid>
From: suresh reddy <sureshreddy.balijepalli@domain.hid>
Content-Type: multipart/alternative; boundary=bcaec5016419799bc204a7f00dde
Subject: [Xenomai-help] regd compiling examples
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>

--bcaec5016419799bc204a7f00dde
Content-Type: text/plain; charset=ISO-8859-1

Dear all,

I have booted the pandaboard with xenomai .
Iam getting error as below when iam trying to compile the examples.

test06:/home/balijepalli/omap4/xenomai-2.5.6/examples# make
XENO=/home/balijepalli/omap4/root/usr/xenomai ARCH=arm
KSRC=/home/balijepalli/omap4/xenomai-2.5.6/ksrc
make[1]: Entering directory
`/home/balijepalli/omap4/xenomai-2.5.6/examples/rtdm/profiles/can'
make[1]: Nothing to be done for `all'.
make[1]: Leaving directory
`/home/balijepalli/omap4/xenomai-2.5.6/examples/rtdm/profiles/can'
make[1]: Entering directory
`/home/balijepalli/omap4/xenomai-2.5.6/examples/rtdm/profiles/serial'
make[1]: Nothing to be done for `all'.
make[1]: Leaving directory
`/home/balijepalli/omap4/xenomai-2.5.6/examples/rtdm/profiles/serial'
make[1]: Entering directory
`/home/balijepalli/omap4/xenomai-2.5.6/examples/rtdm/profiles/ipc'
make[1]: Nothing to be done for `all'.
make[1]: Leaving directory
`/home/balijepalli/omap4/xenomai-2.5.6/examples/rtdm/profiles/ipc'
--xeno-cflags is deprecated, use --skin=name --cflags instead
Makefile:18: /Rules.make: No such file or directory
make[1]: *** No rule to make target `/Rules.make'.  Stop.
make[1]: Entering directory
`/home/balijepalli/omap4/xenomai-2.5.6/examples/rtdm/driver-api'
arm-none-linux-gnueabi-gcc -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT
-Wall -pipe -D__XENO__
-I/home/balijepalli/omap4/xenomai-2.5.6/ksrc/include/xenomai
-I/home/balijepalli/omap4/xenomai-2.5.6/ksrc/include/xenomai/compat
-I/home/balijepalli/omap4/xenomai-2.5.6/ksrc/include/xenomai/posix   -c -o
heartbeat.o heartbeat.c
heartbeat.c:22:26: fatal error: linux/module.h: No such file or directory
compilation terminated.
make[1]: *** [heartbeat.o] Error 1
make[1]: Leaving directory
`/home/balijepalli/omap4/xenomai-2.5.6/examples/rtdm/driver-api'
make[1]: Entering directory
`/home/balijepalli/omap4/xenomai-2.5.6/examples/posix'
make[1]: Nothing to be done for `all'.
make[1]: Leaving directory
`/home/balijepalli/omap4/xenomai-2.5.6/examples/posix'
make[1]: Entering directory
`/home/balijepalli/omap4/xenomai-2.5.6/examples/native'
make[1]: Nothing to be done for `all'.
make[1]: Leaving directory
`/home/balijepalli/omap4/xenomai-2.5.6/examples/native'
make[1]: Entering directory
`/home/balijepalli/omap4/xenomai-2.5.6/examples/common'
make[1]: Nothing to be done for `all'.
make[1]: Leaving directory
`/home/balijepalli/omap4/xenomai-2.5.6/examples/common'





Thanks
Suresh balijepalli
Rosenehim,Baveria.

--bcaec5016419799bc204a7f00dde
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Dear all,<div><br></div><div>I have booted the pandaboard =
with xenomai .=A0</div><div>Iam getting error as below when iam trying to c=
ompile the examples.</div><div><br></div><div><div>test06:/home/balijepalli=
/omap4/xenomai-2.5.6/examples# make XENO=3D/home/balijepalli/omap4/root/usr=
/xenomai ARCH=3Darm KSRC=3D/home/balijepalli/omap4/xenomai-2.5.6/ksrc</div>
<div>make[1]: Entering directory `/home/balijepalli/omap4/xenomai-2.5.6/exa=
mples/rtdm/profiles/can&#39;</div><div>make[1]: Nothing to be done for `all=
&#39;.</div><div>make[1]: Leaving directory `/home/balijepalli/omap4/xenoma=
i-2.5.6/examples/rtdm/profiles/can&#39;</div>
<div>make[1]: Entering directory `/home/balijepalli/omap4/xenomai-2.5.6/exa=
mples/rtdm/profiles/serial&#39;</div><div>make[1]: Nothing to be done for `=
all&#39;.</div><div>make[1]: Leaving directory `/home/balijepalli/omap4/xen=
omai-2.5.6/examples/rtdm/profiles/serial&#39;</div>
<div>make[1]: Entering directory `/home/balijepalli/omap4/xenomai-2.5.6/exa=
mples/rtdm/profiles/ipc&#39;</div><div>make[1]: Nothing to be done for `all=
&#39;.</div><div>make[1]: Leaving directory `/home/balijepalli/omap4/xenoma=
i-2.5.6/examples/rtdm/profiles/ipc&#39;</div>
<div>--xeno-cflags is deprecated, use --skin=3Dname --cflags instead</div><=
div>Makefile:18: /Rules.make: No such file or directory</div><div>make[1]: =
*** No rule to make target `/Rules.make&#39;. =A0Stop.</div><div>make[1]: E=
ntering directory `/home/balijepalli/omap4/xenomai-2.5.6/examples/rtdm/driv=
er-api&#39;</div>
<div>arm-none-linux-gnueabi-gcc -I/usr/xenomai/include -D_GNU_SOURCE -D_REE=
NTRANT -Wall -pipe -D__XENO__ =A0 -I/home/balijepalli/omap4/xenomai-2.5.6/k=
src/include/xenomai -I/home/balijepalli/omap4/xenomai-2.5.6/ksrc/include/xe=
nomai/compat -I/home/balijepalli/omap4/xenomai-2.5.6/ksrc/include/xenomai/p=
osix =A0 -c -o heartbeat.o heartbeat.c</div>
<div>heartbeat.c:22:26: fatal error: linux/module.h: No such file or direct=
ory</div><div>compilation terminated.</div><div>make[1]: *** [heartbeat.o] =
Error 1</div><div>make[1]: Leaving directory `/home/balijepalli/omap4/xenom=
ai-2.5.6/examples/rtdm/driver-api&#39;</div>
<div>make[1]: Entering directory `/home/balijepalli/omap4/xenomai-2.5.6/exa=
mples/posix&#39;</div><div>make[1]: Nothing to be done for `all&#39;.</div>=
<div>make[1]: Leaving directory `/home/balijepalli/omap4/xenomai-2.5.6/exam=
ples/posix&#39;</div>
<div>make[1]: Entering directory `/home/balijepalli/omap4/xenomai-2.5.6/exa=
mples/native&#39;</div><div>make[1]: Nothing to be done for `all&#39;.</div=
><div>make[1]: Leaving directory `/home/balijepalli/omap4/xenomai-2.5.6/exa=
mples/native&#39;</div>
<div>make[1]: Entering directory `/home/balijepalli/omap4/xenomai-2.5.6/exa=
mples/common&#39;</div><div>make[1]: Nothing to be done for `all&#39;.</div=
><div>make[1]: Leaving directory `/home/balijepalli/omap4/xenomai-2.5.6/exa=
mples/common&#39;</div>
<div><br></div><div><br></div><div><br></div><br>=A0<br>Thanks<br>Suresh ba=
lijepalli<br>Rosenehim,Baveria.<br>
</div></div>

--bcaec5016419799bc204a7f00dde--

