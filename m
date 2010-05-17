MIME-Version: 1.0
Date: Mon, 17 May 2010 11:05:18 -0700
Message-ID: <AANLkTil1N6ULXXuv4nx5n_amHqE61tZNuSaw6ndLPdPL@mail.gmail.com>
From: Jeremy Brown <jhbrown@domain.hid>
Content-Type: multipart/alternative; boundary=0016361e81544db7740486ce11ec
Subject: [Xenomai-help] Error building userspace: "selected processor does
	not support `rsc r7, r7, #0'
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

--0016361e81544db7740486ce11ec
Content-Type: text/plain; charset=ISO-8859-1

Hello, all.  I'm trying to build Xenomai 2.5.3 userspace on a Beagleboard
(armel), but building timeconv.c is failing on an assembly error.  I would
appreciate any advice on how to solve it!
------
/bin/bash ../../../libtool --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I.
-I../../.\
./src/include  -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -march=armv7-a
-mfpu=vfp3 -m\
float-abi=softfp -D__XENO__ -D__IN_XENO__ -Wstrict-prototypes
-I../../../include    -M\
T libxenomai_la-timeconv.lo -MD -MP -MF .deps/libxenomai_la-timeconv.Tpo -c
-o libxeno\
mai_la-timeconv.lo `test -f 'timeconv.c' || echo './'`timeconv.c
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -I../../../src/include -O2
-D_GNU_SOURCE -D\
_REENTRANT -Wall -pipe -march=armv7-a -mfpu=vfp3 -mfloat-abi=softfp
-D__XENO__ -D__IN_\
XENO__ -Wstrict-prototypes -I../../../include -MT libxenomai_la-timeconv.lo
-MD -MP -M\
F .deps/libxenomai_la-timeconv.Tpo -c timeconv.c  -fPIC -DPIC -o
.libs/libxenomai_la-t\
imeconv.o
{standard input}: Assembler messages:
{standard input}:140: Error: selected processor does not support `rsc
r7,r7,#0'
{standard input}:159: Error: selected processor does not support `rsc
r1,r1,#0'
make: *** [libxenomai_la-timeconv.lo] Error 1
------

The OS is Ubuntu Lucid.  I'm using native tools, not cross-compilers,
directly on the Beagle.
$ uname -a
Linux beagleboard 2.6.32.11-l13 #1 PREEMPT Tue Apr 13 04:25:20 UTC 2010
armv7l GNU/Linux

Tools packages:
gcc 4:4.4.3-1ubuntu1
binutils 2.20.1-3ubuntu5

Xenomai configuration:
$ ./configure --prefix=/usr/local/xenomai --enable-arm-mach=omap3
--enable-arm-eabi --disable-arm-tsc

(I have tried this with and without the tsc disable.)

The running kernel is a vanilla linux 2.6.33 with the xenomai 2.5.3 patches
applied.

Thanks in advance for any and all help, suggestions, etc.

Jeremy

--0016361e81544db7740486ce11ec
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hello, all. =A0I&#39;m trying to build Xenomai 2.5.3 userspace on a Be=
agleboard (armel), but building timeconv.c is failing on an assembly error.=
 =A0I would appreciate any advice on how to solve it!</div><div>------</div=
>
<div><div>/bin/bash ../../../libtool --tag=3DCC =A0 --mode=3Dcompile gcc -D=
HAVE_CONFIG_H -I. -I../../.\</div><div>./src/include =A0-O2 -D_GNU_SOURCE -=
D_REENTRANT -Wall -pipe -march=3Darmv7-a -mfpu=3Dvfp3 -m\</div><div>float-a=
bi=3Dsoftfp -D__XENO__ -D__IN_XENO__ -Wstrict-prototypes -I../../../include=
 =A0 =A0-M\</div>
<div>T libxenomai_la-timeconv.lo -MD -MP -MF .deps/libxenomai_la-timeconv.T=
po -c -o libxeno\</div><div>mai_la-timeconv.lo `test -f &#39;timeconv.c&#39=
; || echo &#39;./&#39;`timeconv.c</div><div>libtool: compile: =A0gcc -DHAVE=
_CONFIG_H -I. -I../../../src/include -O2 -D_GNU_SOURCE -D\</div>
<div>_REENTRANT -Wall -pipe -march=3Darmv7-a -mfpu=3Dvfp3 -mfloat-abi=3Dsof=
tfp -D__XENO__ -D__IN_\</div><div>XENO__ -Wstrict-prototypes -I../../../inc=
lude -MT libxenomai_la-timeconv.lo -MD -MP -M\</div><div>F .deps/libxenomai=
_la-timeconv.Tpo -c timeconv.c =A0-fPIC -DPIC -o .libs/libxenomai_la-t\</di=
v>
<div>imeconv.o</div><div>{standard input}: Assembler messages:</div><div>{s=
tandard input}:140: Error: selected processor does not support `rsc r7,r7,#=
0&#39;</div><div>{standard input}:159: Error: selected processor does not s=
upport `rsc r1,r1,#0&#39;</div>
<div>make: *** [libxenomai_la-timeconv.lo] Error 1</div><div><div>------</d=
iv><div></div></div></div><div><br></div><div>The OS is Ubuntu Lucid. =A0I&=
#39;m using native tools, not cross-compilers, directly on the Beagle.=A0</=
div>
<div><div><div><div>$ uname -a</div><div>Linux beagleboard 2.6.32.11-l13 #1=
 PREEMPT Tue Apr 13 04:25:20 UTC 2010 armv7l GNU/Linux</div></div></div></d=
iv><div><br></div><div>Tools packages:</div><div>gcc 4:4.4.3-1ubuntu1</div>
<div>binutils 2.20.1-3ubuntu5</div><div><br></div><div>Xenomai configuratio=
n:</div><div><div>$ ./configure --prefix=3D/usr/local/xenomai --enable-arm-=
mach=3Domap3 --enable-arm-eabi --disable-arm-tsc</div><div><br></div><div>(=
I have tried this with and without the tsc disable.)</div>
<div><br></div></div><div>The running kernel is a vanilla linux 2.6.33 with=
 the xenomai 2.5.3 patches applied.</div><div><br></div><div>Thanks in adva=
nce for any and all help, suggestions, etc.</div><div><br></div><div>Jeremy=
</div>
<div>=A0</div>

--0016361e81544db7740486ce11ec--

