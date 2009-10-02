MIME-Version: 1.0
Sender: lcasassa@domain.hid
In-Reply-To: <47a3101a0910011923t7a002c9av7f7df5c666f0cf1@domain.hid>
References: <47a3101a0910011923t7a002c9av7f7df5c666f0cf1@domain.hid>
From: Linus Casassa <linus@domain.hid>
Date: Fri, 2 Oct 2009 08:54:39 -0400
Message-ID: <47a3101a0910020554n39297325x72cd9b7adde9ab9f@domain.hid>
Content-Type: multipart/alternative; boundary=000e0cd22bc0851bfc0474f345f2
Subject: [Xenomai-help] Fwd: Xenomai 2.4.9.1
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--000e0cd22bc0851bfc0474f345f2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi.

I am installing xenomai on a Gumstix Verdex pro (Marvell PXA270 with
XScale). I am fowling this wiki:
http://www.gumstix.net/wiki/index.php?title=3DXenomai_-_Mini_Howto

It compiles fine and works fine.
But it would be nice to have at least 2.4.8 because it hangs when doing the
xeno-test on the latency part. I read that it is an overflow bug already
fixed.
So now I am trying to update to xenomai 2.4.9.1 and I'm getting this error:

(bitbake xenomai)

| Making all in rtdk
| make[2]: Entering directory
`/home/linus/gumstix/gumstix-oe/tmp/work/armv5te-angstrom-linux-gnueabi/xen=
omai-2.4.8-r0/xenomai-2.4.8/src/rtdk'
| if /bin/sh ../../libtool --tag=3DCC --mode=3Dcompile
arm-angstrom-linux-gnueabi-gcc -march=3Darmv5te -mtune=3Dxscale -DHAVE_CONF=
IG_H
-I. -I. -I../../src/include  -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe
-march=3Darmv5 -D__XENO__ -D__IN_XENO__ -Wstrict-prototypes -I../../include
-isystem/home/linus/gumstix/gumstix-oe/tmp/staging/arm-angstrom-linux-gnuea=
bi/include
-isystem/home/linus/gumstix/gumstix-oe/tmp/staging/arm-angstrom-linux-gnuea=
bi/include
-fexpensive-optimizations -fomit-frame-pointer -frename-registers -Os -MT
librtdk_la-init.lo -MD -MP -MF ".deps/librtdk_la-init.Tpo" -c -o
librtdk_la-init.lo `test -f 'init.c' || echo './'`init.c; \
|     then mv -f ".deps/librtdk_la-init.Tpo" ".deps/librtdk_la-init.Plo";
else rm -f ".deps/librtdk_la-init.Tpo"; exit 1; fi
| ../../libtool: line 761: X--tag=3DCC: command not found
| ../../libtool: line 794: libtool: ignoring unknown tag : command not foun=
d
| ../../libtool: line 761: X--mode=3Dcompile: command not found
| ../../libtool: line 911: *** Warning: inferring the mode of operation is
deprecated.: command not found
| ../../libtool: line 912: *** Future versions of Libtool will require
-mode=3DMODE be specified.: command not found
| ../../libtool: line 1055: Xarm-angstrom-linux-gnueabi-gcc: command not
found
| ../../libtool: line 1055: X-march=3Darmv5te: command not found
| ../../libtool: line 1055: X-mtune=3Dxscale: command not found
| ../../libtool: line 1055: X-DHAVE_CONFIG_H: command not found
| ../../libtool: line 1055: X-I.: command not found
| ../../libtool: line 1055: X-I.: command not found
| ../../libtool: line 1055: X-I../../src/include: No such file or directory
| ../../libtool: line 1055: X-O2: command not found
| ../../libtool: line 1055: X-D_GNU_SOURCE: command not found
| ../../libtool: line 1055: X-D_REENTRANT: command not found
| ../../libtool: line 1055: X-Wall: command not found
| ../../libtool: line 1055: X-pipe: command not found
| ../../libtool: line 1055: X-march=3Darmv5: command not found
| ../../libtool: line 1055: X-D__XENO__: command not found
| ../../libtool: line 1055: X-D__IN_XENO__: command not found
| ../../libtool: line 1055: X-Wstrict-prototypes: command not found
| ../../libtool: line 1055: X-I../../include: No such file or directory
| ../../libtool: line 1055:
X-isystem/home/linus/gumstix/gumstix-oe/tmp/staging/arm-angstrom-linux-gnue=
abi/include:
No such file or directory
| ../../libtool: line 1055:
X-isystem/home/linus/gumstix/gumstix-oe/tmp/staging/arm-angstrom-linux-gnue=
abi/include:
No such file or directory
| ../../libtool: line 1055: X-fexpensive-optimizations: command not found
| ../../libtool: line 1055: X-fomit-frame-pointer: command not found
| ../../libtool: line 1055: X-frename-registers: command not found
| ../../libtool: line 1055: X-Os: command not found
| ../../libtool: line 1055: X-MT: command not found
| ../../libtool: line 1055: Xlibrtdk_la-init.lo: command not found
| ../../libtool: line 1055: X-MD: command not found
| ../../libtool: line 1055: X-MP: command not found
| ../../libtool: line 1055: X-MF: command not found
| ../../libtool: line 1055: X.deps/librtdk_la-init.Tpo: No such file or
directory
| ../../libtool: line 1055: X-c: command not found
| ../../libtool: line 1103: Xlibrtdk_la-init.lo: command not found
| ../../libtool: line 1108: libtool: compile: cannot determine name of
library object from `': command not found
| make[2]: *** [librtdk_la-init.lo] Error 1
| make[2]: Leaving directory
`/home/linus/gumstix/gumstix-oe/tmp/work/armv5te-angstrom-linux-gnueabi/xen=
omai-2.4.8-r0/xenomai-2.4.8/src/rtdk'
| make[1]: *** [all-recursive] Error 1
| make[1]: Leaving directory
`/home/linus/gumstix/gumstix-oe/tmp/work/armv5te-angstrom-linux-gnueabi/xen=
omai-2.4.8-r0/xenomai-2.4.8/src'
| make: *** [all-recursive] Error 1
| FATAL: oe_runmake failed

