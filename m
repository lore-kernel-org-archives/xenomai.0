MIME-Version: 1.0
Date: Wed, 11 Mar 2009 23:47:43 +0100
Message-ID: <f48df4840903111547x2d92c434u1e403f86a5d4159f@domain.hid>
From: Bruno Rouchouse <brouchouse@domain.hid>
Content-Type: multipart/alternative; boundary=0016e644de5ed75c920464dfa7b2
Subject: [Xenomai-help] [Xenosim-2.4.7] libelf configure problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Xenomai-help@domain.hid" <xenomai@xenomai.org>

--0016e644de5ed75c920464dfa7b2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi list,

I'm trying to compile xenosim-2.4.7 on my Ubuntu-8.10 with the following
host configuration:
- autoconf 2.61
- automake 1.10.1
- gcc-4.3.2

My configure line is shown below:
../xenomai-2.4.7/xenosim-2.4.7/configure
--prefix=/home/bruno/xenosim_install/
--with-gcc-tarball=/tmp/gcc-2.95.3.tar.gz --x-includes=/usr/include/X11
--x-libraries=/usr/lib32/ CFLAGS=-m32

Please find below the config.log excerpt:
[...]
checking for sys/time.h... yes
checking elf.h usability... yes
checking elf.h presence... yes
checking for elf.h... yes
checking libelf.h usability... no
checking libelf.h presence... yes
configure: WARNING: libelf.h: present but cannot be compiled
configure: WARNING: libelf.h:     check for missing prerequisite headers?
configure: WARNING: libelf.h: see the Autoconf documentation
configure: WARNING: libelf.h:     section "Present But Cannot Be Compiled"
configure: WARNING: libelf.h: proceeding with the preprocessor's result
configure: WARNING: libelf.h: in the future, the compiler will take
precedence
configure: WARNING:     ## ----------------------------------- ##
configure: WARNING:     ## Report this to xenomai@xenomai.org ##
configure: WARNING:     ## ----------------------------------- ##
checking for libelf.h... yes
checking libelf/libelf.h usability... no
checking libelf/libelf.h presence... no
checking for libelf/libelf.h... no
checking for uid_t in sys/types.h... yes
[...]