Same error with versions 2.4.9 and 2.4.8.

Thanks in advance.

--=20
Linus Casassa
Estudiante Ingenier=EDa Civil Electr=F3nica
Fono: 56-9-97776941



--=20
Linus Casassa
Estudiante Ingenier=EDa Civil Electr=F3nica
Fono: 56-9-97776941

--000e0cd22bc0851bfc0474f345f2
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">Hi.<br><br>I am installing xenomai on a Gumstix =
Verdex pro (Marvell PXA270 with XScale). I am fowling this wiki:<br><a href=
=3D"http://www.gumstix.net/wiki/index.php?title=3DXenomai_-_Mini_Howto" tar=
get=3D"_blank">http://www.gumstix.net/wiki/index.php?title=3DXenomai_-_Mini=
_Howto</a><br>

<br>It compiles fine and works fine.<br>But it would be nice to have at lea=
st 2.4.8 because it hangs when doing the xeno-test on the latency part. I r=
ead that it is an overflow bug already fixed.<br>So now I am trying to upda=
te to xenomai 2.4.9.1 and I&#39;m getting this error:<br>


<br>(bitbake xenomai)<br><br>| Making all in rtdk<br>| make[2]: Entering di=
rectory `/home/linus/gumstix/gumstix-oe/tmp/work/armv5te-angstrom-linux-gnu=
eabi/xenomai-2.4.8-r0/xenomai-2.4.8/src/rtdk&#39;<br>| if /bin/sh ../../lib=
tool --tag=3DCC --mode=3Dcompile arm-angstrom-linux-gnueabi-gcc -march=3Dar=
mv5te -mtune=3Dxscale -DHAVE_CONFIG_H -I. -I. -I../../src/include=A0 -O2 -D=
_GNU_SOURCE -D_REENTRANT -Wall -pipe -march=3Darmv5 -D__XENO__ -D__IN_XENO_=
_ -Wstrict-prototypes -I../../include -isystem/home/linus/gumstix/gumstix-o=
e/tmp/staging/arm-angstrom-linux-gnueabi/include=A0 -isystem/home/linus/gum=
stix/gumstix-oe/tmp/staging/arm-angstrom-linux-gnueabi/include -fexpensive-=
optimizations -fomit-frame-pointer -frename-registers -Os -MT librtdk_la-in=
it.lo -MD -MP -MF &quot;.deps/librtdk_la-init.Tpo&quot; -c -o librtdk_la-in=
it.lo `test -f &#39;init.c&#39; || echo &#39;./&#39;`init.c; \<br>


| =A0=A0=A0 then mv -f &quot;.deps/librtdk_la-init.Tpo&quot; &quot;.deps/li=
brtdk_la-init.Plo&quot;; else rm -f &quot;.deps/librtdk_la-init.Tpo&quot;; =
exit 1; fi<br>| ../../libtool: line 761: X--tag=3DCC: command not found<br>=
| ../../libtool: line 794: libtool: ignoring unknown tag : command not foun=
d<br>


| ../../libtool: line 761: X--mode=3Dcompile: command not found<br>| ../../=
libtool: line 911: *** Warning: inferring the mode of operation is deprecat=
ed.: command not found<br>| ../../libtool: line 912: *** Future versions of=
 Libtool will require -mode=3DMODE be specified.: command not found<br>


| ../../libtool: line 1055: Xarm-angstrom-linux-gnueabi-gcc: command not fo=
und<br>| ../../libtool: line 1055: X-march=3Darmv5te: command not found<br>=
| ../../libtool: line 1055: X-mtune=3Dxscale: command not found<br>| ../../=
libtool: line 1055: X-DHAVE_CONFIG_H: command not found<br>


| ../../libtool: line 1055: X-I.: command not found<br>| ../../libtool: lin=
e 1055: X-I.: command not found<br>| ../../libtool: line 1055: X-I../../src=
/include: No such file or directory<br>| ../../libtool: line 1055: X-O2: co=
mmand not found<br>


| ../../libtool: line 1055: X-D_GNU_SOURCE: command not found<br>| ../../li=
btool: line 1055: X-D_REENTRANT: command not found<br>| ../../libtool: line=
 1055: X-Wall: command not found<br>| ../../libtool: line 1055: X-pipe: com=
mand not found<br>


| ../../libtool: line 1055: X-march=3Darmv5: command not found<br>| ../../l=
ibtool: line 1055: X-D__XENO__: command not found<br>| ../../libtool: line =
1055: X-D__IN_XENO__: command not found<br>| ../../libtool: line 1055: X-Ws=
trict-prototypes: command not found<br>


| ../../libtool: line 1055: X-I../../include: No such file or directory<br>=
| ../../libtool: line 1055: X-isystem/home/linus/gumstix/gumstix-oe/tmp/sta=
ging/arm-angstrom-linux-gnueabi/include: No such file or directory<br>

| ../../libtool: line 1055: X-isystem/home/linus/gumstix/gumstix-oe/tmp/sta=
ging/arm-angstrom-linux-gnueabi/include: No such file or directory<br>
| ../../libtool: line 1055: X-fexpensive-optimizations: command not found<b=
r>| ../../libtool: line 1055: X-fomit-frame-pointer: command not found<br>|=
 ../../libtool: line 1055: X-frename-registers: command not found<br>| ../.=
./libtool: line 1055: X-Os: command not found<br>


| ../../libtool: line 1055: X-MT: command not found<br>| ../../libtool: lin=
e 1055: Xlibrtdk_la-init.lo: command not found<br>| ../../libtool: line 105=
5: X-MD: command not found<br>| ../../libtool: line 1055: X-MP: command not=
 found<br>


| ../../libtool: line 1055: X-MF: command not found<br>| ../../libtool: lin=
e 1055: X.deps/librtdk_la-init.Tpo: No such file or directory<br>| ../../li=
btool: line 1055: X-c: command not found<br>| ../../libtool: line 1103: Xli=
brtdk_la-init.lo: command not found<br>


| ../../libtool: line 1108: libtool: compile: cannot determine name of libr=
ary object from `&#39;: command not found<br>| make[2]: *** [librtdk_la-ini=
t.lo] Error 1<br>| make[2]: Leaving directory `/home/linus/gumstix/gumstix-=
oe/tmp/work/armv5te-angstrom-linux-gnueabi/xenomai-2.4.8-r0/xenomai-2.4.8/s=
rc/rtdk&#39;<br>


| make[1]: *** [all-recursive] Error 1<br>| make[1]: Leaving directory `/ho=
me/linus/gumstix/gumstix-oe/tmp/work/armv5te-angstrom-linux-gnueabi/xenomai=
-2.4.8-r0/xenomai-2.4.8/src&#39;<br>| make: *** [all-recursive] Error 1<br>


| FATAL: oe_runmake failed<br><br clear=3D"all">Same error with versions 2.=
4.9 and 2.4.8.<br><br>Thanks in advance.<br><font color=3D"#888888"><br>
-- <br>Linus Casassa<br>Estudiante Ingenier=EDa Civil Electr=F3nica<br>Fono=
: 56-9-97776941<br>
</font></div><br><br clear=3D"all"><br>-- <br>Linus Casassa<br>Estudiante I=
ngenier=EDa Civil Electr=F3nica<br>Fono: 56-9-97776941<br>

--000e0cd22bc0851bfc0474f345f2--