Ignoring the WARNING of course won't work at compile time ;)
gcc -DHAVE_CONFIG_H -I. -I../../xenomai-2.4.7/xenosim-2.4.7/vmutils
-I../include -D__XENO_SIM__ -I../../xenomai-2.4.7/xenosim-2.4.7/vmutils/..
-O2 -MT libmvmutils_la-elf.lo -MD -MP -MF .deps/libmvmutils_la-elf.Tpo -c
../../xenomai-2.4.7/xenosim-2.4.7/vmutils/elf.c  -fPIC -DPIC -o
.libs/libmvmutils_la-elf.o
In file included from ../../xenomai-2.4.7/xenosim-2.4.7/vmutils/elf.c:42:
/usr/include/libelf.h:98: error: expected specifier-qualifier-list before
'off64_t'
/usr/include/libelf.h:160: error: expected specifier-qualifier-list before
'off64_t'
/usr/include/libelf.h:201: error: expected '=', ',', ';', 'asm' or
'__attribute__' before 'elf_update'
/usr/include/libelf.h:207: error: expected '=', ',', ';', 'asm' or
'__attribute__' before 'elf_getbase'
/usr/include/libelf.h:305: error: expected declaration specifiers or '...'
before 'off64_t'
/usr/include/libelf.h:317: error: expected '=', ',', ';', 'asm' or
'__attribute__' before 'elf_getaroff'
make[1]: *** [libmvmutils_la-elf.lo] Error 1
make[1]: Leaving directory `/home/bruno/xenosim_build/vmutils'
make: *** [all-recursive] Error 1

Autoconf documentation gives some explanation of that but I haven't been
able to fix it so far.
http://www.gnu.org/software/hello/manual/autoconf/Present-But-Cannot-Be-Compiled.html

If you went through that already and have a workaround, I'm interested.

Thanks.

--Bruno

--0016e644de5ed75c920464dfa7b2
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi list,<br><br>I&#39;m trying to compile xenosim-2.4.7 on my Ubuntu-8.10 w=
ith the following host configuration:<br>- autoconf 2.61<br>- automake 1.10=
.1<br>- gcc-4.3.2<br><br>My configure line is shown below:<br>../xenomai-2.=
4.7/xenosim-2.4.7/configure --prefix=3D/home/bruno/xenosim_install/ --with-=
gcc-tarball=3D/tmp/gcc-2.95.3.tar.gz --x-includes=3D/usr/include/X11 --x-li=
braries=3D/usr/lib32/ CFLAGS=3D-m32<br>
<br>Please find below the config.log excerpt:<br>[...]<br>checking for sys/=
time.h... yes<br>checking elf.h usability... yes<br>checking elf.h presence=
... yes<br>checking for elf.h... yes<br>checking libelf.h usability... no<b=
r>
checking libelf.h presence... yes<br>configure: WARNING: libelf.h: present =
but cannot be compiled<br>configure: WARNING: libelf.h:=A0=A0=A0=A0 check f=
or missing prerequisite headers?<br>configure: WARNING: libelf.h: see the A=
utoconf documentation<br>
configure: WARNING: libelf.h:=A0=A0=A0=A0 section &quot;Present But Cannot =
Be Compiled&quot;<br>configure: WARNING: libelf.h: proceeding with the prep=
rocessor&#39;s result<br>configure: WARNING: libelf.h: in the future, the c=
ompiler will take precedence<br>
configure: WARNING:=A0=A0=A0=A0 ## ----------------------------------- ##<b=
r>configure: WARNING:=A0=A0=A0=A0 ## Report this to <a href=3D"mailto:xenom=
ai-help@domain.hid">xenomai@xenomai.org</a> ##<br>configure: WARNING:=A0=A0=
=A0=A0 ## ----------------------------------- ##<br>
checking for libelf.h... yes<br>checking libelf/libelf.h usability... no<br=
>checking libelf/libelf.h presence... no<br>checking for libelf/libelf.h...=
 no<br>checking for uid_t in sys/types.h... yes<br>[...]<br><br>Ignoring th=
e WARNING of course won&#39;t work at compile time ;)<br>
gcc -DHAVE_CONFIG_H -I. -I../../xenomai-2.4.7/xenosim-2.4.7/vmutils -I../in=
clude -D__XENO_SIM__ -I../../xenomai-2.4.7/xenosim-2.4.7/vmutils/.. -O2 -MT=
 libmvmutils_la-elf.lo -MD -MP -MF .deps/libmvmutils_la-elf.Tpo -c ../../xe=
nomai-2.4.7/xenosim-2.4.7/vmutils/elf.c=A0 -fPIC -DPIC -o .libs/libmvmutils=
_la-elf.o<br>
In file included from ../../xenomai-2.4.7/xenosim-2.4.7/vmutils/elf.c:42:<b=
r>/usr/include/libelf.h:98: error: expected specifier-qualifier-list before=
 &#39;off64_t&#39;<br>/usr/include/libelf.h:160: error: expected specifier-=
qualifier-list before &#39;off64_t&#39;<br>
/usr/include/libelf.h:201: error: expected &#39;=3D&#39;, &#39;,&#39;, &#39=
;;&#39;, &#39;asm&#39; or &#39;__attribute__&#39; before &#39;elf_update&#3=
9;<br>/usr/include/libelf.h:207: error: expected &#39;=3D&#39;, &#39;,&#39;=
, &#39;;&#39;, &#39;asm&#39; or &#39;__attribute__&#39; before &#39;elf_get=
base&#39;<br>
/usr/include/libelf.h:305: error: expected declaration specifiers or &#39;.=
..&#39; before &#39;off64_t&#39;<br>/usr/include/libelf.h:317: error: expec=
ted &#39;=3D&#39;, &#39;,&#39;, &#39;;&#39;, &#39;asm&#39; or &#39;__attrib=
ute__&#39; before &#39;elf_getaroff&#39;<br>
make[1]: *** [libmvmutils_la-elf.lo] Error 1<br>make[1]: Leaving directory =
`/home/bruno/xenosim_build/vmutils&#39;<br>make: *** [all-recursive] Error =
1<br><br>Autoconf documentation gives some explanation of that but I haven&=
#39;t been able to fix it so far.<br>
<a href=3D"http://www.gnu.org/software/hello/manual/autoconf/Present-But-Ca=
nnot-Be-Compiled.html">http://www.gnu.org/software/hello/manual/autoconf/Pr=
esent-But-Cannot-Be-Compiled.html</a><br><br>If you went through that alrea=
dy and have a workaround, I&#39;m interested.<br>
<br>Thanks.<br><br>--Bruno<br>

--0016e644de5ed75c920464dfa7b2--

