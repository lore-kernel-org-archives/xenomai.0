Message-ID: <48E4E3E9.3020907@domain.hid>
Date: Thu, 02 Oct 2008 15:08:25 +0000
From: Malek <souf_oued@domain.hid>
MIME-Version: 1.0
References: <48E4A6C3.3080508@domain.hid> <48E4B927.6010706@domain.hid>
	<48E4D3A6.5010401@domain.hid> <48E4D6E2.1030309@domain.hid>
In-Reply-To: <48E4D6E2.1030309@domain.hid>
Content-Type: multipart/mixed; boundary="------------040209060401070907080507"
Subject: Re: [Xenomai-help] cross-compiling
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------040209060401070907080507
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix a =E9crit :
> Malek wrote:
>>    $ ./configure --target=3Di686-linux --host=3Di686-linux --build=3Di=
386-pc-linux-gnu=20
>> --prefix=3D/usr --exec-prefix=3D/usr --sysconfdir=3D/etc --prefix=3D/u=
sr/xenomai=20
>> --disable-smp --disable-x86-sep --enable-x86-tsc
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> (...)
>> The architecture of the host is x86 under (cross)uClibc (0.9.29), (cro=
ss)GCC: 4.2.4,
>> (cross)binutils 2.18.50.0.1, Xenomai 2.4.5.
>=20
> So, you are compiling on x86 for x86 ? You are not cross-compiling then=
.
Possible !!!
>=20
> If your host is x86_64 and you are compiling for x86_32, you should pas=
s
> the -m32 option to gcc.
>=20
My host is x86_32 (Fedora 9) also but I do not use gcc that comes with Fe=
dora,
I used Buildroot(http://buildroot.uclibc.org) to produce an isolated comp=
ilation=20
environment for another x86_32, it looks like LFS (Linux From Scratch).

> Now, line 98 in shm.c is a syscall macro invocation, so there should be
> no reason that it works for other skin and does not work for the posix =
skin.
>=20
> Please show us a non truncated error message, and if possible the resul=
t
> of pre-processing shm.c.
>=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
/bin/sh ../../../libtool --tag=3DCC   --mode=3Dcompile=20
/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin/i686=
-linux-uclibc-gcc=20
-Os  -I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/i=
nclude=20
-I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/include=20
--sysroot=3D/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/=
=20
-isysroot /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir=20
-mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFILE_SOURCE -D_LARGEFILE6=
4_SOURCE=20
-D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -I. -I../../../src/include  -O2=20
-D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fstrict-aliasing -Wno-strict-alia=
sing=20
-D__XENO__ -D__IN_XENO__ -Wstrict-prototypes -I../../../include=20
-I../../../include/posix    -MT libpthread_rt_la-mutex.lo -MD -MP -MF=20
.deps/libpthread_rt_la-mutex.Tpo -c -o libpthread_rt_la-mutex.lo `test -f=
=20
'mutex.c' || echo './'`mutex.c
=20
/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin/i686=
-linux-uclibc-gcc=20
-Os -I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/in=
clude=20
-I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/include=20
--sysroot=3D/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/=
=20
-isysroot /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir=20
-mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFILE_SOURCE -D_LARGEFILE6=
4_SOURCE=20
-D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -I. -I../../../src/include -O2=20
-D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fstrict-aliasing -Wno-strict-alia=
sing=20
-D__XENO__ -D__IN_XENO__ -Wstrict-prototypes -I../../../include=20
-I../../../include/posix -MT libpthread_rt_la-mutex.lo -MD -MP -MF=20
.deps/libpthread_rt_la-mutex.Tpo -c mutex.c  -fPIC -DPIC -o=20
.libs/libpthread_rt_la-mutex.o
=20
/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin/i686=
-linux-uclibc-gcc=20
-Os -I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/in=
clude=20
-I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/include=20
--sysroot=3D/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/=
=20
-isysroot /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir=20
-mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFILE_SOURCE -D_LARGEFILE6=
4_SOURCE=20
-D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -I. -I../../../src/include -O2=20
-D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fstrict-aliasing -Wno-strict-alia=
sing=20
-D__XENO__ -D__IN_XENO__ -Wstrict-prototypes -I../../../include=20
-I../../../include/posix -MT libpthread_rt_la-mutex.lo -MD -MP -MF=20
.deps/libpthread_rt_la-mutex.Tpo -c mutex.c -o libpthread_rt_la-mutex.o=20
 >/dev/null 2>&1
mv -f .deps/libpthread_rt_la-mutex.Tpo .deps/libpthread_rt_la-mutex.Plo
/bin/sh ../../../libtool --tag=3DCC   --mode=3Dcompile=20
/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin/i686=
-linux-uclibc-gcc=20
-Os  -I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/i=
nclude=20
-I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/include=20
--sysroot=3D/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/=
=20
-isysroot /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir=20
-mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFILE_SOURCE -D_LARGEFILE6=
4_SOURCE=20
-D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -I. -I../../../src/include  -O2=20
-D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fstrict-aliasing -Wno-strict-alia=
sing=20
-D__XENO__ -D__IN_XENO__ -Wstrict-prototypes -I../../../include=20
-I../../../include/posix    -MT libpthread_rt_la-shm.lo -MD -MP -MF=20
.deps/libpthread_rt_la-shm.Tpo -c -o libpthread_rt_la-shm.lo `test -f 'sh=
m.c' ||=20
echo './'`shm.c
=20
/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin/i686=
-linux-uclibc-gcc=20
-Os -I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/in=
clude=20
-I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/include=20
--sysroot=3D/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/=
=20
-isysroot /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir=20
-mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFILE_SOURCE -D_LARGEFILE6=
4_SOURCE=20
-D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -I. -I../../../src/include -O2=20
-D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fstrict-aliasing -Wno-strict-alia=
sing=20
-D__XENO__ -D__IN_XENO__ -Wstrict-prototypes -I../../../include=20
-I../../../include/posix -MT libpthread_rt_la-shm.lo -MD -MP -MF=20
.deps/libpthread_rt_la-shm.Tpo -c shm.c  -fPIC -DPIC -o .libs/libpthread_=
rt_la-shm.o
shm.c: In function '__wrap_mmap':
shm.c:98: error: impossible register constraint in 'asm'
shm.c:98: error: impossible register constraint in 'asm'
shm.c:98: error: impossible register constraint in 'asm'
make[4]: *** [libpthread_rt_la-shm.lo] Erreur 1
make[4]: quittant le r=E9pertoire =AB=20
/home/malek/minisys/xenomai/buildroot/build_i686/xenomai-2.4.5/src/skins/=
posix =BB
make[3]: *** [all-recursive] Erreur 1
make[3]: quittant le r=E9pertoire =AB=20
/home/malek/minisys/xenomai/buildroot/build_i686/xenomai-2.4.5/src/skins =
=BB
make[2]: *** [all-recursive] Erreur 1
make[2]: quittant le r=E9pertoire =AB=20
/home/malek/minisys/xenomai/buildroot/build_i686/xenomai-2.4.5/src =BB
make[1]: *** [all-recursive] Erreur 1
make[1]: quittant le r=E9pertoire =AB=20
/home/malek/minisys/xenomai/buildroot/build_i686/xenomai-2.4.5 =BB
make: ***=20
[/home/malek/minisys/xenomai/buildroot/build_i686/xenomai-2.4.5/.stamp_bu=
ilt]=20
Erreur 2
[malek@domain.hid buildroot]$
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D




--------------040209060401070907080507
Content-Type: text/plain;
 name="xenomai.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="xenomai.log"

>>> xenomai 2.4.5 Configuring                        =20
cd /home/malek/minisys/xenomai/buildroot/build_i686/xenomai-2.4.5/ && rm =
-f config.cache && \
        PATH=3D"/home/malek/minisys/xenomai/buildroot/toolchain_build_i68=
6/bin:/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/bin:/h=
ome/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin:/usr/l=
ib/qt4/bin:/usr/lib/qt-3.3/bin:/usr/kerberos/bin:/usr/lib/ccache:/usr/loc=
al/bin:/usr/bin:/bin:/home/malek/bin" AR=3D"/home/malek/minisys/xenomai/b=
uildroot/build_i686/staging_dir/usr/bin/i686-linux-uclibc-ar" AS=3D"/home=
/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin/i686-linu=
x-uclibc-as" LD=3D"/home/malek/minisys/xenomai/buildroot/build_i686/stagi=
ng_dir/usr/bin/i686-linux-uclibc-ld -L/home/malek/minisys/xenomai/buildro=
ot/build_i686/staging_dir/lib -L/home/malek/minisys/xenomai/buildroot/bui=
ld_i686/staging_dir/usr/lib --sysroot=3D/home/malek/minisys/xenomai/build=
root/build_i686/staging_dir/" NM=3D"/home/malek/minisys/xenomai/buildroot=
/build_i686/staging_dir/usr/bin/i686-linux-uclibc-nm" CC=3D"/home/malek/m=
inisys/xenomai/buildroot/build_i686/staging_dir/usr/bin/i686-linux-uclibc=
-gcc -Os  -I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/=
usr/include -I/home/malek/minisys/xenomai/buildroot/build_i686/staging_di=
r/include --sysroot=3D/home/malek/minisys/xenomai/buildroot/build_i686/st=
aging_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/build_i686/sta=
ging_dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFILE_SOURCE -D_L=
ARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64" GCC=3D"/home/malek/minisys/xe=
nomai/buildroot/build_i686/staging_dir/usr/bin/i686-linux-uclibc-gcc -Os =
 -I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/inclu=
de -I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/include=
 --sysroot=3D/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir=
/ -isysroot /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir =
-mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFILE_SOURCE -D_LARGEFILE6=
4_SOURCE -D_FILE_OFFSET_BITS=3D64" CPP=3D"/home/malek/minisys/xenomai/bui=
ldroot/build_i686/staging_dir/usr/bin/i686-linux-uclibc-cpp -Os  -I/home/=
malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/include -I/hom=
e/malek/minisys/xenomai/buildroot/build_i686/staging_dir/include --sysroo=
t=3D/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/ -isysro=
ot /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir -mtune=3D=
pentiumpro -march=3Dpentiumpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE =
-D_FILE_OFFSET_BITS=3D64" CXX=3D"/home/malek/minisys/xenomai/buildroot/bu=
ild_i686/staging_dir/usr/bin/i686-linux-uclibc-g++ -Os  -I/home/malek/min=
isys/xenomai/buildroot/build_i686/staging_dir/usr/include -I/home/malek/m=
inisys/xenomai/buildroot/build_i686/staging_dir/include --sysroot=3D/home=
/malek/minisys/xenomai/buildroot/build_i686/staging_dir/ -isysroot /home/=
malek/minisys/xenomai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpr=
o -march=3Dpentiumpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_O=
FFSET_BITS=3D64" FC=3D"/home/malek/minisys/xenomai/buildroot/build_i686/s=
taging_dir/usr/bin/i686-linux-uclibc-gfortran " RANLIB=3D"/home/malek/min=
isys/xenomai/buildroot/build_i686/staging_dir/usr/bin/i686-linux-uclibc-r=
anlib" STRIP=3D"/home/malek/minisys/xenomai/buildroot/build_i686/staging_=
dir/usr/bin/i686-linux-uclibc-strip" OBJCOPY=3D"/home/malek/minisys/xenom=
ai/buildroot/build_i686/staging_dir/usr/bin/i686-linux-uclibc-objcopy" AR=
_FOR_BUILD=3D"/usr/bin/ar" AS_FOR_BUILD=3D"/usr/bin/as" CC_FOR_BUILD=3D"/=
usr/lib/ccache/gcc" GCC_FOR_BUILD=3D"/usr/lib/ccache/gcc" CXX_FOR_BUILD=3D=
"/usr/lib/ccache/g++" FC_FOR_BUILD=3D"/usr/bin/ld" LD_FOR_BUILD=3D"/usr/b=
in/ld" CFLAGS_FOR_BUILD=3D"" CXXFLAGS_FOR_BUILD=3D"" LDFLAGS_FOR_BUILD=3D=
"" FCFLAGS_FOR_BUILD=3D"" AR_FOR_TARGET=3D"/home/malek/minisys/xenomai/bu=
ildroot/build_i686/staging_dir/usr/bin/i686-linux-uclibc-ar" AS_FOR_TARGE=
T=3D"/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin=
/i686-linux-uclibc-as" CC_FOR_TARGET=3D"/home/malek/minisys/xenomai/build=
root/build_i686/staging_dir/usr/bin/i686-linux-uclibc-gcc" LD_FOR_TARGET=3D=
"/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin/i68=
6-linux-uclibc-ld" NM_FOR_TARGET=3D"/home/malek/minisys/xenomai/buildroot=
/build_i686/staging_dir/usr/bin/i686-linux-uclibc-nm" DEFAULT_ASSEMBLER=3D=
"/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin/i68=
6-linux-uclibc-as" DEFAULT_LINKER=3D"/home/malek/minisys/xenomai/buildroo=
t/build_i686/staging_dir/usr/bin/i686-linux-uclibc-ld" PKG_CONFIG_SYSROOT=
_DIR=3D"/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir" PKG=
_CONFIG=3D"/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/u=
sr/bin/pkg-config" PKG_CONFIG_PATH=3D"/home/malek/minisys/xenomai/buildro=
ot/build_i686/staging_dir/usr/lib/pkgconfig:" STAGING_DIR=3D"/home/malek/=
minisys/xenomai/buildroot/build_i686/staging_dir" \                      =
                     =20
        ac_cv_lbl_unaligned_fail=3Dno ac_cv_func_mmap_fixed_mapped=3Dyes =
ac_cv_func_memcmp_working=3Dyes ac_cv_c_bigendian=3Dno \                 =
                                                                         =
                         =20
         \                                                               =
                                                                         =
                                                                         =
                 =20
                ./configure \                                            =
                                                                         =
                                                                         =
                 =20
                --target=3Di686-linux \                                  =
                                                                         =
                                                                         =
                   =20
                --host=3Di686-linux \                                    =
                                                                         =
                                                                         =
                   =20
                --build=3Di386-pc-linux-gnu \                            =
                                                                         =
                                                                         =
                   =20
                --prefix=3D/usr \                                        =
                                                                         =
                                                                         =
                   =20
                --exec-prefix=3D/usr \                                   =
                                                                         =
                                                                         =
                   =20
                --sysconfdir=3D/etc \                                    =
                                                                         =
                                                                         =
                   =20
                 \                                                       =
                                                                         =
                                                                         =
                 =20
                --prefix=3D/usr/xenomai --program-transform-name=3D'' --d=
isable-smp --disable-x86-sep --enable-x86-tsc                            =
                                                                         =
                     =20
checking build system type... i386-pc-linux-gnu                          =
                                                                         =
                                                                         =
                 =20
checking host system type... i686-pc-linux-gnu                           =
                                                                         =
                                                                         =
                 =20
checking for a BSD-compatible install... /usr/bin/install -c             =
                                                                         =
                                                                         =
                 =20
checking for i686-linux-gcc... /home/malek/minisys/xenomai/buildroot/buil=
d_i686/staging_dir/usr/bin/i686-linux-uclibc-gcc -Os  -I/home/malek/minis=
ys/xenomai/buildroot/build_i686/staging_dir/usr/include -I/home/malek/min=
isys/xenomai/buildroot/build_i686/staging_dir/include --sysroot=3D/home/m=
alek/minisys/xenomai/buildroot/build_i686/staging_dir/ -isysroot /home/ma=
lek/minisys/xenomai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro =
-march=3Dpentiumpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFF=
SET_BITS=3D64                                                            =
                                                                         =
                                                             =20
checking for C compiler default output file name... a.out                =
                                                                         =
                                                                         =
                 =20
checking whether the C compiler works... yes                             =
                                                                         =
                                                                         =
                 =20
checking whether we are cross compiling... yes                           =
                                                                         =
                                                                         =
                 =20
checking for suffix of executables...                                    =
                                                                         =
                                                                         =
                 =20
checking for suffix of object files... o                                 =
                                                                         =
                                                                         =
                 =20
checking whether we are using the GNU C compiler... yes                  =
                                                                         =
                                                                         =
                 =20
checking whether /home/malek/minisys/xenomai/buildroot/build_i686/staging=
_dir/usr/bin/i686-linux-uclibc-gcc -Os  -I/home/malek/minisys/xenomai/bui=
ldroot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/b=
uildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/x=
enomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xe=
nomai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpenti=
umpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 =
accepts -g... yes                                                        =
                                                                         =
                                                             =20
checking for /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir=
/usr/bin/i686-linux-uclibc-gcc -Os  -I/home/malek/minisys/xenomai/buildro=
ot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/build=
root/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/xenom=
ai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xenoma=
i/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpr=
o -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 opti=
on to accept ISO C89... none needed                                      =
                                                                         =
                                                             =20
checking how to run the C preprocessor... /home/malek/minisys/xenomai/bui=
ldroot/build_i686/staging_dir/usr/bin/i686-linux-uclibc-cpp -Os  -I/home/=
malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/include -I/hom=
e/malek/minisys/xenomai/buildroot/build_i686/staging_dir/include --sysroo=
t=3D/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/ -isysro=
ot /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir -mtune=3D=
pentiumpro -march=3Dpentiumpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE =
-D_FILE_OFFSET_BITS=3D64                                                 =
                                                                         =
                                                             =20
checking target system type... i686-pc-linux-gnu                         =
                                                                         =
                                                                         =
                 =20
checking for i686-linux-gcc... /usr/lib/ccache/gcc                       =
                                                                         =
                                                                         =
                 =20
checking whether we are using the GNU C compiler... (cached) yes         =
                                                                         =
                                                                         =
                 =20
checking whether /usr/lib/ccache/gcc accepts -g... no                    =
                                                                         =
                                                                         =
                 =20
checking for /usr/lib/ccache/gcc option to accept ISO C89... (cached) non=
e needed                                                                 =
                                                                         =
                 =20
checking how to run the C preprocessor... /usr/lib/ccache/gcc -E         =
                                                                         =
                                                                         =
                 =20
checking whether build environment is sane... yes                        =
                                                                         =
                                                                         =
                 =20
checking for a thread-safe mkdir -p... /bin/mkdir -p                     =
                                                                         =
                                                                         =
                 =20
checking for gawk... gawk                                                =
                                                                         =
                                                                         =
                 =20
checking whether make sets $(MAKE)... yes                                =
                                                                         =
                                                                         =
                 =20
checking for style of include used by make... GNU                        =
                                                                         =
                                                                         =
                 =20
checking for i686-linux-strip... /home/malek/minisys/xenomai/buildroot/bu=
ild_i686/staging_dir/usr/bin/i686-linux-uclibc-strip                     =
                                                                         =
                 =20
checking dependency style of /home/malek/minisys/xenomai/buildroot/build_=
i686/staging_dir/usr/bin/i686-linux-uclibc-gcc -Os  -I/home/malek/minisys=
/xenomai/buildroot/build_i686/staging_dir/usr/include -I/home/malek/minis=
ys/xenomai/buildroot/build_i686/staging_dir/include --sysroot=3D/home/mal=
ek/minisys/xenomai/buildroot/build_i686/staging_dir/ -isysroot /home/male=
k/minisys/xenomai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -m=
arch=3Dpentiumpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSE=
T_BITS=3D64... gcc3                                                      =
                                                                         =
                                                             =20
checking whether to enable maintainer-specific portions of Makefiles... n=
o                                                                        =
                                                                         =
                 =20
checking for a sed that does not truncate output... /home/malek/minisys/x=
enomai/buildroot/toolchain_build_i686/bin/sed                            =
                                                                         =
                 =20
checking for grep that handles long lines and -e... /bin/grep            =
                                                                         =
                                                                         =
                 =20
checking for egrep... /bin/grep -E                                       =
                                                                         =
                                                                         =
                 =20
checking for ld used by /home/malek/minisys/xenomai/buildroot/build_i686/=
staging_dir/usr/bin/i686-linux-uclibc-gcc -Os  -I/home/malek/minisys/xeno=
mai/buildroot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xe=
nomai/buildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/mi=
nisys/xenomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/min=
isys/xenomai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3D=
pentiumpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D=
64... /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bi=
n/i686-linux-uclibc-ld -L/home/malek/minisys/xenomai/buildroot/build_i686=
/staging_dir/lib -L/home/malek/minisys/xenomai/buildroot/build_i686/stagi=
ng_dir/usr/lib --sysroot=3D/home/malek/minisys/xenomai/buildroot/build_i6=
86/staging_dir/                                                          =
                                                                         =
    =20
checking if the linker (/home/malek/minisys/xenomai/buildroot/build_i686/=
staging_dir/usr/bin/i686-linux-uclibc-ld -L/home/malek/minisys/xenomai/bu=
ildroot/build_i686/staging_dir/lib -L/home/malek/minisys/xenomai/buildroo=
t/build_i686/staging_dir/usr/lib --sysroot=3D/home/malek/minisys/xenomai/=
buildroot/build_i686/staging_dir/) is GNU ld... yes                      =
                                                                         =
                                     =20
checking for /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir=
/usr/bin/i686-linux-uclibc-ld -L/home/malek/minisys/xenomai/buildroot/bui=
ld_i686/staging_dir/lib -L/home/malek/minisys/xenomai/buildroot/build_i68=
6/staging_dir/usr/lib --sysroot=3D/home/malek/minisys/xenomai/buildroot/b=
uild_i686/staging_dir/ option to reload object files... -r               =
                                                                         =
                                     =20
checking for BSD-compatible nm... /home/malek/minisys/xenomai/buildroot/b=
uild_i686/staging_dir/usr/bin/i686-linux-uclibc-nm                       =
                                                                         =
                 =20
checking whether ln -s works... yes                                      =
                                                                         =
                                                                         =
                 =20
checking how to recognize dependent libraries... pass_all                =
                                                                         =
                                                                         =
                 =20
checking for ANSI C header files... yes                                  =
                                                                         =
                                                                         =
                 =20
checking for sys/types.h... yes                                          =
                                                                         =
                                                                         =
                 =20
checking for sys/stat.h... yes                                           =
                                                                         =
                                                                         =
                 =20
checking for stdlib.h... yes                                             =
                                                                         =
                                                                         =
                 =20
checking for string.h... yes                                             =
                                                                         =
                                                                         =
                 =20
checking for memory.h... yes                                             =
                                                                         =
                                                                         =
                 =20
checking for strings.h... yes                                            =
                                                                         =
                                                                         =
                 =20
checking for inttypes.h... yes                                           =
                                                                         =
                                                                         =
                 =20
checking for stdint.h... yes                                             =
                                                                         =
                                                                         =
                 =20
checking for unistd.h... yes                                             =
                                                                         =
                                                                         =
                 =20
checking dlfcn.h usability... yes                                        =
                                                                         =
                                                                         =
                 =20
checking dlfcn.h presence... yes                                         =
                                                                         =
                                                                         =
                 =20
checking for dlfcn.h... yes                                              =
                                                                         =
                                                                         =
                 =20
checking whether we are using the GNU C++ compiler... yes                =
                                                                         =
                                                                         =
                 =20
checking whether /home/malek/minisys/xenomai/buildroot/build_i686/staging=
_dir/usr/bin/i686-linux-uclibc-g++ -Os  -I/home/malek/minisys/xenomai/bui=
ldroot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/b=
uildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/x=
enomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xe=
nomai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpenti=
umpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 =
accepts -g... yes                                                        =
                                                                         =
                                                             =20
checking dependency style of /home/malek/minisys/xenomai/buildroot/build_=
i686/staging_dir/usr/bin/i686-linux-uclibc-g++ -Os  -I/home/malek/minisys=
/xenomai/buildroot/build_i686/staging_dir/usr/include -I/home/malek/minis=
ys/xenomai/buildroot/build_i686/staging_dir/include --sysroot=3D/home/mal=
ek/minisys/xenomai/buildroot/build_i686/staging_dir/ -isysroot /home/male=
k/minisys/xenomai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -m=
arch=3Dpentiumpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSE=
T_BITS=3D64... gcc3                                                      =
                                                                         =
                                                             =20
checking how to run the C++ preprocessor... /home/malek/minisys/xenomai/b=
uildroot/build_i686/staging_dir/usr/bin/i686-linux-uclibc-g++ -Os  -I/hom=
e/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/include -I/h=
ome/malek/minisys/xenomai/buildroot/build_i686/staging_dir/include --sysr=
oot=3D/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/ -isys=
root /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir -mtune=3D=
pentiumpro -march=3Dpentiumpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE =
-D_FILE_OFFSET_BITS=3D64 -E                                              =
                                                                         =
                                                           =20
checking for i686-linux-g77... no                                        =
                                                                         =
                                                                         =
                 =20
checking for i686-linux-xlf... no                                        =
                                                                         =
                                                                         =
                 =20
checking for i686-linux-f77... no                                        =
                                                                         =
                                                                         =
                 =20
checking for i686-linux-frt... no                                        =
                                                                         =
                                                                         =
                 =20
checking for i686-linux-pgf77... no                                      =
                                                                         =
                                                                         =
                 =20
checking for i686-linux-cf77... no                                       =
                                                                         =
                                                                         =
                 =20
checking for i686-linux-fort77... no                                     =
                                                                         =
                                                                         =
                 =20
checking for i686-linux-fl32... no                                       =
                                                                         =
                                                                         =
                 =20
checking for i686-linux-af77... no                                       =
                                                                         =
                                                                         =
                 =20
checking for i686-linux-xlf90... no                                      =
                                                                         =
                                                                         =
                 =20
checking for i686-linux-f90... no                                        =
                                                                         =
                                                                         =
                 =20
checking for i686-linux-pgf90... no                                      =
                                                                         =
                                                                         =
                 =20
checking for i686-linux-pghpf... no                                      =
                                                                         =
                                                                         =
                 =20
checking for i686-linux-epcf90... no                                     =
                                                                         =
                                                                         =
                 =20
checking for i686-linux-gfortran... no                                   =
                                                                         =
                                                                         =
                 =20
checking for i686-linux-g95... no                                        =
                                                                         =
                                                                         =
                 =20
checking for i686-linux-xlf95... no                                      =
                                                                         =
                                                                         =
                 =20
checking for i686-linux-f95... no                                        =
                                                                         =
                                                                         =
                 =20
checking for i686-linux-fort... no                                       =
                                                                         =
                                                                         =
                 =20
checking for i686-linux-ifort... no                                      =
                                                                         =
                                                                         =
                 =20
checking for i686-linux-ifc... no                                        =
                                                                         =
                                                                         =
                 =20
checking for i686-linux-efc... no                                        =
                                                                         =
                                                                         =
                 =20
checking for i686-linux-pgf95... no                                      =
                                                                         =
                                                                         =
                 =20
checking for i686-linux-lf95... no                                       =
                                                                         =
                                                                         =
                 =20
checking for i686-linux-ftn... no                                        =
                                                                         =
                                                                         =
                 =20
checking for g77... no                                                   =
                                                                         =
                                                                         =
                 =20
checking for xlf... no                                                   =
                                                                         =
                                                                         =
                 =20
checking for f77... no                                                   =
                                                                         =
                                                                         =
                 =20
checking for frt... no                                                   =
                                                                         =
                                                                         =
                 =20
checking for pgf77... no                                                 =
                                                                         =
                                                                         =
                 =20
checking for cf77... no                                                  =
                                                                         =
                                                                         =
                 =20
checking for fort77... no                                                =
                                                                         =
                                                                         =
                 =20
checking for fl32... no                                                  =
                                                                         =
                                                                         =
                 =20
checking for af77... no                                                  =
                                                                         =
                                                                         =
                 =20
checking for xlf90... no                                                 =
                                                                         =
                                                                         =
                 =20
checking for f90... no                                                   =
                                                                         =
                                                                         =
                 =20
checking for pgf90... no                                                 =
                                                                         =
                                                                         =
                 =20
checking for pghpf... no                                                 =
                                                                         =
                                                                         =
                 =20
checking for epcf90... no                                                =
                                                                         =
                                                                         =
                 =20
checking for gfortran... gfortran                                        =
                                                                         =
                                                                         =
                 =20
configure: WARNING: In the future, Autoconf will not detect cross-tools  =
                                                                         =
                                                                         =
                 =20
whose name does not start with the host triplet.  If you think this      =
                                                                         =
                                                                         =
                 =20
configuration is useful to you, please write to autoconf@domain.hid.        =
                                                                         =
                                                                         =
                 =20
checking whether we are using the GNU Fortran 77 compiler... yes         =
                                                                         =
                                                                         =
                 =20
checking whether gfortran accepts -g... yes                              =
                                                                         =
                                                                         =
                 =20
checking the maximum length of command line arguments... 1966080         =
                                                                         =
                                                                         =
                 =20
checking command to parse /home/malek/minisys/xenomai/buildroot/build_i68=
6/staging_dir/usr/bin/i686-linux-uclibc-nm output from /home/malek/minisy=
s/xenomai/buildroot/build_i686/staging_dir/usr/bin/i686-linux-uclibc-gcc =
-Os  -I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/i=
nclude -I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/inc=
lude --sysroot=3D/home/malek/minisys/xenomai/buildroot/build_i686/staging=
_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/build_i686/staging_=
dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFILE_SOURCE -D_LARGEF=
ILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 object... ok                       =
                                                             =20
checking for objdir... .libs                                             =
                                                                         =
                                                                         =
                 =20
checking for i686-linux-ar... /home/malek/minisys/xenomai/buildroot/build=
_i686/staging_dir/usr/bin/i686-linux-uclibc-ar                           =
                                                                         =
                 =20
checking for i686-linux-ranlib... /home/malek/minisys/xenomai/buildroot/b=
uild_i686/staging_dir/usr/bin/i686-linux-uclibc-ranlib                   =
                                                                         =
                 =20
checking for i686-linux-strip... (cached) /home/malek/minisys/xenomai/bui=
ldroot/build_i686/staging_dir/usr/bin/i686-linux-uclibc-strip            =
                                                                         =
                 =20
checking if /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/=
usr/bin/i686-linux-uclibc-gcc -Os  -I/home/malek/minisys/xenomai/buildroo=
t/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/buildr=
oot/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/xenoma=
i/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xenomai=
/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpro=
 -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 suppo=
rts -fno-rtti -fno-exceptions... no                                      =
                                                                         =
                                                             =20
checking for /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir=
/usr/bin/i686-linux-uclibc-gcc -Os  -I/home/malek/minisys/xenomai/buildro=
ot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/build=
root/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/xenom=
ai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xenoma=
i/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpr=
o -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 opti=
on to produce PIC... -fPIC                                               =
                                                                         =
                                                             =20
checking if /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/=
usr/bin/i686-linux-uclibc-gcc -Os  -I/home/malek/minisys/xenomai/buildroo=
t/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/buildr=
oot/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/xenoma=
i/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xenomai=
/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpro=
 -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 PIC f=
lag -fPIC works... yes                                                   =
                                                                         =
                                                             =20
checking if /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/=
usr/bin/i686-linux-uclibc-gcc -Os  -I/home/malek/minisys/xenomai/buildroo=
t/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/buildr=
oot/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/xenoma=
i/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xenomai=
/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpro=
 -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 stati=
c flag -static works... yes                                              =
                                                                         =
                                                             =20
checking if /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/=
usr/bin/i686-linux-uclibc-gcc -Os  -I/home/malek/minisys/xenomai/buildroo=
t/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/buildr=
oot/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/xenoma=
i/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xenomai=
/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpro=
 -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 suppo=
rts -c -o file.o... yes                                                  =
                                                                         =
                                                             =20
checking whether the /home/malek/minisys/xenomai/buildroot/build_i686/sta=
ging_dir/usr/bin/i686-linux-uclibc-gcc -Os  -I/home/malek/minisys/xenomai=
/buildroot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenom=
ai/buildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/minis=
ys/xenomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisy=
s/xenomai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dp=
entiumpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D=
64 linker (/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/u=
sr/bin/i686-linux-uclibc-ld -L/home/malek/minisys/xenomai/buildroot/build=
_i686/staging_dir/lib -L/home/malek/minisys/xenomai/buildroot/build_i686/=
staging_dir/usr/lib --sysroot=3D/home/malek/minisys/xenomai/buildroot/bui=
ld_i686/staging_dir/) supports shared libraries... yes                   =
                                                                         =
       =20
checking whether -lc should be explicitly linked in... no                =
                                                                         =
                                                                         =
                 =20
checking dynamic linker characteristics... GNU/Linux ld.so               =
                                                                         =
                                                                         =
                 =20
checking how to hardcode library paths into programs... immediate        =
                                                                         =
                                                                         =
                 =20
checking whether stripping libraries is possible... yes                  =
                                                                         =
                                                                         =
                 =20
checking if libtool supports shared libraries... yes                     =
                                                                         =
                                                                         =
                 =20
checking whether to build shared libraries... yes                        =
                                                                         =
                                                                         =
                 =20
checking whether to build static libraries... yes                        =
                                                                         =
                                                                         =
                 =20
configure: creating libtool                                              =
                                                                         =
                                                                         =
                 =20
appending configuration tag "CXX" to libtool                             =
                                                                         =
                                                                         =
                 =20
checking for ld used by /home/malek/minisys/xenomai/buildroot/build_i686/=
staging_dir/usr/bin/i686-linux-uclibc-g++ -Os  -I/home/malek/minisys/xeno=
mai/buildroot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xe=
nomai/buildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/mi=
nisys/xenomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/min=
isys/xenomai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3D=
pentiumpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D=
64... /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bi=
n/i686-linux-uclibc-ld -L/home/malek/minisys/xenomai/buildroot/build_i686=
/staging_dir/lib -L/home/malek/minisys/xenomai/buildroot/build_i686/stagi=
ng_dir/usr/lib --sysroot=3D/home/malek/minisys/xenomai/buildroot/build_i6=
86/staging_dir/                                                          =
                                                                         =
    =20
checking if the linker (/home/malek/minisys/xenomai/buildroot/build_i686/=
staging_dir/usr/bin/i686-linux-uclibc-ld -L/home/malek/minisys/xenomai/bu=
ildroot/build_i686/staging_dir/lib -L/home/malek/minisys/xenomai/buildroo=
t/build_i686/staging_dir/usr/lib --sysroot=3D/home/malek/minisys/xenomai/=
buildroot/build_i686/staging_dir/) is GNU ld... yes                      =
                                                                         =
                                     =20
checking whether the /home/malek/minisys/xenomai/buildroot/build_i686/sta=
ging_dir/usr/bin/i686-linux-uclibc-g++ -Os  -I/home/malek/minisys/xenomai=
/buildroot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenom=
ai/buildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/minis=
ys/xenomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisy=
s/xenomai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dp=
entiumpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D=
64 linker (/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/u=
sr/bin/i686-linux-uclibc-ld -L/home/malek/minisys/xenomai/buildroot/build=
_i686/staging_dir/lib -L/home/malek/minisys/xenomai/buildroot/build_i686/=
staging_dir/usr/lib --sysroot=3D/home/malek/minisys/xenomai/buildroot/bui=
ld_i686/staging_dir/) supports shared libraries... yes                   =
                                                                         =
       =20
checking for /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir=
/usr/bin/i686-linux-uclibc-g++ -Os  -I/home/malek/minisys/xenomai/buildro=
ot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/build=
root/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/xenom=
ai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xenoma=
i/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpr=
o -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 opti=
on to produce PIC... -fPIC                                               =
                                                                         =
                                                             =20
checking if /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/=
usr/bin/i686-linux-uclibc-g++ -Os  -I/home/malek/minisys/xenomai/buildroo=
t/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/buildr=
oot/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/xenoma=
i/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xenomai=
/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpro=
 -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 PIC f=
lag -fPIC works... yes                                                   =
                                                                         =
                                                             =20
checking if /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/=
usr/bin/i686-linux-uclibc-g++ -Os  -I/home/malek/minisys/xenomai/buildroo=
t/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/buildr=
oot/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/xenoma=
i/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xenomai=
/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpro=
 -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 stati=
c flag -static works... no                                               =
                                                                         =
                                                             =20
checking if /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/=
usr/bin/i686-linux-uclibc-g++ -Os  -I/home/malek/minisys/xenomai/buildroo=
t/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/buildr=
oot/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/xenoma=
i/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xenomai=
/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpro=
 -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 suppo=
rts -c -o file.o... yes                                                  =
                                                                         =
                                                             =20
checking whether the /home/malek/minisys/xenomai/buildroot/build_i686/sta=
ging_dir/usr/bin/i686-linux-uclibc-g++ -Os  -I/home/malek/minisys/xenomai=
/buildroot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenom=
ai/buildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/minis=
ys/xenomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisy=
s/xenomai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dp=
entiumpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D=
64 linker (/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/u=
sr/bin/i686-linux-uclibc-ld -L/home/malek/minisys/xenomai/buildroot/build=
_i686/staging_dir/lib -L/home/malek/minisys/xenomai/buildroot/build_i686/=
staging_dir/usr/lib --sysroot=3D/home/malek/minisys/xenomai/buildroot/bui=
ld_i686/staging_dir/) supports shared libraries... yes                   =
                                                                         =
       =20
checking dynamic linker characteristics... GNU/Linux ld.so               =
                                                                         =
                                                                         =
                 =20
(cached) (cached) checking how to hardcode library paths into programs...=
 immediate                                                               =
                                                                         =
                 =20
appending configuration tag "F77" to libtool                             =
                                                                         =
                                                                         =
                 =20
checking if libtool supports shared libraries... yes                     =
                                                                         =
                                                                         =
                 =20
checking whether to build shared libraries... yes                        =
                                                                         =
                                                                         =
                 =20
checking whether to build static libraries... yes                        =
                                                                         =
                                                                         =
                 =20
checking for gfortran option to produce PIC... -fPIC                     =
                                                                         =
                                                                         =
                 =20
checking if gfortran PIC flag -fPIC works... yes                         =
                                                                         =
                                                                         =
                 =20
checking if gfortran static flag -static works... yes                    =
                                                                         =
                                                                         =
                 =20
checking if gfortran supports -c -o file.o... yes                        =
                                                                         =
                                                                         =
                 =20
checking whether the gfortran linker (/home/malek/minisys/xenomai/buildro=
ot/build_i686/staging_dir/usr/bin/i686-linux-uclibc-ld -L/home/malek/mini=
sys/xenomai/buildroot/build_i686/staging_dir/lib -L/home/malek/minisys/xe=
nomai/buildroot/build_i686/staging_dir/usr/lib --sysroot=3D/home/malek/mi=
nisys/xenomai/buildroot/build_i686/staging_dir/) supports shared librarie=
s... yes                                                                 =
                                     =20
checking dynamic linker characteristics... GNU/Linux ld.so               =
                                                                         =
                                                                         =
                 =20
(cached) (cached) checking how to hardcode library paths into programs...=
 immediate                                                               =
                                                                         =
                 =20
checking dependency style of /home/malek/minisys/xenomai/buildroot/build_=
i686/staging_dir/usr/bin/i686-linux-uclibc-gcc -Os  -I/home/malek/minisys=
/xenomai/buildroot/build_i686/staging_dir/usr/include -I/home/malek/minis=
ys/xenomai/buildroot/build_i686/staging_dir/include --sysroot=3D/home/mal=
ek/minisys/xenomai/buildroot/build_i686/staging_dir/ -isysroot /home/male=
k/minisys/xenomai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -m=
arch=3Dpentiumpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSE=
T_BITS=3D64... gcc3                                                      =
                                                                         =
                                                             =20
checking for flex... flex                                                =
                                                                         =
                                                                         =
                 =20
checking lex output file root... lex.yy                                  =
                                                                         =
                                                                         =
                 =20
checking lex library... none needed                                      =
                                                                         =
                                                                         =
                 =20
checking whether yytext is a pointer... no                               =
                                                                         =
                                                                         =
                 =20
checking for target architecture... x86                                  =
                                                                         =
                                                                         =
                 =20
checking for debug symbols... no                                         =
                                                                         =
                                                                         =
                 =20
checking for SMP support... no                                           =
                                                                         =
                                                                         =
                 =20
checking for x86 SEP instructions in syscalls... no                      =
                                                                         =
                                                                         =
                 =20
checking for x86 TSC support... y                                        =
                                                                         =
                                                                         =
                 =20
checking whether building Linux in Xenomai build tree... no              =
                                                                         =
                                                                         =
                 =20
checking for Doxygen documentation... no                                 =
                                                                         =
                                                                         =
                 =20
checking for doxygen... doxygen                                          =
                                                                         =
                                                                         =
                 =20
checking for dot... NO                                                   =
                                                                         =
                                                                         =
                 =20
checking whether compiling Docbook XML documentation... no               =
                                                                         =
                                                                         =
                 =20
checking for xmllint... xmllint                                          =
                                                                         =
                                                                         =
                 =20
checking for xsltproc... xsltproc                                        =
                                                                         =
                                                                         =
                 =20
checking for fop.sh... no                                                =
                                                                         =
                                                                         =
                 =20
checking whether Docbook XML documentation generation can use network....=
 no                                                                      =
                                                                         =
                 =20
checking for docbook-xml root dir... network                             =
                                                                         =
                                                                         =
                 =20
checking for docbook-xsl root dir... network                             =
                                                                         =
                                                                         =
                 =20
checking whether using LaTeX non-stop mode... no                         =
                                                                         =
                                                                         =
                 =20
checking mqueue.h usability... yes                                       =
                                                                         =
                                                                         =
                 =20
checking mqueue.h presence... yes                                        =
                                                                         =
                                                                         =
                 =20
checking for mqueue.h... yes                                             =
                                                                         =
                                                                         =
                 =20
checking for sched_setaffinity... ok                                     =
                                                                         =
                                                                         =
                 =20
checking for specific GCC switches... done                               =
                                                                         =
                                                                         =
                 =20
checking whether ld supports @file... yes                                =
                                                                         =
                                                                         =
                 =20
checking whether the POSIX skin library automatically calls mlockall... n=
o                                                                        =
                                                                         =
                 =20
checking whether the pSOS skin library automatically calls mlockall... no=
                                                                         =
                                                                         =
                 =20
checking whether the uITRON skin library automatically calls mlockall... =
no                                                                       =
                                                                         =
                 =20
checking for shm_open... no                                              =
                                                                         =
                                                                         =
                 =20
checking for shm_unlink... no                                            =
                                                                         =
                                                                         =
                 =20
configure: creating ./config.status                                      =
                                                                         =
                                                                         =
                 =20
config.status: creating Makefile                                         =
                                                                         =
                                                                         =
                 =20
config.status: creating config/Makefile                                  =
                                                                         =
                                                                         =
                 =20
config.status: creating scripts/Makefile                                 =
                                                                         =
                                                                         =
                 =20
config.status: creating scripts/xeno-config                              =
                                                                         =
                                                                         =
                 =20
config.status: creating scripts/xeno-load                                =
                                                                         =
                                                                         =
                 =20
config.status: creating scripts/xeno-test                                =
                                                                         =
                                                                         =
                 =20
config.status: creating src/Makefile                                     =
                                                                         =
                                                                         =
                 =20
config.status: creating src/rtdk/Makefile                                =
                                                                         =
                                                                         =
                 =20
config.status: creating src/skins/Makefile                               =
                                                                         =
                                                                         =
                 =20
config.status: creating src/skins/posix/Makefile                         =
                                                                         =
                                                                         =
                 =20
config.status: creating src/skins/native/Makefile                        =
                                                                         =
                                                                         =
                 =20
config.status: creating src/skins/vxworks/Makefile                       =
                                                                         =
                                                                         =
                 =20
config.status: creating src/skins/psos+/Makefile                         =
                                                                         =
                                                                         =
                 =20
config.status: creating src/skins/vrtx/Makefile                          =
                                                                         =
                                                                         =
                 =20
config.status: creating src/skins/rtdm/Makefile                          =
                                                                         =
                                                                         =
                 =20
config.status: creating src/skins/rtai/Makefile                          =
                                                                         =
                                                                         =
                 =20
config.status: creating src/skins/uitron/Makefile                        =
                                                                         =
                                                                         =
                 =20
config.status: creating src/include/Makefile                             =
                                                                         =
                                                                         =
                 =20
config.status: creating src/testsuite/Makefile                           =
                                                                         =
                                                                         =
                 =20
config.status: creating src/testsuite/latency/Makefile                   =
                                                                         =
                                                                         =
                 =20
config.status: creating src/testsuite/switchbench/Makefile               =
                                                                         =
                                                                         =
                 =20
config.status: creating src/testsuite/cyclic/Makefile                    =
                                                                         =
                                                                         =
                 =20
config.status: creating src/testsuite/switchtest/Makefile                =
                                                                         =
                                                                         =
                 =20
config.status: creating src/testsuite/irqbench/Makefile                  =
                                                                         =
                                                                         =
                 =20
config.status: creating src/testsuite/clocktest/Makefile                 =
                                                                         =
                                                                         =
                 =20
config.status: creating src/testsuite/klatency/Makefile                  =
                                                                         =
                                                                         =
                 =20
config.status: creating src/utils/Makefile                               =
                                                                         =
                                                                         =
                 =20
config.status: creating src/utils/can/Makefile                           =
                                                                         =
                                                                         =
                 =20
config.status: creating include/Makefile                                 =
                                                                         =
                                                                         =
                 =20
config.status: creating include/asm-generic/Makefile                     =
                                                                         =
                                                                         =
                 =20
config.status: creating include/asm-generic/bits/Makefile                =
                                                                         =
                                                                         =
                 =20
config.status: creating include/asm-blackfin/Makefile                    =
                                                                         =
                                                                         =
                 =20
config.status: creating include/asm-blackfin/bits/Makefile               =
                                                                         =
                                                                         =
                 =20
config.status: creating include/asm-x86/Makefile                         =
                                                                         =
                                                                         =
                 =20
config.status: creating include/asm-x86/bits/Makefile                    =
                                                                         =
                                                                         =
                 =20
config.status: creating include/asm-powerpc/Makefile                     =
                                                                         =
                                                                         =
                 =20
config.status: creating include/asm-powerpc/bits/Makefile                =
                                                                         =
                                                                         =
                 =20
config.status: creating include/asm-ia64/Makefile                        =
                                                                         =
                                                                         =
                 =20
config.status: creating include/asm-ia64/bits/Makefile                   =
                                                                         =
                                                                         =
                 =20
config.status: creating include/asm-arm/Makefile                         =
                                                                         =
                                                                         =
                 =20
config.status: creating include/asm-arm/bits/Makefile                    =
                                                                         =
                                                                         =
                 =20
config.status: creating include/asm-sim/Makefile                         =
                                                                         =
                                                                         =
                 =20
config.status: creating include/asm-sim/bits/Makefile                    =
                                                                         =
                                                                         =
                 =20
config.status: creating include/native/Makefile                          =
                                                                         =
                                                                         =
                 =20
config.status: creating include/nucleus/Makefile                         =
                                                                         =
                                                                         =
                 =20
config.status: creating include/posix/Makefile                           =
                                                                         =
                                                                         =
                 =20
config.status: creating include/posix/sys/Makefile                       =
                                                                         =
                                                                         =
                 =20
config.status: creating include/psos+/Makefile                           =
                                                                         =
                                                                         =
                 =20
config.status: creating include/rtai/Makefile                            =
                                                                         =
                                                                         =
                 =20
config.status: creating include/rtdm/Makefile                            =
                                                                         =
                                                                         =
                 =20
config.status: creating include/uitron/Makefile                          =
                                                                         =
                                                                         =
                 =20
config.status: creating include/vrtx/Makefile                            =
                                                                         =
                                                                         =
                 =20
config.status: creating include/vxworks/Makefile                         =
                                                                         =
                                                                         =
                 =20
config.status: creating doc/Makefile                                     =
                                                                         =
                                                                         =
                 =20
config.status: creating doc/txt/Makefile                                 =
                                                                         =
                                                                         =
                 =20
config.status: creating doc/man/Makefile                                 =
                                                                         =
                                                                         =
                 =20
config.status: creating doc/man/clocktest.man                            =
                                                                         =
                                                                         =
                 =20
config.status: creating doc/man/cyclictest.man                           =
                                                                         =
                                                                         =
                 =20
config.status: creating doc/man/irqbench.man                             =
                                                                         =
                                                                         =
                 =20
config.status: creating doc/man/irqloop.man                              =
                                                                         =
                                                                         =
                 =20
config.status: creating doc/man/klatency.man                             =
                                                                         =
                                                                         =
                 =20
config.status: creating doc/man/latency.man                              =
                                                                         =
                                                                         =
                 =20
config.status: creating doc/man/rtcanconfig.man                          =
                                                                         =
                                                                         =
                 =20
config.status: creating doc/man/rtcanrecv.man                            =
                                                                         =
                                                                         =
                 =20
config.status: creating doc/man/rtcansend.man                            =
                                                                         =
                                                                         =
                 =20
config.status: creating doc/man/switchbench.man                          =
                                                                         =
                                                                         =
                 =20
config.status: creating doc/man/switchtest.man                           =
                                                                         =
                                                                         =
                 =20
config.status: creating doc/man/runinfo.man                              =
                                                                         =
                                                                         =
                 =20
config.status: creating doc/man/xeno-config.man                          =
                                                                         =
                                                                         =
                 =20
config.status: creating doc/man/xeno-info.man                            =
                                                                         =
                                                                         =
                 =20
config.status: creating doc/man/xeno-load.man                            =
                                                                         =
                                                                         =
                 =20
config.status: creating doc/man/xeno-test.man                            =
                                                                         =
                                                                         =
                 =20
config.status: creating doc/doxygen/Makefile                             =
                                                                         =
                                                                         =
                 =20
config.status: creating doc/doxygen/Doxyfile-common                      =
                                                                         =
                                                                         =
                 =20
config.status: creating doc/doxygen/Doxyfile                             =
                                                                         =
                                                                         =
                 =20
config.status: creating doc/doxygen/Doxyfile-native                      =
                                                                         =
                                                                         =
                 =20
config.status: creating doc/doxygen/Doxyfile-nucleus                     =
                                                                         =
                                                                         =
                 =20
config.status: creating doc/doxygen/Doxyfile-posix                       =
                                                                         =
                                                                         =
                 =20
config.status: creating doc/doxygen/Doxyfile-rtdm                        =
                                                                         =
                                                                         =
                 =20
config.status: creating doc/docbook/Makefile                             =
                                                                         =
                                                                         =
                 =20
config.status: creating doc/docbook/catalog                              =
                                                                         =
                                                                         =
                 =20
config.status: creating doc/docbook/custom-stylesheets/Makefile          =
                                                                         =
                                                                         =
                 =20
config.status: creating doc/docbook/custom-stylesheets/xsl/Makefile      =
                                                                         =
                                                                         =
                 =20
config.status: creating doc/docbook/custom-stylesheets/xsl/common/Makefil=
e                                                                        =
                                                                         =
                 =20
config.status: creating doc/docbook/custom-stylesheets/xsl/fo/Makefile   =
                                                                         =
                                                                         =
                 =20
config.status: creating doc/docbook/custom-stylesheets/xsl/html/Makefile =
                                                                         =
                                                                         =
                 =20
config.status: creating doc/docbook/custom-stylesheets/xsl/html/chunk.xsl=
                                                                         =
                                                                         =
                 =20
config.status: creating doc/docbook/custom-stylesheets/xsl/html/onechunk.=
xsl                                                                      =
                                                                         =
                 =20
config.status: creating doc/docbook/xenomai/Makefile                     =
                                                                         =
                                                                         =
                 =20
config.status: creating src/include/xeno_config.h                        =
                                                                         =
                                                                         =
                 =20
config.status: linking ./include/asm-x86 to src/include/asm/xenomai      =
                                                                         =
                                                                         =
                 =20
config.status: linking ./include/asm-generic to src/include/asm-generic/x=
enomai                                                                   =
                                                                         =
                 =20
config.status: executing depfiles commands                               =
                                                                         =
                                                                         =
                 =20
>>> xenomai 2.4.5 Building                                               =
                                                                         =
                                                                         =
                 =20
/usr/bin/make -j1  -C /home/malek/minisys/xenomai/buildroot/build_i686/xe=
nomai-2.4.5/                                                             =
                                                                         =
                 =20
make[1]: entrant dans le r=C3=A9pertoire =C2=AB /home/malek/minisys/xenom=
ai/buildroot/build_i686/xenomai-2.4.5 =C2=BB                             =
                                                                         =
                                =20
Making all in src                                                        =
                                                                         =
                                                                         =
                 =20
make[2]: entrant dans le r=C3=A9pertoire =C2=AB /home/malek/minisys/xenom=
ai/buildroot/build_i686/xenomai-2.4.5/src =C2=BB                         =
                                                                         =
                                =20
Making all in include                                                    =
                                                                         =
                                                                         =
                 =20
make[3]: entrant dans le r=C3=A9pertoire =C2=AB /home/malek/minisys/xenom=
ai/buildroot/build_i686/xenomai-2.4.5/src/include =C2=BB                 =
                                                                         =
                                =20
/usr/bin/make  all-am                                                    =
                                                                         =
                                                                         =
                 =20
make[4]: entrant dans le r=C3=A9pertoire =C2=AB /home/malek/minisys/xenom=
ai/buildroot/build_i686/xenomai-2.4.5/src/include =C2=BB                 =
                                                                         =
                                =20
make[4]: Rien =C3=A0 faire pour =C2=AB all-am =C2=BB.                    =
                                                                         =
                                                                         =
                                =20
make[4]: quittant le r=C3=A9pertoire =C2=AB /home/malek/minisys/xenomai/b=
uildroot/build_i686/xenomai-2.4.5/src/include =C2=BB                     =
                                                                         =
                                =20
make[3]: quittant le r=C3=A9pertoire =C2=AB /home/malek/minisys/xenomai/b=
uildroot/build_i686/xenomai-2.4.5/src/include =C2=BB                     =
                                                                         =
                                =20
Making all in rtdk                                                       =
                                                                         =
                                                                         =
                 =20
make[3]: entrant dans le r=C3=A9pertoire =C2=AB /home/malek/minisys/xenom=
ai/buildroot/build_i686/xenomai-2.4.5/src/rtdk =C2=BB                    =
                                                                         =
                                =20
/bin/sh ../../libtool --tag=3DCC   --mode=3Dcompile /home/malek/minisys/x=
enomai/buildroot/build_i686/staging_dir/usr/bin/i686-linux-uclibc-gcc -Os=
  -I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/incl=
ude -I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/includ=
e --sysroot=3D/home/malek/minisys/xenomai/buildroot/build_i686/staging_di=
r/ -isysroot /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir=
 -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFILE_SOURCE -D_LARGEFILE=
64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -I. -I../../src/includ=
e  -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fstrict-aliasing -Wno-stri=
ct-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prototypes -I../../include =
   -MT librtdk_la-init.lo -MD -MP -MF .deps/librtdk_la-init.Tpo -c -o lib=
rtdk_la-init.lo `test -f 'init.c' || echo './'`init.c                    =
                                                                         =
          =20
mkdir .libs                                                              =
                                                                         =
                                                                         =
                 =20
 /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin/i68=
6-linux-uclibc-gcc -Os -I/home/malek/minisys/xenomai/buildroot/build_i686=
/staging_dir/usr/include -I/home/malek/minisys/xenomai/buildroot/build_i6=
86/staging_dir/include --sysroot=3D/home/malek/minisys/xenomai/buildroot/=
build_i686/staging_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/b=
uild_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFIL=
E_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -=
I. -I../../src/include -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fstric=
t-aliasing -Wno-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prototy=
pes -I../../include -MT librtdk_la-init.lo -MD -MP -MF .deps/librtdk_la-i=
nit.Tpo -c init.c  -fPIC -DPIC -o .libs/librtdk_la-init.o                =
                                                                         =
                                                                         =
      =20
 /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin/i68=
6-linux-uclibc-gcc -Os -I/home/malek/minisys/xenomai/buildroot/build_i686=
/staging_dir/usr/include -I/home/malek/minisys/xenomai/buildroot/build_i6=
86/staging_dir/include --sysroot=3D/home/malek/minisys/xenomai/buildroot/=
build_i686/staging_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/b=
uild_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFIL=
E_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -=
I. -I../../src/include -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fstric=
t-aliasing -Wno-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prototy=
pes -I../../include -MT librtdk_la-init.lo -MD -MP -MF .deps/librtdk_la-i=
nit.Tpo -c init.c -o librtdk_la-init.o >/dev/null 2>&1                   =
                                                                         =
                                                                         =
      =20
mv -f .deps/librtdk_la-init.Tpo .deps/librtdk_la-init.Plo                =
                                                                         =
                                                                         =
                 =20
/bin/sh ../../libtool --tag=3DCC   --mode=3Dcompile /home/malek/minisys/x=
enomai/buildroot/build_i686/staging_dir/usr/bin/i686-linux-uclibc-gcc -Os=
  -I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/incl=
ude -I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/includ=
e --sysroot=3D/home/malek/minisys/xenomai/buildroot/build_i686/staging_di=
r/ -isysroot /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir=
 -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFILE_SOURCE -D_LARGEFILE=
64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -I. -I../../src/includ=
e  -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fstrict-aliasing -Wno-stri=
ct-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prototypes -I../../include =
   -MT librtdk_la-rt_print.lo -MD -MP -MF .deps/librtdk_la-rt_print.Tpo -=
c -o librtdk_la-rt_print.lo `test -f 'rt_print.c' || echo './'`rt_print.c=
                                                                         =
          =20
 /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin/i68=
6-linux-uclibc-gcc -Os -I/home/malek/minisys/xenomai/buildroot/build_i686=
/staging_dir/usr/include -I/home/malek/minisys/xenomai/buildroot/build_i6=
86/staging_dir/include --sysroot=3D/home/malek/minisys/xenomai/buildroot/=
build_i686/staging_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/b=
uild_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFIL=
E_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -=
I. -I../../src/include -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fstric=
t-aliasing -Wno-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prototy=
pes -I../../include -MT librtdk_la-rt_print.lo -MD -MP -MF .deps/librtdk_=
la-rt_print.Tpo -c rt_print.c  -fPIC -DPIC -o .libs/librtdk_la-rt_print.o=
                                                                         =
                                                                         =
      =20
 /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin/i68=
6-linux-uclibc-gcc -Os -I/home/malek/minisys/xenomai/buildroot/build_i686=
/staging_dir/usr/include -I/home/malek/minisys/xenomai/buildroot/build_i6=
86/staging_dir/include --sysroot=3D/home/malek/minisys/xenomai/buildroot/=
build_i686/staging_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/b=
uild_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFIL=
E_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -=
I. -I../../src/include -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fstric=
t-aliasing -Wno-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prototy=
pes -I../../include -MT librtdk_la-rt_print.lo -MD -MP -MF .deps/librtdk_=
la-rt_print.Tpo -c rt_print.c -o librtdk_la-rt_print.o >/dev/null 2>&1   =
                                                                         =
                                                                         =
      =20
mv -f .deps/librtdk_la-rt_print.Tpo .deps/librtdk_la-rt_print.Plo        =
                                                                         =
                                                                         =
                 =20
/bin/sh ../../libtool --tag=3DCC   --mode=3Dlink /home/malek/minisys/xeno=
mai/buildroot/build_i686/staging_dir/usr/bin/i686-linux-uclibc-gcc -Os  -=
I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/include=
 -I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/include -=
-sysroot=3D/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/ =
-isysroot /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir -m=
tune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_=
SOURCE -D_FILE_OFFSET_BITS=3D64   -version-info 0:0:0 -lpthread  -o librt=
dk.la -rpath /usr/lib librtdk_la-init.lo librtdk_la-rt_print.lo          =
                                                                 =20
/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin/i686=
-linux-uclibc-gcc -Os  -I/home/malek/minisys/xenomai/buildroot/build_i686=
/staging_dir/usr/include -I/home/malek/minisys/xenomai/buildroot/build_i6=
86/staging_dir/include --sysroot=3D/home/malek/minisys/xenomai/buildroot/=
build_i686/staging_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/b=
uild_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFIL=
E_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -shared  .libs/li=
brtdk_la-init.o .libs/librtdk_la-rt_print.o  -lpthread  -mtune=3Dpentiump=
ro -march=3Dpentiumpro -Wl,-soname -Wl,librtdk.so.0 -o .libs/librtdk.so.0=
=2E0.0                                                             =20
(cd .libs && rm -f librtdk.so.0 && ln -s librtdk.so.0.0.0 librtdk.so.0)  =
                                                                         =
                                                                         =
                 =20
(cd .libs && rm -f librtdk.so && ln -s librtdk.so.0.0.0 librtdk.so)      =
                                                                         =
                                                                         =
                 =20
/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin/i686=
-linux-uclibc-ar cru .libs/librtdk.a  librtdk_la-init.o librtdk_la-rt_pri=
nt.o                                                                     =
                 =20
/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin/i686=
-linux-uclibc-ranlib .libs/librtdk.a                                     =
                                                                         =
                 =20
creating librtdk.la                                                      =
                                                                         =
                                                                         =
                 =20
(cd .libs && rm -f librtdk.la && ln -s ../librtdk.la librtdk.la)         =
                                                                         =
                                                                         =
                 =20
make[3]: quittant le r=C3=A9pertoire =C2=AB /home/malek/minisys/xenomai/b=
uildroot/build_i686/xenomai-2.4.5/src/rtdk =C2=BB                        =
                                                                         =
                                =20
Making all in skins                                                      =
                                                                         =
                                                                         =
                 =20
make[3]: entrant dans le r=C3=A9pertoire =C2=AB /home/malek/minisys/xenom=
ai/buildroot/build_i686/xenomai-2.4.5/src/skins =C2=BB                   =
                                                                         =
                                =20
Making all in native                                                     =
                                                                         =
                                                                         =
                 =20
make[4]: entrant dans le r=C3=A9pertoire =C2=AB /home/malek/minisys/xenom=
ai/buildroot/build_i686/xenomai-2.4.5/src/skins/native =C2=BB            =
                                                                         =
                                =20
/bin/sh ../../../libtool --tag=3DCC   --mode=3Dcompile /home/malek/minisy=
s/xenomai/buildroot/build_i686/staging_dir/usr/bin/i686-linux-uclibc-gcc =
-Os  -I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/i=
nclude -I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/inc=
lude --sysroot=3D/home/malek/minisys/xenomai/buildroot/build_i686/staging=
_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/build_i686/staging_=
dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFILE_SOURCE -D_LARGEF=
ILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -I. -I../../../src/=
include  -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fstrict-aliasing -Wn=
o-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prototypes -I../../..=
/include    -MT libnative_la-alarm.lo -MD -MP -MF .deps/libnative_la-alar=
m.Tpo -c -o libnative_la-alarm.lo `test -f 'alarm.c' || echo './'`alarm.c=
                                                                         =
          =20
mkdir .libs                                                              =
                                                                         =
                                                                         =
                 =20
 /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin/i68=
6-linux-uclibc-gcc -Os -I/home/malek/minisys/xenomai/buildroot/build_i686=
/staging_dir/usr/include -I/home/malek/minisys/xenomai/buildroot/build_i6=
86/staging_dir/include --sysroot=3D/home/malek/minisys/xenomai/buildroot/=
build_i686/staging_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/b=
uild_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFIL=
E_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -=
I. -I../../../src/include -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fst=
rict-aliasing -Wno-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prot=
otypes -I../../../include -MT libnative_la-alarm.lo -MD -MP -MF .deps/lib=
native_la-alarm.Tpo -c alarm.c  -fPIC -DPIC -o .libs/libnative_la-alarm.o=
                                                                         =
                                                                         =
      =20
 /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin/i68=
6-linux-uclibc-gcc -Os -I/home/malek/minisys/xenomai/buildroot/build_i686=
/staging_dir/usr/include -I/home/malek/minisys/xenomai/buildroot/build_i6=
86/staging_dir/include --sysroot=3D/home/malek/minisys/xenomai/buildroot/=
build_i686/staging_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/b=
uild_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFIL=
E_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -=
I. -I../../../src/include -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fst=
rict-aliasing -Wno-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prot=
otypes -I../../../include -MT libnative_la-alarm.lo -MD -MP -MF .deps/lib=
native_la-alarm.Tpo -c alarm.c -o libnative_la-alarm.o >/dev/null 2>&1   =
                                                                         =
                                                                         =
      =20
mv -f .deps/libnative_la-alarm.Tpo .deps/libnative_la-alarm.Plo          =
                                                                         =
                                                                         =
                 =20
/bin/sh ../../../libtool --tag=3DCC   --mode=3Dcompile /home/malek/minisy=
s/xenomai/buildroot/build_i686/staging_dir/usr/bin/i686-linux-uclibc-gcc =
-Os  -I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/i=
nclude -I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/inc=
lude --sysroot=3D/home/malek/minisys/xenomai/buildroot/build_i686/staging=
_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/build_i686/staging_=
dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFILE_SOURCE -D_LARGEF=
ILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -I. -I../../../src/=
include  -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fstrict-aliasing -Wn=
o-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prototypes -I../../..=
/include    -MT libnative_la-cond.lo -MD -MP -MF .deps/libnative_la-cond.=
Tpo -c -o libnative_la-cond.lo `test -f 'cond.c' || echo './'`cond.c     =
                                                                         =
          =20
 /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin/i68=
6-linux-uclibc-gcc -Os -I/home/malek/minisys/xenomai/buildroot/build_i686=
/staging_dir/usr/include -I/home/malek/minisys/xenomai/buildroot/build_i6=
86/staging_dir/include --sysroot=3D/home/malek/minisys/xenomai/buildroot/=
build_i686/staging_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/b=
uild_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFIL=
E_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -=
I. -I../../../src/include -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fst=
rict-aliasing -Wno-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prot=
otypes -I../../../include -MT libnative_la-cond.lo -MD -MP -MF .deps/libn=
ative_la-cond.Tpo -c cond.c  -fPIC -DPIC -o .libs/libnative_la-cond.o    =
                                                                         =
                                                                         =
      =20
 /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin/i68=
6-linux-uclibc-gcc -Os -I/home/malek/minisys/xenomai/buildroot/build_i686=
/staging_dir/usr/include -I/home/malek/minisys/xenomai/buildroot/build_i6=
86/staging_dir/include --sysroot=3D/home/malek/minisys/xenomai/buildroot/=
build_i686/staging_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/b=
uild_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFIL=
E_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -=
I. -I../../../src/include -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fst=
rict-aliasing -Wno-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prot=
otypes -I../../../include -MT libnative_la-cond.lo -MD -MP -MF .deps/libn=
ative_la-cond.Tpo -c cond.c -o libnative_la-cond.o >/dev/null 2>&1       =
                                                                         =
                                                                         =
      =20
mv -f .deps/libnative_la-cond.Tpo .deps/libnative_la-cond.Plo            =
                                                                         =
                                                                         =
                 =20
/bin/sh ../../../libtool --tag=3DCC   --mode=3Dcompile /home/malek/minisy=
s/xenomai/buildroot/build_i686/staging_dir/usr/bin/i686-linux-uclibc-gcc =
-Os  -I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/i=
nclude -I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/inc=
lude --sysroot=3D/home/malek/minisys/xenomai/buildroot/build_i686/staging=
_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/build_i686/staging_=
dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFILE_SOURCE -D_LARGEF=
ILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -I. -I../../../src/=
include  -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fstrict-aliasing -Wn=
o-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prototypes -I../../..=
/include    -MT libnative_la-event.lo -MD -MP -MF .deps/libnative_la-even=
t.Tpo -c -o libnative_la-event.lo `test -f 'event.c' || echo './'`event.c=
                                                                         =
          =20
 /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin/i68=
6-linux-uclibc-gcc -Os -I/home/malek/minisys/xenomai/buildroot/build_i686=
/staging_dir/usr/include -I/home/malek/minisys/xenomai/buildroot/build_i6=
86/staging_dir/include --sysroot=3D/home/malek/minisys/xenomai/buildroot/=
build_i686/staging_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/b=
uild_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFIL=
E_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -=
I. -I../../../src/include -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fst=
rict-aliasing -Wno-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prot=
otypes -I../../../include -MT libnative_la-event.lo -MD -MP -MF .deps/lib=
native_la-event.Tpo -c event.c  -fPIC -DPIC -o .libs/libnative_la-event.o=
                                                                         =
                                                                         =
      =20
 /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin/i68=
6-linux-uclibc-gcc -Os -I/home/malek/minisys/xenomai/buildroot/build_i686=
/staging_dir/usr/include -I/home/malek/minisys/xenomai/buildroot/build_i6=
86/staging_dir/include --sysroot=3D/home/malek/minisys/xenomai/buildroot/=
build_i686/staging_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/b=
uild_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFIL=
E_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -=
I. -I../../../src/include -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fst=
rict-aliasing -Wno-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prot=
otypes -I../../../include -MT libnative_la-event.lo -MD -MP -MF .deps/lib=
native_la-event.Tpo -c event.c -o libnative_la-event.o >/dev/null 2>&1   =
                                                                         =
                                                                         =
      =20
mv -f .deps/libnative_la-event.Tpo .deps/libnative_la-event.Plo          =
                                                                         =
                                                                         =
                 =20
/bin/sh ../../../libtool --tag=3DCC   --mode=3Dcompile /home/malek/minisy=
s/xenomai/buildroot/build_i686/staging_dir/usr/bin/i686-linux-uclibc-gcc =
-Os  -I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/i=
nclude -I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/inc=
lude --sysroot=3D/home/malek/minisys/xenomai/buildroot/build_i686/staging=
_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/build_i686/staging_=
dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFILE_SOURCE -D_LARGEF=
ILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -I. -I../../../src/=
include  -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fstrict-aliasing -Wn=
o-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prototypes -I../../..=
/include    -MT libnative_la-heap.lo -MD -MP -MF .deps/libnative_la-heap.=
Tpo -c -o libnative_la-heap.lo `test -f 'heap.c' || echo './'`heap.c     =
                                                                         =
          =20
 /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin/i68=
6-linux-uclibc-gcc -Os -I/home/malek/minisys/xenomai/buildroot/build_i686=
/staging_dir/usr/include -I/home/malek/minisys/xenomai/buildroot/build_i6=
86/staging_dir/include --sysroot=3D/home/malek/minisys/xenomai/buildroot/=
build_i686/staging_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/b=
uild_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFIL=
E_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -=
I. -I../../../src/include -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fst=
rict-aliasing -Wno-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prot=
otypes -I../../../include -MT libnative_la-heap.lo -MD -MP -MF .deps/libn=
ative_la-heap.Tpo -c heap.c  -fPIC -DPIC -o .libs/libnative_la-heap.o    =
                                                                         =
                                                                         =
      =20
 /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin/i68=
6-linux-uclibc-gcc -Os -I/home/malek/minisys/xenomai/buildroot/build_i686=
/staging_dir/usr/include -I/home/malek/minisys/xenomai/buildroot/build_i6=
86/staging_dir/include --sysroot=3D/home/malek/minisys/xenomai/buildroot/=
build_i686/staging_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/b=
uild_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFIL=
E_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -=
I. -I../../../src/include -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fst=
rict-aliasing -Wno-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prot=
otypes -I../../../include -MT libnative_la-heap.lo -MD -MP -MF .deps/libn=
ative_la-heap.Tpo -c heap.c -o libnative_la-heap.o >/dev/null 2>&1       =
                                                                         =
                                                                         =
      =20
mv -f .deps/libnative_la-heap.Tpo .deps/libnative_la-heap.Plo            =
                                                                         =
                                                                         =
                 =20
/bin/sh ../../../libtool --tag=3DCC   --mode=3Dcompile /home/malek/minisy=
s/xenomai/buildroot/build_i686/staging_dir/usr/bin/i686-linux-uclibc-gcc =
-Os  -I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/i=
nclude -I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/inc=
lude --sysroot=3D/home/malek/minisys/xenomai/buildroot/build_i686/staging=
_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/build_i686/staging_=
dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFILE_SOURCE -D_LARGEF=
ILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -I. -I../../../src/=
include  -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fstrict-aliasing -Wn=
o-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prototypes -I../../..=
/include    -MT libnative_la-init.lo -MD -MP -MF .deps/libnative_la-init.=
Tpo -c -o libnative_la-init.lo `test -f 'init.c' || echo './'`init.c     =
                                                                         =
          =20
 /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin/i68=
6-linux-uclibc-gcc -Os -I/home/malek/minisys/xenomai/buildroot/build_i686=
/staging_dir/usr/include -I/home/malek/minisys/xenomai/buildroot/build_i6=
86/staging_dir/include --sysroot=3D/home/malek/minisys/xenomai/buildroot/=
build_i686/staging_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/b=
uild_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFIL=
E_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -=
I. -I../../../src/include -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fst=
rict-aliasing -Wno-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prot=
otypes -I../../../include -MT libnative_la-init.lo -MD -MP -MF .deps/libn=
ative_la-init.Tpo -c init.c  -fPIC -DPIC -o .libs/libnative_la-init.o    =
                                                                         =
                                                                         =
      =20
 /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin/i68=
6-linux-uclibc-gcc -Os -I/home/malek/minisys/xenomai/buildroot/build_i686=
/staging_dir/usr/include -I/home/malek/minisys/xenomai/buildroot/build_i6=
86/staging_dir/include --sysroot=3D/home/malek/minisys/xenomai/buildroot/=
build_i686/staging_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/b=
uild_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFIL=
E_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -=
I. -I../../../src/include -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fst=
rict-aliasing -Wno-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prot=
otypes -I../../../include -MT libnative_la-init.lo -MD -MP -MF .deps/libn=
ative_la-init.Tpo -c init.c -o libnative_la-init.o >/dev/null 2>&1       =
                                                                         =
                                                                         =
      =20
mv -f .deps/libnative_la-init.Tpo .deps/libnative_la-init.Plo            =
                                                                         =
                                                                         =
                 =20
/bin/sh ../../../libtool --tag=3DCC   --mode=3Dcompile /home/malek/minisy=
s/xenomai/buildroot/build_i686/staging_dir/usr/bin/i686-linux-uclibc-gcc =
-Os  -I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/i=
nclude -I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/inc=
lude --sysroot=3D/home/malek/minisys/xenomai/buildroot/build_i686/staging=
_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/build_i686/staging_=
dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFILE_SOURCE -D_LARGEF=
ILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -I. -I../../../src/=
include  -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fstrict-aliasing -Wn=
o-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prototypes -I../../..=
/include    -MT libnative_la-intr.lo -MD -MP -MF .deps/libnative_la-intr.=
Tpo -c -o libnative_la-intr.lo `test -f 'intr.c' || echo './'`intr.c     =
                                                                         =
          =20
 /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin/i68=
6-linux-uclibc-gcc -Os -I/home/malek/minisys/xenomai/buildroot/build_i686=
/staging_dir/usr/include -I/home/malek/minisys/xenomai/buildroot/build_i6=
86/staging_dir/include --sysroot=3D/home/malek/minisys/xenomai/buildroot/=
build_i686/staging_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/b=
uild_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFIL=
E_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -=
I. -I../../../src/include -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fst=
rict-aliasing -Wno-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prot=
otypes -I../../../include -MT libnative_la-intr.lo -MD -MP -MF .deps/libn=
ative_la-intr.Tpo -c intr.c  -fPIC -DPIC -o .libs/libnative_la-intr.o    =
                                                                         =
                                                                         =
      =20
 /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin/i68=
6-linux-uclibc-gcc -Os -I/home/malek/minisys/xenomai/buildroot/build_i686=
/staging_dir/usr/include -I/home/malek/minisys/xenomai/buildroot/build_i6=
86/staging_dir/include --sysroot=3D/home/malek/minisys/xenomai/buildroot/=
build_i686/staging_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/b=
uild_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFIL=
E_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -=
I. -I../../../src/include -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fst=
rict-aliasing -Wno-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prot=
otypes -I../../../include -MT libnative_la-intr.lo -MD -MP -MF .deps/libn=
ative_la-intr.Tpo -c intr.c -o libnative_la-intr.o >/dev/null 2>&1       =
                                                                         =
                                                                         =
      =20
mv -f .deps/libnative_la-intr.Tpo .deps/libnative_la-intr.Plo            =
                                                                         =
                                                                         =
                 =20
/bin/sh ../../../libtool --tag=3DCC   --mode=3Dcompile /home/malek/minisy=
s/xenomai/buildroot/build_i686/staging_dir/usr/bin/i686-linux-uclibc-gcc =
-Os  -I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/i=
nclude -I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/inc=
lude --sysroot=3D/home/malek/minisys/xenomai/buildroot/build_i686/staging=
_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/build_i686/staging_=
dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFILE_SOURCE -D_LARGEF=
ILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -I. -I../../../src/=
include  -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fstrict-aliasing -Wn=
o-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prototypes -I../../..=
/include    -MT libnative_la-misc.lo -MD -MP -MF .deps/libnative_la-misc.=
Tpo -c -o libnative_la-misc.lo `test -f 'misc.c' || echo './'`misc.c     =
                                                                         =
          =20
 /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin/i68=
6-linux-uclibc-gcc -Os -I/home/malek/minisys/xenomai/buildroot/build_i686=
/staging_dir/usr/include -I/home/malek/minisys/xenomai/buildroot/build_i6=
86/staging_dir/include --sysroot=3D/home/malek/minisys/xenomai/buildroot/=
build_i686/staging_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/b=
uild_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFIL=
E_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -=
I. -I../../../src/include -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fst=
rict-aliasing -Wno-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prot=
otypes -I../../../include -MT libnative_la-misc.lo -MD -MP -MF .deps/libn=
ative_la-misc.Tpo -c misc.c  -fPIC -DPIC -o .libs/libnative_la-misc.o    =
                                                                         =
                                                                         =
      =20
 /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin/i68=
6-linux-uclibc-gcc -Os -I/home/malek/minisys/xenomai/buildroot/build_i686=
/staging_dir/usr/include -I/home/malek/minisys/xenomai/buildroot/build_i6=
86/staging_dir/include --sysroot=3D/home/malek/minisys/xenomai/buildroot/=
build_i686/staging_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/b=
uild_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFIL=
E_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -=
I. -I../../../src/include -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fst=
rict-aliasing -Wno-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prot=
otypes -I../../../include -MT libnative_la-misc.lo -MD -MP -MF .deps/libn=
ative_la-misc.Tpo -c misc.c -o libnative_la-misc.o >/dev/null 2>&1       =
                                                                         =
                                                                         =
      =20
mv -f .deps/libnative_la-misc.Tpo .deps/libnative_la-misc.Plo            =
                                                                         =
                                                                         =
                 =20
/bin/sh ../../../libtool --tag=3DCC   --mode=3Dcompile /home/malek/minisy=
s/xenomai/buildroot/build_i686/staging_dir/usr/bin/i686-linux-uclibc-gcc =
-Os  -I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/i=
nclude -I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/inc=
lude --sysroot=3D/home/malek/minisys/xenomai/buildroot/build_i686/staging=
_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/build_i686/staging_=
dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFILE_SOURCE -D_LARGEF=
ILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -I. -I../../../src/=
include  -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fstrict-aliasing -Wn=
o-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prototypes -I../../..=
/include    -MT libnative_la-mutex.lo -MD -MP -MF .deps/libnative_la-mute=
x.Tpo -c -o libnative_la-mutex.lo `test -f 'mutex.c' || echo './'`mutex.c=
                                                                         =
          =20
 /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin/i68=
6-linux-uclibc-gcc -Os -I/home/malek/minisys/xenomai/buildroot/build_i686=
/staging_dir/usr/include -I/home/malek/minisys/xenomai/buildroot/build_i6=
86/staging_dir/include --sysroot=3D/home/malek/minisys/xenomai/buildroot/=
build_i686/staging_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/b=
uild_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFIL=
E_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -=
I. -I../../../src/include -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fst=
rict-aliasing -Wno-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prot=
otypes -I../../../include -MT libnative_la-mutex.lo -MD -MP -MF .deps/lib=
native_la-mutex.Tpo -c mutex.c  -fPIC -DPIC -o .libs/libnative_la-mutex.o=
                                                                         =
                                                                         =
      =20
 /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin/i68=
6-linux-uclibc-gcc -Os -I/home/malek/minisys/xenomai/buildroot/build_i686=
/staging_dir/usr/include -I/home/malek/minisys/xenomai/buildroot/build_i6=
86/staging_dir/include --sysroot=3D/home/malek/minisys/xenomai/buildroot/=
build_i686/staging_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/b=
uild_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFIL=
E_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -=
I. -I../../../src/include -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fst=
rict-aliasing -Wno-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prot=
otypes -I../../../include -MT libnative_la-mutex.lo -MD -MP -MF .deps/lib=
native_la-mutex.Tpo -c mutex.c -o libnative_la-mutex.o >/dev/null 2>&1   =
                                                                         =
                                                                         =
      =20
mv -f .deps/libnative_la-mutex.Tpo .deps/libnative_la-mutex.Plo          =
                                                                         =
                                                                         =
                 =20
/bin/sh ../../../libtool --tag=3DCC   --mode=3Dcompile /home/malek/minisy=
s/xenomai/buildroot/build_i686/staging_dir/usr/bin/i686-linux-uclibc-gcc =
-Os  -I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/i=
nclude -I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/inc=
lude --sysroot=3D/home/malek/minisys/xenomai/buildroot/build_i686/staging=
_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/build_i686/staging_=
dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFILE_SOURCE -D_LARGEF=
ILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -I. -I../../../src/=
include  -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fstrict-aliasing -Wn=
o-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prototypes -I../../..=
/include    -MT libnative_la-pipe.lo -MD -MP -MF .deps/libnative_la-pipe.=
Tpo -c -o libnative_la-pipe.lo `test -f 'pipe.c' || echo './'`pipe.c     =
                                                                         =
          =20
 /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin/i68=
6-linux-uclibc-gcc -Os -I/home/malek/minisys/xenomai/buildroot/build_i686=
/staging_dir/usr/include -I/home/malek/minisys/xenomai/buildroot/build_i6=
86/staging_dir/include --sysroot=3D/home/malek/minisys/xenomai/buildroot/=
build_i686/staging_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/b=
uild_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFIL=
E_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -=
I. -I../../../src/include -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fst=
rict-aliasing -Wno-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prot=
otypes -I../../../include -MT libnative_la-pipe.lo -MD -MP -MF .deps/libn=
ative_la-pipe.Tpo -c pipe.c  -fPIC -DPIC -o .libs/libnative_la-pipe.o    =
                                                                         =
                                                                         =
      =20
 /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin/i68=
6-linux-uclibc-gcc -Os -I/home/malek/minisys/xenomai/buildroot/build_i686=
/staging_dir/usr/include -I/home/malek/minisys/xenomai/buildroot/build_i6=
86/staging_dir/include --sysroot=3D/home/malek/minisys/xenomai/buildroot/=
build_i686/staging_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/b=
uild_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFIL=
E_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -=
I. -I../../../src/include -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fst=
rict-aliasing -Wno-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prot=
otypes -I../../../include -MT libnative_la-pipe.lo -MD -MP -MF .deps/libn=
ative_la-pipe.Tpo -c pipe.c -o libnative_la-pipe.o >/dev/null 2>&1       =
                                                                         =
                                                                         =
      =20
mv -f .deps/libnative_la-pipe.Tpo .deps/libnative_la-pipe.Plo            =
                                                                         =
                                                                         =
                 =20
/bin/sh ../../../libtool --tag=3DCC   --mode=3Dcompile /home/malek/minisy=
s/xenomai/buildroot/build_i686/staging_dir/usr/bin/i686-linux-uclibc-gcc =
-Os  -I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/i=
nclude -I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/inc=
lude --sysroot=3D/home/malek/minisys/xenomai/buildroot/build_i686/staging=
_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/build_i686/staging_=
dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFILE_SOURCE -D_LARGEF=
ILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -I. -I../../../src/=
include  -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fstrict-aliasing -Wn=
o-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prototypes -I../../..=
/include    -MT libnative_la-queue.lo -MD -MP -MF .deps/libnative_la-queu=
e.Tpo -c -o libnative_la-queue.lo `test -f 'queue.c' || echo './'`queue.c=
                                                                         =
          =20
 /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin/i68=
6-linux-uclibc-gcc -Os -I/home/malek/minisys/xenomai/buildroot/build_i686=
/staging_dir/usr/include -I/home/malek/minisys/xenomai/buildroot/build_i6=
86/staging_dir/include --sysroot=3D/home/malek/minisys/xenomai/buildroot/=
build_i686/staging_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/b=
uild_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFIL=
E_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -=
I. -I../../../src/include -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fst=
rict-aliasing -Wno-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prot=
otypes -I../../../include -MT libnative_la-queue.lo -MD -MP -MF .deps/lib=
native_la-queue.Tpo -c queue.c  -fPIC -DPIC -o .libs/libnative_la-queue.o=
                                                                         =
                                                                         =
      =20
 /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin/i68=
6-linux-uclibc-gcc -Os -I/home/malek/minisys/xenomai/buildroot/build_i686=
/staging_dir/usr/include -I/home/malek/minisys/xenomai/buildroot/build_i6=
86/staging_dir/include --sysroot=3D/home/malek/minisys/xenomai/buildroot/=
build_i686/staging_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/b=
uild_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFIL=
E_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -=
I. -I../../../src/include -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fst=
rict-aliasing -Wno-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prot=
otypes -I../../../include -MT libnative_la-queue.lo -MD -MP -MF .deps/lib=
native_la-queue.Tpo -c queue.c -o libnative_la-queue.o >/dev/null 2>&1   =
                                                                         =
                                                                         =
      =20
mv -f .deps/libnative_la-queue.Tpo .deps/libnative_la-queue.Plo          =
                                                                         =
                                                                         =
                 =20
/bin/sh ../../../libtool --tag=3DCC   --mode=3Dcompile /home/malek/minisy=
s/xenomai/buildroot/build_i686/staging_dir/usr/bin/i686-linux-uclibc-gcc =
-Os  -I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/i=
nclude -I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/inc=
lude --sysroot=3D/home/malek/minisys/xenomai/buildroot/build_i686/staging=
_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/build_i686/staging_=
dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFILE_SOURCE -D_LARGEF=
ILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -I. -I../../../src/=
include  -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fstrict-aliasing -Wn=
o-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prototypes -I../../..=
/include    -MT libnative_la-sem.lo -MD -MP -MF .deps/libnative_la-sem.Tp=
o -c -o libnative_la-sem.lo `test -f 'sem.c' || echo './'`sem.c          =
                                                                         =
          =20
 /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin/i68=
6-linux-uclibc-gcc -Os -I/home/malek/minisys/xenomai/buildroot/build_i686=
/staging_dir/usr/include -I/home/malek/minisys/xenomai/buildroot/build_i6=
86/staging_dir/include --sysroot=3D/home/malek/minisys/xenomai/buildroot/=
build_i686/staging_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/b=
uild_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFIL=
E_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -=
I. -I../../../src/include -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fst=
rict-aliasing -Wno-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prot=
otypes -I../../../include -MT libnative_la-sem.lo -MD -MP -MF .deps/libna=
tive_la-sem.Tpo -c sem.c  -fPIC -DPIC -o .libs/libnative_la-sem.o        =
                                                                         =
                                                                         =
      =20
 /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin/i68=
6-linux-uclibc-gcc -Os -I/home/malek/minisys/xenomai/buildroot/build_i686=
/staging_dir/usr/include -I/home/malek/minisys/xenomai/buildroot/build_i6=
86/staging_dir/include --sysroot=3D/home/malek/minisys/xenomai/buildroot/=
build_i686/staging_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/b=
uild_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFIL=
E_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -=
I. -I../../../src/include -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fst=
rict-aliasing -Wno-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prot=
otypes -I../../../include -MT libnative_la-sem.lo -MD -MP -MF .deps/libna=
tive_la-sem.Tpo -c sem.c -o libnative_la-sem.o >/dev/null 2>&1           =
                                                                         =
                                                                         =
      =20
mv -f .deps/libnative_la-sem.Tpo .deps/libnative_la-sem.Plo              =
                                                                         =
                                                                         =
                 =20
/bin/sh ../../../libtool --tag=3DCC   --mode=3Dcompile /home/malek/minisy=
s/xenomai/buildroot/build_i686/staging_dir/usr/bin/i686-linux-uclibc-gcc =
-Os  -I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/i=
nclude -I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/inc=
lude --sysroot=3D/home/malek/minisys/xenomai/buildroot/build_i686/staging=
_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/build_i686/staging_=
dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFILE_SOURCE -D_LARGEF=
ILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -I. -I../../../src/=
include  -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fstrict-aliasing -Wn=
o-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prototypes -I../../..=
/include    -MT libnative_la-task.lo -MD -MP -MF .deps/libnative_la-task.=
Tpo -c -o libnative_la-task.lo `test -f 'task.c' || echo './'`task.c     =
                                                                         =
          =20
 /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin/i68=
6-linux-uclibc-gcc -Os -I/home/malek/minisys/xenomai/buildroot/build_i686=
/staging_dir/usr/include -I/home/malek/minisys/xenomai/buildroot/build_i6=
86/staging_dir/include --sysroot=3D/home/malek/minisys/xenomai/buildroot/=
build_i686/staging_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/b=
uild_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFIL=
E_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -=
I. -I../../../src/include -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fst=
rict-aliasing -Wno-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prot=
otypes -I../../../include -MT libnative_la-task.lo -MD -MP -MF .deps/libn=
ative_la-task.Tpo -c task.c  -fPIC -DPIC -o .libs/libnative_la-task.o    =
                                                                         =
                                                                         =
      =20
 /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin/i68=
6-linux-uclibc-gcc -Os -I/home/malek/minisys/xenomai/buildroot/build_i686=
/staging_dir/usr/include -I/home/malek/minisys/xenomai/buildroot/build_i6=
86/staging_dir/include --sysroot=3D/home/malek/minisys/xenomai/buildroot/=
build_i686/staging_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/b=
uild_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFIL=
E_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -=
I. -I../../../src/include -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fst=
rict-aliasing -Wno-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prot=
otypes -I../../../include -MT libnative_la-task.lo -MD -MP -MF .deps/libn=
ative_la-task.Tpo -c task.c -o libnative_la-task.o >/dev/null 2>&1       =
                                                                         =
                                                                         =
      =20
mv -f .deps/libnative_la-task.Tpo .deps/libnative_la-task.Plo            =
                                                                         =
                                                                         =
                 =20
/bin/sh ../../../libtool --tag=3DCC   --mode=3Dcompile /home/malek/minisy=
s/xenomai/buildroot/build_i686/staging_dir/usr/bin/i686-linux-uclibc-gcc =
-Os  -I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/i=
nclude -I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/inc=
lude --sysroot=3D/home/malek/minisys/xenomai/buildroot/build_i686/staging=
_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/build_i686/staging_=
dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFILE_SOURCE -D_LARGEF=
ILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -I. -I../../../src/=
include  -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fstrict-aliasing -Wn=
o-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prototypes -I../../..=
/include    -MT libnative_la-timer.lo -MD -MP -MF .deps/libnative_la-time=
r.Tpo -c -o libnative_la-timer.lo `test -f 'timer.c' || echo './'`timer.c=
                                                                         =
          =20
 /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin/i68=
6-linux-uclibc-gcc -Os -I/home/malek/minisys/xenomai/buildroot/build_i686=
/staging_dir/usr/include -I/home/malek/minisys/xenomai/buildroot/build_i6=
86/staging_dir/include --sysroot=3D/home/malek/minisys/xenomai/buildroot/=
build_i686/staging_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/b=
uild_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFIL=
E_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -=
I. -I../../../src/include -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fst=
rict-aliasing -Wno-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prot=
otypes -I../../../include -MT libnative_la-timer.lo -MD -MP -MF .deps/lib=
native_la-timer.Tpo -c timer.c  -fPIC -DPIC -o .libs/libnative_la-timer.o=
                                                                         =
                                                                         =
      =20
 /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin/i68=
6-linux-uclibc-gcc -Os -I/home/malek/minisys/xenomai/buildroot/build_i686=
/staging_dir/usr/include -I/home/malek/minisys/xenomai/buildroot/build_i6=
86/staging_dir/include --sysroot=3D/home/malek/minisys/xenomai/buildroot/=
build_i686/staging_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/b=
uild_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFIL=
E_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -=
I. -I../../../src/include -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fst=
rict-aliasing -Wno-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prot=
otypes -I../../../include -MT libnative_la-timer.lo -MD -MP -MF .deps/lib=
native_la-timer.Tpo -c timer.c -o libnative_la-timer.o >/dev/null 2>&1   =
                                                                         =
                                                                         =
      =20
mv -f .deps/libnative_la-timer.Tpo .deps/libnative_la-timer.Plo          =
                                                                         =
                                                                         =
                 =20
/bin/sh ../../../libtool --tag=3DCC   --mode=3Dcompile /home/malek/minisy=
s/xenomai/buildroot/build_i686/staging_dir/usr/bin/i686-linux-uclibc-gcc =
-Os  -I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/i=
nclude -I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/inc=
lude --sysroot=3D/home/malek/minisys/xenomai/buildroot/build_i686/staging=
_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/build_i686/staging_=
dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFILE_SOURCE -D_LARGEF=
ILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -I. -I../../../src/=
include  -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fstrict-aliasing -Wn=
o-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prototypes -I../../..=
/include    -MT libnative_la-wrappers.lo -MD -MP -MF .deps/libnative_la-w=
rappers.Tpo -c -o libnative_la-wrappers.lo `test -f 'wrappers.c' || echo =
'./'`wrappers.c                                                          =
          =20
 /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin/i68=
6-linux-uclibc-gcc -Os -I/home/malek/minisys/xenomai/buildroot/build_i686=
/staging_dir/usr/include -I/home/malek/minisys/xenomai/buildroot/build_i6=
86/staging_dir/include --sysroot=3D/home/malek/minisys/xenomai/buildroot/=
build_i686/staging_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/b=
uild_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFIL=
E_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -=
I. -I../../../src/include -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fst=
rict-aliasing -Wno-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prot=
otypes -I../../../include -MT libnative_la-wrappers.lo -MD -MP -MF .deps/=
libnative_la-wrappers.Tpo -c wrappers.c  -fPIC -DPIC -o .libs/libnative_l=
a-wrappers.o                                                             =
                                                                         =
      =20
 /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin/i68=
6-linux-uclibc-gcc -Os -I/home/malek/minisys/xenomai/buildroot/build_i686=
/staging_dir/usr/include -I/home/malek/minisys/xenomai/buildroot/build_i6=
86/staging_dir/include --sysroot=3D/home/malek/minisys/xenomai/buildroot/=
build_i686/staging_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/b=
uild_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFIL=
E_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -=
I. -I../../../src/include -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fst=
rict-aliasing -Wno-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prot=
otypes -I../../../include -MT libnative_la-wrappers.lo -MD -MP -MF .deps/=
libnative_la-wrappers.Tpo -c wrappers.c -o libnative_la-wrappers.o >/dev/=
null 2>&1                                                                =
                                                                         =
      =20
mv -f .deps/libnative_la-wrappers.Tpo .deps/libnative_la-wrappers.Plo    =
                                                                         =
                                                                         =
                 =20
/bin/sh ../../../libtool --tag=3DCC   --mode=3Dlink /home/malek/minisys/x=
enomai/buildroot/build_i686/staging_dir/usr/bin/i686-linux-uclibc-gcc -Os=
  -I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/incl=
ude -I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/includ=
e --sysroot=3D/home/malek/minisys/xenomai/buildroot/build_i686/staging_di=
r/ -isysroot /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir=
 -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFILE_SOURCE -D_LARGEFILE=
64_SOURCE -D_FILE_OFFSET_BITS=3D64   -version-info 1:0:0 -lpthread  -o li=
bnative.la -rpath /usr/lib libnative_la-alarm.lo libnative_la-cond.lo lib=
native_la-event.lo libnative_la-heap.lo libnative_la-init.lo libnative_la=
-intr.lo libnative_la-misc.lo libnative_la-mutex.lo libnative_la-pipe.lo =
libnative_la-queue.lo libnative_la-sem.lo libnative_la-task.lo libnative_=
la-timer.lo libnative_la-wrappers.lo                                     =
          =20
/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin/i686=
-linux-uclibc-gcc -Os  -I/home/malek/minisys/xenomai/buildroot/build_i686=
/staging_dir/usr/include -I/home/malek/minisys/xenomai/buildroot/build_i6=
86/staging_dir/include --sysroot=3D/home/malek/minisys/xenomai/buildroot/=
build_i686/staging_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/b=
uild_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFIL=
E_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -shared  .libs/li=
bnative_la-alarm.o .libs/libnative_la-cond.o .libs/libnative_la-event.o .=
libs/libnative_la-heap.o .libs/libnative_la-init.o .libs/libnative_la-int=
r.o .libs/libnative_la-misc.o .libs/libnative_la-mutex.o .libs/libnative_=
la-pipe.o .libs/libnative_la-queue.o .libs/libnative_la-sem.o .libs/libna=
tive_la-task.o .libs/libnative_la-timer.o .libs/libnative_la-wrappers.o  =
-lpthread  -mtune=3Dpentiumpro -march=3Dpentiumpro -Wl,-soname -Wl,libnat=
ive.so.1 -o .libs/libnative.so.1.0.0                                     =
                                                                         =
                                                                         =
                            =20
(cd .libs && rm -f libnative.so.1 && ln -s libnative.so.1.0.0 libnative.s=
o.1)                                                                     =
                                                                         =
                 =20
(cd .libs && rm -f libnative.so && ln -s libnative.so.1.0.0 libnative.so)=
                                                                         =
                                                                         =
                 =20
/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin/i686=
-linux-uclibc-ar cru .libs/libnative.a  libnative_la-alarm.o libnative_la=
-cond.o libnative_la-event.o libnative_la-heap.o libnative_la-init.o libn=
ative_la-intr.o libnative_la-misc.o libnative_la-mutex.o libnative_la-pip=
e.o libnative_la-queue.o libnative_la-sem.o libnative_la-task.o libnative=
_la-timer.o libnative_la-wrappers.o                                      =
                                   =20
/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin/i686=
-linux-uclibc-ranlib .libs/libnative.a                                   =
                                                                         =
                 =20
creating libnative.la                                                    =
                                                                         =
                                                                         =
                 =20
(cd .libs && rm -f libnative.la && ln -s ../libnative.la libnative.la)   =
                                                                         =
                                                                         =
                 =20
make[4]: quittant le r=C3=A9pertoire =C2=AB /home/malek/minisys/xenomai/b=
uildroot/build_i686/xenomai-2.4.5/src/skins/native =C2=BB                =
                                                                         =
                                =20
Making all in posix                                                      =
                                                                         =
                                                                         =
                 =20
make[4]: entrant dans le r=C3=A9pertoire =C2=AB /home/malek/minisys/xenom=
ai/buildroot/build_i686/xenomai-2.4.5/src/skins/posix =C2=BB             =
                                                                         =
                                =20
/bin/sh ../../../libtool --tag=3DCC   --mode=3Dcompile /home/malek/minisy=
s/xenomai/buildroot/build_i686/staging_dir/usr/bin/i686-linux-uclibc-gcc =
-Os  -I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/i=
nclude -I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/inc=
lude --sysroot=3D/home/malek/minisys/xenomai/buildroot/build_i686/staging=
_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/build_i686/staging_=
dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFILE_SOURCE -D_LARGEF=
ILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -I. -I../../../src/=
include  -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fstrict-aliasing -Wn=
o-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prototypes -I../../..=
/include -I../../../include/posix    -MT libpthread_rt_la-init.lo -MD -MP=
 -MF .deps/libpthread_rt_la-init.Tpo -c -o libpthread_rt_la-init.lo `test=
 -f 'init.c' || echo './'`init.c                                         =
          =20
mkdir .libs                                                              =
                                                                         =
                                                                         =
                 =20
 /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin/i68=
6-linux-uclibc-gcc -Os -I/home/malek/minisys/xenomai/buildroot/build_i686=
/staging_dir/usr/include -I/home/malek/minisys/xenomai/buildroot/build_i6=
86/staging_dir/include --sysroot=3D/home/malek/minisys/xenomai/buildroot/=
build_i686/staging_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/b=
uild_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFIL=
E_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -=
I. -I../../../src/include -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fst=
rict-aliasing -Wno-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prot=
otypes -I../../../include -I../../../include/posix -MT libpthread_rt_la-i=
nit.lo -MD -MP -MF .deps/libpthread_rt_la-init.Tpo -c init.c  -fPIC -DPIC=
 -o .libs/libpthread_rt_la-init.o                                        =
                                                                         =
      =20
 /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin/i68=
6-linux-uclibc-gcc -Os -I/home/malek/minisys/xenomai/buildroot/build_i686=
/staging_dir/usr/include -I/home/malek/minisys/xenomai/buildroot/build_i6=
86/staging_dir/include --sysroot=3D/home/malek/minisys/xenomai/buildroot/=
build_i686/staging_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/b=
uild_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFIL=
E_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -=
I. -I../../../src/include -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fst=
rict-aliasing -Wno-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prot=
otypes -I../../../include -I../../../include/posix -MT libpthread_rt_la-i=
nit.lo -MD -MP -MF .deps/libpthread_rt_la-init.Tpo -c init.c -o libpthrea=
d_rt_la-init.o >/dev/null 2>&1                                           =
                                                                         =
      =20
mv -f .deps/libpthread_rt_la-init.Tpo .deps/libpthread_rt_la-init.Plo    =
                                                                         =
                                                                         =
                 =20
/bin/sh ../../../libtool --tag=3DCC   --mode=3Dcompile /home/malek/minisy=
s/xenomai/buildroot/build_i686/staging_dir/usr/bin/i686-linux-uclibc-gcc =
-Os  -I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/i=
nclude -I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/inc=
lude --sysroot=3D/home/malek/minisys/xenomai/buildroot/build_i686/staging=
_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/build_i686/staging_=
dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFILE_SOURCE -D_LARGEF=
ILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -I. -I../../../src/=
include  -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fstrict-aliasing -Wn=
o-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prototypes -I../../..=
/include -I../../../include/posix    -MT libpthread_rt_la-thread.lo -MD -=
MP -MF .deps/libpthread_rt_la-thread.Tpo -c -o libpthread_rt_la-thread.lo=
 `test -f 'thread.c' || echo './'`thread.c                               =
          =20
 /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin/i68=
6-linux-uclibc-gcc -Os -I/home/malek/minisys/xenomai/buildroot/build_i686=
/staging_dir/usr/include -I/home/malek/minisys/xenomai/buildroot/build_i6=
86/staging_dir/include --sysroot=3D/home/malek/minisys/xenomai/buildroot/=
build_i686/staging_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/b=
uild_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFIL=
E_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -=
I. -I../../../src/include -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fst=
rict-aliasing -Wno-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prot=
otypes -I../../../include -I../../../include/posix -MT libpthread_rt_la-t=
hread.lo -MD -MP -MF .deps/libpthread_rt_la-thread.Tpo -c thread.c  -fPIC=
 -DPIC -o .libs/libpthread_rt_la-thread.o                                =
                                                                         =
      =20
thread.c: In function 'pse51_thread_init':                               =
                                                                         =
                                                                         =
                 =20
thread.c:283: warning: unused variable 'vers'                            =
                                                                         =
                                                                         =
                 =20
 /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin/i68=
6-linux-uclibc-gcc -Os -I/home/malek/minisys/xenomai/buildroot/build_i686=
/staging_dir/usr/include -I/home/malek/minisys/xenomai/buildroot/build_i6=
86/staging_dir/include --sysroot=3D/home/malek/minisys/xenomai/buildroot/=
build_i686/staging_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/b=
uild_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFIL=
E_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -=
I. -I../../../src/include -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fst=
rict-aliasing -Wno-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prot=
otypes -I../../../include -I../../../include/posix -MT libpthread_rt_la-t=
hread.lo -MD -MP -MF .deps/libpthread_rt_la-thread.Tpo -c thread.c -o lib=
pthread_rt_la-thread.o >/dev/null 2>&1                                   =
                                                                         =
      =20
mv -f .deps/libpthread_rt_la-thread.Tpo .deps/libpthread_rt_la-thread.Plo=
                                                                         =
                                                                         =
                 =20
/bin/sh ../../../libtool --tag=3DCC   --mode=3Dcompile /home/malek/minisy=
s/xenomai/buildroot/build_i686/staging_dir/usr/bin/i686-linux-uclibc-gcc =
-Os  -I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/i=
nclude -I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/inc=
lude --sysroot=3D/home/malek/minisys/xenomai/buildroot/build_i686/staging=
_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/build_i686/staging_=
dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFILE_SOURCE -D_LARGEF=
ILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -I. -I../../../src/=
include  -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fstrict-aliasing -Wn=
o-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prototypes -I../../..=
/include -I../../../include/posix    -MT libpthread_rt_la-timer.lo -MD -M=
P -MF .deps/libpthread_rt_la-timer.Tpo -c -o libpthread_rt_la-timer.lo `t=
est -f 'timer.c' || echo './'`timer.c                                    =
          =20
 /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin/i68=
6-linux-uclibc-gcc -Os -I/home/malek/minisys/xenomai/buildroot/build_i686=
/staging_dir/usr/include -I/home/malek/minisys/xenomai/buildroot/build_i6=
86/staging_dir/include --sysroot=3D/home/malek/minisys/xenomai/buildroot/=
build_i686/staging_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/b=
uild_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFIL=
E_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -=
I. -I../../../src/include -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fst=
rict-aliasing -Wno-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prot=
otypes -I../../../include -I../../../include/posix -MT libpthread_rt_la-t=
imer.lo -MD -MP -MF .deps/libpthread_rt_la-timer.Tpo -c timer.c  -fPIC -D=
PIC -o .libs/libpthread_rt_la-timer.o                                    =
                                                                         =
      =20
 /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin/i68=
6-linux-uclibc-gcc -Os -I/home/malek/minisys/xenomai/buildroot/build_i686=
/staging_dir/usr/include -I/home/malek/minisys/xenomai/buildroot/build_i6=
86/staging_dir/include --sysroot=3D/home/malek/minisys/xenomai/buildroot/=
build_i686/staging_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/b=
uild_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFIL=
E_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -=
I. -I../../../src/include -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fst=
rict-aliasing -Wno-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prot=
otypes -I../../../include -I../../../include/posix -MT libpthread_rt_la-t=
imer.lo -MD -MP -MF .deps/libpthread_rt_la-timer.Tpo -c timer.c -o libpth=
read_rt_la-timer.o >/dev/null 2>&1                                       =
                                                                         =
      =20
mv -f .deps/libpthread_rt_la-timer.Tpo .deps/libpthread_rt_la-timer.Plo  =
                                                                         =
                                                                         =
                 =20
/bin/sh ../../../libtool --tag=3DCC   --mode=3Dcompile /home/malek/minisy=
s/xenomai/buildroot/build_i686/staging_dir/usr/bin/i686-linux-uclibc-gcc =
-Os  -I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/i=
nclude -I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/inc=
lude --sysroot=3D/home/malek/minisys/xenomai/buildroot/build_i686/staging=
_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/build_i686/staging_=
dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFILE_SOURCE -D_LARGEF=
ILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -I. -I../../../src/=
include  -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fstrict-aliasing -Wn=
o-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prototypes -I../../..=
/include -I../../../include/posix    -MT libpthread_rt_la-semaphore.lo -M=
D -MP -MF .deps/libpthread_rt_la-semaphore.Tpo -c -o libpthread_rt_la-sem=
aphore.lo `test -f 'semaphore.c' || echo './'`semaphore.c                =
          =20
 /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin/i68=
6-linux-uclibc-gcc -Os -I/home/malek/minisys/xenomai/buildroot/build_i686=
/staging_dir/usr/include -I/home/malek/minisys/xenomai/buildroot/build_i6=
86/staging_dir/include --sysroot=3D/home/malek/minisys/xenomai/buildroot/=
build_i686/staging_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/b=
uild_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFIL=
E_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -=
I. -I../../../src/include -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fst=
rict-aliasing -Wno-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prot=
otypes -I../../../include -I../../../include/posix -MT libpthread_rt_la-s=
emaphore.lo -MD -MP -MF .deps/libpthread_rt_la-semaphore.Tpo -c semaphore=
=2Ec  -fPIC -DPIC -o .libs/libpthread_rt_la-semaphore.o                  =
                                                                         =
        =20
 /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin/i68=
6-linux-uclibc-gcc -Os -I/home/malek/minisys/xenomai/buildroot/build_i686=
/staging_dir/usr/include -I/home/malek/minisys/xenomai/buildroot/build_i6=
86/staging_dir/include --sysroot=3D/home/malek/minisys/xenomai/buildroot/=
build_i686/staging_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/b=
uild_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFIL=
E_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -=
I. -I../../../src/include -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fst=
rict-aliasing -Wno-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prot=
otypes -I../../../include -I../../../include/posix -MT libpthread_rt_la-s=
emaphore.lo -MD -MP -MF .deps/libpthread_rt_la-semaphore.Tpo -c semaphore=
=2Ec -o libpthread_rt_la-semaphore.o >/dev/null 2>&1                     =
                                                                         =
        =20
mv -f .deps/libpthread_rt_la-semaphore.Tpo .deps/libpthread_rt_la-semapho=
re.Plo                                                                   =
                                                                         =
                 =20
/bin/sh ../../../libtool --tag=3DCC   --mode=3Dcompile /home/malek/minisy=
s/xenomai/buildroot/build_i686/staging_dir/usr/bin/i686-linux-uclibc-gcc =
-Os  -I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/i=
nclude -I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/inc=
lude --sysroot=3D/home/malek/minisys/xenomai/buildroot/build_i686/staging=
_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/build_i686/staging_=
dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFILE_SOURCE -D_LARGEF=
ILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -I. -I../../../src/=
include  -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fstrict-aliasing -Wn=
o-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prototypes -I../../..=
/include -I../../../include/posix    -MT libpthread_rt_la-clock.lo -MD -M=
P -MF .deps/libpthread_rt_la-clock.Tpo -c -o libpthread_rt_la-clock.lo `t=
est -f 'clock.c' || echo './'`clock.c                                    =
          =20
 /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin/i68=
6-linux-uclibc-gcc -Os -I/home/malek/minisys/xenomai/buildroot/build_i686=
/staging_dir/usr/include -I/home/malek/minisys/xenomai/buildroot/build_i6=
86/staging_dir/include --sysroot=3D/home/malek/minisys/xenomai/buildroot/=
build_i686/staging_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/b=
uild_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFIL=
E_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -=
I. -I../../../src/include -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fst=
rict-aliasing -Wno-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prot=
otypes -I../../../include -I../../../include/posix -MT libpthread_rt_la-c=
lock.lo -MD -MP -MF .deps/libpthread_rt_la-clock.Tpo -c clock.c  -fPIC -D=
PIC -o .libs/libpthread_rt_la-clock.o                                    =
                                                                         =
      =20
 /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin/i68=
6-linux-uclibc-gcc -Os -I/home/malek/minisys/xenomai/buildroot/build_i686=
/staging_dir/usr/include -I/home/malek/minisys/xenomai/buildroot/build_i6=
86/staging_dir/include --sysroot=3D/home/malek/minisys/xenomai/buildroot/=
build_i686/staging_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/b=
uild_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFIL=
E_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -=
I. -I../../../src/include -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fst=
rict-aliasing -Wno-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prot=
otypes -I../../../include -I../../../include/posix -MT libpthread_rt_la-c=
lock.lo -MD -MP -MF .deps/libpthread_rt_la-clock.Tpo -c clock.c -o libpth=
read_rt_la-clock.o >/dev/null 2>&1                                       =
                                                                         =
      =20
mv -f .deps/libpthread_rt_la-clock.Tpo .deps/libpthread_rt_la-clock.Plo  =
                                                                         =
                                                                         =
                 =20
/bin/sh ../../../libtool --tag=3DCC   --mode=3Dcompile /home/malek/minisy=
s/xenomai/buildroot/build_i686/staging_dir/usr/bin/i686-linux-uclibc-gcc =
-Os  -I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/i=
nclude -I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/inc=
lude --sysroot=3D/home/malek/minisys/xenomai/buildroot/build_i686/staging=
_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/build_i686/staging_=
dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFILE_SOURCE -D_LARGEF=
ILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -I. -I../../../src/=
include  -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fstrict-aliasing -Wn=
o-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prototypes -I../../..=
/include -I../../../include/posix    -MT libpthread_rt_la-cond.lo -MD -MP=
 -MF .deps/libpthread_rt_la-cond.Tpo -c -o libpthread_rt_la-cond.lo `test=
 -f 'cond.c' || echo './'`cond.c                                         =
          =20
 /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin/i68=
6-linux-uclibc-gcc -Os -I/home/malek/minisys/xenomai/buildroot/build_i686=
/staging_dir/usr/include -I/home/malek/minisys/xenomai/buildroot/build_i6=
86/staging_dir/include --sysroot=3D/home/malek/minisys/xenomai/buildroot/=
build_i686/staging_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/b=
uild_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFIL=
E_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -=
I. -I../../../src/include -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fst=
rict-aliasing -Wno-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prot=
otypes -I../../../include -I../../../include/posix -MT libpthread_rt_la-c=
ond.lo -MD -MP -MF .deps/libpthread_rt_la-cond.Tpo -c cond.c  -fPIC -DPIC=
 -o .libs/libpthread_rt_la-cond.o
 /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin/i68=
6-linux-uclibc-gcc -Os -I/home/malek/minisys/xenomai/buildroot/build_i686=
/staging_dir/usr/include -I/home/malek/minisys/xenomai/buildroot/build_i6=
86/staging_dir/include --sysroot=3D/home/malek/minisys/xenomai/buildroot/=
build_i686/staging_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/b=
uild_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFIL=
E_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -=
I. -I../../../src/include -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fst=
rict-aliasing -Wno-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prot=
otypes -I../../../include -I../../../include/posix -MT libpthread_rt_la-c=
ond.lo -MD -MP -MF .deps/libpthread_rt_la-cond.Tpo -c cond.c -o libpthrea=
d_rt_la-cond.o >/dev/null 2>&1
mv -f .deps/libpthread_rt_la-cond.Tpo .deps/libpthread_rt_la-cond.Plo
/bin/sh ../../../libtool --tag=3DCC   --mode=3Dcompile /home/malek/minisy=
s/xenomai/buildroot/build_i686/staging_dir/usr/bin/i686-linux-uclibc-gcc =
-Os  -I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/i=
nclude -I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/inc=
lude --sysroot=3D/home/malek/minisys/xenomai/buildroot/build_i686/staging=
_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/build_i686/staging_=
dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFILE_SOURCE -D_LARGEF=
ILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -I. -I../../../src/=
include  -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fstrict-aliasing -Wn=
o-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prototypes -I../../..=
/include -I../../../include/posix    -MT libpthread_rt_la-mq.lo -MD -MP -=
MF .deps/libpthread_rt_la-mq.Tpo -c -o libpthread_rt_la-mq.lo `test -f 'm=
q.c' || echo './'`mq.c
 /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin/i68=
6-linux-uclibc-gcc -Os -I/home/malek/minisys/xenomai/buildroot/build_i686=
/staging_dir/usr/include -I/home/malek/minisys/xenomai/buildroot/build_i6=
86/staging_dir/include --sysroot=3D/home/malek/minisys/xenomai/buildroot/=
build_i686/staging_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/b=
uild_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFIL=
E_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -=
I. -I../../../src/include -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fst=
rict-aliasing -Wno-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prot=
otypes -I../../../include -I../../../include/posix -MT libpthread_rt_la-m=
q.lo -MD -MP -MF .deps/libpthread_rt_la-mq.Tpo -c mq.c  -fPIC -DPIC -o .l=
ibs/libpthread_rt_la-mq.o
 /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin/i68=
6-linux-uclibc-gcc -Os -I/home/malek/minisys/xenomai/buildroot/build_i686=
/staging_dir/usr/include -I/home/malek/minisys/xenomai/buildroot/build_i6=
86/staging_dir/include --sysroot=3D/home/malek/minisys/xenomai/buildroot/=
build_i686/staging_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/b=
uild_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFIL=
E_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -=
I. -I../../../src/include -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fst=
rict-aliasing -Wno-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prot=
otypes -I../../../include -I../../../include/posix -MT libpthread_rt_la-m=
q.lo -MD -MP -MF .deps/libpthread_rt_la-mq.Tpo -c mq.c -o libpthread_rt_l=
a-mq.o >/dev/null 2>&1
mv -f .deps/libpthread_rt_la-mq.Tpo .deps/libpthread_rt_la-mq.Plo
/bin/sh ../../../libtool --tag=3DCC   --mode=3Dcompile /home/malek/minisy=
s/xenomai/buildroot/build_i686/staging_dir/usr/bin/i686-linux-uclibc-gcc =
-Os  -I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/i=
nclude -I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/inc=
lude --sysroot=3D/home/malek/minisys/xenomai/buildroot/build_i686/staging=
_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/build_i686/staging_=
dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFILE_SOURCE -D_LARGEF=
ILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -I. -I../../../src/=
include  -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fstrict-aliasing -Wn=
o-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prototypes -I../../..=
/include -I../../../include/posix    -MT libpthread_rt_la-mutex.lo -MD -M=
P -MF .deps/libpthread_rt_la-mutex.Tpo -c -o libpthread_rt_la-mutex.lo `t=
est -f 'mutex.c' || echo './'`mutex.c
 /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin/i68=
6-linux-uclibc-gcc -Os -I/home/malek/minisys/xenomai/buildroot/build_i686=
/staging_dir/usr/include -I/home/malek/minisys/xenomai/buildroot/build_i6=
86/staging_dir/include --sysroot=3D/home/malek/minisys/xenomai/buildroot/=
build_i686/staging_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/b=
uild_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFIL=
E_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -=
I. -I../../../src/include -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fst=
rict-aliasing -Wno-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prot=
otypes -I../../../include -I../../../include/posix -MT libpthread_rt_la-m=
utex.lo -MD -MP -MF .deps/libpthread_rt_la-mutex.Tpo -c mutex.c  -fPIC -D=
PIC -o .libs/libpthread_rt_la-mutex.o
 /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin/i68=
6-linux-uclibc-gcc -Os -I/home/malek/minisys/xenomai/buildroot/build_i686=
/staging_dir/usr/include -I/home/malek/minisys/xenomai/buildroot/build_i6=
86/staging_dir/include --sysroot=3D/home/malek/minisys/xenomai/buildroot/=
build_i686/staging_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/b=
uild_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFIL=
E_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -=
I. -I../../../src/include -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fst=
rict-aliasing -Wno-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prot=
otypes -I../../../include -I../../../include/posix -MT libpthread_rt_la-m=
utex.lo -MD -MP -MF .deps/libpthread_rt_la-mutex.Tpo -c mutex.c -o libpth=
read_rt_la-mutex.o >/dev/null 2>&1
mv -f .deps/libpthread_rt_la-mutex.Tpo .deps/libpthread_rt_la-mutex.Plo
/bin/sh ../../../libtool --tag=3DCC   --mode=3Dcompile /home/malek/minisy=
s/xenomai/buildroot/build_i686/staging_dir/usr/bin/i686-linux-uclibc-gcc =
-Os  -I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/i=
nclude -I/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/inc=
lude --sysroot=3D/home/malek/minisys/xenomai/buildroot/build_i686/staging=
_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/build_i686/staging_=
dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFILE_SOURCE -D_LARGEF=
ILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -I. -I../../../src/=
include  -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fstrict-aliasing -Wn=
o-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prototypes -I../../..=
/include -I../../../include/posix    -MT libpthread_rt_la-shm.lo -MD -MP =
-MF .deps/libpthread_rt_la-shm.Tpo -c -o libpthread_rt_la-shm.lo `test -f=
 'shm.c' || echo './'`shm.c
 /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin/i68=
6-linux-uclibc-gcc -Os -I/home/malek/minisys/xenomai/buildroot/build_i686=
/staging_dir/usr/include -I/home/malek/minisys/xenomai/buildroot/build_i6=
86/staging_dir/include --sysroot=3D/home/malek/minisys/xenomai/buildroot/=
build_i686/staging_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/b=
uild_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFIL=
E_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -DHAVE_CONFIG_H -=
I. -I../../../src/include -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fst=
rict-aliasing -Wno-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prot=
otypes -I../../../include -I../../../include/posix -MT libpthread_rt_la-s=
hm.lo -MD -MP -MF .deps/libpthread_rt_la-shm.Tpo -c shm.c  -fPIC -DPIC -o=
 .libs/libpthread_rt_la-shm.o
shm.c: In function '__wrap_mmap':
shm.c:98: error: impossible register constraint in 'asm'
shm.c:98: error: impossible register constraint in 'asm'
shm.c:98: error: impossible register constraint in 'asm'
make[4]: *** [libpthread_rt_la-shm.lo] Erreur 1
make[4]: quittant le r=C3=A9pertoire =C2=AB /home/malek/minisys/xenomai/b=
uildroot/build_i686/xenomai-2.4.5/src/skins/posix =C2=BB
make[3]: *** [all-recursive] Erreur 1
make[3]: quittant le r=C3=A9pertoire =C2=AB /home/malek/minisys/xenomai/b=
uildroot/build_i686/xenomai-2.4.5/src/skins =C2=BB
make[2]: *** [all-recursive] Erreur 1
make[2]: quittant le r=C3=A9pertoire =C2=AB /home/malek/minisys/xenomai/b=
uildroot/build_i686/xenomai-2.4.5/src =C2=BB
make[1]: *** [all-recursive] Erreur 1
make[1]: quittant le r=C3=A9pertoire =C2=AB /home/malek/minisys/xenomai/b=
uildroot/build_i686/xenomai-2.4.5 =C2=BB
make: *** [/home/malek/minisys/xenomai/buildroot/build_i686/xenomai-2.4.5=
/.stamp_built] Erreur 2
[malek@domain.hid buildroot]$
=20

--------------040209060401070907080507
Content-Type: text/plain;
 name="config.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="config.log"

This file contains any messages produced by compilers while
running configure, to aid debugging if configure makes a mistake.

It was created by Xenomai configure 2.4.5, which was
generated by GNU Autoconf 2.61.  Invocation command line was

  $ ./configure --target=3Di686-linux --host=3Di686-linux --build=3Di386-=
pc-linux-gnu --prefix=3D/usr --exec-prefix=3D/usr --sysconfdir=3D/etc --p=
refix=3D/usr/xenomai --program-transform-name=3D --disable-smp --disable-=
x86-sep --enable-x86-tsc

## --------- ##
## Platform. ##
## --------- ##

hostname =3D localhost.localdomain
uname -m =3D i686
uname -r =3D 2.6.26.3-29.local.fc9.i686
uname -s =3D Linux
uname -v =3D #1 SMP PREEMPT Sun Sep 14 10:42:39 UTC 2008

/usr/bin/uname -p =3D unknown
/bin/uname -X     =3D unknown

/bin/arch              =3D i686
/usr/bin/arch -k       =3D unknown
/usr/convex/getsysinfo =3D unknown
/usr/bin/hostinfo      =3D unknown
/bin/machine           =3D unknown
/usr/bin/oslevel       =3D unknown
/bin/universe          =3D unknown

PATH: /home/malek/minisys/xenomai/buildroot/toolchain_build_i686/bin
PATH: /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/bin
PATH: /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bi=
n
PATH: /usr/lib/qt4/bin
PATH: /usr/lib/qt-3.3/bin
PATH: /usr/kerberos/bin
PATH: /usr/lib/ccache
PATH: /usr/local/bin
PATH: /usr/bin
PATH: /bin
PATH: /home/malek/bin


## ----------- ##
## Core tests. ##
## ----------- ##

configure:2130: checking build system type
configure:2148: result: i386-pc-linux-gnu
configure:2170: checking host system type
configure:2185: result: i686-pc-linux-gnu
configure:2220: checking for a BSD-compatible install
configure:2276: result: /usr/bin/install -c
configure:2311: checking for i686-linux-gcc
configure:2338: result: /home/malek/minisys/xenomai/buildroot/build_i686/=
staging_dir/usr/bin/i686-linux-uclibc-gcc -Os  -I/home/malek/minisys/xeno=
mai/buildroot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xe=
nomai/buildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/mi=
nisys/xenomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/min=
isys/xenomai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3D=
pentiumpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D=
64
configure:2616: checking for C compiler version
configure:2623: /home/malek/minisys/xenomai/buildroot/build_i686/staging_=
dir/usr/bin/i686-linux-uclibc-gcc -Os  -I/home/malek/minisys/xenomai/buil=
droot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/bu=
ildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/xe=
nomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xen=
omai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiu=
mpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -=
-version >&5
i686-linux-uclibc-gcc (GCC) 4.2.4
Copyright (C) 2007 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is N=
O
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOS=
E.

configure:2626: $? =3D 0
configure:2633: /home/malek/minisys/xenomai/buildroot/build_i686/staging_=
dir/usr/bin/i686-linux-uclibc-gcc -Os  -I/home/malek/minisys/xenomai/buil=
droot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/bu=
ildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/xe=
nomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xen=
omai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiu=
mpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -=
v >&5
Using built-in specs.
Target: i686-linux-uclibc
Configured with: /home/malek/minisys/xenomai/buildroot/toolchain_build_i6=
86/gcc-4.2.4/configure --prefix=3D/usr --build=3Di386-pc-linux-gnu --host=
=3Di386-pc-linux-gnu --target=3Di686-linux-uclibc --enable-languages=3Dc,=
c++ --with-sysroot=3D/home/malek/minisys/xenomai/buildroot/build_i686/sta=
ging_dir --with-build-time-tools=3D/home/malek/minisys/xenomai/buildroot/=
build_i686/staging_dir/usr/i686-linux-uclibc/bin --disable-__cxa_atexit -=
-enable-target-optspace --with-gnu-ld --enable-shared --with-gmp=3D/home/=
malek/minisys/xenomai/buildroot/toolchain_build_i686/gmp --with-mpfr=3D/h=
ome/malek/minisys/xenomai/buildroot/toolchain_build_i686/mpfr --enable-th=
reads --disable-multilib --with-arch=3Dpentiumpro --with-tune=3Dpentiumpr=
o : (reconfigured) /home/malek/minisys/xenomai/buildroot/toolchain_build_=
i686/gcc-4.2.4/configure --prefix=3D/usr --build=3Di386-pc-linux-gnu --ho=
st=3Di386-pc-linux-gnu --target=3Di686-linux-uclibc --enable-languages=3D=
c,c++ --with-sysroot=3D/home/malek/minisys/xenomai/buildroot/build_i686/s=
taging_dir --with-build-time-tools=3D/home/malek/minisys/xenomai/buildroo=
t/build_i686/staging_dir/usr/i686-linux-uclibc/bin --disable-__cxa_atexit=
 --enable-target-optspace --with-gnu-ld --enable-shared --with-gmp=3D/hom=
e/malek/minisys/xenomai/buildroot/toolchain_build_i686/gmp --with-mpfr=3D=
/home/malek/minisys/xenomai/buildroot/toolchain_build_i686/mpfr --enable-=
threads --disable-multilib --with-arch=3Dpentiumpro --with-tune=3Dpentium=
pro
Thread model: posix
gcc version 4.2.4
configure:2636: $? =3D 0
configure:2643: /home/malek/minisys/xenomai/buildroot/build_i686/staging_=
dir/usr/bin/i686-linux-uclibc-gcc -Os  -I/home/malek/minisys/xenomai/buil=
droot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/bu=
ildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/xe=
nomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xen=
omai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiu=
mpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -=
V >&5
i686-linux-uclibc-gcc: '-V' must come at the start of the command line
configure:2646: $? =3D 1
configure:2669: checking for C compiler default output file name
configure:2696: /home/malek/minisys/xenomai/buildroot/build_i686/staging_=
dir/usr/bin/i686-linux-uclibc-gcc -Os  -I/home/malek/minisys/xenomai/buil=
droot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/bu=
ildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/xe=
nomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xen=
omai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiu=
mpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64  =
  conftest.c  >&5
configure:2699: $? =3D 0
configure:2737: result: a.out
configure:2754: checking whether the C compiler works
configure:2784: result: yes
configure:2791: checking whether we are cross compiling
configure:2793: result: yes
configure:2796: checking for suffix of executables
configure:2803: /home/malek/minisys/xenomai/buildroot/build_i686/staging_=
dir/usr/bin/i686-linux-uclibc-gcc -Os  -I/home/malek/minisys/xenomai/buil=
droot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/bu=
ildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/xe=
nomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xen=
omai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiu=
mpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -=
o conftest    conftest.c  >&5
configure:2806: $? =3D 0
configure:2830: result:=20
configure:2836: checking for suffix of object files
configure:2862: /home/malek/minisys/xenomai/buildroot/build_i686/staging_=
dir/usr/bin/i686-linux-uclibc-gcc -Os  -I/home/malek/minisys/xenomai/buil=
droot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/bu=
ildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/xe=
nomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xen=
omai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiu=
mpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -=
c   conftest.c >&5
configure:2865: $? =3D 0
configure:2888: result: o
configure:2892: checking whether we are using the GNU C compiler
configure:2921: /home/malek/minisys/xenomai/buildroot/build_i686/staging_=
dir/usr/bin/i686-linux-uclibc-gcc -Os  -I/home/malek/minisys/xenomai/buil=
droot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/bu=
ildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/xe=
nomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xen=
omai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiu=
mpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -=
c   conftest.c >&5
configure:2927: $? =3D 0
configure:2944: result: yes
configure:2949: checking whether /home/malek/minisys/xenomai/buildroot/bu=
ild_i686/staging_dir/usr/bin/i686-linux-uclibc-gcc -Os  -I/home/malek/min=
isys/xenomai/buildroot/build_i686/staging_dir/usr/include -I/home/malek/m=
inisys/xenomai/buildroot/build_i686/staging_dir/include --sysroot=3D/home=
/malek/minisys/xenomai/buildroot/build_i686/staging_dir/ -isysroot /home/=
malek/minisys/xenomai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpr=
o -march=3Dpentiumpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_O=
FFSET_BITS=3D64 accepts -g
configure:2979: /home/malek/minisys/xenomai/buildroot/build_i686/staging_=
dir/usr/bin/i686-linux-uclibc-gcc -Os  -I/home/malek/minisys/xenomai/buil=
droot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/bu=
ildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/xe=
nomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xen=
omai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiu=
mpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -=
c -g  conftest.c >&5
configure:2985: $? =3D 0
configure:3084: result: yes
configure:3101: checking for /home/malek/minisys/xenomai/buildroot/build_=
i686/staging_dir/usr/bin/i686-linux-uclibc-gcc -Os  -I/home/malek/minisys=
/xenomai/buildroot/build_i686/staging_dir/usr/include -I/home/malek/minis=
ys/xenomai/buildroot/build_i686/staging_dir/include --sysroot=3D/home/mal=
ek/minisys/xenomai/buildroot/build_i686/staging_dir/ -isysroot /home/male=
k/minisys/xenomai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -m=
arch=3Dpentiumpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSE=
T_BITS=3D64 option to accept ISO C89
configure:3175: /home/malek/minisys/xenomai/buildroot/build_i686/staging_=
dir/usr/bin/i686-linux-uclibc-gcc -Os  -I/home/malek/minisys/xenomai/buil=
droot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/bu=
ildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/xe=
nomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xen=
omai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiu=
mpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64  =
-c -g -O2  conftest.c >&5
configure:3181: $? =3D 0
configure:3204: result: none needed
configure:3233: checking how to run the C preprocessor
configure:3349: result: /home/malek/minisys/xenomai/buildroot/build_i686/=
staging_dir/usr/bin/i686-linux-uclibc-cpp -Os  -I/home/malek/minisys/xeno=
mai/buildroot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xe=
nomai/buildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/mi=
nisys/xenomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/min=
isys/xenomai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3D=
pentiumpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D=
64
configure:3378: /home/malek/minisys/xenomai/buildroot/build_i686/staging_=
dir/usr/bin/i686-linux-uclibc-cpp -Os  -I/home/malek/minisys/xenomai/buil=
droot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/bu=
ildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/xe=
nomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xen=
omai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiu=
mpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64  =
conftest.c
configure:3384: $? =3D 0
configure:3415: /home/malek/minisys/xenomai/buildroot/build_i686/staging_=
dir/usr/bin/i686-linux-uclibc-cpp -Os  -I/home/malek/minisys/xenomai/buil=
droot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/bu=
ildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/xe=
nomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xen=
omai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiu=
mpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64  =
conftest.c
conftest.c:8:28: error: ac_nonexistent.h: No such file or directory
configure:3421: $? =3D 1
configure: failed program was:
| /* confdefs.h.  */
| #define PACKAGE_NAME "Xenomai"
| #define PACKAGE_TARNAME "xenomai"
| #define PACKAGE_VERSION "2.4.5"
| #define PACKAGE_STRING "Xenomai 2.4.5"
| #define PACKAGE_BUGREPORT "xenomai@xenomai.org"
| /* end confdefs.h.  */
| #include <ac_nonexistent.h>
configure:3459: checking target system type
configure:3474: result: i686-pc-linux-gnu
configure:3513: checking for i686-linux-gcc
configure:3540: result: /usr/lib/ccache/gcc
configure:3818: checking for C compiler version
configure:3825: /usr/lib/ccache/gcc --version >&5
gcc (GCC) 4.3.0 20080428 (Red Hat 4.3.0-8)
Copyright (C) 2008 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is N=
O
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOS=
E.

configure:3828: $? =3D 0
configure:3835: /usr/lib/ccache/gcc -v >&5
Using built-in specs.
Target: i386-redhat-linux
Configured with: ../configure --prefix=3D/usr --mandir=3D/usr/share/man -=
-infodir=3D/usr/share/info --with-bugurl=3Dhttp://bugzilla.redhat.com/bug=
zilla --enable-bootstrap --enable-shared --enable-threads=3Dposix --enabl=
e-checking=3Drelease --with-system-zlib --enable-__cxa_atexit --disable-l=
ibunwind-exceptions --enable-languages=3Dc,c++,objc,obj-c++,java,fortran,=
ada --enable-java-awt=3Dgtk --disable-dssi --enable-plugin --with-java-ho=
me=3D/usr/lib/jvm/java-1.5.0-gcj-1.5.0.0/jre --enable-libgcj-multifile --=
enable-java-maintainer-mode --with-ecj-jar=3D/usr/share/java/eclipse-ecj.=
jar --disable-libjava-multilib --with-cpu=3Dgeneric --build=3Di386-redhat=
-linux
Thread model: posix
gcc version 4.3.0 20080428 (Red Hat 4.3.0-8) (GCC)=20
configure:3838: $? =3D 0
configure:3845: /usr/lib/ccache/gcc -V >&5
gcc: '-V' option must have argument
configure:3848: $? =3D 1
configure:3851: checking whether we are using the GNU C compiler
configure:3903: result: yes
configure:3908: checking whether /usr/lib/ccache/gcc accepts -g
configure:3938: /usr/lib/ccache/gcc -c -g  conftest.c >&5
configure:3944: $? =3D 0
configure: failed program was:
| /* confdefs.h.  */
| #define PACKAGE_NAME "Xenomai"
| #define PACKAGE_TARNAME "xenomai"
| #define PACKAGE_VERSION "2.4.5"
| #define PACKAGE_STRING "Xenomai 2.4.5"
| #define PACKAGE_BUGREPORT "xenomai@xenomai.org"
| /* end confdefs.h.  */
|=20
| int
| main ()
| {
|=20
|   ;
|   return 0;
| }
configure:3976: /usr/lib/ccache/gcc -c   conftest.c >&5
configure:3982: $? =3D 0
configure: failed program was:
| /* confdefs.h.  */
| #define PACKAGE_NAME "Xenomai"
| #define PACKAGE_TARNAME "xenomai"
| #define PACKAGE_VERSION "2.4.5"
| #define PACKAGE_STRING "Xenomai 2.4.5"
| #define PACKAGE_BUGREPORT "xenomai@xenomai.org"
| /* end confdefs.h.  */
|=20
| int
| main ()
| {
|=20
|   ;
|   return 0;
| }
configure:4015: /usr/lib/ccache/gcc -c -g  conftest.c >&5
configure:4021: $? =3D 0
configure: failed program was:
| /* confdefs.h.  */
| #define PACKAGE_NAME "Xenomai"
| #define PACKAGE_TARNAME "xenomai"
| #define PACKAGE_VERSION "2.4.5"
| #define PACKAGE_STRING "Xenomai 2.4.5"
| #define PACKAGE_BUGREPORT "xenomai@xenomai.org"
| /* end confdefs.h.  */
|=20
| int
| main ()
| {
|=20
|   ;
|   return 0;
| }
configure:4043: result: no
configure:4060: checking for /usr/lib/ccache/gcc option to accept ISO C89=

configure:4163: result: none needed
configure:4186: checking how to run the C preprocessor
configure:4226: /usr/lib/ccache/gcc -E  conftest.c
configure:4232: $? =3D 0
configure:4263: /usr/lib/ccache/gcc -E  conftest.c
conftest.c:8:28: error: ac_nonexistent.h: No such file or directory
configure:4269: $? =3D 1
configure: failed program was:
| /* confdefs.h.  */
| #define PACKAGE_NAME "Xenomai"
| #define PACKAGE_TARNAME "xenomai"
| #define PACKAGE_VERSION "2.4.5"
| #define PACKAGE_STRING "Xenomai 2.4.5"
| #define PACKAGE_BUGREPORT "xenomai@xenomai.org"
| /* end confdefs.h.  */
| #include <ac_nonexistent.h>
configure:4302: result: /usr/lib/ccache/gcc -E
configure:4331: /usr/lib/ccache/gcc -E  conftest.c
configure:4337: $? =3D 0
configure:4368: /usr/lib/ccache/gcc -E  conftest.c
conftest.c:8:28: error: ac_nonexistent.h: No such file or directory
configure:4374: $? =3D 1
configure: failed program was:
| /* confdefs.h.  */
| #define PACKAGE_NAME "Xenomai"
| #define PACKAGE_TARNAME "xenomai"
| #define PACKAGE_VERSION "2.4.5"
| #define PACKAGE_STRING "Xenomai 2.4.5"
| #define PACKAGE_BUGREPORT "xenomai@xenomai.org"
| /* end confdefs.h.  */
| #include <ac_nonexistent.h>
configure:4438: checking whether build environment is sane
configure:4481: result: yes
configure:4509: checking for a thread-safe mkdir -p
configure:4548: result: /bin/mkdir -p
configure:4561: checking for gawk
configure:4577: found /usr/bin/gawk
configure:4588: result: gawk
configure:4599: checking whether make sets $(MAKE)
configure:4620: result: yes
configure:4650: checking for style of include used by make
configure:4678: result: GNU
configure:4762: checking for i686-linux-strip
configure:4789: result: /home/malek/minisys/xenomai/buildroot/build_i686/=
staging_dir/usr/bin/i686-linux-uclibc-strip
configure:4871: checking dependency style of /home/malek/minisys/xenomai/=
buildroot/build_i686/staging_dir/usr/bin/i686-linux-uclibc-gcc -Os  -I/ho=
me/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/include -I/=
home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/include --sys=
root=3D/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/ -isy=
sroot /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir -mtune=
=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOUR=
CE -D_FILE_OFFSET_BITS=3D64
configure:4962: result: gcc3
configure:4978: checking whether to enable maintainer-specific portions o=
f Makefiles
configure:4987: result: no
configure:5072: checking for a sed that does not truncate output
configure:5128: result: /home/malek/minisys/xenomai/buildroot/toolchain_b=
uild_i686/bin/sed
configure:5131: checking for grep that handles long lines and -e
configure:5205: result: /bin/grep
configure:5210: checking for egrep
configure:5288: result: /bin/grep -E
configure:5304: checking for ld used by /home/malek/minisys/xenomai/build=
root/build_i686/staging_dir/usr/bin/i686-linux-uclibc-gcc -Os  -I/home/ma=
lek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/include -I/home/=
malek/minisys/xenomai/buildroot/build_i686/staging_dir/include --sysroot=3D=
/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/ -isysroot /=
home/malek/minisys/xenomai/buildroot/build_i686/staging_dir -mtune=3Dpent=
iumpro -march=3Dpentiumpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_F=
ILE_OFFSET_BITS=3D64
configure:5371: result: /home/malek/minisys/xenomai/buildroot/build_i686/=
staging_dir/usr/bin/i686-linux-uclibc-ld -L/home/malek/minisys/xenomai/bu=
ildroot/build_i686/staging_dir/lib -L/home/malek/minisys/xenomai/buildroo=
t/build_i686/staging_dir/usr/lib --sysroot=3D/home/malek/minisys/xenomai/=
buildroot/build_i686/staging_dir/
configure:5380: checking if the linker (/home/malek/minisys/xenomai/build=
root/build_i686/staging_dir/usr/bin/i686-linux-uclibc-ld -L/home/malek/mi=
nisys/xenomai/buildroot/build_i686/staging_dir/lib -L/home/malek/minisys/=
xenomai/buildroot/build_i686/staging_dir/usr/lib --sysroot=3D/home/malek/=
minisys/xenomai/buildroot/build_i686/staging_dir/) is GNU ld
configure:5395: result: yes
configure:5400: checking for /home/malek/minisys/xenomai/buildroot/build_=
i686/staging_dir/usr/bin/i686-linux-uclibc-ld -L/home/malek/minisys/xenom=
ai/buildroot/build_i686/staging_dir/lib -L/home/malek/minisys/xenomai/bui=
ldroot/build_i686/staging_dir/usr/lib --sysroot=3D/home/malek/minisys/xen=
omai/buildroot/build_i686/staging_dir/ option to reload object files
configure:5407: result: -r
configure:5425: checking for BSD-compatible nm
configure:5474: result: /home/malek/minisys/xenomai/buildroot/build_i686/=
staging_dir/usr/bin/i686-linux-uclibc-nm
configure:5478: checking whether ln -s works
configure:5482: result: yes
configure:5489: checking how to recognize dependent libraries
configure:5675: result: pass_all
configure:5915: checking for ANSI C header files
configure:5945: /home/malek/minisys/xenomai/buildroot/build_i686/staging_=
dir/usr/bin/i686-linux-uclibc-gcc -Os  -I/home/malek/minisys/xenomai/buil=
droot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/bu=
ildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/xe=
nomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xen=
omai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiu=
mpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -=
c   conftest.c >&5
configure:5951: $? =3D 0
configure:6079: result: yes
configure:6103: checking for sys/types.h
configure:6124: /home/malek/minisys/xenomai/buildroot/build_i686/staging_=
dir/usr/bin/i686-linux-uclibc-gcc -Os  -I/home/malek/minisys/xenomai/buil=
droot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/bu=
ildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/xe=
nomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xen=
omai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiu=
mpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -=
c   conftest.c >&5
configure:6130: $? =3D 0
configure:6146: result: yes
configure:6103: checking for sys/stat.h
configure:6124: /home/malek/minisys/xenomai/buildroot/build_i686/staging_=
dir/usr/bin/i686-linux-uclibc-gcc -Os  -I/home/malek/minisys/xenomai/buil=
droot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/bu=
ildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/xe=
nomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xen=
omai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiu=
mpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -=
c   conftest.c >&5
configure:6130: $? =3D 0
configure:6146: result: yes
configure:6103: checking for stdlib.h
configure:6124: /home/malek/minisys/xenomai/buildroot/build_i686/staging_=
dir/usr/bin/i686-linux-uclibc-gcc -Os  -I/home/malek/minisys/xenomai/buil=
droot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/bu=
ildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/xe=
nomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xen=
omai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiu=
mpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -=
c   conftest.c >&5
configure:6130: $? =3D 0
configure:6146: result: yes
configure:6103: checking for string.h
configure:6124: /home/malek/minisys/xenomai/buildroot/build_i686/staging_=
dir/usr/bin/i686-linux-uclibc-gcc -Os  -I/home/malek/minisys/xenomai/buil=
droot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/bu=
ildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/xe=
nomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xen=
omai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiu=
mpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -=
c   conftest.c >&5
configure:6130: $? =3D 0
configure:6146: result: yes
configure:6103: checking for memory.h
configure:6124: /home/malek/minisys/xenomai/buildroot/build_i686/staging_=
dir/usr/bin/i686-linux-uclibc-gcc -Os  -I/home/malek/minisys/xenomai/buil=
droot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/bu=
ildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/xe=
nomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xen=
omai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiu=
mpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -=
c   conftest.c >&5
configure:6130: $? =3D 0
configure:6146: result: yes
configure:6103: checking for strings.h
configure:6124: /home/malek/minisys/xenomai/buildroot/build_i686/staging_=
dir/usr/bin/i686-linux-uclibc-gcc -Os  -I/home/malek/minisys/xenomai/buil=
droot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/bu=
ildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/xe=
nomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xen=
omai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiu=
mpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -=
c   conftest.c >&5
configure:6130: $? =3D 0
configure:6146: result: yes
configure:6103: checking for inttypes.h
configure:6124: /home/malek/minisys/xenomai/buildroot/build_i686/staging_=
dir/usr/bin/i686-linux-uclibc-gcc -Os  -I/home/malek/minisys/xenomai/buil=
droot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/bu=
ildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/xe=
nomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xen=
omai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiu=
mpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -=
c   conftest.c >&5
configure:6130: $? =3D 0
configure:6146: result: yes
configure:6103: checking for stdint.h
configure:6124: /home/malek/minisys/xenomai/buildroot/build_i686/staging_=
dir/usr/bin/i686-linux-uclibc-gcc -Os  -I/home/malek/minisys/xenomai/buil=
droot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/bu=
ildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/xe=
nomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xen=
omai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiu=
mpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -=
c   conftest.c >&5
configure:6130: $? =3D 0
configure:6146: result: yes
configure:6103: checking for unistd.h
configure:6124: /home/malek/minisys/xenomai/buildroot/build_i686/staging_=
dir/usr/bin/i686-linux-uclibc-gcc -Os  -I/home/malek/minisys/xenomai/buil=
droot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/bu=
ildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/xe=
nomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xen=
omai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiu=
mpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -=
c   conftest.c >&5
configure:6130: $? =3D 0
configure:6146: result: yes
configure:6173: checking dlfcn.h usability
configure:6190: /home/malek/minisys/xenomai/buildroot/build_i686/staging_=
dir/usr/bin/i686-linux-uclibc-gcc -Os  -I/home/malek/minisys/xenomai/buil=
droot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/bu=
ildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/xe=
nomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xen=
omai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiu=
mpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -=
c   conftest.c >&5
configure:6196: $? =3D 0
configure:6210: result: yes
configure:6214: checking dlfcn.h presence
configure:6229: /home/malek/minisys/xenomai/buildroot/build_i686/staging_=
dir/usr/bin/i686-linux-uclibc-cpp -Os  -I/home/malek/minisys/xenomai/buil=
droot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/bu=
ildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/xe=
nomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xen=
omai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiu=
mpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64  =
conftest.c
configure:6235: $? =3D 0
configure:6249: result: yes
configure:6282: checking for dlfcn.h
configure:6290: result: yes
configure:6419: checking for C++ compiler version
configure:6426: /home/malek/minisys/xenomai/buildroot/build_i686/staging_=
dir/usr/bin/i686-linux-uclibc-g++ -Os  -I/home/malek/minisys/xenomai/buil=
droot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/bu=
ildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/xe=
nomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xen=
omai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiu=
mpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -=
-version >&5
i686-linux-uclibc-g++ (GCC) 4.2.4
Copyright (C) 2007 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is N=
O
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOS=
E.

configure:6429: $? =3D 0
configure:6436: /home/malek/minisys/xenomai/buildroot/build_i686/staging_=
dir/usr/bin/i686-linux-uclibc-g++ -Os  -I/home/malek/minisys/xenomai/buil=
droot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/bu=
ildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/xe=
nomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xen=
omai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiu=
mpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -=
v >&5
Using built-in specs.
Target: i686-linux-uclibc
Configured with: /home/malek/minisys/xenomai/buildroot/toolchain_build_i6=
86/gcc-4.2.4/configure --prefix=3D/usr --build=3Di386-pc-linux-gnu --host=
=3Di386-pc-linux-gnu --target=3Di686-linux-uclibc --enable-languages=3Dc,=
c++ --with-sysroot=3D/home/malek/minisys/xenomai/buildroot/build_i686/sta=
ging_dir --with-build-time-tools=3D/home/malek/minisys/xenomai/buildroot/=
build_i686/staging_dir/usr/i686-linux-uclibc/bin --disable-__cxa_atexit -=
-enable-target-optspace --with-gnu-ld --enable-shared --with-gmp=3D/home/=
malek/minisys/xenomai/buildroot/toolchain_build_i686/gmp --with-mpfr=3D/h=
ome/malek/minisys/xenomai/buildroot/toolchain_build_i686/mpfr --enable-th=
reads --disable-multilib --with-arch=3Dpentiumpro --with-tune=3Dpentiumpr=
o : (reconfigured) /home/malek/minisys/xenomai/buildroot/toolchain_build_=
i686/gcc-4.2.4/configure --prefix=3D/usr --build=3Di386-pc-linux-gnu --ho=
st=3Di386-pc-linux-gnu --target=3Di686-linux-uclibc --enable-languages=3D=
c,c++ --with-sysroot=3D/home/malek/minisys/xenomai/buildroot/build_i686/s=
taging_dir --with-build-time-tools=3D/home/malek/minisys/xenomai/buildroo=
t/build_i686/staging_dir/usr/i686-linux-uclibc/bin --disable-__cxa_atexit=
 --enable-target-optspace --with-gnu-ld --enable-shared --with-gmp=3D/hom=
e/malek/minisys/xenomai/buildroot/toolchain_build_i686/gmp --with-mpfr=3D=
/home/malek/minisys/xenomai/buildroot/toolchain_build_i686/mpfr --enable-=
threads --disable-multilib --with-arch=3Dpentiumpro --with-tune=3Dpentium=
pro
Thread model: posix
gcc version 4.2.4
configure:6439: $? =3D 0
configure:6446: /home/malek/minisys/xenomai/buildroot/build_i686/staging_=
dir/usr/bin/i686-linux-uclibc-g++ -Os  -I/home/malek/minisys/xenomai/buil=
droot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/bu=
ildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/xe=
nomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xen=
omai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiu=
mpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -=
V >&5
i686-linux-uclibc-g++: argument to '-V' missing

configure:6449: $? =3D 1
configure:6452: checking whether we are using the GNU C++ compiler
configure:6481: /home/malek/minisys/xenomai/buildroot/build_i686/staging_=
dir/usr/bin/i686-linux-uclibc-g++ -Os  -I/home/malek/minisys/xenomai/buil=
droot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/bu=
ildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/xe=
nomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xen=
omai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiu=
mpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -=
c   conftest.cpp >&5
configure:6487: $? =3D 0
configure:6504: result: yes
configure:6509: checking whether /home/malek/minisys/xenomai/buildroot/bu=
ild_i686/staging_dir/usr/bin/i686-linux-uclibc-g++ -Os  -I/home/malek/min=
isys/xenomai/buildroot/build_i686/staging_dir/usr/include -I/home/malek/m=
inisys/xenomai/buildroot/build_i686/staging_dir/include --sysroot=3D/home=
/malek/minisys/xenomai/buildroot/build_i686/staging_dir/ -isysroot /home/=
malek/minisys/xenomai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpr=
o -march=3Dpentiumpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_O=
FFSET_BITS=3D64 accepts -g
configure:6539: /home/malek/minisys/xenomai/buildroot/build_i686/staging_=
dir/usr/bin/i686-linux-uclibc-g++ -Os  -I/home/malek/minisys/xenomai/buil=
droot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/bu=
ildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/xe=
nomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xen=
omai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiu=
mpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -=
c -g  conftest.cpp >&5
configure:6545: $? =3D 0
configure:6644: result: yes
configure:6669: checking dependency style of /home/malek/minisys/xenomai/=
buildroot/build_i686/staging_dir/usr/bin/i686-linux-uclibc-g++ -Os  -I/ho=
me/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/include -I/=
home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/include --sys=
root=3D/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/ -isy=
sroot /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir -mtune=
=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOUR=
CE -D_FILE_OFFSET_BITS=3D64
configure:6760: result: gcc3
configure:6785: checking how to run the C++ preprocessor
configure:6821: /home/malek/minisys/xenomai/buildroot/build_i686/staging_=
dir/usr/bin/i686-linux-uclibc-g++ -Os  -I/home/malek/minisys/xenomai/buil=
droot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/bu=
ildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/xe=
nomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xen=
omai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiu=
mpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -=
E  conftest.cpp
configure:6827: $? =3D 0
configure:6858: /home/malek/minisys/xenomai/buildroot/build_i686/staging_=
dir/usr/bin/i686-linux-uclibc-g++ -Os  -I/home/malek/minisys/xenomai/buil=
droot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/bu=
ildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/xe=
nomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xen=
omai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiu=
mpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -=
E  conftest.cpp
conftest.cpp:24:28: error: ac_nonexistent.h: No such file or directory
configure:6864: $? =3D 1
configure: failed program was:
| /* confdefs.h.  */
| #define PACKAGE_NAME "Xenomai"
| #define PACKAGE_TARNAME "xenomai"
| #define PACKAGE_VERSION "2.4.5"
| #define PACKAGE_STRING "Xenomai 2.4.5"
| #define PACKAGE_BUGREPORT "xenomai@xenomai.org"
| #define CONFIG_XENO_BUILD_STRING "i386-pc-linux-gnu"
| #define CONFIG_XENO_HOST_STRING "i686-pc-linux-gnu"
| #define CONFIG_XENO_COMPILER "gcc version 4.2.4"
| #define PACKAGE "xenomai"
| #define VERSION "2.4.5"
| #define STDC_HEADERS 1
| #define HAVE_SYS_TYPES_H 1
| #define HAVE_SYS_STAT_H 1
| #define HAVE_STDLIB_H 1
| #define HAVE_STRING_H 1
| #define HAVE_MEMORY_H 1
| #define HAVE_STRINGS_H 1
| #define HAVE_INTTYPES_H 1
| #define HAVE_STDINT_H 1
| #define HAVE_UNISTD_H 1
| #define HAVE_DLFCN_H 1
| /* end confdefs.h.  */
| #include <ac_nonexistent.h>
configure:6897: result: /home/malek/minisys/xenomai/buildroot/build_i686/=
staging_dir/usr/bin/i686-linux-uclibc-g++ -Os  -I/home/malek/minisys/xeno=
mai/buildroot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xe=
nomai/buildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/mi=
nisys/xenomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/min=
isys/xenomai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3D=
pentiumpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D=
64 -E
configure:6926: /home/malek/minisys/xenomai/buildroot/build_i686/staging_=
dir/usr/bin/i686-linux-uclibc-g++ -Os  -I/home/malek/minisys/xenomai/buil=
droot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/bu=
ildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/xe=
nomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xen=
omai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiu=
mpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -=
E  conftest.cpp
configure:6932: $? =3D 0
configure:6963: /home/malek/minisys/xenomai/buildroot/build_i686/staging_=
dir/usr/bin/i686-linux-uclibc-g++ -Os  -I/home/malek/minisys/xenomai/buil=
droot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/bu=
ildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/xe=
nomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xen=
omai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiu=
mpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -=
E  conftest.cpp
conftest.cpp:24:28: error: ac_nonexistent.h: No such file or directory
configure:6969: $? =3D 1
configure: failed program was:
| /* confdefs.h.  */
| #define PACKAGE_NAME "Xenomai"
| #define PACKAGE_TARNAME "xenomai"
| #define PACKAGE_VERSION "2.4.5"
| #define PACKAGE_STRING "Xenomai 2.4.5"
| #define PACKAGE_BUGREPORT "xenomai@xenomai.org"
| #define CONFIG_XENO_BUILD_STRING "i386-pc-linux-gnu"
| #define CONFIG_XENO_HOST_STRING "i686-pc-linux-gnu"
| #define CONFIG_XENO_COMPILER "gcc version 4.2.4"
| #define PACKAGE "xenomai"
| #define VERSION "2.4.5"
| #define STDC_HEADERS 1
| #define HAVE_SYS_TYPES_H 1
| #define HAVE_SYS_STAT_H 1
| #define HAVE_STDLIB_H 1
| #define HAVE_STRING_H 1
| #define HAVE_MEMORY_H 1
| #define HAVE_STRINGS_H 1
| #define HAVE_INTTYPES_H 1
| #define HAVE_STDINT_H 1
| #define HAVE_UNISTD_H 1
| #define HAVE_DLFCN_H 1
| /* end confdefs.h.  */
| #include <ac_nonexistent.h>
configure:7018: checking for i686-linux-g77
configure:7048: result: no
configure:7018: checking for i686-linux-xlf
configure:7048: result: no
configure:7018: checking for i686-linux-f77
configure:7048: result: no
configure:7018: checking for i686-linux-frt
configure:7048: result: no
configure:7018: checking for i686-linux-pgf77
configure:7048: result: no
configure:7018: checking for i686-linux-cf77
configure:7048: result: no
configure:7018: checking for i686-linux-fort77
configure:7048: result: no
configure:7018: checking for i686-linux-fl32
configure:7048: result: no
configure:7018: checking for i686-linux-af77
configure:7048: result: no
configure:7018: checking for i686-linux-xlf90
configure:7048: result: no
configure:7018: checking for i686-linux-f90
configure:7048: result: no
configure:7018: checking for i686-linux-pgf90
configure:7048: result: no
configure:7018: checking for i686-linux-pghpf
configure:7048: result: no
configure:7018: checking for i686-linux-epcf90
configure:7048: result: no
configure:7018: checking for i686-linux-gfortran
configure:7048: result: no
configure:7018: checking for i686-linux-g95
configure:7048: result: no
configure:7018: checking for i686-linux-xlf95
configure:7048: result: no
configure:7018: checking for i686-linux-f95
configure:7048: result: no
configure:7018: checking for i686-linux-fort
configure:7048: result: no
configure:7018: checking for i686-linux-ifort
configure:7048: result: no
configure:7018: checking for i686-linux-ifc
configure:7048: result: no
configure:7018: checking for i686-linux-efc
configure:7048: result: no
configure:7018: checking for i686-linux-pgf95
configure:7048: result: no
configure:7018: checking for i686-linux-lf95
configure:7048: result: no
configure:7018: checking for i686-linux-ftn
configure:7048: result: no
configure:7062: checking for g77
configure:7092: result: no
configure:7062: checking for xlf
configure:7092: result: no
configure:7062: checking for f77
configure:7092: result: no
configure:7062: checking for frt
configure:7092: result: no
configure:7062: checking for pgf77
configure:7092: result: no
configure:7062: checking for cf77
configure:7092: result: no
configure:7062: checking for fort77
configure:7092: result: no
configure:7062: checking for fl32
configure:7092: result: no
configure:7062: checking for af77
configure:7092: result: no
configure:7062: checking for xlf90
configure:7092: result: no
configure:7062: checking for f90
configure:7092: result: no
configure:7062: checking for pgf90
configure:7092: result: no
configure:7062: checking for pghpf
configure:7092: result: no
configure:7062: checking for epcf90
configure:7092: result: no
configure:7062: checking for gfortran
configure:7078: found /usr/bin/gfortran
configure:7089: result: gfortran
configure:7107: WARNING: In the future, Autoconf will not detect cross-to=
ols
whose name does not start with the host triplet.  If you think this
configuration is useful to you, please write to autoconf@domain.hid.
configure:7119: checking for Fortran 77 compiler version
configure:7126: gfortran --version >&5
GNU Fortran (GCC) 4.3.0 20080428 (Red Hat 4.3.0-8)
Copyright (C) 2008 Free Software Foundation, Inc.

GNU Fortran comes with NO WARRANTY, to the extent permitted by law.
You may redistribute copies of GNU Fortran
under the terms of the GNU General Public License.
For more information about these matters, see the file named COPYING

configure:7129: $? =3D 0
configure:7136: gfortran -v >&5
Using built-in specs.
Target: i386-redhat-linux
Configured with: ../configure --prefix=3D/usr --mandir=3D/usr/share/man -=
-infodir=3D/usr/share/info --with-bugurl=3Dhttp://bugzilla.redhat.com/bug=
zilla --enable-bootstrap --enable-shared --enable-threads=3Dposix --enabl=
e-checking=3Drelease --with-system-zlib --enable-__cxa_atexit --disable-l=
ibunwind-exceptions --enable-languages=3Dc,c++,objc,obj-c++,java,fortran,=
ada --enable-java-awt=3Dgtk --disable-dssi --enable-plugin --with-java-ho=
me=3D/usr/lib/jvm/java-1.5.0-gcj-1.5.0.0/jre --enable-libgcj-multifile --=
enable-java-maintainer-mode --with-ecj-jar=3D/usr/share/java/eclipse-ecj.=
jar --disable-libjava-multilib --with-cpu=3Dgeneric --build=3Di386-redhat=
-linux
Thread model: posix
gcc version 4.3.0 20080428 (Red Hat 4.3.0-8) (GCC)=20
configure:7139: $? =3D 0
configure:7146: gfortran -V >&5
gfortran: '-V' option must have argument
configure:7149: $? =3D 1
configure:7157: checking whether we are using the GNU Fortran 77 compiler=

configure:7176: gfortran -c  conftest.F >&5
configure:7182: $? =3D 0
configure:7199: result: yes
configure:7205: checking whether gfortran accepts -g
configure:7222: gfortran -c -g conftest.f >&5
configure:7228: $? =3D 0
configure:7244: result: yes
configure:7273: checking the maximum length of command line arguments
configure:7385: result: 1966080
configure:7397: checking command to parse /home/malek/minisys/xenomai/bui=
ldroot/build_i686/staging_dir/usr/bin/i686-linux-uclibc-nm output from /h=
ome/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin/i686-l=
inux-uclibc-gcc -Os  -I/home/malek/minisys/xenomai/buildroot/build_i686/s=
taging_dir/usr/include -I/home/malek/minisys/xenomai/buildroot/build_i686=
/staging_dir/include --sysroot=3D/home/malek/minisys/xenomai/buildroot/bu=
ild_i686/staging_dir/ -isysroot /home/malek/minisys/xenomai/buildroot/bui=
ld_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFILE_=
SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 object
configure:7502: /home/malek/minisys/xenomai/buildroot/build_i686/staging_=
dir/usr/bin/i686-linux-uclibc-gcc -Os  -I/home/malek/minisys/xenomai/buil=
droot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/bu=
ildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/xe=
nomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xen=
omai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiu=
mpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -=
c   conftest.c >&5
configure:7505: $? =3D 0
configure:7509: /home/malek/minisys/xenomai/buildroot/build_i686/staging_=
dir/usr/bin/i686-linux-uclibc-nm conftest.o \| sed -n -e 's/^.*[ 	]\([ABC=
DGIRSTW][ABCDGIRSTW]*\)[ 	][ 	]*\([_A-Za-z][_A-Za-z0-9]*\)$/\1 \2 \2/p' \=
> conftest.nm
configure:7512: $? =3D 0
configure:7564: /home/malek/minisys/xenomai/buildroot/build_i686/staging_=
dir/usr/bin/i686-linux-uclibc-gcc -Os  -I/home/malek/minisys/xenomai/buil=
droot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/bu=
ildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/xe=
nomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xen=
omai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiu=
mpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -=
o conftest    conftest.c conftstm.o >&5
configure:7567: $? =3D 0
configure:7605: result: ok
configure:7609: checking for objdir
configure:7624: result: .libs
configure:7676: checking for i686-linux-ar
configure:7703: result: /home/malek/minisys/xenomai/buildroot/build_i686/=
staging_dir/usr/bin/i686-linux-uclibc-ar
configure:7772: checking for i686-linux-ranlib
configure:7799: result: /home/malek/minisys/xenomai/buildroot/build_i686/=
staging_dir/usr/bin/i686-linux-uclibc-ranlib
configure:7868: checking for i686-linux-strip
configure:7895: result: /home/malek/minisys/xenomai/buildroot/build_i686/=
staging_dir/usr/bin/i686-linux-uclibc-strip
configure:8533: checking if /home/malek/minisys/xenomai/buildroot/build_i=
686/staging_dir/usr/bin/i686-linux-uclibc-gcc -Os  -I/home/malek/minisys/=
xenomai/buildroot/build_i686/staging_dir/usr/include -I/home/malek/minisy=
s/xenomai/buildroot/build_i686/staging_dir/include --sysroot=3D/home/male=
k/minisys/xenomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek=
/minisys/xenomai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -ma=
rch=3Dpentiumpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET=
_BITS=3D64 supports -fno-rtti -fno-exceptions
configure:8551: /home/malek/minisys/xenomai/buildroot/build_i686/staging_=
dir/usr/bin/i686-linux-uclibc-gcc -Os  -I/home/malek/minisys/xenomai/buil=
droot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/bu=
ildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/xe=
nomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xen=
omai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiu=
mpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -=
c   -fno-rtti -fno-exceptions conftest.c >&5
cc1: warning: command line option "-fno-rtti" is valid for C++/ObjC++ but=
 not for C
configure:8555: $? =3D 0
configure:8568: result: no
configure:8583: checking for /home/malek/minisys/xenomai/buildroot/build_=
i686/staging_dir/usr/bin/i686-linux-uclibc-gcc -Os  -I/home/malek/minisys=
/xenomai/buildroot/build_i686/staging_dir/usr/include -I/home/malek/minis=
ys/xenomai/buildroot/build_i686/staging_dir/include --sysroot=3D/home/mal=
ek/minisys/xenomai/buildroot/build_i686/staging_dir/ -isysroot /home/male=
k/minisys/xenomai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -m=
arch=3Dpentiumpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSE=
T_BITS=3D64 option to produce PIC
configure:8815: result: -fPIC
configure:8823: checking if /home/malek/minisys/xenomai/buildroot/build_i=
686/staging_dir/usr/bin/i686-linux-uclibc-gcc -Os  -I/home/malek/minisys/=
xenomai/buildroot/build_i686/staging_dir/usr/include -I/home/malek/minisy=
s/xenomai/buildroot/build_i686/staging_dir/include --sysroot=3D/home/male=
k/minisys/xenomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek=
/minisys/xenomai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -ma=
rch=3Dpentiumpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET=
_BITS=3D64 PIC flag -fPIC works
configure:8841: /home/malek/minisys/xenomai/buildroot/build_i686/staging_=
dir/usr/bin/i686-linux-uclibc-gcc -Os  -I/home/malek/minisys/xenomai/buil=
droot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/bu=
ildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/xe=
nomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xen=
omai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiu=
mpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -=
c   -fPIC -DPIC conftest.c >&5
configure:8845: $? =3D 0
configure:8858: result: yes
configure:8886: checking if /home/malek/minisys/xenomai/buildroot/build_i=
686/staging_dir/usr/bin/i686-linux-uclibc-gcc -Os  -I/home/malek/minisys/=
xenomai/buildroot/build_i686/staging_dir/usr/include -I/home/malek/minisy=
s/xenomai/buildroot/build_i686/staging_dir/include --sysroot=3D/home/male=
k/minisys/xenomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek=
/minisys/xenomai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -ma=
rch=3Dpentiumpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET=
_BITS=3D64 static flag -static works
configure:8914: result: yes
configure:8924: checking if /home/malek/minisys/xenomai/buildroot/build_i=
686/staging_dir/usr/bin/i686-linux-uclibc-gcc -Os  -I/home/malek/minisys/=
xenomai/buildroot/build_i686/staging_dir/usr/include -I/home/malek/minisy=
s/xenomai/buildroot/build_i686/staging_dir/include --sysroot=3D/home/male=
k/minisys/xenomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek=
/minisys/xenomai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -ma=
rch=3Dpentiumpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET=
_BITS=3D64 supports -c -o file.o
configure:8945: /home/malek/minisys/xenomai/buildroot/build_i686/staging_=
dir/usr/bin/i686-linux-uclibc-gcc -Os  -I/home/malek/minisys/xenomai/buil=
droot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/bu=
ildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/xe=
nomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xen=
omai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiu=
mpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -=
c   -o out/conftest2.o conftest.c >&5
configure:8949: $? =3D 0
configure:8971: result: yes
configure:8997: checking whether the /home/malek/minisys/xenomai/buildroo=
t/build_i686/staging_dir/usr/bin/i686-linux-uclibc-gcc -Os  -I/home/malek=
/minisys/xenomai/buildroot/build_i686/staging_dir/usr/include -I/home/mal=
ek/minisys/xenomai/buildroot/build_i686/staging_dir/include --sysroot=3D/=
home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/ -isysroot /h=
ome/malek/minisys/xenomai/buildroot/build_i686/staging_dir -mtune=3Dpenti=
umpro -march=3Dpentiumpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FI=
LE_OFFSET_BITS=3D64 linker (/home/malek/minisys/xenomai/buildroot/build_i=
686/staging_dir/usr/bin/i686-linux-uclibc-ld -L/home/malek/minisys/xenoma=
i/buildroot/build_i686/staging_dir/lib -L/home/malek/minisys/xenomai/buil=
droot/build_i686/staging_dir/usr/lib --sysroot=3D/home/malek/minisys/xeno=
mai/buildroot/build_i686/staging_dir/) supports shared libraries
configure:9978: result: yes
configure:9999: checking whether -lc should be explicitly linked in
configure:10004: /home/malek/minisys/xenomai/buildroot/build_i686/staging=
_dir/usr/bin/i686-linux-uclibc-gcc -Os  -I/home/malek/minisys/xenomai/bui=
ldroot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/b=
uildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/x=
enomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xe=
nomai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpenti=
umpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 =
-c   conftest.c >&5
configure:10007: $? =3D 0
configure:10022: /home/malek/minisys/xenomai/buildroot/build_i686/staging=
_dir/usr/bin/i686-linux-uclibc-gcc -Os  -I/home/malek/minisys/xenomai/bui=
ldroot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/b=
uildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/x=
enomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xe=
nomai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpenti=
umpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 =
-shared conftest.o  -v -Wl,-soname -Wl,conftest -o conftest 2\>\&1 \| gre=
p  -lc  \>/dev/null 2\>\&1
configure:10025: $? =3D 0
configure:10037: result: no
configure:10045: checking dynamic linker characteristics
configure:10659: result: GNU/Linux ld.so
configure:10683: checking how to hardcode library paths into programs
configure:10708: result: immediate
configure:10722: checking whether stripping libraries is possible
configure:10727: result: yes
configure:11529: checking if libtool supports shared libraries
configure:11531: result: yes
configure:11534: checking whether to build shared libraries
configure:11555: result: yes
configure:11558: checking whether to build static libraries
configure:11562: result: yes
configure:11656: creating libtool
configure:12249: checking for ld used by /home/malek/minisys/xenomai/buil=
droot/build_i686/staging_dir/usr/bin/i686-linux-uclibc-g++ -Os  -I/home/m=
alek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/include -I/home=
/malek/minisys/xenomai/buildroot/build_i686/staging_dir/include --sysroot=
=3D/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/ -isysroo=
t /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir -mtune=3Dp=
entiumpro -march=3Dpentiumpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -=
D_FILE_OFFSET_BITS=3D64
configure:12316: result: /home/malek/minisys/xenomai/buildroot/build_i686=
/staging_dir/usr/bin/i686-linux-uclibc-ld -L/home/malek/minisys/xenomai/b=
uildroot/build_i686/staging_dir/lib -L/home/malek/minisys/xenomai/buildro=
ot/build_i686/staging_dir/usr/lib --sysroot=3D/home/malek/minisys/xenomai=
/buildroot/build_i686/staging_dir/
configure:12325: checking if the linker (/home/malek/minisys/xenomai/buil=
droot/build_i686/staging_dir/usr/bin/i686-linux-uclibc-ld -L/home/malek/m=
inisys/xenomai/buildroot/build_i686/staging_dir/lib -L/home/malek/minisys=
/xenomai/buildroot/build_i686/staging_dir/usr/lib --sysroot=3D/home/malek=
/minisys/xenomai/buildroot/build_i686/staging_dir/) is GNU ld
configure:12340: result: yes
configure:12391: checking whether the /home/malek/minisys/xenomai/buildro=
ot/build_i686/staging_dir/usr/bin/i686-linux-uclibc-g++ -Os  -I/home/male=
k/minisys/xenomai/buildroot/build_i686/staging_dir/usr/include -I/home/ma=
lek/minisys/xenomai/buildroot/build_i686/staging_dir/include --sysroot=3D=
/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/ -isysroot /=
home/malek/minisys/xenomai/buildroot/build_i686/staging_dir -mtune=3Dpent=
iumpro -march=3Dpentiumpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_F=
ILE_OFFSET_BITS=3D64 linker (/home/malek/minisys/xenomai/buildroot/build_=
i686/staging_dir/usr/bin/i686-linux-uclibc-ld -L/home/malek/minisys/xenom=
ai/buildroot/build_i686/staging_dir/lib -L/home/malek/minisys/xenomai/bui=
ldroot/build_i686/staging_dir/usr/lib --sysroot=3D/home/malek/minisys/xen=
omai/buildroot/build_i686/staging_dir/) supports shared libraries
configure:13337: result: yes
configure:13354: /home/malek/minisys/xenomai/buildroot/build_i686/staging=
_dir/usr/bin/i686-linux-uclibc-g++ -Os  -I/home/malek/minisys/xenomai/bui=
ldroot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/b=
uildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/x=
enomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xe=
nomai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpenti=
umpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 =
-c -g -O2  conftest.cpp >&5
configure:13357: $? =3D 0
configure:13513: checking for /home/malek/minisys/xenomai/buildroot/build=
_i686/staging_dir/usr/bin/i686-linux-uclibc-g++ -Os  -I/home/malek/minisy=
s/xenomai/buildroot/build_i686/staging_dir/usr/include -I/home/malek/mini=
sys/xenomai/buildroot/build_i686/staging_dir/include --sysroot=3D/home/ma=
lek/minisys/xenomai/buildroot/build_i686/staging_dir/ -isysroot /home/mal=
ek/minisys/xenomai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -=
march=3Dpentiumpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFS=
ET_BITS=3D64 option to produce PIC
configure:13797: result: -fPIC
configure:13805: checking if /home/malek/minisys/xenomai/buildroot/build_=
i686/staging_dir/usr/bin/i686-linux-uclibc-g++ -Os  -I/home/malek/minisys=
/xenomai/buildroot/build_i686/staging_dir/usr/include -I/home/malek/minis=
ys/xenomai/buildroot/build_i686/staging_dir/include --sysroot=3D/home/mal=
ek/minisys/xenomai/buildroot/build_i686/staging_dir/ -isysroot /home/male=
k/minisys/xenomai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -m=
arch=3Dpentiumpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSE=
T_BITS=3D64 PIC flag -fPIC works
configure:13823: /home/malek/minisys/xenomai/buildroot/build_i686/staging=
_dir/usr/bin/i686-linux-uclibc-g++ -Os  -I/home/malek/minisys/xenomai/bui=
ldroot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/b=
uildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/x=
enomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xe=
nomai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpenti=
umpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 =
-c -g -O2  -fPIC -DPIC conftest.cpp >&5
configure:13827: $? =3D 0
configure:13840: result: yes
configure:13868: checking if /home/malek/minisys/xenomai/buildroot/build_=
i686/staging_dir/usr/bin/i686-linux-uclibc-g++ -Os  -I/home/malek/minisys=
/xenomai/buildroot/build_i686/staging_dir/usr/include -I/home/malek/minis=
ys/xenomai/buildroot/build_i686/staging_dir/include --sysroot=3D/home/mal=
ek/minisys/xenomai/buildroot/build_i686/staging_dir/ -isysroot /home/male=
k/minisys/xenomai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -m=
arch=3Dpentiumpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSE=
T_BITS=3D64 static flag -static works
configure:13896: result: no
configure:13906: checking if /home/malek/minisys/xenomai/buildroot/build_=
i686/staging_dir/usr/bin/i686-linux-uclibc-g++ -Os  -I/home/malek/minisys=
/xenomai/buildroot/build_i686/staging_dir/usr/include -I/home/malek/minis=
ys/xenomai/buildroot/build_i686/staging_dir/include --sysroot=3D/home/mal=
ek/minisys/xenomai/buildroot/build_i686/staging_dir/ -isysroot /home/male=
k/minisys/xenomai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -m=
arch=3Dpentiumpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSE=
T_BITS=3D64 supports -c -o file.o
configure:13927: /home/malek/minisys/xenomai/buildroot/build_i686/staging=
_dir/usr/bin/i686-linux-uclibc-g++ -Os  -I/home/malek/minisys/xenomai/bui=
ldroot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/b=
uildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/x=
enomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xe=
nomai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpenti=
umpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 =
-c -g -O2  -o out/conftest2.o conftest.cpp >&5
configure:13931: $? =3D 0
configure:13953: result: yes
configure:13979: checking whether the /home/malek/minisys/xenomai/buildro=
ot/build_i686/staging_dir/usr/bin/i686-linux-uclibc-g++ -Os  -I/home/male=
k/minisys/xenomai/buildroot/build_i686/staging_dir/usr/include -I/home/ma=
lek/minisys/xenomai/buildroot/build_i686/staging_dir/include --sysroot=3D=
/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/ -isysroot /=
home/malek/minisys/xenomai/buildroot/build_i686/staging_dir -mtune=3Dpent=
iumpro -march=3Dpentiumpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_F=
ILE_OFFSET_BITS=3D64 linker (/home/malek/minisys/xenomai/buildroot/build_=
i686/staging_dir/usr/bin/i686-linux-uclibc-ld -L/home/malek/minisys/xenom=
ai/buildroot/build_i686/staging_dir/lib -L/home/malek/minisys/xenomai/bui=
ldroot/build_i686/staging_dir/usr/lib --sysroot=3D/home/malek/minisys/xen=
omai/buildroot/build_i686/staging_dir/) supports shared libraries
configure:14008: result: yes
configure:14075: checking dynamic linker characteristics
configure:14637: result: GNU/Linux ld.so
configure:14661: checking how to hardcode library paths into programs
configure:14686: result: immediate
configure:15225: checking if libtool supports shared libraries
configure:15227: result: yes
configure:15230: checking whether to build shared libraries
configure:15250: result: yes
configure:15253: checking whether to build static libraries
configure:15257: result: yes
configure:15267: checking for gfortran option to produce PIC
configure:15499: result: -fPIC
configure:15507: checking if gfortran PIC flag -fPIC works
configure:15525: gfortran -c -g -O2 -fPIC conftest.f >&5
configure:15529: $? =3D 0
configure:15542: result: yes
configure:15570: checking if gfortran static flag -static works
configure:15598: result: yes
configure:15608: checking if gfortran supports -c -o file.o
configure:15629: gfortran -c -g -O2 -o out/conftest2.o conftest.f >&5
configure:15633: $? =3D 0
configure:15655: result: yes
configure:15681: checking whether the gfortran linker (/home/malek/minisy=
s/xenomai/buildroot/build_i686/staging_dir/usr/bin/i686-linux-uclibc-ld -=
L/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/lib -L/home=
/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/lib --sysroot=
=3D/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/) support=
s shared libraries
configure:16642: result: yes
configure:16709: checking dynamic linker characteristics
configure:17271: result: GNU/Linux ld.so
configure:17295: checking how to hardcode library paths into programs
configure:17320: result: immediate
configure:20942: checking dependency style of /home/malek/minisys/xenomai=
/buildroot/build_i686/staging_dir/usr/bin/i686-linux-uclibc-gcc -Os  -I/h=
ome/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/include -I=
/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/include --sy=
sroot=3D/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/ -is=
ysroot /home/malek/minisys/xenomai/buildroot/build_i686/staging_dir -mtun=
e=3Dpentiumpro -march=3Dpentiumpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOU=
RCE -D_FILE_OFFSET_BITS=3D64
configure:21033: result: gcc3
configure:21052: checking for flex
configure:21068: found /usr/bin/flex
configure:21079: result: flex
configure:21116: flex conftest.l
configure:21119: $? =3D 0
configure:21121: checking lex output file root
configure:21137: result: lex.yy
configure:21142: checking lex library
configure:21161: /home/malek/minisys/xenomai/buildroot/build_i686/staging=
_dir/usr/bin/i686-linux-uclibc-gcc -Os  -I/home/malek/minisys/xenomai/bui=
ldroot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/b=
uildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/x=
enomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xe=
nomai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpenti=
umpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 =
-o conftest    conftest.c   >&5
/tmp/ccodwf8I.o: In function `input':
conftest.c:(.text+0xacb): undefined reference to `yywrap'
/tmp/ccodwf8I.o: In function `yylex':
conftest.c:(.text+0xf88): undefined reference to `yywrap'
/tmp/ccodwf8I.o: In function `main':
conftest.c:(.text+0x1065): undefined reference to `yywrap'
collect2: ld returned 1 exit status
configure:21167: $? =3D 1
configure: failed program was:
|=20
| #line 3 "lex.yy.c"
|=20
| #define  YY_INT_ALIGNED short int
|=20
| /* A lexical scanner generated by flex */
|=20
| #define FLEX_SCANNER
| #define YY_FLEX_MAJOR_VERSION 2
| #define YY_FLEX_MINOR_VERSION 5
| #define YY_FLEX_SUBMINOR_VERSION 35
| #if YY_FLEX_SUBMINOR_VERSION > 0
| #define FLEX_BETA
| #endif
|=20
| /* First, we deal with  platform-specific or compiler-specific issues. =
*/
|=20
| /* begin standard C headers. */
| #include <stdio.h>
| #include <string.h>
| #include <errno.h>
| #include <stdlib.h>
|=20
| /* end standard C headers. */
|=20
| /* flex integer type definitions */
|=20
| #ifndef FLEXINT_H
| #define FLEXINT_H
|=20
| /* C99 systems have <inttypes.h>. Non-C99 systems may or may not. */
|=20
| #if defined (__STDC_VERSION__) && __STDC_VERSION__ >=3D 199901L
|=20
| /* C99 says to define __STDC_LIMIT_MACROS before including stdint.h,
|  * if you want the limit (max/min) macros for int types.=20
|  */
| #ifndef __STDC_LIMIT_MACROS
| #define __STDC_LIMIT_MACROS 1
| #endif
|=20
| #include <inttypes.h>
| typedef int8_t flex_int8_t;
| typedef uint8_t flex_uint8_t;
| typedef int16_t flex_int16_t;
| typedef uint16_t flex_uint16_t;
| typedef int32_t flex_int32_t;
| typedef uint32_t flex_uint32_t;
| #else
| typedef signed char flex_int8_t;
| typedef short int flex_int16_t;
| typedef int flex_int32_t;
| typedef unsigned char flex_uint8_t;=20
| typedef unsigned short int flex_uint16_t;
| typedef unsigned int flex_uint32_t;
| #endif /* ! C99 */
|=20
| /* Limits of integral types. */
| #ifndef INT8_MIN
| #define INT8_MIN               (-128)
| #endif
| #ifndef INT16_MIN
| #define INT16_MIN              (-32767-1)
| #endif
| #ifndef INT32_MIN
| #define INT32_MIN              (-2147483647-1)
| #endif
| #ifndef INT8_MAX
| #define INT8_MAX               (127)
| #endif
| #ifndef INT16_MAX
| #define INT16_MAX              (32767)
| #endif
| #ifndef INT32_MAX
| #define INT32_MAX              (2147483647)
| #endif
| #ifndef UINT8_MAX
| #define UINT8_MAX              (255U)
| #endif
| #ifndef UINT16_MAX
| #define UINT16_MAX             (65535U)
| #endif
| #ifndef UINT32_MAX
| #define UINT32_MAX             (4294967295U)
| #endif
|=20
| #endif /* ! FLEXINT_H */
|=20
| #ifdef __cplusplus
|=20
| /* The "const" storage-class-modifier is valid. */
| #define YY_USE_CONST
|=20
| #else	/* ! __cplusplus */
|=20
| /* C99 requires __STDC__ to be defined as 1. */
| #if defined (__STDC__)
|=20
| #define YY_USE_CONST
|=20
| #endif	/* defined (__STDC__) */
| #endif	/* ! __cplusplus */
|=20
| #ifdef YY_USE_CONST
| #define yyconst const
| #else
| #define yyconst
| #endif
|=20
| /* Returned upon end-of-file. */
| #define YY_NULL 0
|=20
| /* Promotes a possibly negative, possibly signed char to an unsigned
|  * integer for use as an array index.  If the signed char is negative,
|  * we want to instead treat it as an 8-bit unsigned char, hence the
|  * double cast.
|  */
| #define YY_SC_TO_UI(c) ((unsigned int) (unsigned char) c)
|=20
| /* Enter a start condition.  This macro really ought to take a paramete=
r,
|  * but we do it the disgusting crufty way forced on us by the ()-less
|  * definition of BEGIN.
|  */
| #define BEGIN (yy_start) =3D 1 + 2 *
|=20
| /* Translate the current start state into a value that can be later han=
ded
|  * to BEGIN to return to the state.  The YYSTATE alias is for lex
|  * compatibility.
|  */
| #define YY_START (((yy_start) - 1) / 2)
| #define YYSTATE YY_START
|=20
| /* Action number for EOF rule of a given start state. */
| #define YY_STATE_EOF(state) (YY_END_OF_BUFFER + state + 1)
|=20
| /* Special action meaning "start processing a new file". */
| #define YY_NEW_FILE yyrestart(yyin  )
|=20
| #define YY_END_OF_BUFFER_CHAR 0
|=20
| /* Size of default input buffer. */
| #ifndef YY_BUF_SIZE
| #define YY_BUF_SIZE 16384
| #endif
|=20
| /* The state buf must be large enough to hold one state per character i=
n the main buffer.
|  */
| #define YY_STATE_BUF_SIZE   ((YY_BUF_SIZE + 2) * sizeof(yy_state_type))=

|=20
| #ifndef YY_TYPEDEF_YY_BUFFER_STATE
| #define YY_TYPEDEF_YY_BUFFER_STATE
| typedef struct yy_buffer_state *YY_BUFFER_STATE;
| #endif
|=20
| extern int yyleng;
|=20
| extern FILE *yyin, *yyout;
|=20
| #define EOB_ACT_CONTINUE_SCAN 0
| #define EOB_ACT_END_OF_FILE 1
| #define EOB_ACT_LAST_MATCH 2
|=20
|     #define YY_LESS_LINENO(n)
|    =20
| /* Return all but the first "n" matched characters back to the input st=
ream. */
| #define yyless(n) \
| 	do \
| 		{ \
| 		/* Undo effects of setting up yytext. */ \
|         int yyless_macro_arg =3D (n); \
|         YY_LESS_LINENO(yyless_macro_arg);\
| 		*yy_cp =3D (yy_hold_char); \
| 		YY_RESTORE_YY_MORE_OFFSET \
| 		(yy_c_buf_p) =3D yy_cp =3D yy_bp + yyless_macro_arg - YY_MORE_ADJ; \
| 		YY_DO_BEFORE_ACTION; /* set up yytext again */ \
| 		} \
| 	while ( 0 )
|=20
| #define unput(c) yyunput( c, (yytext_ptr)  )
|=20
| #ifndef YY_TYPEDEF_YY_SIZE_T
| #define YY_TYPEDEF_YY_SIZE_T
| typedef size_t yy_size_t;
| #endif
|=20
| #ifndef YY_STRUCT_YY_BUFFER_STATE
| #define YY_STRUCT_YY_BUFFER_STATE
| struct yy_buffer_state
| 	{
| 	FILE *yy_input_file;
|=20
| 	char *yy_ch_buf;		/* input buffer */
| 	char *yy_buf_pos;		/* current position in input buffer */
|=20
| 	/* Size of input buffer in bytes, not including room for EOB
| 	 * characters.
| 	 */
| 	yy_size_t yy_buf_size;
|=20
| 	/* Number of characters read into yy_ch_buf, not including EOB
| 	 * characters.
| 	 */
| 	int yy_n_chars;
|=20
| 	/* Whether we "own" the buffer - i.e., we know we created it,
| 	 * and can realloc() it to grow it, and should free() it to
| 	 * delete it.
| 	 */
| 	int yy_is_our_buffer;
|=20
| 	/* Whether this is an "interactive" input source; if so, and
| 	 * if we're using stdio for input, then we want to use getc()
| 	 * instead of fread(), to make sure we stop fetching input after
| 	 * each newline.
| 	 */
| 	int yy_is_interactive;
|=20
| 	/* Whether we're considered to be at the beginning of a line.
| 	 * If so, '^' rules will be active on the next match, otherwise
| 	 * not.
| 	 */
| 	int yy_at_bol;
|=20
|     int yy_bs_lineno; /**< The line count. */
|     int yy_bs_column; /**< The column count. */
|    =20
| 	/* Whether to try to fill the input buffer when we reach the
| 	 * end of it.
| 	 */
| 	int yy_fill_buffer;
|=20
| 	int yy_buffer_status;
|=20
| #define YY_BUFFER_NEW 0
| #define YY_BUFFER_NORMAL 1
| 	/* When an EOF's been seen but there's still some text to process
| 	 * then we mark the buffer as YY_EOF_PENDING, to indicate that we
| 	 * shouldn't try reading from the input source any more.  We might
| 	 * still have a bunch of tokens to match, though, because of
| 	 * possible backing-up.
| 	 *
| 	 * When we actually see the EOF, we change the status to "new"
| 	 * (via yyrestart()), so that the user can continue scanning by
| 	 * just pointing yyin at a new input file.
| 	 */
| #define YY_BUFFER_EOF_PENDING 2
|=20
| 	};
| #endif /* !YY_STRUCT_YY_BUFFER_STATE */
|=20
| /* Stack of input buffers. */
| static size_t yy_buffer_stack_top =3D 0; /**< index of top of stack. */=

| static size_t yy_buffer_stack_max =3D 0; /**< capacity of stack. */
| static YY_BUFFER_STATE * yy_buffer_stack =3D 0; /**< Stack as an array.=
 */
|=20
| /* We provide macros for accessing buffer states in case in the
|  * future we want to put the buffer states in a more general
|  * "scanner state".
|  *
|  * Returns the top of the stack, or NULL.
|  */
| #define YY_CURRENT_BUFFER ( (yy_buffer_stack) \
|                           ? (yy_buffer_stack)[(yy_buffer_stack_top)] \
|                           : NULL)
|=20
| /* Same as previous macro, but useful when we know that the buffer stac=
k is not
|  * NULL or when we need an lvalue. For internal use only.
|  */
| #define YY_CURRENT_BUFFER_LVALUE (yy_buffer_stack)[(yy_buffer_stack_top=
)]
|=20
| /* yy_hold_char holds the character lost when yytext is formed. */
| static char yy_hold_char;
| static int yy_n_chars;		/* number of characters read into yy_ch_buf */
| int yyleng;
|=20
| /* Points to current character in buffer. */
| static char *yy_c_buf_p =3D (char *) 0;
| static int yy_init =3D 0;		/* whether we need to initialize */
| static int yy_start =3D 0;	/* start state number */
|=20
| /* Flag which is used to allow yywrap()'s to do buffer switches
|  * instead of setting up a fresh yyin.  A bit of a hack ...
|  */
| static int yy_did_buffer_switch_on_eof;
|=20
| void yyrestart (FILE *input_file  );
| void yy_switch_to_buffer (YY_BUFFER_STATE new_buffer  );
| YY_BUFFER_STATE yy_create_buffer (FILE *file,int size  );
| void yy_delete_buffer (YY_BUFFER_STATE b  );
| void yy_flush_buffer (YY_BUFFER_STATE b  );
| void yypush_buffer_state (YY_BUFFER_STATE new_buffer  );
| void yypop_buffer_state (void );
|=20
| static void yyensure_buffer_stack (void );
| static void yy_load_buffer_state (void );
| static void yy_init_buffer (YY_BUFFER_STATE b,FILE *file  );
|=20
| #define YY_FLUSH_BUFFER yy_flush_buffer(YY_CURRENT_BUFFER )
|=20
| YY_BUFFER_STATE yy_scan_buffer (char *base,yy_size_t size  );
| YY_BUFFER_STATE yy_scan_string (yyconst char *yy_str  );
| YY_BUFFER_STATE yy_scan_bytes (yyconst char *bytes,int len  );
|=20
| void *yyalloc (yy_size_t  );
| void *yyrealloc (void *,yy_size_t  );
| void yyfree (void *  );
|=20
| #define yy_new_buffer yy_create_buffer
|=20
| #define yy_set_interactive(is_interactive) \
| 	{ \
| 	if ( ! YY_CURRENT_BUFFER ){ \
|         yyensure_buffer_stack (); \
| 		YY_CURRENT_BUFFER_LVALUE =3D    \
|             yy_create_buffer(yyin,YY_BUF_SIZE ); \
| 	} \
| 	YY_CURRENT_BUFFER_LVALUE->yy_is_interactive =3D is_interactive; \
| 	}
|=20
| #define yy_set_bol(at_bol) \
| 	{ \
| 	if ( ! YY_CURRENT_BUFFER ){\
|         yyensure_buffer_stack (); \
| 		YY_CURRENT_BUFFER_LVALUE =3D    \
|             yy_create_buffer(yyin,YY_BUF_SIZE ); \
| 	} \
| 	YY_CURRENT_BUFFER_LVALUE->yy_at_bol =3D at_bol; \
| 	}
|=20
| #define YY_AT_BOL() (YY_CURRENT_BUFFER_LVALUE->yy_at_bol)
|=20
| /* Begin user sect3 */
|=20
| typedef unsigned char YY_CHAR;
|=20
| FILE *yyin =3D (FILE *) 0, *yyout =3D (FILE *) 0;
|=20
| typedef int yy_state_type;
|=20
| extern int yylineno;
|=20
| int yylineno =3D 1;
|=20
| extern char *yytext;
| #define yytext_ptr yytext
|=20
| static yy_state_type yy_get_previous_state (void );
| static yy_state_type yy_try_NUL_trans (yy_state_type current_state  );
| static int yy_get_next_buffer (void );
| static void yy_fatal_error (yyconst char msg[]  );
|=20
| /* Done after the current pattern has been matched and before the
|  * corresponding action - sets up yytext.
|  */
| #define YY_DO_BEFORE_ACTION \
| 	(yytext_ptr) =3D yy_bp; \
| 	(yytext_ptr) -=3D (yy_more_len); \
| 	yyleng =3D (size_t) (yy_cp - (yytext_ptr)); \
| 	(yy_hold_char) =3D *yy_cp; \
| 	*yy_cp =3D '\0'; \
| 	(yy_c_buf_p) =3D yy_cp;
|=20
| #define YY_NUM_RULES 8
| #define YY_END_OF_BUFFER 9
| /* This struct is not used in this scanner,
|    but its presence is necessary. */
| struct yy_trans_info
| 	{
| 	flex_int32_t yy_verify;
| 	flex_int32_t yy_nxt;
| 	};
| static yyconst flex_int16_t yy_acclist[23] =3D
|     {   0,
|         9,    7,    8,    8,    1,    7,    8,    2,    7,    8,
|         3,    7,    8,    4,    7,    8,    5,    7,    8,    6,
|         7,    8
|     } ;
|=20
| static yyconst flex_int16_t yy_accept[14] =3D
|     {   0,
|         1,    1,    1,    2,    4,    5,    8,   11,   14,   17,
|        20,   23,   23
|     } ;
|=20
| static yyconst flex_int32_t yy_ec[256] =3D
|     {   0,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    2,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    3,    4,    5,    6,
|=20
|         7,    8,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|=20
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1
|     } ;
|=20
| static yyconst flex_int32_t yy_meta[9] =3D
|     {   0,
|         1,    1,    1,    1,    1,    1,    1,    1
|     } ;
|=20
| static yyconst flex_int16_t yy_base[13] =3D
|     {   0,
|         0,    0,    9,   10,   10,   10,   10,   10,   10,   10,
|        10,   10
|     } ;
|=20
| static yyconst flex_int16_t yy_def[13] =3D
|     {   0,
|        12,    1,   12,   12,   12,   12,   12,   12,   12,   12,
|        12,    0
|     } ;
|=20
| static yyconst flex_int16_t yy_nxt[19] =3D
|     {   0,
|         4,    5,    6,    7,    8,    9,   10,   11,   12,    3,
|        12,   12,   12,   12,   12,   12,   12,   12
|     } ;
|=20
| static yyconst flex_int16_t yy_chk[19] =3D
|     {   0,
|         1,    1,    1,    1,    1,    1,    1,    1,    3,   12,
|        12,   12,   12,   12,   12,   12,   12,   12
|     } ;
|=20
| extern int yy_flex_debug;
| int yy_flex_debug =3D 0;
|=20
| static yy_state_type *yy_state_buf=3D0, *yy_state_ptr=3D0;
| static char *yy_full_match;
| static int yy_lp;
| #define REJECT \
| { \
| *yy_cp =3D (yy_hold_char); /* undo effects of setting up yytext */ \
| yy_cp =3D (yy_full_match); /* restore poss. backed-over text */ \
| ++(yy_lp); \
| goto find_rule; \
| }
|=20
| static int yy_more_flag =3D 0;
| static int yy_more_len =3D 0;
| #define yymore() ((yy_more_flag) =3D 1)
| #define YY_MORE_ADJ (yy_more_len)
| #define YY_RESTORE_YY_MORE_OFFSET
| char *yytext;
| #line 1 "conftest.l"
| #line 468 "lex.yy.c"
|=20
| #define INITIAL 0
|=20
| #ifndef YY_NO_UNISTD_H
| /* Special case for "unistd.h", since it is non-ANSI. We include it way=

|  * down here because we want the user's section 1 to have been scanned =
first.
|  * The user has a chance to override it with an option.
|  */
| #include <unistd.h>
| #endif
|=20
| #ifndef YY_EXTRA_TYPE
| #define YY_EXTRA_TYPE void *
| #endif
|=20
| static int yy_init_globals (void );
|=20
| /* Accessor methods to globals.
|    These are made visible to non-reentrant scanners for convenience. */=

|=20
| int yylex_destroy (void );
|=20
| int yyget_debug (void );
|=20
| void yyset_debug (int debug_flag  );
|=20
| YY_EXTRA_TYPE yyget_extra (void );
|=20
| void yyset_extra (YY_EXTRA_TYPE user_defined  );
|=20
| FILE *yyget_in (void );
|=20
| void yyset_in  (FILE * in_str  );
|=20
| FILE *yyget_out (void );
|=20
| void yyset_out  (FILE * out_str  );
|=20
| int yyget_leng (void );
|=20
| char *yyget_text (void );
|=20
| int yyget_lineno (void );
|=20
| void yyset_lineno (int line_number  );
|=20
| /* Macros after this point can all be overridden by user definitions in=

|  * section 1.
|  */
|=20
| #ifndef YY_SKIP_YYWRAP
| #ifdef __cplusplus
| extern "C" int yywrap (void );
| #else
| extern int yywrap (void );
| #endif
| #endif
|=20
|     static void yyunput (int c,char *buf_ptr  );
|    =20
| #ifndef yytext_ptr
| static void yy_flex_strncpy (char *,yyconst char *,int );
| #endif
|=20
| #ifdef YY_NEED_STRLEN
| static int yy_flex_strlen (yyconst char * );
| #endif
|=20
| #ifndef YY_NO_INPUT
|=20
| #ifdef __cplusplus
| static int yyinput (void );
| #else
| static int input (void );
| #endif
|=20
| #endif
|=20
| /* Amount of stuff to slurp up with each read. */
| #ifndef YY_READ_BUF_SIZE
| #define YY_READ_BUF_SIZE 8192
| #endif
|=20
| /* Copy whatever the last rule matched to the standard output. */
| #ifndef ECHO
| /* This used to be an fputs(), but since the string might contain NUL's=
,
|  * we now use fwrite().
|  */
| #define ECHO fwrite( yytext, yyleng, 1, yyout )
| #endif
|=20
| /* Gets input and stuffs it into "buf".  number of characters read, or =
YY_NULL,
|  * is returned in "result".
|  */
| #ifndef YY_INPUT
| #define YY_INPUT(buf,result,max_size) \
| 	if ( YY_CURRENT_BUFFER_LVALUE->yy_is_interactive ) \
| 		{ \
| 		int c =3D '*'; \
| 		unsigned n; \
| 		for ( n =3D 0; n < max_size && \
| 			     (c =3D getc( yyin )) !=3D EOF && c !=3D '\n'; ++n ) \
| 			buf[n] =3D (char) c; \
| 		if ( c =3D=3D '\n' ) \
| 			buf[n++] =3D (char) c; \
| 		if ( c =3D=3D EOF && ferror( yyin ) ) \
| 			YY_FATAL_ERROR( "input in flex scanner failed" ); \
| 		result =3D n; \
| 		} \
| 	else \
| 		{ \
| 		errno=3D0; \
| 		while ( (result =3D fread(buf, 1, max_size, yyin))=3D=3D0 && ferror(y=
yin)) \
| 			{ \
| 			if( errno !=3D EINTR) \
| 				{ \
| 				YY_FATAL_ERROR( "input in flex scanner failed" ); \
| 				break; \
| 				} \
| 			errno=3D0; \
| 			clearerr(yyin); \
| 			} \
| 		}\
| \
|=20
| #endif
|=20
| /* No semi-colon after return; correct usage is to write "yyterminate()=
;" -
|  * we don't want an extra ';' after the "return" because that will caus=
e
|  * some compilers to complain about unreachable statements.
|  */
| #ifndef yyterminate
| #define yyterminate() return YY_NULL
| #endif
|=20
| /* Number of entries by which start-condition stack grows. */
| #ifndef YY_START_STACK_INCR
| #define YY_START_STACK_INCR 25
| #endif
|=20
| /* Report a fatal error. */
| #ifndef YY_FATAL_ERROR
| #define YY_FATAL_ERROR(msg) yy_fatal_error( msg )
| #endif
|=20
| /* end tables serialization structures and prototypes */
|=20
| /* Default declaration of generated scanner - a define so the user can
|  * easily add parameters.
|  */
| #ifndef YY_DECL
| #define YY_DECL_IS_OURS 1
|=20
| extern int yylex (void);
|=20
| #define YY_DECL int yylex (void)
| #endif /* !YY_DECL */
|=20
| /* Code executed at the beginning of each rule, after yytext and yyleng=

|  * have been set up.
|  */
| #ifndef YY_USER_ACTION
| #define YY_USER_ACTION
| #endif
|=20
| /* Code executed at the end of each rule. */
| #ifndef YY_BREAK
| #define YY_BREAK break;
| #endif
|=20
| #define YY_RULE_SETUP \
| 	YY_USER_ACTION
|=20
| /** The main scanner function which does all the work.
|  */
| YY_DECL
| {
| 	register yy_state_type yy_current_state;
| 	register char *yy_cp, *yy_bp;
| 	register int yy_act;
|    =20
| #line 1 "conftest.l"
|=20
| #line 652 "lex.yy.c"
|=20
| 	if ( !(yy_init) )
| 		{
| 		(yy_init) =3D 1;
|=20
| #ifdef YY_USER_INIT
| 		YY_USER_INIT;
| #endif
|=20
|         /* Create the reject buffer large enough to save one state per =
allowed character. */
|         if ( ! (yy_state_buf) )
|             (yy_state_buf) =3D (yy_state_type *)yyalloc(YY_STATE_BUF_SI=
ZE  );
|             if ( ! (yy_state_buf) )
|                 YY_FATAL_ERROR( "out of dynamic memory in yylex()" );
|=20
| 		if ( ! (yy_start) )
| 			(yy_start) =3D 1;	/* first start state */
|=20
| 		if ( ! yyin )
| 			yyin =3D stdin;
|=20
| 		if ( ! yyout )
| 			yyout =3D stdout;
|=20
| 		if ( ! YY_CURRENT_BUFFER ) {
| 			yyensure_buffer_stack ();
| 			YY_CURRENT_BUFFER_LVALUE =3D
| 				yy_create_buffer(yyin,YY_BUF_SIZE );
| 		}
|=20
| 		yy_load_buffer_state( );
| 		}
|=20
| 	while ( 1 )		/* loops until end-of-file is reached */
| 		{
| 		(yy_more_len) =3D 0;
| 		if ( (yy_more_flag) )
| 			{
| 			(yy_more_len) =3D (yy_c_buf_p) - (yytext_ptr);
| 			(yy_more_flag) =3D 0;
| 			}
| 		yy_cp =3D (yy_c_buf_p);
|=20
| 		/* Support of yytext. */
| 		*yy_cp =3D (yy_hold_char);
|=20
| 		/* yy_bp points to the position in yy_ch_buf of the start of
| 		 * the current run.
| 		 */
| 		yy_bp =3D yy_cp;
|=20
| 		yy_current_state =3D (yy_start);
|=20
| 		(yy_state_ptr) =3D (yy_state_buf);
| 		*(yy_state_ptr)++ =3D yy_current_state;
|=20
| yy_match:
| 		do
| 			{
| 			register YY_CHAR yy_c =3D yy_ec[YY_SC_TO_UI(*yy_cp)];
| 			while ( yy_chk[yy_base[yy_current_state] + yy_c] !=3D yy_current_sta=
te )
| 				{
| 				yy_current_state =3D (int) yy_def[yy_current_state];
| 				if ( yy_current_state >=3D 13 )
| 					yy_c =3D yy_meta[(unsigned int) yy_c];
| 				}
| 			yy_current_state =3D yy_nxt[yy_base[yy_current_state] + (unsigned in=
t) yy_c];
| 			*(yy_state_ptr)++ =3D yy_current_state;
| 			++yy_cp;
| 			}
| 		while ( yy_base[yy_current_state] !=3D 10 );
|=20
| yy_find_action:
| 		yy_current_state =3D *--(yy_state_ptr);
| 		(yy_lp) =3D yy_accept[yy_current_state];
| find_rule: /* we branch to this label when backing up */
| 		for ( ; ; ) /* until we find what rule we matched */
| 			{
| 			if ( (yy_lp) && (yy_lp) < yy_accept[yy_current_state + 1] )
| 				{
| 				yy_act =3D yy_acclist[(yy_lp)];
| 					{
| 					(yy_full_match) =3D yy_cp;
| 					break;
| 					}
| 				}
| 			--yy_cp;
| 			yy_current_state =3D *--(yy_state_ptr);
| 			(yy_lp) =3D yy_accept[yy_current_state];
| 			}
|=20
| 		YY_DO_BEFORE_ACTION;
|=20
| do_action:	/* This label is used only to access EOF actions. */
|=20
| 		switch ( yy_act )
| 	{ /* beginning of action switch */
| case 1:
| YY_RULE_SETUP
| #line 2 "conftest.l"
| { ECHO; }
| 	YY_BREAK
| case 2:
| YY_RULE_SETUP
| #line 3 "conftest.l"
| { REJECT; }
| 	YY_BREAK
| case 3:
| YY_RULE_SETUP
| #line 4 "conftest.l"
| { yymore (); }
| 	YY_BREAK
| case 4:
| YY_RULE_SETUP
| #line 5 "conftest.l"
| { yyless (1); }
| 	YY_BREAK
| case 5:
| YY_RULE_SETUP
| #line 6 "conftest.l"
| { yyless (input () !=3D 0); }
| 	YY_BREAK
| case 6:
| YY_RULE_SETUP
| #line 7 "conftest.l"
| { unput (yytext[0]); }
| 	YY_BREAK
| case 7:
| YY_RULE_SETUP
| #line 8 "conftest.l"
| { BEGIN INITIAL; }
| 	YY_BREAK
| case 8:
| YY_RULE_SETUP
| #line 9 "conftest.l"
| ECHO;
| 	YY_BREAK
| #line 790 "lex.yy.c"
| 			case YY_STATE_EOF(INITIAL):
| 				yyterminate();
|=20
| 	case YY_END_OF_BUFFER:
| 		{
| 		/* Amount of text matched not including the EOB char. */
| 		int yy_amount_of_matched_text =3D (int) (yy_cp - (yytext_ptr)) - 1;
|=20
| 		/* Undo the effects of YY_DO_BEFORE_ACTION. */
| 		*yy_cp =3D (yy_hold_char);
| 		YY_RESTORE_YY_MORE_OFFSET
|=20
| 		if ( YY_CURRENT_BUFFER_LVALUE->yy_buffer_status =3D=3D YY_BUFFER_NEW =
)
| 			{
| 			/* We're scanning a new file or input source.  It's
| 			 * possible that this happened because the user
| 			 * just pointed yyin at a new source and called
| 			 * yylex().  If so, then we have to assure
| 			 * consistency between YY_CURRENT_BUFFER and our
| 			 * globals.  Here is the right place to do so, because
| 			 * this is the first action (other than possibly a
| 			 * back-up) that will match for the new input source.
| 			 */
| 			(yy_n_chars) =3D YY_CURRENT_BUFFER_LVALUE->yy_n_chars;
| 			YY_CURRENT_BUFFER_LVALUE->yy_input_file =3D yyin;
| 			YY_CURRENT_BUFFER_LVALUE->yy_buffer_status =3D YY_BUFFER_NORMAL;
| 			}
|=20
| 		/* Note that here we test for yy_c_buf_p "<=3D" to the position
| 		 * of the first EOB in the buffer, since yy_c_buf_p will
| 		 * already have been incremented past the NUL character
| 		 * (since all states make transitions on EOB to the
| 		 * end-of-buffer state).  Contrast this with the test
| 		 * in input().
| 		 */
| 		if ( (yy_c_buf_p) <=3D &YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[(yy_n_cha=
rs)] )
| 			{ /* This was really a NUL. */
| 			yy_state_type yy_next_state;
|=20
| 			(yy_c_buf_p) =3D (yytext_ptr) + yy_amount_of_matched_text;
|=20
| 			yy_current_state =3D yy_get_previous_state(  );
|=20
| 			/* Okay, we're now positioned to make the NUL
| 			 * transition.  We couldn't have
| 			 * yy_get_previous_state() go ahead and do it
| 			 * for us because it doesn't know how to deal
| 			 * with the possibility of jamming (and we don't
| 			 * want to build jamming into it because then it
| 			 * will run more slowly).
| 			 */
|=20
| 			yy_next_state =3D yy_try_NUL_trans( yy_current_state );
|=20
| 			yy_bp =3D (yytext_ptr) + YY_MORE_ADJ;
|=20
| 			if ( yy_next_state )
| 				{
| 				/* Consume the NUL. */
| 				yy_cp =3D ++(yy_c_buf_p);
| 				yy_current_state =3D yy_next_state;
| 				goto yy_match;
| 				}
|=20
| 			else
| 				{
| 				yy_cp =3D (yy_c_buf_p);
| 				goto yy_find_action;
| 				}
| 			}
|=20
| 		else switch ( yy_get_next_buffer(  ) )
| 			{
| 			case EOB_ACT_END_OF_FILE:
| 				{
| 				(yy_did_buffer_switch_on_eof) =3D 0;
|=20
| 				if ( yywrap( ) )
| 					{
| 					/* Note: because we've taken care in
| 					 * yy_get_next_buffer() to have set up
| 					 * yytext, we can now set up
| 					 * yy_c_buf_p so that if some total
| 					 * hoser (like flex itself) wants to
| 					 * call the scanner after we return the
| 					 * YY_NULL, it'll still work - another
| 					 * YY_NULL will get returned.
| 					 */
| 					(yy_c_buf_p) =3D (yytext_ptr) + YY_MORE_ADJ;
|=20
| 					yy_act =3D YY_STATE_EOF(YY_START);
| 					goto do_action;
| 					}
|=20
| 				else
| 					{
| 					if ( ! (yy_did_buffer_switch_on_eof) )
| 						YY_NEW_FILE;
| 					}
| 				break;
| 				}
|=20
| 			case EOB_ACT_CONTINUE_SCAN:
| 				(yy_c_buf_p) =3D
| 					(yytext_ptr) + yy_amount_of_matched_text;
|=20
| 				yy_current_state =3D yy_get_previous_state(  );
|=20
| 				yy_cp =3D (yy_c_buf_p);
| 				yy_bp =3D (yytext_ptr) + YY_MORE_ADJ;
| 				goto yy_match;
|=20
| 			case EOB_ACT_LAST_MATCH:
| 				(yy_c_buf_p) =3D
| 				&YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[(yy_n_chars)];
|=20
| 				yy_current_state =3D yy_get_previous_state(  );
|=20
| 				yy_cp =3D (yy_c_buf_p);
| 				yy_bp =3D (yytext_ptr) + YY_MORE_ADJ;
| 				goto yy_find_action;
| 			}
| 		break;
| 		}
|=20
| 	default:
| 		YY_FATAL_ERROR(
| 			"fatal flex scanner internal error--no action found" );
| 	} /* end of action switch */
| 		} /* end of scanning one token */
| } /* end of yylex */
|=20
| /* yy_get_next_buffer - try to read in a new buffer
|  *
|  * Returns a code representing an action:
|  *	EOB_ACT_LAST_MATCH -
|  *	EOB_ACT_CONTINUE_SCAN - continue scanning from current position
|  *	EOB_ACT_END_OF_FILE - end of file
|  */
| static int yy_get_next_buffer (void)
| {
|     	register char *dest =3D YY_CURRENT_BUFFER_LVALUE->yy_ch_buf;
| 	register char *source =3D (yytext_ptr);
| 	register int number_to_move, i;
| 	int ret_val;
|=20
| 	if ( (yy_c_buf_p) > &YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[(yy_n_chars) =
+ 1] )
| 		YY_FATAL_ERROR(
| 		"fatal flex scanner internal error--end of buffer missed" );
|=20
| 	if ( YY_CURRENT_BUFFER_LVALUE->yy_fill_buffer =3D=3D 0 )
| 		{ /* Don't try to fill the buffer, so this is an EOF. */
| 		if ( (yy_c_buf_p) - (yytext_ptr) - YY_MORE_ADJ =3D=3D 1 )
| 			{
| 			/* We matched a single character, the EOB, so
| 			 * treat this as a final EOF.
| 			 */
| 			return EOB_ACT_END_OF_FILE;
| 			}
|=20
| 		else
| 			{
| 			/* We matched some text prior to the EOB, first
| 			 * process it.
| 			 */
| 			return EOB_ACT_LAST_MATCH;
| 			}
| 		}
|=20
| 	/* Try to read more data. */
|=20
| 	/* First move last chars to start of buffer. */
| 	number_to_move =3D (int) ((yy_c_buf_p) - (yytext_ptr)) - 1;
|=20
| 	for ( i =3D 0; i < number_to_move; ++i )
| 		*(dest++) =3D *(source++);
|=20
| 	if ( YY_CURRENT_BUFFER_LVALUE->yy_buffer_status =3D=3D YY_BUFFER_EOF_P=
ENDING )
| 		/* don't do the read, it's not guaranteed to return an EOF,
| 		 * just force an EOF
| 		 */
| 		YY_CURRENT_BUFFER_LVALUE->yy_n_chars =3D (yy_n_chars) =3D 0;
|=20
| 	else
| 		{
| 			int num_to_read =3D
| 			YY_CURRENT_BUFFER_LVALUE->yy_buf_size - number_to_move - 1;
|=20
| 		while ( num_to_read <=3D 0 )
| 			{ /* Not enough room in the buffer - grow it. */
|=20
| 			YY_FATAL_ERROR(
| "input buffer overflow, can't enlarge buffer because scanner uses REJEC=
T" );
|=20
| 			}
|=20
| 		if ( num_to_read > YY_READ_BUF_SIZE )
| 			num_to_read =3D YY_READ_BUF_SIZE;
|=20
| 		/* Read in more data. */
| 		YY_INPUT( (&YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[number_to_move]),
| 			(yy_n_chars), (size_t) num_to_read );
|=20
| 		YY_CURRENT_BUFFER_LVALUE->yy_n_chars =3D (yy_n_chars);
| 		}
|=20
| 	if ( (yy_n_chars) =3D=3D 0 )
| 		{
| 		if ( number_to_move =3D=3D YY_MORE_ADJ )
| 			{
| 			ret_val =3D EOB_ACT_END_OF_FILE;
| 			yyrestart(yyin  );
| 			}
|=20
| 		else
| 			{
| 			ret_val =3D EOB_ACT_LAST_MATCH;
| 			YY_CURRENT_BUFFER_LVALUE->yy_buffer_status =3D
| 				YY_BUFFER_EOF_PENDING;
| 			}
| 		}
|=20
| 	else
| 		ret_val =3D EOB_ACT_CONTINUE_SCAN;
|=20
| 	if ((yy_size_t) ((yy_n_chars) + number_to_move) > YY_CURRENT_BUFFER_LV=
ALUE->yy_buf_size) {
| 		/* Extend the array by 50%, plus the number we really need. */
| 		yy_size_t new_size =3D (yy_n_chars) + number_to_move + ((yy_n_chars) =
>> 1);
| 		YY_CURRENT_BUFFER_LVALUE->yy_ch_buf =3D (char *) yyrealloc((void *) Y=
Y_CURRENT_BUFFER_LVALUE->yy_ch_buf,new_size  );
| 		if ( ! YY_CURRENT_BUFFER_LVALUE->yy_ch_buf )
| 			YY_FATAL_ERROR( "out of dynamic memory in yy_get_next_buffer()" );
| 	}
|=20
| 	(yy_n_chars) +=3D number_to_move;
| 	YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[(yy_n_chars)] =3D YY_END_OF_BUFFER=
_CHAR;
| 	YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[(yy_n_chars) + 1] =3D YY_END_OF_BU=
FFER_CHAR;
|=20
| 	(yytext_ptr) =3D &YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[0];
|=20
| 	return ret_val;
| }
|=20
| /* yy_get_previous_state - get the state just before the EOB char was r=
eached */
|=20
|     static yy_state_type yy_get_previous_state (void)
| {
| 	register yy_state_type yy_current_state;
| 	register char *yy_cp;
|    =20
| 	yy_current_state =3D (yy_start);
|=20
| 	(yy_state_ptr) =3D (yy_state_buf);
| 	*(yy_state_ptr)++ =3D yy_current_state;
|=20
| 	for ( yy_cp =3D (yytext_ptr) + YY_MORE_ADJ; yy_cp < (yy_c_buf_p); ++yy=
_cp )
| 		{
| 		register YY_CHAR yy_c =3D (*yy_cp ? yy_ec[YY_SC_TO_UI(*yy_cp)] : 1);
| 		while ( yy_chk[yy_base[yy_current_state] + yy_c] !=3D yy_current_stat=
e )
| 			{
| 			yy_current_state =3D (int) yy_def[yy_current_state];
| 			if ( yy_current_state >=3D 13 )
| 				yy_c =3D yy_meta[(unsigned int) yy_c];
| 			}
| 		yy_current_state =3D yy_nxt[yy_base[yy_current_state] + (unsigned int=
) yy_c];
| 		*(yy_state_ptr)++ =3D yy_current_state;
| 		}
|=20
| 	return yy_current_state;
| }
|=20
| /* yy_try_NUL_trans - try to make a transition on the NUL character
|  *
|  * synopsis
|  *	next_state =3D yy_try_NUL_trans( current_state );
|  */
|     static yy_state_type yy_try_NUL_trans  (yy_state_type yy_current_st=
ate )
| {
| 	register int yy_is_jam;
|    =20
| 	register YY_CHAR yy_c =3D 1;
| 	while ( yy_chk[yy_base[yy_current_state] + yy_c] !=3D yy_current_state=
 )
| 		{
| 		yy_current_state =3D (int) yy_def[yy_current_state];
| 		if ( yy_current_state >=3D 13 )
| 			yy_c =3D yy_meta[(unsigned int) yy_c];
| 		}
| 	yy_current_state =3D yy_nxt[yy_base[yy_current_state] + (unsigned int)=
 yy_c];
| 	yy_is_jam =3D (yy_current_state =3D=3D 12);
| 	if ( ! yy_is_jam )
| 		*(yy_state_ptr)++ =3D yy_current_state;
|=20
| 	return yy_is_jam ? 0 : yy_current_state;
| }
|=20
|     static void yyunput (int c, register char * yy_bp )
| {
| 	register char *yy_cp;
|    =20
|     yy_cp =3D (yy_c_buf_p);
|=20
| 	/* undo effects of setting up yytext */
| 	*yy_cp =3D (yy_hold_char);
|=20
| 	if ( yy_cp < YY_CURRENT_BUFFER_LVALUE->yy_ch_buf + 2 )
| 		{ /* need to shift things up to make room */
| 		/* +2 for EOB chars. */
| 		register int number_to_move =3D (yy_n_chars) + 2;
| 		register char *dest =3D &YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[
| 					YY_CURRENT_BUFFER_LVALUE->yy_buf_size + 2];
| 		register char *source =3D
| 				&YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[number_to_move];
|=20
| 		while ( source > YY_CURRENT_BUFFER_LVALUE->yy_ch_buf )
| 			*--dest =3D *--source;
|=20
| 		yy_cp +=3D (int) (dest - source);
| 		yy_bp +=3D (int) (dest - source);
| 		YY_CURRENT_BUFFER_LVALUE->yy_n_chars =3D
| 			(yy_n_chars) =3D YY_CURRENT_BUFFER_LVALUE->yy_buf_size;
|=20
| 		if ( yy_cp < YY_CURRENT_BUFFER_LVALUE->yy_ch_buf + 2 )
| 			YY_FATAL_ERROR( "flex scanner push-back overflow" );
| 		}
|=20
| 	*--yy_cp =3D (char) c;
|=20
| 	(yytext_ptr) =3D yy_bp;
| 	(yy_hold_char) =3D *yy_cp;
| 	(yy_c_buf_p) =3D yy_cp;
| }
|=20
| #ifndef YY_NO_INPUT
| #ifdef __cplusplus
|     static int yyinput (void)
| #else
|     static int input  (void)
| #endif
|=20
| {
| 	int c;
|    =20
| 	*(yy_c_buf_p) =3D (yy_hold_char);
|=20
| 	if ( *(yy_c_buf_p) =3D=3D YY_END_OF_BUFFER_CHAR )
| 		{
| 		/* yy_c_buf_p now points to the character we want to return.
| 		 * If this occurs *before* the EOB characters, then it's a
| 		 * valid NUL; if not, then we've hit the end of the buffer.
| 		 */
| 		if ( (yy_c_buf_p) < &YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[(yy_n_chars)=
] )
| 			/* This was really a NUL. */
| 			*(yy_c_buf_p) =3D '\0';
|=20
| 		else
| 			{ /* need more input */
| 			int offset =3D (yy_c_buf_p) - (yytext_ptr);
| 			++(yy_c_buf_p);
|=20
| 			switch ( yy_get_next_buffer(  ) )
| 				{
| 				case EOB_ACT_LAST_MATCH:
| 					/* This happens because yy_g_n_b()
| 					 * sees that we've accumulated a
| 					 * token and flags that we need to
| 					 * try matching the token before
| 					 * proceeding.  But for input(),
| 					 * there's no matching to consider.
| 					 * So convert the EOB_ACT_LAST_MATCH
| 					 * to EOB_ACT_END_OF_FILE.
| 					 */
|=20
| 					/* Reset buffer status. */
| 					yyrestart(yyin );
|=20
| 					/*FALLTHROUGH*/
|=20
| 				case EOB_ACT_END_OF_FILE:
| 					{
| 					if ( yywrap( ) )
| 						return EOF;
|=20
| 					if ( ! (yy_did_buffer_switch_on_eof) )
| 						YY_NEW_FILE;
| #ifdef __cplusplus
| 					return yyinput();
| #else
| 					return input();
| #endif
| 					}
|=20
| 				case EOB_ACT_CONTINUE_SCAN:
| 					(yy_c_buf_p) =3D (yytext_ptr) + offset;
| 					break;
| 				}
| 			}
| 		}
|=20
| 	c =3D *(unsigned char *) (yy_c_buf_p);	/* cast for 8-bit char's */
| 	*(yy_c_buf_p) =3D '\0';	/* preserve yytext */
| 	(yy_hold_char) =3D *++(yy_c_buf_p);
|=20
| 	return c;
| }
| #endif	/* ifndef YY_NO_INPUT */
|=20
| /** Immediately switch to a different input stream.
|  * @param input_file A readable stream.
|  *=20
|  * @note This function does not reset the start condition to @c INITIAL=
 .
|  */
|     void yyrestart  (FILE * input_file )
| {
|    =20
| 	if ( ! YY_CURRENT_BUFFER ){
|         yyensure_buffer_stack ();
| 		YY_CURRENT_BUFFER_LVALUE =3D
|             yy_create_buffer(yyin,YY_BUF_SIZE );
| 	}
|=20
| 	yy_init_buffer(YY_CURRENT_BUFFER,input_file );
| 	yy_load_buffer_state( );
| }
|=20
| /** Switch to a different input buffer.
|  * @param new_buffer The new input buffer.
|  *=20
|  */
|     void yy_switch_to_buffer  (YY_BUFFER_STATE  new_buffer )
| {
|    =20
| 	/* TODO. We should be able to replace this entire function body
| 	 * with
| 	 *		yypop_buffer_state();
| 	 *		yypush_buffer_state(new_buffer);
|      */
| 	yyensure_buffer_stack ();
| 	if ( YY_CURRENT_BUFFER =3D=3D new_buffer )
| 		return;
|=20
| 	if ( YY_CURRENT_BUFFER )
| 		{
| 		/* Flush out information for old buffer. */
| 		*(yy_c_buf_p) =3D (yy_hold_char);
| 		YY_CURRENT_BUFFER_LVALUE->yy_buf_pos =3D (yy_c_buf_p);
| 		YY_CURRENT_BUFFER_LVALUE->yy_n_chars =3D (yy_n_chars);
| 		}
|=20
| 	YY_CURRENT_BUFFER_LVALUE =3D new_buffer;
| 	yy_load_buffer_state( );
|=20
| 	/* We don't actually know whether we did this switch during
| 	 * EOF (yywrap()) processing, but the only time this flag
| 	 * is looked at is after yywrap() is called, so it's safe
| 	 * to go ahead and always set it.
| 	 */
| 	(yy_did_buffer_switch_on_eof) =3D 1;
| }
|=20
| static void yy_load_buffer_state  (void)
| {
|     	(yy_n_chars) =3D YY_CURRENT_BUFFER_LVALUE->yy_n_chars;
| 	(yytext_ptr) =3D (yy_c_buf_p) =3D YY_CURRENT_BUFFER_LVALUE->yy_buf_pos=
;
| 	yyin =3D YY_CURRENT_BUFFER_LVALUE->yy_input_file;
| 	(yy_hold_char) =3D *(yy_c_buf_p);
| }
|=20
| /** Allocate and initialize an input buffer state.
|  * @param file A readable stream.
|  * @param size The character buffer size in bytes. When in doubt, use @=
c YY_BUF_SIZE.
|  *=20
|  * @return the allocated buffer state.
|  */
|     YY_BUFFER_STATE yy_create_buffer  (FILE * file, int  size )
| {
| 	YY_BUFFER_STATE b;
|    =20
| 	b =3D (YY_BUFFER_STATE) yyalloc(sizeof( struct yy_buffer_state )  );
| 	if ( ! b )
| 		YY_FATAL_ERROR( "out of dynamic memory in yy_create_buffer()" );
|=20
| 	b->yy_buf_size =3D size;
|=20
| 	/* yy_ch_buf has to be 2 characters longer than the size given because=

| 	 * we need to put in 2 end-of-buffer characters.
| 	 */
| 	b->yy_ch_buf =3D (char *) yyalloc(b->yy_buf_size + 2  );
| 	if ( ! b->yy_ch_buf )
| 		YY_FATAL_ERROR( "out of dynamic memory in yy_create_buffer()" );
|=20
| 	b->yy_is_our_buffer =3D 1;
|=20
| 	yy_init_buffer(b,file );
|=20
| 	return b;
| }
|=20
| /** Destroy the buffer.
|  * @param b a buffer created with yy_create_buffer()
|  *=20
|  */
|     void yy_delete_buffer (YY_BUFFER_STATE  b )
| {
|    =20
| 	if ( ! b )
| 		return;
|=20
| 	if ( b =3D=3D YY_CURRENT_BUFFER ) /* Not sure if we should pop here. *=
/
| 		YY_CURRENT_BUFFER_LVALUE =3D (YY_BUFFER_STATE) 0;
|=20
| 	if ( b->yy_is_our_buffer )
| 		yyfree((void *) b->yy_ch_buf  );
|=20
| 	yyfree((void *) b  );
| }
|=20
| #ifndef __cplusplus
| extern int isatty (int );
| #endif /* __cplusplus */
|    =20
| /* Initializes or reinitializes a buffer.
|  * This function is sometimes called more than once on the same buffer,=

|  * such as during a yyrestart() or at EOF.
|  */
|     static void yy_init_buffer  (YY_BUFFER_STATE  b, FILE * file )
|=20
| {
| 	int oerrno =3D errno;
|    =20
| 	yy_flush_buffer(b );
|=20
| 	b->yy_input_file =3D file;
| 	b->yy_fill_buffer =3D 1;
|=20
|     /* If b is the current buffer, then yy_init_buffer was _probably_
|      * called from yyrestart() or through yy_get_next_buffer.
|      * In that case, we don't want to reset the lineno or column.
|      */
|     if (b !=3D YY_CURRENT_BUFFER){
|         b->yy_bs_lineno =3D 1;
|         b->yy_bs_column =3D 0;
|     }
|=20
|         b->yy_is_interactive =3D file ? (isatty( fileno(file) ) > 0) : =
0;
|    =20
| 	errno =3D oerrno;
| }
|=20
| /** Discard all buffered characters. On the next scan, YY_INPUT will be=
 called.
|  * @param b the buffer state to be flushed, usually @c YY_CURRENT_BUFFE=
R.
|  *=20
|  */
|     void yy_flush_buffer (YY_BUFFER_STATE  b )
| {
|     	if ( ! b )
| 		return;
|=20
| 	b->yy_n_chars =3D 0;
|=20
| 	/* We always need two end-of-buffer characters.  The first causes
| 	 * a transition to the end-of-buffer state.  The second causes
| 	 * a jam in that state.
| 	 */
| 	b->yy_ch_buf[0] =3D YY_END_OF_BUFFER_CHAR;
| 	b->yy_ch_buf[1] =3D YY_END_OF_BUFFER_CHAR;
|=20
| 	b->yy_buf_pos =3D &b->yy_ch_buf[0];
|=20
| 	b->yy_at_bol =3D 1;
| 	b->yy_buffer_status =3D YY_BUFFER_NEW;
|=20
| 	if ( b =3D=3D YY_CURRENT_BUFFER )
| 		yy_load_buffer_state( );
| }
|=20
| /** Pushes the new state onto the stack. The new state becomes
|  *  the current state. This function will allocate the stack
|  *  if necessary.
|  *  @param new_buffer The new state.
|  * =20
|  */
| void yypush_buffer_state (YY_BUFFER_STATE new_buffer )
| {
|     	if (new_buffer =3D=3D NULL)
| 		return;
|=20
| 	yyensure_buffer_stack();
|=20
| 	/* This block is copied from yy_switch_to_buffer. */
| 	if ( YY_CURRENT_BUFFER )
| 		{
| 		/* Flush out information for old buffer. */
| 		*(yy_c_buf_p) =3D (yy_hold_char);
| 		YY_CURRENT_BUFFER_LVALUE->yy_buf_pos =3D (yy_c_buf_p);
| 		YY_CURRENT_BUFFER_LVALUE->yy_n_chars =3D (yy_n_chars);
| 		}
|=20
| 	/* Only push if top exists. Otherwise, replace top. */
| 	if (YY_CURRENT_BUFFER)
| 		(yy_buffer_stack_top)++;
| 	YY_CURRENT_BUFFER_LVALUE =3D new_buffer;
|=20
| 	/* copied from yy_switch_to_buffer. */
| 	yy_load_buffer_state( );
| 	(yy_did_buffer_switch_on_eof) =3D 1;
| }
|=20
| /** Removes and deletes the top of the stack, if present.
|  *  The next element becomes the new top.
|  * =20
|  */
| void yypop_buffer_state (void)
| {
|     	if (!YY_CURRENT_BUFFER)
| 		return;
|=20
| 	yy_delete_buffer(YY_CURRENT_BUFFER );
| 	YY_CURRENT_BUFFER_LVALUE =3D NULL;
| 	if ((yy_buffer_stack_top) > 0)
| 		--(yy_buffer_stack_top);
|=20
| 	if (YY_CURRENT_BUFFER) {
| 		yy_load_buffer_state( );
| 		(yy_did_buffer_switch_on_eof) =3D 1;
| 	}
| }
|=20
| /* Allocates the stack if it does not exist.
|  *  Guarantees space for at least one push.
|  */
| static void yyensure_buffer_stack (void)
| {
| 	int num_to_alloc;
|    =20
| 	if (!(yy_buffer_stack)) {
|=20
| 		/* First allocation is just for 2 elements, since we don't know if th=
is
| 		 * scanner will even need a stack. We use 2 instead of 1 to avoid an
| 		 * immediate realloc on the next call.
|          */
| 		num_to_alloc =3D 1;
| 		(yy_buffer_stack) =3D (struct yy_buffer_state**)yyalloc
| 								(num_to_alloc * sizeof(struct yy_buffer_state*)
| 								);
| 		if ( ! (yy_buffer_stack) )
| 			YY_FATAL_ERROR( "out of dynamic memory in yyensure_buffer_stack()" )=
;
| 								 =20
| 		memset((yy_buffer_stack), 0, num_to_alloc * sizeof(struct yy_buffer_s=
tate*));
| 			=09
| 		(yy_buffer_stack_max) =3D num_to_alloc;
| 		(yy_buffer_stack_top) =3D 0;
| 		return;
| 	}
|=20
| 	if ((yy_buffer_stack_top) >=3D ((yy_buffer_stack_max)) - 1){
|=20
| 		/* Increase the buffer to prepare for a possible push. */
| 		int grow_size =3D 8 /* arbitrary grow size */;
|=20
| 		num_to_alloc =3D (yy_buffer_stack_max) + grow_size;
| 		(yy_buffer_stack) =3D (struct yy_buffer_state**)yyrealloc
| 								((yy_buffer_stack),
| 								num_to_alloc * sizeof(struct yy_buffer_state*)
| 								);
| 		if ( ! (yy_buffer_stack) )
| 			YY_FATAL_ERROR( "out of dynamic memory in yyensure_buffer_stack()" )=
;
|=20
| 		/* zero only the new slots.*/
| 		memset((yy_buffer_stack) + (yy_buffer_stack_max), 0, grow_size * size=
of(struct yy_buffer_state*));
| 		(yy_buffer_stack_max) =3D num_to_alloc;
| 	}
| }
|=20
| /** Setup the input buffer state to scan directly from a user-specified=
 character buffer.
|  * @param base the character buffer
|  * @param size the size in bytes of the character buffer
|  *=20
|  * @return the newly allocated buffer state object.=20
|  */
| YY_BUFFER_STATE yy_scan_buffer  (char * base, yy_size_t  size )
| {
| 	YY_BUFFER_STATE b;
|    =20
| 	if ( size < 2 ||
| 	     base[size-2] !=3D YY_END_OF_BUFFER_CHAR ||
| 	     base[size-1] !=3D YY_END_OF_BUFFER_CHAR )
| 		/* They forgot to leave room for the EOB's. */
| 		return 0;
|=20
| 	b =3D (YY_BUFFER_STATE) yyalloc(sizeof( struct yy_buffer_state )  );
| 	if ( ! b )
| 		YY_FATAL_ERROR( "out of dynamic memory in yy_scan_buffer()" );
|=20
| 	b->yy_buf_size =3D size - 2;	/* "- 2" to take care of EOB's */
| 	b->yy_buf_pos =3D b->yy_ch_buf =3D base;
| 	b->yy_is_our_buffer =3D 0;
| 	b->yy_input_file =3D 0;
| 	b->yy_n_chars =3D b->yy_buf_size;
| 	b->yy_is_interactive =3D 0;
| 	b->yy_at_bol =3D 1;
| 	b->yy_fill_buffer =3D 0;
| 	b->yy_buffer_status =3D YY_BUFFER_NEW;
|=20
| 	yy_switch_to_buffer(b  );
|=20
| 	return b;
| }
|=20
| /** Setup the input buffer state to scan a string. The next call to yyl=
ex() will
|  * scan from a @e copy of @a str.
|  * @param yystr a NUL-terminated string to scan
|  *=20
|  * @return the newly allocated buffer state object.
|  * @note If you want to scan bytes that may contain NUL values, then us=
e
|  *       yy_scan_bytes() instead.
|  */
| YY_BUFFER_STATE yy_scan_string (yyconst char * yystr )
| {
|    =20
| 	return yy_scan_bytes(yystr,strlen(yystr) );
| }
|=20
| /** Setup the input buffer state to scan the given bytes. The next call=
 to yylex() will
|  * scan from a @e copy of @a bytes.
|  * @param bytes the byte buffer to scan
|  * @param len the number of bytes in the buffer pointed to by @a bytes.=

|  *=20
|  * @return the newly allocated buffer state object.
|  */
| YY_BUFFER_STATE yy_scan_bytes  (yyconst char * yybytes, int  _yybytes_l=
en )
| {
| 	YY_BUFFER_STATE b;
| 	char *buf;
| 	yy_size_t n;
| 	int i;
|    =20
| 	/* Get memory for full buffer, including space for trailing EOB's. */
| 	n =3D _yybytes_len + 2;
| 	buf =3D (char *) yyalloc(n  );
| 	if ( ! buf )
| 		YY_FATAL_ERROR( "out of dynamic memory in yy_scan_bytes()" );
|=20
| 	for ( i =3D 0; i < _yybytes_len; ++i )
| 		buf[i] =3D yybytes[i];
|=20
| 	buf[_yybytes_len] =3D buf[_yybytes_len+1] =3D YY_END_OF_BUFFER_CHAR;
|=20
| 	b =3D yy_scan_buffer(buf,n );
| 	if ( ! b )
| 		YY_FATAL_ERROR( "bad buffer in yy_scan_bytes()" );
|=20
| 	/* It's okay to grow etc. this buffer, and we should throw it
| 	 * away when we're done.
| 	 */
| 	b->yy_is_our_buffer =3D 1;
|=20
| 	return b;
| }
|=20
| #ifndef YY_EXIT_FAILURE
| #define YY_EXIT_FAILURE 2
| #endif
|=20
| static void yy_fatal_error (yyconst char* msg )
| {
|     	(void) fprintf( stderr, "%s\n", msg );
| 	exit( YY_EXIT_FAILURE );
| }
|=20
| /* Redefine yyless() so it works in section 3 code. */
|=20
| #undef yyless
| #define yyless(n) \
| 	do \
| 		{ \
| 		/* Undo effects of setting up yytext. */ \
|         int yyless_macro_arg =3D (n); \
|         YY_LESS_LINENO(yyless_macro_arg);\
| 		yytext[yyleng] =3D (yy_hold_char); \
| 		(yy_c_buf_p) =3D yytext + yyless_macro_arg; \
| 		(yy_hold_char) =3D *(yy_c_buf_p); \
| 		*(yy_c_buf_p) =3D '\0'; \
| 		yyleng =3D yyless_macro_arg; \
| 		} \
| 	while ( 0 )
|=20
| /* Accessor  methods (get/set functions) to struct members. */
|=20
| /** Get the current line number.
|  *=20
|  */
| int yyget_lineno  (void)
| {
|        =20
|     return yylineno;
| }
|=20
| /** Get the input stream.
|  *=20
|  */
| FILE *yyget_in  (void)
| {
|         return yyin;
| }
|=20
| /** Get the output stream.
|  *=20
|  */
| FILE *yyget_out  (void)
| {
|         return yyout;
| }
|=20
| /** Get the length of the current token.
|  *=20
|  */
| int yyget_leng  (void)
| {
|         return yyleng;
| }
|=20
| /** Get the current token.
|  *=20
|  */
|=20
| char *yyget_text  (void)
| {
|         return yytext;
| }
|=20
| /** Set the current line number.
|  * @param line_number
|  *=20
|  */
| void yyset_lineno (int  line_number )
| {
|    =20
|     yylineno =3D line_number;
| }
|=20
| /** Set the input stream. This does not discard the current
|  * input buffer.
|  * @param in_str A readable stream.
|  *=20
|  * @see yy_switch_to_buffer
|  */
| void yyset_in (FILE *  in_str )
| {
|         yyin =3D in_str ;
| }
|=20
| void yyset_out (FILE *  out_str )
| {
|         yyout =3D out_str ;
| }
|=20
| int yyget_debug  (void)
| {
|         return yy_flex_debug;
| }
|=20
| void yyset_debug (int  bdebug )
| {
|         yy_flex_debug =3D bdebug ;
| }
|=20
| static int yy_init_globals (void)
| {
|         /* Initialization is the same as for the non-reentrant scanner.=

|      * This function is called from yylex_destroy(), so don't allocate =
here.
|      */
|=20
|     (yy_buffer_stack) =3D 0;
|     (yy_buffer_stack_top) =3D 0;
|     (yy_buffer_stack_max) =3D 0;
|     (yy_c_buf_p) =3D (char *) 0;
|     (yy_init) =3D 0;
|     (yy_start) =3D 0;
|=20
|     (yy_state_buf) =3D 0;
|     (yy_state_ptr) =3D 0;
|     (yy_full_match) =3D 0;
|     (yy_lp) =3D 0;
|=20
| /* Defined in main.c */
| #ifdef YY_STDINIT
|     yyin =3D stdin;
|     yyout =3D stdout;
| #else
|     yyin =3D (FILE *) 0;
|     yyout =3D (FILE *) 0;
| #endif
|=20
|     /* For future reference: Set errno on error, since we are called by=

|      * yylex_init()
|      */
|     return 0;
| }
|=20
| /* yylex_destroy is for both reentrant and non-reentrant scanners. */
| int yylex_destroy  (void)
| {
|    =20
|     /* Pop the buffer stack, destroying each element. */
| 	while(YY_CURRENT_BUFFER){
| 		yy_delete_buffer(YY_CURRENT_BUFFER  );
| 		YY_CURRENT_BUFFER_LVALUE =3D NULL;
| 		yypop_buffer_state();
| 	}
|=20
| 	/* Destroy the stack itself. */
| 	yyfree((yy_buffer_stack) );
| 	(yy_buffer_stack) =3D NULL;
|=20
|     yyfree ( (yy_state_buf) );
|     (yy_state_buf)  =3D NULL;
|=20
|     /* Reset the globals. This is important in a non-reentrant scanner =
so the next time
|      * yylex() is called, initialization will occur. */
|     yy_init_globals( );
|=20
|     return 0;
| }
|=20
| /*
|  * Internal utility routines.
|  */
|=20
| #ifndef yytext_ptr
| static void yy_flex_strncpy (char* s1, yyconst char * s2, int n )
| {
| 	register int i;
| 	for ( i =3D 0; i < n; ++i )
| 		s1[i] =3D s2[i];
| }
| #endif
|=20
| #ifdef YY_NEED_STRLEN
| static int yy_flex_strlen (yyconst char * s )
| {
| 	register int n;
| 	for ( n =3D 0; s[n]; ++n )
| 		;
|=20
| 	return n;
| }
| #endif
|=20
| void *yyalloc (yy_size_t  size )
| {
| 	return (void *) malloc( size );
| }
|=20
| void *yyrealloc  (void * ptr, yy_size_t  size )
| {
| 	/* The cast to (char *) in the following accommodates both
| 	 * implementations that use char* generic pointers, and those
| 	 * that use void* generic pointers.  It works with the latter
| 	 * because both ANSI C and C++ allow castless assignment from
| 	 * any pointer type to void*, and deal with argument conversions
| 	 * as though doing an assignment.
| 	 */
| 	return (void *) realloc( (char *) ptr, size );
| }
|=20
| void yyfree (void * ptr )
| {
| 	free( (char *) ptr );	/* see yyrealloc() for (char *) cast */
| }
|=20
| #define YYTABLES_NAME "yytables"
|=20
| #line 9 "conftest.l"
|=20
|=20
| #ifdef YYTEXT_POINTER
| extern char *yytext;
| #endif
| int
| main (void)
| {
|   return ! yylex () + ! yywrap ();
| }
configure:21161: /home/malek/minisys/xenomai/buildroot/build_i686/staging=
_dir/usr/bin/i686-linux-uclibc-gcc -Os  -I/home/malek/minisys/xenomai/bui=
ldroot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/b=
uildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/x=
enomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xe=
nomai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpenti=
umpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 =
-o conftest    conftest.c -lfl  >&5
/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin/../l=
ib/gcc/i686-linux-uclibc/4.2.4/../../../../i686-linux-uclibc/bin/ld: cann=
ot find -lfl
collect2: ld returned 1 exit status
configure:21167: $? =3D 1
configure: failed program was:
|=20
| #line 3 "lex.yy.c"
|=20
| #define  YY_INT_ALIGNED short int
|=20
| /* A lexical scanner generated by flex */
|=20
| #define FLEX_SCANNER
| #define YY_FLEX_MAJOR_VERSION 2
| #define YY_FLEX_MINOR_VERSION 5
| #define YY_FLEX_SUBMINOR_VERSION 35
| #if YY_FLEX_SUBMINOR_VERSION > 0
| #define FLEX_BETA
| #endif
|=20
| /* First, we deal with  platform-specific or compiler-specific issues. =
*/
|=20
| /* begin standard C headers. */
| #include <stdio.h>
| #include <string.h>
| #include <errno.h>
| #include <stdlib.h>
|=20
| /* end standard C headers. */
|=20
| /* flex integer type definitions */
|=20
| #ifndef FLEXINT_H
| #define FLEXINT_H
|=20
| /* C99 systems have <inttypes.h>. Non-C99 systems may or may not. */
|=20
| #if defined (__STDC_VERSION__) && __STDC_VERSION__ >=3D 199901L
|=20
| /* C99 says to define __STDC_LIMIT_MACROS before including stdint.h,
|  * if you want the limit (max/min) macros for int types.=20
|  */
| #ifndef __STDC_LIMIT_MACROS
| #define __STDC_LIMIT_MACROS 1
| #endif
|=20
| #include <inttypes.h>
| typedef int8_t flex_int8_t;
| typedef uint8_t flex_uint8_t;
| typedef int16_t flex_int16_t;
| typedef uint16_t flex_uint16_t;
| typedef int32_t flex_int32_t;
| typedef uint32_t flex_uint32_t;
| #else
| typedef signed char flex_int8_t;
| typedef short int flex_int16_t;
| typedef int flex_int32_t;
| typedef unsigned char flex_uint8_t;=20
| typedef unsigned short int flex_uint16_t;
| typedef unsigned int flex_uint32_t;
| #endif /* ! C99 */
|=20
| /* Limits of integral types. */
| #ifndef INT8_MIN
| #define INT8_MIN               (-128)
| #endif
| #ifndef INT16_MIN
| #define INT16_MIN              (-32767-1)
| #endif
| #ifndef INT32_MIN
| #define INT32_MIN              (-2147483647-1)
| #endif
| #ifndef INT8_MAX
| #define INT8_MAX               (127)
| #endif
| #ifndef INT16_MAX
| #define INT16_MAX              (32767)
| #endif
| #ifndef INT32_MAX
| #define INT32_MAX              (2147483647)
| #endif
| #ifndef UINT8_MAX
| #define UINT8_MAX              (255U)
| #endif
| #ifndef UINT16_MAX
| #define UINT16_MAX             (65535U)
| #endif
| #ifndef UINT32_MAX
| #define UINT32_MAX             (4294967295U)
| #endif
|=20
| #endif /* ! FLEXINT_H */
|=20
| #ifdef __cplusplus
|=20
| /* The "const" storage-class-modifier is valid. */
| #define YY_USE_CONST
|=20
| #else	/* ! __cplusplus */
|=20
| /* C99 requires __STDC__ to be defined as 1. */
| #if defined (__STDC__)
|=20
| #define YY_USE_CONST
|=20
| #endif	/* defined (__STDC__) */
| #endif	/* ! __cplusplus */
|=20
| #ifdef YY_USE_CONST
| #define yyconst const
| #else
| #define yyconst
| #endif
|=20
| /* Returned upon end-of-file. */
| #define YY_NULL 0
|=20
| /* Promotes a possibly negative, possibly signed char to an unsigned
|  * integer for use as an array index.  If the signed char is negative,
|  * we want to instead treat it as an 8-bit unsigned char, hence the
|  * double cast.
|  */
| #define YY_SC_TO_UI(c) ((unsigned int) (unsigned char) c)
|=20
| /* Enter a start condition.  This macro really ought to take a paramete=
r,
|  * but we do it the disgusting crufty way forced on us by the ()-less
|  * definition of BEGIN.
|  */
| #define BEGIN (yy_start) =3D 1 + 2 *
|=20
| /* Translate the current start state into a value that can be later han=
ded
|  * to BEGIN to return to the state.  The YYSTATE alias is for lex
|  * compatibility.
|  */
| #define YY_START (((yy_start) - 1) / 2)
| #define YYSTATE YY_START
|=20
| /* Action number for EOF rule of a given start state. */
| #define YY_STATE_EOF(state) (YY_END_OF_BUFFER + state + 1)
|=20
| /* Special action meaning "start processing a new file". */
| #define YY_NEW_FILE yyrestart(yyin  )
|=20
| #define YY_END_OF_BUFFER_CHAR 0
|=20
| /* Size of default input buffer. */
| #ifndef YY_BUF_SIZE
| #define YY_BUF_SIZE 16384
| #endif
|=20
| /* The state buf must be large enough to hold one state per character i=
n the main buffer.
|  */
| #define YY_STATE_BUF_SIZE   ((YY_BUF_SIZE + 2) * sizeof(yy_state_type))=

|=20
| #ifndef YY_TYPEDEF_YY_BUFFER_STATE
| #define YY_TYPEDEF_YY_BUFFER_STATE
| typedef struct yy_buffer_state *YY_BUFFER_STATE;
| #endif
|=20
| extern int yyleng;
|=20
| extern FILE *yyin, *yyout;
|=20
| #define EOB_ACT_CONTINUE_SCAN 0
| #define EOB_ACT_END_OF_FILE 1
| #define EOB_ACT_LAST_MATCH 2
|=20
|     #define YY_LESS_LINENO(n)
|    =20
| /* Return all but the first "n" matched characters back to the input st=
ream. */
| #define yyless(n) \
| 	do \
| 		{ \
| 		/* Undo effects of setting up yytext. */ \
|         int yyless_macro_arg =3D (n); \
|         YY_LESS_LINENO(yyless_macro_arg);\
| 		*yy_cp =3D (yy_hold_char); \
| 		YY_RESTORE_YY_MORE_OFFSET \
| 		(yy_c_buf_p) =3D yy_cp =3D yy_bp + yyless_macro_arg - YY_MORE_ADJ; \
| 		YY_DO_BEFORE_ACTION; /* set up yytext again */ \
| 		} \
| 	while ( 0 )
|=20
| #define unput(c) yyunput( c, (yytext_ptr)  )
|=20
| #ifndef YY_TYPEDEF_YY_SIZE_T
| #define YY_TYPEDEF_YY_SIZE_T
| typedef size_t yy_size_t;
| #endif
|=20
| #ifndef YY_STRUCT_YY_BUFFER_STATE
| #define YY_STRUCT_YY_BUFFER_STATE
| struct yy_buffer_state
| 	{
| 	FILE *yy_input_file;
|=20
| 	char *yy_ch_buf;		/* input buffer */
| 	char *yy_buf_pos;		/* current position in input buffer */
|=20
| 	/* Size of input buffer in bytes, not including room for EOB
| 	 * characters.
| 	 */
| 	yy_size_t yy_buf_size;
|=20
| 	/* Number of characters read into yy_ch_buf, not including EOB
| 	 * characters.
| 	 */
| 	int yy_n_chars;
|=20
| 	/* Whether we "own" the buffer - i.e., we know we created it,
| 	 * and can realloc() it to grow it, and should free() it to
| 	 * delete it.
| 	 */
| 	int yy_is_our_buffer;
|=20
| 	/* Whether this is an "interactive" input source; if so, and
| 	 * if we're using stdio for input, then we want to use getc()
| 	 * instead of fread(), to make sure we stop fetching input after
| 	 * each newline.
| 	 */
| 	int yy_is_interactive;
|=20
| 	/* Whether we're considered to be at the beginning of a line.
| 	 * If so, '^' rules will be active on the next match, otherwise
| 	 * not.
| 	 */
| 	int yy_at_bol;
|=20
|     int yy_bs_lineno; /**< The line count. */
|     int yy_bs_column; /**< The column count. */
|    =20
| 	/* Whether to try to fill the input buffer when we reach the
| 	 * end of it.
| 	 */
| 	int yy_fill_buffer;
|=20
| 	int yy_buffer_status;
|=20
| #define YY_BUFFER_NEW 0
| #define YY_BUFFER_NORMAL 1
| 	/* When an EOF's been seen but there's still some text to process
| 	 * then we mark the buffer as YY_EOF_PENDING, to indicate that we
| 	 * shouldn't try reading from the input source any more.  We might
| 	 * still have a bunch of tokens to match, though, because of
| 	 * possible backing-up.
| 	 *
| 	 * When we actually see the EOF, we change the status to "new"
| 	 * (via yyrestart()), so that the user can continue scanning by
| 	 * just pointing yyin at a new input file.
| 	 */
| #define YY_BUFFER_EOF_PENDING 2
|=20
| 	};
| #endif /* !YY_STRUCT_YY_BUFFER_STATE */
|=20
| /* Stack of input buffers. */
| static size_t yy_buffer_stack_top =3D 0; /**< index of top of stack. */=

| static size_t yy_buffer_stack_max =3D 0; /**< capacity of stack. */
| static YY_BUFFER_STATE * yy_buffer_stack =3D 0; /**< Stack as an array.=
 */
|=20
| /* We provide macros for accessing buffer states in case in the
|  * future we want to put the buffer states in a more general
|  * "scanner state".
|  *
|  * Returns the top of the stack, or NULL.
|  */
| #define YY_CURRENT_BUFFER ( (yy_buffer_stack) \
|                           ? (yy_buffer_stack)[(yy_buffer_stack_top)] \
|                           : NULL)
|=20
| /* Same as previous macro, but useful when we know that the buffer stac=
k is not
|  * NULL or when we need an lvalue. For internal use only.
|  */
| #define YY_CURRENT_BUFFER_LVALUE (yy_buffer_stack)[(yy_buffer_stack_top=
)]
|=20
| /* yy_hold_char holds the character lost when yytext is formed. */
| static char yy_hold_char;
| static int yy_n_chars;		/* number of characters read into yy_ch_buf */
| int yyleng;
|=20
| /* Points to current character in buffer. */
| static char *yy_c_buf_p =3D (char *) 0;
| static int yy_init =3D 0;		/* whether we need to initialize */
| static int yy_start =3D 0;	/* start state number */
|=20
| /* Flag which is used to allow yywrap()'s to do buffer switches
|  * instead of setting up a fresh yyin.  A bit of a hack ...
|  */
| static int yy_did_buffer_switch_on_eof;
|=20
| void yyrestart (FILE *input_file  );
| void yy_switch_to_buffer (YY_BUFFER_STATE new_buffer  );
| YY_BUFFER_STATE yy_create_buffer (FILE *file,int size  );
| void yy_delete_buffer (YY_BUFFER_STATE b  );
| void yy_flush_buffer (YY_BUFFER_STATE b  );
| void yypush_buffer_state (YY_BUFFER_STATE new_buffer  );
| void yypop_buffer_state (void );
|=20
| static void yyensure_buffer_stack (void );
| static void yy_load_buffer_state (void );
| static void yy_init_buffer (YY_BUFFER_STATE b,FILE *file  );
|=20
| #define YY_FLUSH_BUFFER yy_flush_buffer(YY_CURRENT_BUFFER )
|=20
| YY_BUFFER_STATE yy_scan_buffer (char *base,yy_size_t size  );
| YY_BUFFER_STATE yy_scan_string (yyconst char *yy_str  );
| YY_BUFFER_STATE yy_scan_bytes (yyconst char *bytes,int len  );
|=20
| void *yyalloc (yy_size_t  );
| void *yyrealloc (void *,yy_size_t  );
| void yyfree (void *  );
|=20
| #define yy_new_buffer yy_create_buffer
|=20
| #define yy_set_interactive(is_interactive) \
| 	{ \
| 	if ( ! YY_CURRENT_BUFFER ){ \
|         yyensure_buffer_stack (); \
| 		YY_CURRENT_BUFFER_LVALUE =3D    \
|             yy_create_buffer(yyin,YY_BUF_SIZE ); \
| 	} \
| 	YY_CURRENT_BUFFER_LVALUE->yy_is_interactive =3D is_interactive; \
| 	}
|=20
| #define yy_set_bol(at_bol) \
| 	{ \
| 	if ( ! YY_CURRENT_BUFFER ){\
|         yyensure_buffer_stack (); \
| 		YY_CURRENT_BUFFER_LVALUE =3D    \
|             yy_create_buffer(yyin,YY_BUF_SIZE ); \
| 	} \
| 	YY_CURRENT_BUFFER_LVALUE->yy_at_bol =3D at_bol; \
| 	}
|=20
| #define YY_AT_BOL() (YY_CURRENT_BUFFER_LVALUE->yy_at_bol)
|=20
| /* Begin user sect3 */
|=20
| typedef unsigned char YY_CHAR;
|=20
| FILE *yyin =3D (FILE *) 0, *yyout =3D (FILE *) 0;
|=20
| typedef int yy_state_type;
|=20
| extern int yylineno;
|=20
| int yylineno =3D 1;
|=20
| extern char *yytext;
| #define yytext_ptr yytext
|=20
| static yy_state_type yy_get_previous_state (void );
| static yy_state_type yy_try_NUL_trans (yy_state_type current_state  );
| static int yy_get_next_buffer (void );
| static void yy_fatal_error (yyconst char msg[]  );
|=20
| /* Done after the current pattern has been matched and before the
|  * corresponding action - sets up yytext.
|  */
| #define YY_DO_BEFORE_ACTION \
| 	(yytext_ptr) =3D yy_bp; \
| 	(yytext_ptr) -=3D (yy_more_len); \
| 	yyleng =3D (size_t) (yy_cp - (yytext_ptr)); \
| 	(yy_hold_char) =3D *yy_cp; \
| 	*yy_cp =3D '\0'; \
| 	(yy_c_buf_p) =3D yy_cp;
|=20
| #define YY_NUM_RULES 8
| #define YY_END_OF_BUFFER 9
| /* This struct is not used in this scanner,
|    but its presence is necessary. */
| struct yy_trans_info
| 	{
| 	flex_int32_t yy_verify;
| 	flex_int32_t yy_nxt;
| 	};
| static yyconst flex_int16_t yy_acclist[23] =3D
|     {   0,
|         9,    7,    8,    8,    1,    7,    8,    2,    7,    8,
|         3,    7,    8,    4,    7,    8,    5,    7,    8,    6,
|         7,    8
|     } ;
|=20
| static yyconst flex_int16_t yy_accept[14] =3D
|     {   0,
|         1,    1,    1,    2,    4,    5,    8,   11,   14,   17,
|        20,   23,   23
|     } ;
|=20
| static yyconst flex_int32_t yy_ec[256] =3D
|     {   0,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    2,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    3,    4,    5,    6,
|=20
|         7,    8,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|=20
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1
|     } ;
|=20
| static yyconst flex_int32_t yy_meta[9] =3D
|     {   0,
|         1,    1,    1,    1,    1,    1,    1,    1
|     } ;
|=20
| static yyconst flex_int16_t yy_base[13] =3D
|     {   0,
|         0,    0,    9,   10,   10,   10,   10,   10,   10,   10,
|        10,   10
|     } ;
|=20
| static yyconst flex_int16_t yy_def[13] =3D
|     {   0,
|        12,    1,   12,   12,   12,   12,   12,   12,   12,   12,
|        12,    0
|     } ;
|=20
| static yyconst flex_int16_t yy_nxt[19] =3D
|     {   0,
|         4,    5,    6,    7,    8,    9,   10,   11,   12,    3,
|        12,   12,   12,   12,   12,   12,   12,   12
|     } ;
|=20
| static yyconst flex_int16_t yy_chk[19] =3D
|     {   0,
|         1,    1,    1,    1,    1,    1,    1,    1,    3,   12,
|        12,   12,   12,   12,   12,   12,   12,   12
|     } ;
|=20
| extern int yy_flex_debug;
| int yy_flex_debug =3D 0;
|=20
| static yy_state_type *yy_state_buf=3D0, *yy_state_ptr=3D0;
| static char *yy_full_match;
| static int yy_lp;
| #define REJECT \
| { \
| *yy_cp =3D (yy_hold_char); /* undo effects of setting up yytext */ \
| yy_cp =3D (yy_full_match); /* restore poss. backed-over text */ \
| ++(yy_lp); \
| goto find_rule; \
| }
|=20
| static int yy_more_flag =3D 0;
| static int yy_more_len =3D 0;
| #define yymore() ((yy_more_flag) =3D 1)
| #define YY_MORE_ADJ (yy_more_len)
| #define YY_RESTORE_YY_MORE_OFFSET
| char *yytext;
| #line 1 "conftest.l"
| #line 468 "lex.yy.c"
|=20
| #define INITIAL 0
|=20
| #ifndef YY_NO_UNISTD_H
| /* Special case for "unistd.h", since it is non-ANSI. We include it way=

|  * down here because we want the user's section 1 to have been scanned =
first.
|  * The user has a chance to override it with an option.
|  */
| #include <unistd.h>
| #endif
|=20
| #ifndef YY_EXTRA_TYPE
| #define YY_EXTRA_TYPE void *
| #endif
|=20
| static int yy_init_globals (void );
|=20
| /* Accessor methods to globals.
|    These are made visible to non-reentrant scanners for convenience. */=

|=20
| int yylex_destroy (void );
|=20
| int yyget_debug (void );
|=20
| void yyset_debug (int debug_flag  );
|=20
| YY_EXTRA_TYPE yyget_extra (void );
|=20
| void yyset_extra (YY_EXTRA_TYPE user_defined  );
|=20
| FILE *yyget_in (void );
|=20
| void yyset_in  (FILE * in_str  );
|=20
| FILE *yyget_out (void );
|=20
| void yyset_out  (FILE * out_str  );
|=20
| int yyget_leng (void );
|=20
| char *yyget_text (void );
|=20
| int yyget_lineno (void );
|=20
| void yyset_lineno (int line_number  );
|=20
| /* Macros after this point can all be overridden by user definitions in=

|  * section 1.
|  */
|=20
| #ifndef YY_SKIP_YYWRAP
| #ifdef __cplusplus
| extern "C" int yywrap (void );
| #else
| extern int yywrap (void );
| #endif
| #endif
|=20
|     static void yyunput (int c,char *buf_ptr  );
|    =20
| #ifndef yytext_ptr
| static void yy_flex_strncpy (char *,yyconst char *,int );
| #endif
|=20
| #ifdef YY_NEED_STRLEN
| static int yy_flex_strlen (yyconst char * );
| #endif
|=20
| #ifndef YY_NO_INPUT
|=20
| #ifdef __cplusplus
| static int yyinput (void );
| #else
| static int input (void );
| #endif
|=20
| #endif
|=20
| /* Amount of stuff to slurp up with each read. */
| #ifndef YY_READ_BUF_SIZE
| #define YY_READ_BUF_SIZE 8192
| #endif
|=20
| /* Copy whatever the last rule matched to the standard output. */
| #ifndef ECHO
| /* This used to be an fputs(), but since the string might contain NUL's=
,
|  * we now use fwrite().
|  */
| #define ECHO fwrite( yytext, yyleng, 1, yyout )
| #endif
|=20
| /* Gets input and stuffs it into "buf".  number of characters read, or =
YY_NULL,
|  * is returned in "result".
|  */
| #ifndef YY_INPUT
| #define YY_INPUT(buf,result,max_size) \
| 	if ( YY_CURRENT_BUFFER_LVALUE->yy_is_interactive ) \
| 		{ \
| 		int c =3D '*'; \
| 		unsigned n; \
| 		for ( n =3D 0; n < max_size && \
| 			     (c =3D getc( yyin )) !=3D EOF && c !=3D '\n'; ++n ) \
| 			buf[n] =3D (char) c; \
| 		if ( c =3D=3D '\n' ) \
| 			buf[n++] =3D (char) c; \
| 		if ( c =3D=3D EOF && ferror( yyin ) ) \
| 			YY_FATAL_ERROR( "input in flex scanner failed" ); \
| 		result =3D n; \
| 		} \
| 	else \
| 		{ \
| 		errno=3D0; \
| 		while ( (result =3D fread(buf, 1, max_size, yyin))=3D=3D0 && ferror(y=
yin)) \
| 			{ \
| 			if( errno !=3D EINTR) \
| 				{ \
| 				YY_FATAL_ERROR( "input in flex scanner failed" ); \
| 				break; \
| 				} \
| 			errno=3D0; \
| 			clearerr(yyin); \
| 			} \
| 		}\
| \
|=20
| #endif
|=20
| /* No semi-colon after return; correct usage is to write "yyterminate()=
;" -
|  * we don't want an extra ';' after the "return" because that will caus=
e
|  * some compilers to complain about unreachable statements.
|  */
| #ifndef yyterminate
| #define yyterminate() return YY_NULL
| #endif
|=20
| /* Number of entries by which start-condition stack grows. */
| #ifndef YY_START_STACK_INCR
| #define YY_START_STACK_INCR 25
| #endif
|=20
| /* Report a fatal error. */
| #ifndef YY_FATAL_ERROR
| #define YY_FATAL_ERROR(msg) yy_fatal_error( msg )
| #endif
|=20
| /* end tables serialization structures and prototypes */
|=20
| /* Default declaration of generated scanner - a define so the user can
|  * easily add parameters.
|  */
| #ifndef YY_DECL
| #define YY_DECL_IS_OURS 1
|=20
| extern int yylex (void);
|=20
| #define YY_DECL int yylex (void)
| #endif /* !YY_DECL */
|=20
| /* Code executed at the beginning of each rule, after yytext and yyleng=

|  * have been set up.
|  */
| #ifndef YY_USER_ACTION
| #define YY_USER_ACTION
| #endif
|=20
| /* Code executed at the end of each rule. */
| #ifndef YY_BREAK
| #define YY_BREAK break;
| #endif
|=20
| #define YY_RULE_SETUP \
| 	YY_USER_ACTION
|=20
| /** The main scanner function which does all the work.
|  */
| YY_DECL
| {
| 	register yy_state_type yy_current_state;
| 	register char *yy_cp, *yy_bp;
| 	register int yy_act;
|    =20
| #line 1 "conftest.l"
|=20
| #line 652 "lex.yy.c"
|=20
| 	if ( !(yy_init) )
| 		{
| 		(yy_init) =3D 1;
|=20
| #ifdef YY_USER_INIT
| 		YY_USER_INIT;
| #endif
|=20
|         /* Create the reject buffer large enough to save one state per =
allowed character. */
|         if ( ! (yy_state_buf) )
|             (yy_state_buf) =3D (yy_state_type *)yyalloc(YY_STATE_BUF_SI=
ZE  );
|             if ( ! (yy_state_buf) )
|                 YY_FATAL_ERROR( "out of dynamic memory in yylex()" );
|=20
| 		if ( ! (yy_start) )
| 			(yy_start) =3D 1;	/* first start state */
|=20
| 		if ( ! yyin )
| 			yyin =3D stdin;
|=20
| 		if ( ! yyout )
| 			yyout =3D stdout;
|=20
| 		if ( ! YY_CURRENT_BUFFER ) {
| 			yyensure_buffer_stack ();
| 			YY_CURRENT_BUFFER_LVALUE =3D
| 				yy_create_buffer(yyin,YY_BUF_SIZE );
| 		}
|=20
| 		yy_load_buffer_state( );
| 		}
|=20
| 	while ( 1 )		/* loops until end-of-file is reached */
| 		{
| 		(yy_more_len) =3D 0;
| 		if ( (yy_more_flag) )
| 			{
| 			(yy_more_len) =3D (yy_c_buf_p) - (yytext_ptr);
| 			(yy_more_flag) =3D 0;
| 			}
| 		yy_cp =3D (yy_c_buf_p);
|=20
| 		/* Support of yytext. */
| 		*yy_cp =3D (yy_hold_char);
|=20
| 		/* yy_bp points to the position in yy_ch_buf of the start of
| 		 * the current run.
| 		 */
| 		yy_bp =3D yy_cp;
|=20
| 		yy_current_state =3D (yy_start);
|=20
| 		(yy_state_ptr) =3D (yy_state_buf);
| 		*(yy_state_ptr)++ =3D yy_current_state;
|=20
| yy_match:
| 		do
| 			{
| 			register YY_CHAR yy_c =3D yy_ec[YY_SC_TO_UI(*yy_cp)];
| 			while ( yy_chk[yy_base[yy_current_state] + yy_c] !=3D yy_current_sta=
te )
| 				{
| 				yy_current_state =3D (int) yy_def[yy_current_state];
| 				if ( yy_current_state >=3D 13 )
| 					yy_c =3D yy_meta[(unsigned int) yy_c];
| 				}
| 			yy_current_state =3D yy_nxt[yy_base[yy_current_state] + (unsigned in=
t) yy_c];
| 			*(yy_state_ptr)++ =3D yy_current_state;
| 			++yy_cp;
| 			}
| 		while ( yy_base[yy_current_state] !=3D 10 );
|=20
| yy_find_action:
| 		yy_current_state =3D *--(yy_state_ptr);
| 		(yy_lp) =3D yy_accept[yy_current_state];
| find_rule: /* we branch to this label when backing up */
| 		for ( ; ; ) /* until we find what rule we matched */
| 			{
| 			if ( (yy_lp) && (yy_lp) < yy_accept[yy_current_state + 1] )
| 				{
| 				yy_act =3D yy_acclist[(yy_lp)];
| 					{
| 					(yy_full_match) =3D yy_cp;
| 					break;
| 					}
| 				}
| 			--yy_cp;
| 			yy_current_state =3D *--(yy_state_ptr);
| 			(yy_lp) =3D yy_accept[yy_current_state];
| 			}
|=20
| 		YY_DO_BEFORE_ACTION;
|=20
| do_action:	/* This label is used only to access EOF actions. */
|=20
| 		switch ( yy_act )
| 	{ /* beginning of action switch */
| case 1:
| YY_RULE_SETUP
| #line 2 "conftest.l"
| { ECHO; }
| 	YY_BREAK
| case 2:
| YY_RULE_SETUP
| #line 3 "conftest.l"
| { REJECT; }
| 	YY_BREAK
| case 3:
| YY_RULE_SETUP
| #line 4 "conftest.l"
| { yymore (); }
| 	YY_BREAK
| case 4:
| YY_RULE_SETUP
| #line 5 "conftest.l"
| { yyless (1); }
| 	YY_BREAK
| case 5:
| YY_RULE_SETUP
| #line 6 "conftest.l"
| { yyless (input () !=3D 0); }
| 	YY_BREAK
| case 6:
| YY_RULE_SETUP
| #line 7 "conftest.l"
| { unput (yytext[0]); }
| 	YY_BREAK
| case 7:
| YY_RULE_SETUP
| #line 8 "conftest.l"
| { BEGIN INITIAL; }
| 	YY_BREAK
| case 8:
| YY_RULE_SETUP
| #line 9 "conftest.l"
| ECHO;
| 	YY_BREAK
| #line 790 "lex.yy.c"
| 			case YY_STATE_EOF(INITIAL):
| 				yyterminate();
|=20
| 	case YY_END_OF_BUFFER:
| 		{
| 		/* Amount of text matched not including the EOB char. */
| 		int yy_amount_of_matched_text =3D (int) (yy_cp - (yytext_ptr)) - 1;
|=20
| 		/* Undo the effects of YY_DO_BEFORE_ACTION. */
| 		*yy_cp =3D (yy_hold_char);
| 		YY_RESTORE_YY_MORE_OFFSET
|=20
| 		if ( YY_CURRENT_BUFFER_LVALUE->yy_buffer_status =3D=3D YY_BUFFER_NEW =
)
| 			{
| 			/* We're scanning a new file or input source.  It's
| 			 * possible that this happened because the user
| 			 * just pointed yyin at a new source and called
| 			 * yylex().  If so, then we have to assure
| 			 * consistency between YY_CURRENT_BUFFER and our
| 			 * globals.  Here is the right place to do so, because
| 			 * this is the first action (other than possibly a
| 			 * back-up) that will match for the new input source.
| 			 */
| 			(yy_n_chars) =3D YY_CURRENT_BUFFER_LVALUE->yy_n_chars;
| 			YY_CURRENT_BUFFER_LVALUE->yy_input_file =3D yyin;
| 			YY_CURRENT_BUFFER_LVALUE->yy_buffer_status =3D YY_BUFFER_NORMAL;
| 			}
|=20
| 		/* Note that here we test for yy_c_buf_p "<=3D" to the position
| 		 * of the first EOB in the buffer, since yy_c_buf_p will
| 		 * already have been incremented past the NUL character
| 		 * (since all states make transitions on EOB to the
| 		 * end-of-buffer state).  Contrast this with the test
| 		 * in input().
| 		 */
| 		if ( (yy_c_buf_p) <=3D &YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[(yy_n_cha=
rs)] )
| 			{ /* This was really a NUL. */
| 			yy_state_type yy_next_state;
|=20
| 			(yy_c_buf_p) =3D (yytext_ptr) + yy_amount_of_matched_text;
|=20
| 			yy_current_state =3D yy_get_previous_state(  );
|=20
| 			/* Okay, we're now positioned to make the NUL
| 			 * transition.  We couldn't have
| 			 * yy_get_previous_state() go ahead and do it
| 			 * for us because it doesn't know how to deal
| 			 * with the possibility of jamming (and we don't
| 			 * want to build jamming into it because then it
| 			 * will run more slowly).
| 			 */
|=20
| 			yy_next_state =3D yy_try_NUL_trans( yy_current_state );
|=20
| 			yy_bp =3D (yytext_ptr) + YY_MORE_ADJ;
|=20
| 			if ( yy_next_state )
| 				{
| 				/* Consume the NUL. */
| 				yy_cp =3D ++(yy_c_buf_p);
| 				yy_current_state =3D yy_next_state;
| 				goto yy_match;
| 				}
|=20
| 			else
| 				{
| 				yy_cp =3D (yy_c_buf_p);
| 				goto yy_find_action;
| 				}
| 			}
|=20
| 		else switch ( yy_get_next_buffer(  ) )
| 			{
| 			case EOB_ACT_END_OF_FILE:
| 				{
| 				(yy_did_buffer_switch_on_eof) =3D 0;
|=20
| 				if ( yywrap( ) )
| 					{
| 					/* Note: because we've taken care in
| 					 * yy_get_next_buffer() to have set up
| 					 * yytext, we can now set up
| 					 * yy_c_buf_p so that if some total
| 					 * hoser (like flex itself) wants to
| 					 * call the scanner after we return the
| 					 * YY_NULL, it'll still work - another
| 					 * YY_NULL will get returned.
| 					 */
| 					(yy_c_buf_p) =3D (yytext_ptr) + YY_MORE_ADJ;
|=20
| 					yy_act =3D YY_STATE_EOF(YY_START);
| 					goto do_action;
| 					}
|=20
| 				else
| 					{
| 					if ( ! (yy_did_buffer_switch_on_eof) )
| 						YY_NEW_FILE;
| 					}
| 				break;
| 				}
|=20
| 			case EOB_ACT_CONTINUE_SCAN:
| 				(yy_c_buf_p) =3D
| 					(yytext_ptr) + yy_amount_of_matched_text;
|=20
| 				yy_current_state =3D yy_get_previous_state(  );
|=20
| 				yy_cp =3D (yy_c_buf_p);
| 				yy_bp =3D (yytext_ptr) + YY_MORE_ADJ;
| 				goto yy_match;
|=20
| 			case EOB_ACT_LAST_MATCH:
| 				(yy_c_buf_p) =3D
| 				&YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[(yy_n_chars)];
|=20
| 				yy_current_state =3D yy_get_previous_state(  );
|=20
| 				yy_cp =3D (yy_c_buf_p);
| 				yy_bp =3D (yytext_ptr) + YY_MORE_ADJ;
| 				goto yy_find_action;
| 			}
| 		break;
| 		}
|=20
| 	default:
| 		YY_FATAL_ERROR(
| 			"fatal flex scanner internal error--no action found" );
| 	} /* end of action switch */
| 		} /* end of scanning one token */
| } /* end of yylex */
|=20
| /* yy_get_next_buffer - try to read in a new buffer
|  *
|  * Returns a code representing an action:
|  *	EOB_ACT_LAST_MATCH -
|  *	EOB_ACT_CONTINUE_SCAN - continue scanning from current position
|  *	EOB_ACT_END_OF_FILE - end of file
|  */
| static int yy_get_next_buffer (void)
| {
|     	register char *dest =3D YY_CURRENT_BUFFER_LVALUE->yy_ch_buf;
| 	register char *source =3D (yytext_ptr);
| 	register int number_to_move, i;
| 	int ret_val;
|=20
| 	if ( (yy_c_buf_p) > &YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[(yy_n_chars) =
+ 1] )
| 		YY_FATAL_ERROR(
| 		"fatal flex scanner internal error--end of buffer missed" );
|=20
| 	if ( YY_CURRENT_BUFFER_LVALUE->yy_fill_buffer =3D=3D 0 )
| 		{ /* Don't try to fill the buffer, so this is an EOF. */
| 		if ( (yy_c_buf_p) - (yytext_ptr) - YY_MORE_ADJ =3D=3D 1 )
| 			{
| 			/* We matched a single character, the EOB, so
| 			 * treat this as a final EOF.
| 			 */
| 			return EOB_ACT_END_OF_FILE;
| 			}
|=20
| 		else
| 			{
| 			/* We matched some text prior to the EOB, first
| 			 * process it.
| 			 */
| 			return EOB_ACT_LAST_MATCH;
| 			}
| 		}
|=20
| 	/* Try to read more data. */
|=20
| 	/* First move last chars to start of buffer. */
| 	number_to_move =3D (int) ((yy_c_buf_p) - (yytext_ptr)) - 1;
|=20
| 	for ( i =3D 0; i < number_to_move; ++i )
| 		*(dest++) =3D *(source++);
|=20
| 	if ( YY_CURRENT_BUFFER_LVALUE->yy_buffer_status =3D=3D YY_BUFFER_EOF_P=
ENDING )
| 		/* don't do the read, it's not guaranteed to return an EOF,
| 		 * just force an EOF
| 		 */
| 		YY_CURRENT_BUFFER_LVALUE->yy_n_chars =3D (yy_n_chars) =3D 0;
|=20
| 	else
| 		{
| 			int num_to_read =3D
| 			YY_CURRENT_BUFFER_LVALUE->yy_buf_size - number_to_move - 1;
|=20
| 		while ( num_to_read <=3D 0 )
| 			{ /* Not enough room in the buffer - grow it. */
|=20
| 			YY_FATAL_ERROR(
| "input buffer overflow, can't enlarge buffer because scanner uses REJEC=
T" );
|=20
| 			}
|=20
| 		if ( num_to_read > YY_READ_BUF_SIZE )
| 			num_to_read =3D YY_READ_BUF_SIZE;
|=20
| 		/* Read in more data. */
| 		YY_INPUT( (&YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[number_to_move]),
| 			(yy_n_chars), (size_t) num_to_read );
|=20
| 		YY_CURRENT_BUFFER_LVALUE->yy_n_chars =3D (yy_n_chars);
| 		}
|=20
| 	if ( (yy_n_chars) =3D=3D 0 )
| 		{
| 		if ( number_to_move =3D=3D YY_MORE_ADJ )
| 			{
| 			ret_val =3D EOB_ACT_END_OF_FILE;
| 			yyrestart(yyin  );
| 			}
|=20
| 		else
| 			{
| 			ret_val =3D EOB_ACT_LAST_MATCH;
| 			YY_CURRENT_BUFFER_LVALUE->yy_buffer_status =3D
| 				YY_BUFFER_EOF_PENDING;
| 			}
| 		}
|=20
| 	else
| 		ret_val =3D EOB_ACT_CONTINUE_SCAN;
|=20
| 	if ((yy_size_t) ((yy_n_chars) + number_to_move) > YY_CURRENT_BUFFER_LV=
ALUE->yy_buf_size) {
| 		/* Extend the array by 50%, plus the number we really need. */
| 		yy_size_t new_size =3D (yy_n_chars) + number_to_move + ((yy_n_chars) =
>> 1);
| 		YY_CURRENT_BUFFER_LVALUE->yy_ch_buf =3D (char *) yyrealloc((void *) Y=
Y_CURRENT_BUFFER_LVALUE->yy_ch_buf,new_size  );
| 		if ( ! YY_CURRENT_BUFFER_LVALUE->yy_ch_buf )
| 			YY_FATAL_ERROR( "out of dynamic memory in yy_get_next_buffer()" );
| 	}
|=20
| 	(yy_n_chars) +=3D number_to_move;
| 	YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[(yy_n_chars)] =3D YY_END_OF_BUFFER=
_CHAR;
| 	YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[(yy_n_chars) + 1] =3D YY_END_OF_BU=
FFER_CHAR;
|=20
| 	(yytext_ptr) =3D &YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[0];
|=20
| 	return ret_val;
| }
|=20
| /* yy_get_previous_state - get the state just before the EOB char was r=
eached */
|=20
|     static yy_state_type yy_get_previous_state (void)
| {
| 	register yy_state_type yy_current_state;
| 	register char *yy_cp;
|    =20
| 	yy_current_state =3D (yy_start);
|=20
| 	(yy_state_ptr) =3D (yy_state_buf);
| 	*(yy_state_ptr)++ =3D yy_current_state;
|=20
| 	for ( yy_cp =3D (yytext_ptr) + YY_MORE_ADJ; yy_cp < (yy_c_buf_p); ++yy=
_cp )
| 		{
| 		register YY_CHAR yy_c =3D (*yy_cp ? yy_ec[YY_SC_TO_UI(*yy_cp)] : 1);
| 		while ( yy_chk[yy_base[yy_current_state] + yy_c] !=3D yy_current_stat=
e )
| 			{
| 			yy_current_state =3D (int) yy_def[yy_current_state];
| 			if ( yy_current_state >=3D 13 )
| 				yy_c =3D yy_meta[(unsigned int) yy_c];
| 			}
| 		yy_current_state =3D yy_nxt[yy_base[yy_current_state] + (unsigned int=
) yy_c];
| 		*(yy_state_ptr)++ =3D yy_current_state;
| 		}
|=20
| 	return yy_current_state;
| }
|=20
| /* yy_try_NUL_trans - try to make a transition on the NUL character
|  *
|  * synopsis
|  *	next_state =3D yy_try_NUL_trans( current_state );
|  */
|     static yy_state_type yy_try_NUL_trans  (yy_state_type yy_current_st=
ate )
| {
| 	register int yy_is_jam;
|    =20
| 	register YY_CHAR yy_c =3D 1;
| 	while ( yy_chk[yy_base[yy_current_state] + yy_c] !=3D yy_current_state=
 )
| 		{
| 		yy_current_state =3D (int) yy_def[yy_current_state];
| 		if ( yy_current_state >=3D 13 )
| 			yy_c =3D yy_meta[(unsigned int) yy_c];
| 		}
| 	yy_current_state =3D yy_nxt[yy_base[yy_current_state] + (unsigned int)=
 yy_c];
| 	yy_is_jam =3D (yy_current_state =3D=3D 12);
| 	if ( ! yy_is_jam )
| 		*(yy_state_ptr)++ =3D yy_current_state;
|=20
| 	return yy_is_jam ? 0 : yy_current_state;
| }
|=20
|     static void yyunput (int c, register char * yy_bp )
| {
| 	register char *yy_cp;
|    =20
|     yy_cp =3D (yy_c_buf_p);
|=20
| 	/* undo effects of setting up yytext */
| 	*yy_cp =3D (yy_hold_char);
|=20
| 	if ( yy_cp < YY_CURRENT_BUFFER_LVALUE->yy_ch_buf + 2 )
| 		{ /* need to shift things up to make room */
| 		/* +2 for EOB chars. */
| 		register int number_to_move =3D (yy_n_chars) + 2;
| 		register char *dest =3D &YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[
| 					YY_CURRENT_BUFFER_LVALUE->yy_buf_size + 2];
| 		register char *source =3D
| 				&YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[number_to_move];
|=20
| 		while ( source > YY_CURRENT_BUFFER_LVALUE->yy_ch_buf )
| 			*--dest =3D *--source;
|=20
| 		yy_cp +=3D (int) (dest - source);
| 		yy_bp +=3D (int) (dest - source);
| 		YY_CURRENT_BUFFER_LVALUE->yy_n_chars =3D
| 			(yy_n_chars) =3D YY_CURRENT_BUFFER_LVALUE->yy_buf_size;
|=20
| 		if ( yy_cp < YY_CURRENT_BUFFER_LVALUE->yy_ch_buf + 2 )
| 			YY_FATAL_ERROR( "flex scanner push-back overflow" );
| 		}
|=20
| 	*--yy_cp =3D (char) c;
|=20
| 	(yytext_ptr) =3D yy_bp;
| 	(yy_hold_char) =3D *yy_cp;
| 	(yy_c_buf_p) =3D yy_cp;
| }
|=20
| #ifndef YY_NO_INPUT
| #ifdef __cplusplus
|     static int yyinput (void)
| #else
|     static int input  (void)
| #endif
|=20
| {
| 	int c;
|    =20
| 	*(yy_c_buf_p) =3D (yy_hold_char);
|=20
| 	if ( *(yy_c_buf_p) =3D=3D YY_END_OF_BUFFER_CHAR )
| 		{
| 		/* yy_c_buf_p now points to the character we want to return.
| 		 * If this occurs *before* the EOB characters, then it's a
| 		 * valid NUL; if not, then we've hit the end of the buffer.
| 		 */
| 		if ( (yy_c_buf_p) < &YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[(yy_n_chars)=
] )
| 			/* This was really a NUL. */
| 			*(yy_c_buf_p) =3D '\0';
|=20
| 		else
| 			{ /* need more input */
| 			int offset =3D (yy_c_buf_p) - (yytext_ptr);
| 			++(yy_c_buf_p);
|=20
| 			switch ( yy_get_next_buffer(  ) )
| 				{
| 				case EOB_ACT_LAST_MATCH:
| 					/* This happens because yy_g_n_b()
| 					 * sees that we've accumulated a
| 					 * token and flags that we need to
| 					 * try matching the token before
| 					 * proceeding.  But for input(),
| 					 * there's no matching to consider.
| 					 * So convert the EOB_ACT_LAST_MATCH
| 					 * to EOB_ACT_END_OF_FILE.
| 					 */
|=20
| 					/* Reset buffer status. */
| 					yyrestart(yyin );
|=20
| 					/*FALLTHROUGH*/
|=20
| 				case EOB_ACT_END_OF_FILE:
| 					{
| 					if ( yywrap( ) )
| 						return EOF;
|=20
| 					if ( ! (yy_did_buffer_switch_on_eof) )
| 						YY_NEW_FILE;
| #ifdef __cplusplus
| 					return yyinput();
| #else
| 					return input();
| #endif
| 					}
|=20
| 				case EOB_ACT_CONTINUE_SCAN:
| 					(yy_c_buf_p) =3D (yytext_ptr) + offset;
| 					break;
| 				}
| 			}
| 		}
|=20
| 	c =3D *(unsigned char *) (yy_c_buf_p);	/* cast for 8-bit char's */
| 	*(yy_c_buf_p) =3D '\0';	/* preserve yytext */
| 	(yy_hold_char) =3D *++(yy_c_buf_p);
|=20
| 	return c;
| }
| #endif	/* ifndef YY_NO_INPUT */
|=20
| /** Immediately switch to a different input stream.
|  * @param input_file A readable stream.
|  *=20
|  * @note This function does not reset the start condition to @c INITIAL=
 .
|  */
|     void yyrestart  (FILE * input_file )
| {
|    =20
| 	if ( ! YY_CURRENT_BUFFER ){
|         yyensure_buffer_stack ();
| 		YY_CURRENT_BUFFER_LVALUE =3D
|             yy_create_buffer(yyin,YY_BUF_SIZE );
| 	}
|=20
| 	yy_init_buffer(YY_CURRENT_BUFFER,input_file );
| 	yy_load_buffer_state( );
| }
|=20
| /** Switch to a different input buffer.
|  * @param new_buffer The new input buffer.
|  *=20
|  */
|     void yy_switch_to_buffer  (YY_BUFFER_STATE  new_buffer )
| {
|    =20
| 	/* TODO. We should be able to replace this entire function body
| 	 * with
| 	 *		yypop_buffer_state();
| 	 *		yypush_buffer_state(new_buffer);
|      */
| 	yyensure_buffer_stack ();
| 	if ( YY_CURRENT_BUFFER =3D=3D new_buffer )
| 		return;
|=20
| 	if ( YY_CURRENT_BUFFER )
| 		{
| 		/* Flush out information for old buffer. */
| 		*(yy_c_buf_p) =3D (yy_hold_char);
| 		YY_CURRENT_BUFFER_LVALUE->yy_buf_pos =3D (yy_c_buf_p);
| 		YY_CURRENT_BUFFER_LVALUE->yy_n_chars =3D (yy_n_chars);
| 		}
|=20
| 	YY_CURRENT_BUFFER_LVALUE =3D new_buffer;
| 	yy_load_buffer_state( );
|=20
| 	/* We don't actually know whether we did this switch during
| 	 * EOF (yywrap()) processing, but the only time this flag
| 	 * is looked at is after yywrap() is called, so it's safe
| 	 * to go ahead and always set it.
| 	 */
| 	(yy_did_buffer_switch_on_eof) =3D 1;
| }
|=20
| static void yy_load_buffer_state  (void)
| {
|     	(yy_n_chars) =3D YY_CURRENT_BUFFER_LVALUE->yy_n_chars;
| 	(yytext_ptr) =3D (yy_c_buf_p) =3D YY_CURRENT_BUFFER_LVALUE->yy_buf_pos=
;
| 	yyin =3D YY_CURRENT_BUFFER_LVALUE->yy_input_file;
| 	(yy_hold_char) =3D *(yy_c_buf_p);
| }
|=20
| /** Allocate and initialize an input buffer state.
|  * @param file A readable stream.
|  * @param size The character buffer size in bytes. When in doubt, use @=
c YY_BUF_SIZE.
|  *=20
|  * @return the allocated buffer state.
|  */
|     YY_BUFFER_STATE yy_create_buffer  (FILE * file, int  size )
| {
| 	YY_BUFFER_STATE b;
|    =20
| 	b =3D (YY_BUFFER_STATE) yyalloc(sizeof( struct yy_buffer_state )  );
| 	if ( ! b )
| 		YY_FATAL_ERROR( "out of dynamic memory in yy_create_buffer()" );
|=20
| 	b->yy_buf_size =3D size;
|=20
| 	/* yy_ch_buf has to be 2 characters longer than the size given because=

| 	 * we need to put in 2 end-of-buffer characters.
| 	 */
| 	b->yy_ch_buf =3D (char *) yyalloc(b->yy_buf_size + 2  );
| 	if ( ! b->yy_ch_buf )
| 		YY_FATAL_ERROR( "out of dynamic memory in yy_create_buffer()" );
|=20
| 	b->yy_is_our_buffer =3D 1;
|=20
| 	yy_init_buffer(b,file );
|=20
| 	return b;
| }
|=20
| /** Destroy the buffer.
|  * @param b a buffer created with yy_create_buffer()
|  *=20
|  */
|     void yy_delete_buffer (YY_BUFFER_STATE  b )
| {
|    =20
| 	if ( ! b )
| 		return;
|=20
| 	if ( b =3D=3D YY_CURRENT_BUFFER ) /* Not sure if we should pop here. *=
/
| 		YY_CURRENT_BUFFER_LVALUE =3D (YY_BUFFER_STATE) 0;
|=20
| 	if ( b->yy_is_our_buffer )
| 		yyfree((void *) b->yy_ch_buf  );
|=20
| 	yyfree((void *) b  );
| }
|=20
| #ifndef __cplusplus
| extern int isatty (int );
| #endif /* __cplusplus */
|    =20
| /* Initializes or reinitializes a buffer.
|  * This function is sometimes called more than once on the same buffer,=

|  * such as during a yyrestart() or at EOF.
|  */
|     static void yy_init_buffer  (YY_BUFFER_STATE  b, FILE * file )
|=20
| {
| 	int oerrno =3D errno;
|    =20
| 	yy_flush_buffer(b );
|=20
| 	b->yy_input_file =3D file;
| 	b->yy_fill_buffer =3D 1;
|=20
|     /* If b is the current buffer, then yy_init_buffer was _probably_
|      * called from yyrestart() or through yy_get_next_buffer.
|      * In that case, we don't want to reset the lineno or column.
|      */
|     if (b !=3D YY_CURRENT_BUFFER){
|         b->yy_bs_lineno =3D 1;
|         b->yy_bs_column =3D 0;
|     }
|=20
|         b->yy_is_interactive =3D file ? (isatty( fileno(file) ) > 0) : =
0;
|    =20
| 	errno =3D oerrno;
| }
|=20
| /** Discard all buffered characters. On the next scan, YY_INPUT will be=
 called.
|  * @param b the buffer state to be flushed, usually @c YY_CURRENT_BUFFE=
R.
|  *=20
|  */
|     void yy_flush_buffer (YY_BUFFER_STATE  b )
| {
|     	if ( ! b )
| 		return;
|=20
| 	b->yy_n_chars =3D 0;
|=20
| 	/* We always need two end-of-buffer characters.  The first causes
| 	 * a transition to the end-of-buffer state.  The second causes
| 	 * a jam in that state.
| 	 */
| 	b->yy_ch_buf[0] =3D YY_END_OF_BUFFER_CHAR;
| 	b->yy_ch_buf[1] =3D YY_END_OF_BUFFER_CHAR;
|=20
| 	b->yy_buf_pos =3D &b->yy_ch_buf[0];
|=20
| 	b->yy_at_bol =3D 1;
| 	b->yy_buffer_status =3D YY_BUFFER_NEW;
|=20
| 	if ( b =3D=3D YY_CURRENT_BUFFER )
| 		yy_load_buffer_state( );
| }
|=20
| /** Pushes the new state onto the stack. The new state becomes
|  *  the current state. This function will allocate the stack
|  *  if necessary.
|  *  @param new_buffer The new state.
|  * =20
|  */
| void yypush_buffer_state (YY_BUFFER_STATE new_buffer )
| {
|     	if (new_buffer =3D=3D NULL)
| 		return;
|=20
| 	yyensure_buffer_stack();
|=20
| 	/* This block is copied from yy_switch_to_buffer. */
| 	if ( YY_CURRENT_BUFFER )
| 		{
| 		/* Flush out information for old buffer. */
| 		*(yy_c_buf_p) =3D (yy_hold_char);
| 		YY_CURRENT_BUFFER_LVALUE->yy_buf_pos =3D (yy_c_buf_p);
| 		YY_CURRENT_BUFFER_LVALUE->yy_n_chars =3D (yy_n_chars);
| 		}
|=20
| 	/* Only push if top exists. Otherwise, replace top. */
| 	if (YY_CURRENT_BUFFER)
| 		(yy_buffer_stack_top)++;
| 	YY_CURRENT_BUFFER_LVALUE =3D new_buffer;
|=20
| 	/* copied from yy_switch_to_buffer. */
| 	yy_load_buffer_state( );
| 	(yy_did_buffer_switch_on_eof) =3D 1;
| }
|=20
| /** Removes and deletes the top of the stack, if present.
|  *  The next element becomes the new top.
|  * =20
|  */
| void yypop_buffer_state (void)
| {
|     	if (!YY_CURRENT_BUFFER)
| 		return;
|=20
| 	yy_delete_buffer(YY_CURRENT_BUFFER );
| 	YY_CURRENT_BUFFER_LVALUE =3D NULL;
| 	if ((yy_buffer_stack_top) > 0)
| 		--(yy_buffer_stack_top);
|=20
| 	if (YY_CURRENT_BUFFER) {
| 		yy_load_buffer_state( );
| 		(yy_did_buffer_switch_on_eof) =3D 1;
| 	}
| }
|=20
| /* Allocates the stack if it does not exist.
|  *  Guarantees space for at least one push.
|  */
| static void yyensure_buffer_stack (void)
| {
| 	int num_to_alloc;
|    =20
| 	if (!(yy_buffer_stack)) {
|=20
| 		/* First allocation is just for 2 elements, since we don't know if th=
is
| 		 * scanner will even need a stack. We use 2 instead of 1 to avoid an
| 		 * immediate realloc on the next call.
|          */
| 		num_to_alloc =3D 1;
| 		(yy_buffer_stack) =3D (struct yy_buffer_state**)yyalloc
| 								(num_to_alloc * sizeof(struct yy_buffer_state*)
| 								);
| 		if ( ! (yy_buffer_stack) )
| 			YY_FATAL_ERROR( "out of dynamic memory in yyensure_buffer_stack()" )=
;
| 								 =20
| 		memset((yy_buffer_stack), 0, num_to_alloc * sizeof(struct yy_buffer_s=
tate*));
| 			=09
| 		(yy_buffer_stack_max) =3D num_to_alloc;
| 		(yy_buffer_stack_top) =3D 0;
| 		return;
| 	}
|=20
| 	if ((yy_buffer_stack_top) >=3D ((yy_buffer_stack_max)) - 1){
|=20
| 		/* Increase the buffer to prepare for a possible push. */
| 		int grow_size =3D 8 /* arbitrary grow size */;
|=20
| 		num_to_alloc =3D (yy_buffer_stack_max) + grow_size;
| 		(yy_buffer_stack) =3D (struct yy_buffer_state**)yyrealloc
| 								((yy_buffer_stack),
| 								num_to_alloc * sizeof(struct yy_buffer_state*)
| 								);
| 		if ( ! (yy_buffer_stack) )
| 			YY_FATAL_ERROR( "out of dynamic memory in yyensure_buffer_stack()" )=
;
|=20
| 		/* zero only the new slots.*/
| 		memset((yy_buffer_stack) + (yy_buffer_stack_max), 0, grow_size * size=
of(struct yy_buffer_state*));
| 		(yy_buffer_stack_max) =3D num_to_alloc;
| 	}
| }
|=20
| /** Setup the input buffer state to scan directly from a user-specified=
 character buffer.
|  * @param base the character buffer
|  * @param size the size in bytes of the character buffer
|  *=20
|  * @return the newly allocated buffer state object.=20
|  */
| YY_BUFFER_STATE yy_scan_buffer  (char * base, yy_size_t  size )
| {
| 	YY_BUFFER_STATE b;
|    =20
| 	if ( size < 2 ||
| 	     base[size-2] !=3D YY_END_OF_BUFFER_CHAR ||
| 	     base[size-1] !=3D YY_END_OF_BUFFER_CHAR )
| 		/* They forgot to leave room for the EOB's. */
| 		return 0;
|=20
| 	b =3D (YY_BUFFER_STATE) yyalloc(sizeof( struct yy_buffer_state )  );
| 	if ( ! b )
| 		YY_FATAL_ERROR( "out of dynamic memory in yy_scan_buffer()" );
|=20
| 	b->yy_buf_size =3D size - 2;	/* "- 2" to take care of EOB's */
| 	b->yy_buf_pos =3D b->yy_ch_buf =3D base;
| 	b->yy_is_our_buffer =3D 0;
| 	b->yy_input_file =3D 0;
| 	b->yy_n_chars =3D b->yy_buf_size;
| 	b->yy_is_interactive =3D 0;
| 	b->yy_at_bol =3D 1;
| 	b->yy_fill_buffer =3D 0;
| 	b->yy_buffer_status =3D YY_BUFFER_NEW;
|=20
| 	yy_switch_to_buffer(b  );
|=20
| 	return b;
| }
|=20
| /** Setup the input buffer state to scan a string. The next call to yyl=
ex() will
|  * scan from a @e copy of @a str.
|  * @param yystr a NUL-terminated string to scan
|  *=20
|  * @return the newly allocated buffer state object.
|  * @note If you want to scan bytes that may contain NUL values, then us=
e
|  *       yy_scan_bytes() instead.
|  */
| YY_BUFFER_STATE yy_scan_string (yyconst char * yystr )
| {
|    =20
| 	return yy_scan_bytes(yystr,strlen(yystr) );
| }
|=20
| /** Setup the input buffer state to scan the given bytes. The next call=
 to yylex() will
|  * scan from a @e copy of @a bytes.
|  * @param bytes the byte buffer to scan
|  * @param len the number of bytes in the buffer pointed to by @a bytes.=

|  *=20
|  * @return the newly allocated buffer state object.
|  */
| YY_BUFFER_STATE yy_scan_bytes  (yyconst char * yybytes, int  _yybytes_l=
en )
| {
| 	YY_BUFFER_STATE b;
| 	char *buf;
| 	yy_size_t n;
| 	int i;
|    =20
| 	/* Get memory for full buffer, including space for trailing EOB's. */
| 	n =3D _yybytes_len + 2;
| 	buf =3D (char *) yyalloc(n  );
| 	if ( ! buf )
| 		YY_FATAL_ERROR( "out of dynamic memory in yy_scan_bytes()" );
|=20
| 	for ( i =3D 0; i < _yybytes_len; ++i )
| 		buf[i] =3D yybytes[i];
|=20
| 	buf[_yybytes_len] =3D buf[_yybytes_len+1] =3D YY_END_OF_BUFFER_CHAR;
|=20
| 	b =3D yy_scan_buffer(buf,n );
| 	if ( ! b )
| 		YY_FATAL_ERROR( "bad buffer in yy_scan_bytes()" );
|=20
| 	/* It's okay to grow etc. this buffer, and we should throw it
| 	 * away when we're done.
| 	 */
| 	b->yy_is_our_buffer =3D 1;
|=20
| 	return b;
| }
|=20
| #ifndef YY_EXIT_FAILURE
| #define YY_EXIT_FAILURE 2
| #endif
|=20
| static void yy_fatal_error (yyconst char* msg )
| {
|     	(void) fprintf( stderr, "%s\n", msg );
| 	exit( YY_EXIT_FAILURE );
| }
|=20
| /* Redefine yyless() so it works in section 3 code. */
|=20
| #undef yyless
| #define yyless(n) \
| 	do \
| 		{ \
| 		/* Undo effects of setting up yytext. */ \
|         int yyless_macro_arg =3D (n); \
|         YY_LESS_LINENO(yyless_macro_arg);\
| 		yytext[yyleng] =3D (yy_hold_char); \
| 		(yy_c_buf_p) =3D yytext + yyless_macro_arg; \
| 		(yy_hold_char) =3D *(yy_c_buf_p); \
| 		*(yy_c_buf_p) =3D '\0'; \
| 		yyleng =3D yyless_macro_arg; \
| 		} \
| 	while ( 0 )
|=20
| /* Accessor  methods (get/set functions) to struct members. */
|=20
| /** Get the current line number.
|  *=20
|  */
| int yyget_lineno  (void)
| {
|        =20
|     return yylineno;
| }
|=20
| /** Get the input stream.
|  *=20
|  */
| FILE *yyget_in  (void)
| {
|         return yyin;
| }
|=20
| /** Get the output stream.
|  *=20
|  */
| FILE *yyget_out  (void)
| {
|         return yyout;
| }
|=20
| /** Get the length of the current token.
|  *=20
|  */
| int yyget_leng  (void)
| {
|         return yyleng;
| }
|=20
| /** Get the current token.
|  *=20
|  */
|=20
| char *yyget_text  (void)
| {
|         return yytext;
| }
|=20
| /** Set the current line number.
|  * @param line_number
|  *=20
|  */
| void yyset_lineno (int  line_number )
| {
|    =20
|     yylineno =3D line_number;
| }
|=20
| /** Set the input stream. This does not discard the current
|  * input buffer.
|  * @param in_str A readable stream.
|  *=20
|  * @see yy_switch_to_buffer
|  */
| void yyset_in (FILE *  in_str )
| {
|         yyin =3D in_str ;
| }
|=20
| void yyset_out (FILE *  out_str )
| {
|         yyout =3D out_str ;
| }
|=20
| int yyget_debug  (void)
| {
|         return yy_flex_debug;
| }
|=20
| void yyset_debug (int  bdebug )
| {
|         yy_flex_debug =3D bdebug ;
| }
|=20
| static int yy_init_globals (void)
| {
|         /* Initialization is the same as for the non-reentrant scanner.=

|      * This function is called from yylex_destroy(), so don't allocate =
here.
|      */
|=20
|     (yy_buffer_stack) =3D 0;
|     (yy_buffer_stack_top) =3D 0;
|     (yy_buffer_stack_max) =3D 0;
|     (yy_c_buf_p) =3D (char *) 0;
|     (yy_init) =3D 0;
|     (yy_start) =3D 0;
|=20
|     (yy_state_buf) =3D 0;
|     (yy_state_ptr) =3D 0;
|     (yy_full_match) =3D 0;
|     (yy_lp) =3D 0;
|=20
| /* Defined in main.c */
| #ifdef YY_STDINIT
|     yyin =3D stdin;
|     yyout =3D stdout;
| #else
|     yyin =3D (FILE *) 0;
|     yyout =3D (FILE *) 0;
| #endif
|=20
|     /* For future reference: Set errno on error, since we are called by=

|      * yylex_init()
|      */
|     return 0;
| }
|=20
| /* yylex_destroy is for both reentrant and non-reentrant scanners. */
| int yylex_destroy  (void)
| {
|    =20
|     /* Pop the buffer stack, destroying each element. */
| 	while(YY_CURRENT_BUFFER){
| 		yy_delete_buffer(YY_CURRENT_BUFFER  );
| 		YY_CURRENT_BUFFER_LVALUE =3D NULL;
| 		yypop_buffer_state();
| 	}
|=20
| 	/* Destroy the stack itself. */
| 	yyfree((yy_buffer_stack) );
| 	(yy_buffer_stack) =3D NULL;
|=20
|     yyfree ( (yy_state_buf) );
|     (yy_state_buf)  =3D NULL;
|=20
|     /* Reset the globals. This is important in a non-reentrant scanner =
so the next time
|      * yylex() is called, initialization will occur. */
|     yy_init_globals( );
|=20
|     return 0;
| }
|=20
| /*
|  * Internal utility routines.
|  */
|=20
| #ifndef yytext_ptr
| static void yy_flex_strncpy (char* s1, yyconst char * s2, int n )
| {
| 	register int i;
| 	for ( i =3D 0; i < n; ++i )
| 		s1[i] =3D s2[i];
| }
| #endif
|=20
| #ifdef YY_NEED_STRLEN
| static int yy_flex_strlen (yyconst char * s )
| {
| 	register int n;
| 	for ( n =3D 0; s[n]; ++n )
| 		;
|=20
| 	return n;
| }
| #endif
|=20
| void *yyalloc (yy_size_t  size )
| {
| 	return (void *) malloc( size );
| }
|=20
| void *yyrealloc  (void * ptr, yy_size_t  size )
| {
| 	/* The cast to (char *) in the following accommodates both
| 	 * implementations that use char* generic pointers, and those
| 	 * that use void* generic pointers.  It works with the latter
| 	 * because both ANSI C and C++ allow castless assignment from
| 	 * any pointer type to void*, and deal with argument conversions
| 	 * as though doing an assignment.
| 	 */
| 	return (void *) realloc( (char *) ptr, size );
| }
|=20
| void yyfree (void * ptr )
| {
| 	free( (char *) ptr );	/* see yyrealloc() for (char *) cast */
| }
|=20
| #define YYTABLES_NAME "yytables"
|=20
| #line 9 "conftest.l"
|=20
|=20
| #ifdef YYTEXT_POINTER
| extern char *yytext;
| #endif
| int
| main (void)
| {
|   return ! yylex () + ! yywrap ();
| }
configure:21161: /home/malek/minisys/xenomai/buildroot/build_i686/staging=
_dir/usr/bin/i686-linux-uclibc-gcc -Os  -I/home/malek/minisys/xenomai/bui=
ldroot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/b=
uildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/x=
enomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xe=
nomai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpenti=
umpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 =
-o conftest    conftest.c -ll  >&5
/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bin/../l=
ib/gcc/i686-linux-uclibc/4.2.4/../../../../i686-linux-uclibc/bin/ld: cann=
ot find -ll
collect2: ld returned 1 exit status
configure:21167: $? =3D 1
configure: failed program was:
|=20
| #line 3 "lex.yy.c"
|=20
| #define  YY_INT_ALIGNED short int
|=20
| /* A lexical scanner generated by flex */
|=20
| #define FLEX_SCANNER
| #define YY_FLEX_MAJOR_VERSION 2
| #define YY_FLEX_MINOR_VERSION 5
| #define YY_FLEX_SUBMINOR_VERSION 35
| #if YY_FLEX_SUBMINOR_VERSION > 0
| #define FLEX_BETA
| #endif
|=20
| /* First, we deal with  platform-specific or compiler-specific issues. =
*/
|=20
| /* begin standard C headers. */
| #include <stdio.h>
| #include <string.h>
| #include <errno.h>
| #include <stdlib.h>
|=20
| /* end standard C headers. */
|=20
| /* flex integer type definitions */
|=20
| #ifndef FLEXINT_H
| #define FLEXINT_H
|=20
| /* C99 systems have <inttypes.h>. Non-C99 systems may or may not. */
|=20
| #if defined (__STDC_VERSION__) && __STDC_VERSION__ >=3D 199901L
|=20
| /* C99 says to define __STDC_LIMIT_MACROS before including stdint.h,
|  * if you want the limit (max/min) macros for int types.=20
|  */
| #ifndef __STDC_LIMIT_MACROS
| #define __STDC_LIMIT_MACROS 1
| #endif
|=20
| #include <inttypes.h>
| typedef int8_t flex_int8_t;
| typedef uint8_t flex_uint8_t;
| typedef int16_t flex_int16_t;
| typedef uint16_t flex_uint16_t;
| typedef int32_t flex_int32_t;
| typedef uint32_t flex_uint32_t;
| #else
| typedef signed char flex_int8_t;
| typedef short int flex_int16_t;
| typedef int flex_int32_t;
| typedef unsigned char flex_uint8_t;=20
| typedef unsigned short int flex_uint16_t;
| typedef unsigned int flex_uint32_t;
| #endif /* ! C99 */
|=20
| /* Limits of integral types. */
| #ifndef INT8_MIN
| #define INT8_MIN               (-128)
| #endif
| #ifndef INT16_MIN
| #define INT16_MIN              (-32767-1)
| #endif
| #ifndef INT32_MIN
| #define INT32_MIN              (-2147483647-1)
| #endif
| #ifndef INT8_MAX
| #define INT8_MAX               (127)
| #endif
| #ifndef INT16_MAX
| #define INT16_MAX              (32767)
| #endif
| #ifndef INT32_MAX
| #define INT32_MAX              (2147483647)
| #endif
| #ifndef UINT8_MAX
| #define UINT8_MAX              (255U)
| #endif
| #ifndef UINT16_MAX
| #define UINT16_MAX             (65535U)
| #endif
| #ifndef UINT32_MAX
| #define UINT32_MAX             (4294967295U)
| #endif
|=20
| #endif /* ! FLEXINT_H */
|=20
| #ifdef __cplusplus
|=20
| /* The "const" storage-class-modifier is valid. */
| #define YY_USE_CONST
|=20
| #else	/* ! __cplusplus */
|=20
| /* C99 requires __STDC__ to be defined as 1. */
| #if defined (__STDC__)
|=20
| #define YY_USE_CONST
|=20
| #endif	/* defined (__STDC__) */
| #endif	/* ! __cplusplus */
|=20
| #ifdef YY_USE_CONST
| #define yyconst const
| #else
| #define yyconst
| #endif
|=20
| /* Returned upon end-of-file. */
| #define YY_NULL 0
|=20
| /* Promotes a possibly negative, possibly signed char to an unsigned
|  * integer for use as an array index.  If the signed char is negative,
|  * we want to instead treat it as an 8-bit unsigned char, hence the
|  * double cast.
|  */
| #define YY_SC_TO_UI(c) ((unsigned int) (unsigned char) c)
|=20
| /* Enter a start condition.  This macro really ought to take a paramete=
r,
|  * but we do it the disgusting crufty way forced on us by the ()-less
|  * definition of BEGIN.
|  */
| #define BEGIN (yy_start) =3D 1 + 2 *
|=20
| /* Translate the current start state into a value that can be later han=
ded
|  * to BEGIN to return to the state.  The YYSTATE alias is for lex
|  * compatibility.
|  */
| #define YY_START (((yy_start) - 1) / 2)
| #define YYSTATE YY_START
|=20
| /* Action number for EOF rule of a given start state. */
| #define YY_STATE_EOF(state) (YY_END_OF_BUFFER + state + 1)
|=20
| /* Special action meaning "start processing a new file". */
| #define YY_NEW_FILE yyrestart(yyin  )
|=20
| #define YY_END_OF_BUFFER_CHAR 0
|=20
| /* Size of default input buffer. */
| #ifndef YY_BUF_SIZE
| #define YY_BUF_SIZE 16384
| #endif
|=20
| /* The state buf must be large enough to hold one state per character i=
n the main buffer.
|  */
| #define YY_STATE_BUF_SIZE   ((YY_BUF_SIZE + 2) * sizeof(yy_state_type))=

|=20
| #ifndef YY_TYPEDEF_YY_BUFFER_STATE
| #define YY_TYPEDEF_YY_BUFFER_STATE
| typedef struct yy_buffer_state *YY_BUFFER_STATE;
| #endif
|=20
| extern int yyleng;
|=20
| extern FILE *yyin, *yyout;
|=20
| #define EOB_ACT_CONTINUE_SCAN 0
| #define EOB_ACT_END_OF_FILE 1
| #define EOB_ACT_LAST_MATCH 2
|=20
|     #define YY_LESS_LINENO(n)
|    =20
| /* Return all but the first "n" matched characters back to the input st=
ream. */
| #define yyless(n) \
| 	do \
| 		{ \
| 		/* Undo effects of setting up yytext. */ \
|         int yyless_macro_arg =3D (n); \
|         YY_LESS_LINENO(yyless_macro_arg);\
| 		*yy_cp =3D (yy_hold_char); \
| 		YY_RESTORE_YY_MORE_OFFSET \
| 		(yy_c_buf_p) =3D yy_cp =3D yy_bp + yyless_macro_arg - YY_MORE_ADJ; \
| 		YY_DO_BEFORE_ACTION; /* set up yytext again */ \
| 		} \
| 	while ( 0 )
|=20
| #define unput(c) yyunput( c, (yytext_ptr)  )
|=20
| #ifndef YY_TYPEDEF_YY_SIZE_T
| #define YY_TYPEDEF_YY_SIZE_T
| typedef size_t yy_size_t;
| #endif
|=20
| #ifndef YY_STRUCT_YY_BUFFER_STATE
| #define YY_STRUCT_YY_BUFFER_STATE
| struct yy_buffer_state
| 	{
| 	FILE *yy_input_file;
|=20
| 	char *yy_ch_buf;		/* input buffer */
| 	char *yy_buf_pos;		/* current position in input buffer */
|=20
| 	/* Size of input buffer in bytes, not including room for EOB
| 	 * characters.
| 	 */
| 	yy_size_t yy_buf_size;
|=20
| 	/* Number of characters read into yy_ch_buf, not including EOB
| 	 * characters.
| 	 */
| 	int yy_n_chars;
|=20
| 	/* Whether we "own" the buffer - i.e., we know we created it,
| 	 * and can realloc() it to grow it, and should free() it to
| 	 * delete it.
| 	 */
| 	int yy_is_our_buffer;
|=20
| 	/* Whether this is an "interactive" input source; if so, and
| 	 * if we're using stdio for input, then we want to use getc()
| 	 * instead of fread(), to make sure we stop fetching input after
| 	 * each newline.
| 	 */
| 	int yy_is_interactive;
|=20
| 	/* Whether we're considered to be at the beginning of a line.
| 	 * If so, '^' rules will be active on the next match, otherwise
| 	 * not.
| 	 */
| 	int yy_at_bol;
|=20
|     int yy_bs_lineno; /**< The line count. */
|     int yy_bs_column; /**< The column count. */
|    =20
| 	/* Whether to try to fill the input buffer when we reach the
| 	 * end of it.
| 	 */
| 	int yy_fill_buffer;
|=20
| 	int yy_buffer_status;
|=20
| #define YY_BUFFER_NEW 0
| #define YY_BUFFER_NORMAL 1
| 	/* When an EOF's been seen but there's still some text to process
| 	 * then we mark the buffer as YY_EOF_PENDING, to indicate that we
| 	 * shouldn't try reading from the input source any more.  We might
| 	 * still have a bunch of tokens to match, though, because of
| 	 * possible backing-up.
| 	 *
| 	 * When we actually see the EOF, we change the status to "new"
| 	 * (via yyrestart()), so that the user can continue scanning by
| 	 * just pointing yyin at a new input file.
| 	 */
| #define YY_BUFFER_EOF_PENDING 2
|=20
| 	};
| #endif /* !YY_STRUCT_YY_BUFFER_STATE */
|=20
| /* Stack of input buffers. */
| static size_t yy_buffer_stack_top =3D 0; /**< index of top of stack. */=

| static size_t yy_buffer_stack_max =3D 0; /**< capacity of stack. */
| static YY_BUFFER_STATE * yy_buffer_stack =3D 0; /**< Stack as an array.=
 */
|=20
| /* We provide macros for accessing buffer states in case in the
|  * future we want to put the buffer states in a more general
|  * "scanner state".
|  *
|  * Returns the top of the stack, or NULL.
|  */
| #define YY_CURRENT_BUFFER ( (yy_buffer_stack) \
|                           ? (yy_buffer_stack)[(yy_buffer_stack_top)] \
|                           : NULL)
|=20
| /* Same as previous macro, but useful when we know that the buffer stac=
k is not
|  * NULL or when we need an lvalue. For internal use only.
|  */
| #define YY_CURRENT_BUFFER_LVALUE (yy_buffer_stack)[(yy_buffer_stack_top=
)]
|=20
| /* yy_hold_char holds the character lost when yytext is formed. */
| static char yy_hold_char;
| static int yy_n_chars;		/* number of characters read into yy_ch_buf */
| int yyleng;
|=20
| /* Points to current character in buffer. */
| static char *yy_c_buf_p =3D (char *) 0;
| static int yy_init =3D 0;		/* whether we need to initialize */
| static int yy_start =3D 0;	/* start state number */
|=20
| /* Flag which is used to allow yywrap()'s to do buffer switches
|  * instead of setting up a fresh yyin.  A bit of a hack ...
|  */
| static int yy_did_buffer_switch_on_eof;
|=20
| void yyrestart (FILE *input_file  );
| void yy_switch_to_buffer (YY_BUFFER_STATE new_buffer  );
| YY_BUFFER_STATE yy_create_buffer (FILE *file,int size  );
| void yy_delete_buffer (YY_BUFFER_STATE b  );
| void yy_flush_buffer (YY_BUFFER_STATE b  );
| void yypush_buffer_state (YY_BUFFER_STATE new_buffer  );
| void yypop_buffer_state (void );
|=20
| static void yyensure_buffer_stack (void );
| static void yy_load_buffer_state (void );
| static void yy_init_buffer (YY_BUFFER_STATE b,FILE *file  );
|=20
| #define YY_FLUSH_BUFFER yy_flush_buffer(YY_CURRENT_BUFFER )
|=20
| YY_BUFFER_STATE yy_scan_buffer (char *base,yy_size_t size  );
| YY_BUFFER_STATE yy_scan_string (yyconst char *yy_str  );
| YY_BUFFER_STATE yy_scan_bytes (yyconst char *bytes,int len  );
|=20
| void *yyalloc (yy_size_t  );
| void *yyrealloc (void *,yy_size_t  );
| void yyfree (void *  );
|=20
| #define yy_new_buffer yy_create_buffer
|=20
| #define yy_set_interactive(is_interactive) \
| 	{ \
| 	if ( ! YY_CURRENT_BUFFER ){ \
|         yyensure_buffer_stack (); \
| 		YY_CURRENT_BUFFER_LVALUE =3D    \
|             yy_create_buffer(yyin,YY_BUF_SIZE ); \
| 	} \
| 	YY_CURRENT_BUFFER_LVALUE->yy_is_interactive =3D is_interactive; \
| 	}
|=20
| #define yy_set_bol(at_bol) \
| 	{ \
| 	if ( ! YY_CURRENT_BUFFER ){\
|         yyensure_buffer_stack (); \
| 		YY_CURRENT_BUFFER_LVALUE =3D    \
|             yy_create_buffer(yyin,YY_BUF_SIZE ); \
| 	} \
| 	YY_CURRENT_BUFFER_LVALUE->yy_at_bol =3D at_bol; \
| 	}
|=20
| #define YY_AT_BOL() (YY_CURRENT_BUFFER_LVALUE->yy_at_bol)
|=20
| /* Begin user sect3 */
|=20
| typedef unsigned char YY_CHAR;
|=20
| FILE *yyin =3D (FILE *) 0, *yyout =3D (FILE *) 0;
|=20
| typedef int yy_state_type;
|=20
| extern int yylineno;
|=20
| int yylineno =3D 1;
|=20
| extern char *yytext;
| #define yytext_ptr yytext
|=20
| static yy_state_type yy_get_previous_state (void );
| static yy_state_type yy_try_NUL_trans (yy_state_type current_state  );
| static int yy_get_next_buffer (void );
| static void yy_fatal_error (yyconst char msg[]  );
|=20
| /* Done after the current pattern has been matched and before the
|  * corresponding action - sets up yytext.
|  */
| #define YY_DO_BEFORE_ACTION \
| 	(yytext_ptr) =3D yy_bp; \
| 	(yytext_ptr) -=3D (yy_more_len); \
| 	yyleng =3D (size_t) (yy_cp - (yytext_ptr)); \
| 	(yy_hold_char) =3D *yy_cp; \
| 	*yy_cp =3D '\0'; \
| 	(yy_c_buf_p) =3D yy_cp;
|=20
| #define YY_NUM_RULES 8
| #define YY_END_OF_BUFFER 9
| /* This struct is not used in this scanner,
|    but its presence is necessary. */
| struct yy_trans_info
| 	{
| 	flex_int32_t yy_verify;
| 	flex_int32_t yy_nxt;
| 	};
| static yyconst flex_int16_t yy_acclist[23] =3D
|     {   0,
|         9,    7,    8,    8,    1,    7,    8,    2,    7,    8,
|         3,    7,    8,    4,    7,    8,    5,    7,    8,    6,
|         7,    8
|     } ;
|=20
| static yyconst flex_int16_t yy_accept[14] =3D
|     {   0,
|         1,    1,    1,    2,    4,    5,    8,   11,   14,   17,
|        20,   23,   23
|     } ;
|=20
| static yyconst flex_int32_t yy_ec[256] =3D
|     {   0,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    2,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    3,    4,    5,    6,
|=20
|         7,    8,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|=20
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1
|     } ;
|=20
| static yyconst flex_int32_t yy_meta[9] =3D
|     {   0,
|         1,    1,    1,    1,    1,    1,    1,    1
|     } ;
|=20
| static yyconst flex_int16_t yy_base[13] =3D
|     {   0,
|         0,    0,    9,   10,   10,   10,   10,   10,   10,   10,
|        10,   10
|     } ;
|=20
| static yyconst flex_int16_t yy_def[13] =3D
|     {   0,
|        12,    1,   12,   12,   12,   12,   12,   12,   12,   12,
|        12,    0
|     } ;
|=20
| static yyconst flex_int16_t yy_nxt[19] =3D
|     {   0,
|         4,    5,    6,    7,    8,    9,   10,   11,   12,    3,
|        12,   12,   12,   12,   12,   12,   12,   12
|     } ;
|=20
| static yyconst flex_int16_t yy_chk[19] =3D
|     {   0,
|         1,    1,    1,    1,    1,    1,    1,    1,    3,   12,
|        12,   12,   12,   12,   12,   12,   12,   12
|     } ;
|=20
| extern int yy_flex_debug;
| int yy_flex_debug =3D 0;
|=20
| static yy_state_type *yy_state_buf=3D0, *yy_state_ptr=3D0;
| static char *yy_full_match;
| static int yy_lp;
| #define REJECT \
| { \
| *yy_cp =3D (yy_hold_char); /* undo effects of setting up yytext */ \
| yy_cp =3D (yy_full_match); /* restore poss. backed-over text */ \
| ++(yy_lp); \
| goto find_rule; \
| }
|=20
| static int yy_more_flag =3D 0;
| static int yy_more_len =3D 0;
| #define yymore() ((yy_more_flag) =3D 1)
| #define YY_MORE_ADJ (yy_more_len)
| #define YY_RESTORE_YY_MORE_OFFSET
| char *yytext;
| #line 1 "conftest.l"
| #line 468 "lex.yy.c"
|=20
| #define INITIAL 0
|=20
| #ifndef YY_NO_UNISTD_H
| /* Special case for "unistd.h", since it is non-ANSI. We include it way=

|  * down here because we want the user's section 1 to have been scanned =
first.
|  * The user has a chance to override it with an option.
|  */
| #include <unistd.h>
| #endif
|=20
| #ifndef YY_EXTRA_TYPE
| #define YY_EXTRA_TYPE void *
| #endif
|=20
| static int yy_init_globals (void );
|=20
| /* Accessor methods to globals.
|    These are made visible to non-reentrant scanners for convenience. */=

|=20
| int yylex_destroy (void );
|=20
| int yyget_debug (void );
|=20
| void yyset_debug (int debug_flag  );
|=20
| YY_EXTRA_TYPE yyget_extra (void );
|=20
| void yyset_extra (YY_EXTRA_TYPE user_defined  );
|=20
| FILE *yyget_in (void );
|=20
| void yyset_in  (FILE * in_str  );
|=20
| FILE *yyget_out (void );
|=20
| void yyset_out  (FILE * out_str  );
|=20
| int yyget_leng (void );
|=20
| char *yyget_text (void );
|=20
| int yyget_lineno (void );
|=20
| void yyset_lineno (int line_number  );
|=20
| /* Macros after this point can all be overridden by user definitions in=

|  * section 1.
|  */
|=20
| #ifndef YY_SKIP_YYWRAP
| #ifdef __cplusplus
| extern "C" int yywrap (void );
| #else
| extern int yywrap (void );
| #endif
| #endif
|=20
|     static void yyunput (int c,char *buf_ptr  );
|    =20
| #ifndef yytext_ptr
| static void yy_flex_strncpy (char *,yyconst char *,int );
| #endif
|=20
| #ifdef YY_NEED_STRLEN
| static int yy_flex_strlen (yyconst char * );
| #endif
|=20
| #ifndef YY_NO_INPUT
|=20
| #ifdef __cplusplus
| static int yyinput (void );
| #else
| static int input (void );
| #endif
|=20
| #endif
|=20
| /* Amount of stuff to slurp up with each read. */
| #ifndef YY_READ_BUF_SIZE
| #define YY_READ_BUF_SIZE 8192
| #endif
|=20
| /* Copy whatever the last rule matched to the standard output. */
| #ifndef ECHO
| /* This used to be an fputs(), but since the string might contain NUL's=
,
|  * we now use fwrite().
|  */
| #define ECHO fwrite( yytext, yyleng, 1, yyout )
| #endif
|=20
| /* Gets input and stuffs it into "buf".  number of characters read, or =
YY_NULL,
|  * is returned in "result".
|  */
| #ifndef YY_INPUT
| #define YY_INPUT(buf,result,max_size) \
| 	if ( YY_CURRENT_BUFFER_LVALUE->yy_is_interactive ) \
| 		{ \
| 		int c =3D '*'; \
| 		unsigned n; \
| 		for ( n =3D 0; n < max_size && \
| 			     (c =3D getc( yyin )) !=3D EOF && c !=3D '\n'; ++n ) \
| 			buf[n] =3D (char) c; \
| 		if ( c =3D=3D '\n' ) \
| 			buf[n++] =3D (char) c; \
| 		if ( c =3D=3D EOF && ferror( yyin ) ) \
| 			YY_FATAL_ERROR( "input in flex scanner failed" ); \
| 		result =3D n; \
| 		} \
| 	else \
| 		{ \
| 		errno=3D0; \
| 		while ( (result =3D fread(buf, 1, max_size, yyin))=3D=3D0 && ferror(y=
yin)) \
| 			{ \
| 			if( errno !=3D EINTR) \
| 				{ \
| 				YY_FATAL_ERROR( "input in flex scanner failed" ); \
| 				break; \
| 				} \
| 			errno=3D0; \
| 			clearerr(yyin); \
| 			} \
| 		}\
| \
|=20
| #endif
|=20
| /* No semi-colon after return; correct usage is to write "yyterminate()=
;" -
|  * we don't want an extra ';' after the "return" because that will caus=
e
|  * some compilers to complain about unreachable statements.
|  */
| #ifndef yyterminate
| #define yyterminate() return YY_NULL
| #endif
|=20
| /* Number of entries by which start-condition stack grows. */
| #ifndef YY_START_STACK_INCR
| #define YY_START_STACK_INCR 25
| #endif
|=20
| /* Report a fatal error. */
| #ifndef YY_FATAL_ERROR
| #define YY_FATAL_ERROR(msg) yy_fatal_error( msg )
| #endif
|=20
| /* end tables serialization structures and prototypes */
|=20
| /* Default declaration of generated scanner - a define so the user can
|  * easily add parameters.
|  */
| #ifndef YY_DECL
| #define YY_DECL_IS_OURS 1
|=20
| extern int yylex (void);
|=20
| #define YY_DECL int yylex (void)
| #endif /* !YY_DECL */
|=20
| /* Code executed at the beginning of each rule, after yytext and yyleng=

|  * have been set up.
|  */
| #ifndef YY_USER_ACTION
| #define YY_USER_ACTION
| #endif
|=20
| /* Code executed at the end of each rule. */
| #ifndef YY_BREAK
| #define YY_BREAK break;
| #endif
|=20
| #define YY_RULE_SETUP \
| 	YY_USER_ACTION
|=20
| /** The main scanner function which does all the work.
|  */
| YY_DECL
| {
| 	register yy_state_type yy_current_state;
| 	register char *yy_cp, *yy_bp;
| 	register int yy_act;
|    =20
| #line 1 "conftest.l"
|=20
| #line 652 "lex.yy.c"
|=20
| 	if ( !(yy_init) )
| 		{
| 		(yy_init) =3D 1;
|=20
| #ifdef YY_USER_INIT
| 		YY_USER_INIT;
| #endif
|=20
|         /* Create the reject buffer large enough to save one state per =
allowed character. */
|         if ( ! (yy_state_buf) )
|             (yy_state_buf) =3D (yy_state_type *)yyalloc(YY_STATE_BUF_SI=
ZE  );
|             if ( ! (yy_state_buf) )
|                 YY_FATAL_ERROR( "out of dynamic memory in yylex()" );
|=20
| 		if ( ! (yy_start) )
| 			(yy_start) =3D 1;	/* first start state */
|=20
| 		if ( ! yyin )
| 			yyin =3D stdin;
|=20
| 		if ( ! yyout )
| 			yyout =3D stdout;
|=20
| 		if ( ! YY_CURRENT_BUFFER ) {
| 			yyensure_buffer_stack ();
| 			YY_CURRENT_BUFFER_LVALUE =3D
| 				yy_create_buffer(yyin,YY_BUF_SIZE );
| 		}
|=20
| 		yy_load_buffer_state( );
| 		}
|=20
| 	while ( 1 )		/* loops until end-of-file is reached */
| 		{
| 		(yy_more_len) =3D 0;
| 		if ( (yy_more_flag) )
| 			{
| 			(yy_more_len) =3D (yy_c_buf_p) - (yytext_ptr);
| 			(yy_more_flag) =3D 0;
| 			}
| 		yy_cp =3D (yy_c_buf_p);
|=20
| 		/* Support of yytext. */
| 		*yy_cp =3D (yy_hold_char);
|=20
| 		/* yy_bp points to the position in yy_ch_buf of the start of
| 		 * the current run.
| 		 */
| 		yy_bp =3D yy_cp;
|=20
| 		yy_current_state =3D (yy_start);
|=20
| 		(yy_state_ptr) =3D (yy_state_buf);
| 		*(yy_state_ptr)++ =3D yy_current_state;
|=20
| yy_match:
| 		do
| 			{
| 			register YY_CHAR yy_c =3D yy_ec[YY_SC_TO_UI(*yy_cp)];
| 			while ( yy_chk[yy_base[yy_current_state] + yy_c] !=3D yy_current_sta=
te )
| 				{
| 				yy_current_state =3D (int) yy_def[yy_current_state];
| 				if ( yy_current_state >=3D 13 )
| 					yy_c =3D yy_meta[(unsigned int) yy_c];
| 				}
| 			yy_current_state =3D yy_nxt[yy_base[yy_current_state] + (unsigned in=
t) yy_c];
| 			*(yy_state_ptr)++ =3D yy_current_state;
| 			++yy_cp;
| 			}
| 		while ( yy_base[yy_current_state] !=3D 10 );
|=20
| yy_find_action:
| 		yy_current_state =3D *--(yy_state_ptr);
| 		(yy_lp) =3D yy_accept[yy_current_state];
| find_rule: /* we branch to this label when backing up */
| 		for ( ; ; ) /* until we find what rule we matched */
| 			{
| 			if ( (yy_lp) && (yy_lp) < yy_accept[yy_current_state + 1] )
| 				{
| 				yy_act =3D yy_acclist[(yy_lp)];
| 					{
| 					(yy_full_match) =3D yy_cp;
| 					break;
| 					}
| 				}
| 			--yy_cp;
| 			yy_current_state =3D *--(yy_state_ptr);
| 			(yy_lp) =3D yy_accept[yy_current_state];
| 			}
|=20
| 		YY_DO_BEFORE_ACTION;
|=20
| do_action:	/* This label is used only to access EOF actions. */
|=20
| 		switch ( yy_act )
| 	{ /* beginning of action switch */
| case 1:
| YY_RULE_SETUP
| #line 2 "conftest.l"
| { ECHO; }
| 	YY_BREAK
| case 2:
| YY_RULE_SETUP
| #line 3 "conftest.l"
| { REJECT; }
| 	YY_BREAK
| case 3:
| YY_RULE_SETUP
| #line 4 "conftest.l"
| { yymore (); }
| 	YY_BREAK
| case 4:
| YY_RULE_SETUP
| #line 5 "conftest.l"
| { yyless (1); }
| 	YY_BREAK
| case 5:
| YY_RULE_SETUP
| #line 6 "conftest.l"
| { yyless (input () !=3D 0); }
| 	YY_BREAK
| case 6:
| YY_RULE_SETUP
| #line 7 "conftest.l"
| { unput (yytext[0]); }
| 	YY_BREAK
| case 7:
| YY_RULE_SETUP
| #line 8 "conftest.l"
| { BEGIN INITIAL; }
| 	YY_BREAK
| case 8:
| YY_RULE_SETUP
| #line 9 "conftest.l"
| ECHO;
| 	YY_BREAK
| #line 790 "lex.yy.c"
| 			case YY_STATE_EOF(INITIAL):
| 				yyterminate();
|=20
| 	case YY_END_OF_BUFFER:
| 		{
| 		/* Amount of text matched not including the EOB char. */
| 		int yy_amount_of_matched_text =3D (int) (yy_cp - (yytext_ptr)) - 1;
|=20
| 		/* Undo the effects of YY_DO_BEFORE_ACTION. */
| 		*yy_cp =3D (yy_hold_char);
| 		YY_RESTORE_YY_MORE_OFFSET
|=20
| 		if ( YY_CURRENT_BUFFER_LVALUE->yy_buffer_status =3D=3D YY_BUFFER_NEW =
)
| 			{
| 			/* We're scanning a new file or input source.  It's
| 			 * possible that this happened because the user
| 			 * just pointed yyin at a new source and called
| 			 * yylex().  If so, then we have to assure
| 			 * consistency between YY_CURRENT_BUFFER and our
| 			 * globals.  Here is the right place to do so, because
| 			 * this is the first action (other than possibly a
| 			 * back-up) that will match for the new input source.
| 			 */
| 			(yy_n_chars) =3D YY_CURRENT_BUFFER_LVALUE->yy_n_chars;
| 			YY_CURRENT_BUFFER_LVALUE->yy_input_file =3D yyin;
| 			YY_CURRENT_BUFFER_LVALUE->yy_buffer_status =3D YY_BUFFER_NORMAL;
| 			}
|=20
| 		/* Note that here we test for yy_c_buf_p "<=3D" to the position
| 		 * of the first EOB in the buffer, since yy_c_buf_p will
| 		 * already have been incremented past the NUL character
| 		 * (since all states make transitions on EOB to the
| 		 * end-of-buffer state).  Contrast this with the test
| 		 * in input().
| 		 */
| 		if ( (yy_c_buf_p) <=3D &YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[(yy_n_cha=
rs)] )
| 			{ /* This was really a NUL. */
| 			yy_state_type yy_next_state;
|=20
| 			(yy_c_buf_p) =3D (yytext_ptr) + yy_amount_of_matched_text;
|=20
| 			yy_current_state =3D yy_get_previous_state(  );
|=20
| 			/* Okay, we're now positioned to make the NUL
| 			 * transition.  We couldn't have
| 			 * yy_get_previous_state() go ahead and do it
| 			 * for us because it doesn't know how to deal
| 			 * with the possibility of jamming (and we don't
| 			 * want to build jamming into it because then it
| 			 * will run more slowly).
| 			 */
|=20
| 			yy_next_state =3D yy_try_NUL_trans( yy_current_state );
|=20
| 			yy_bp =3D (yytext_ptr) + YY_MORE_ADJ;
|=20
| 			if ( yy_next_state )
| 				{
| 				/* Consume the NUL. */
| 				yy_cp =3D ++(yy_c_buf_p);
| 				yy_current_state =3D yy_next_state;
| 				goto yy_match;
| 				}
|=20
| 			else
| 				{
| 				yy_cp =3D (yy_c_buf_p);
| 				goto yy_find_action;
| 				}
| 			}
|=20
| 		else switch ( yy_get_next_buffer(  ) )
| 			{
| 			case EOB_ACT_END_OF_FILE:
| 				{
| 				(yy_did_buffer_switch_on_eof) =3D 0;
|=20
| 				if ( yywrap( ) )
| 					{
| 					/* Note: because we've taken care in
| 					 * yy_get_next_buffer() to have set up
| 					 * yytext, we can now set up
| 					 * yy_c_buf_p so that if some total
| 					 * hoser (like flex itself) wants to
| 					 * call the scanner after we return the
| 					 * YY_NULL, it'll still work - another
| 					 * YY_NULL will get returned.
| 					 */
| 					(yy_c_buf_p) =3D (yytext_ptr) + YY_MORE_ADJ;
|=20
| 					yy_act =3D YY_STATE_EOF(YY_START);
| 					goto do_action;
| 					}
|=20
| 				else
| 					{
| 					if ( ! (yy_did_buffer_switch_on_eof) )
| 						YY_NEW_FILE;
| 					}
| 				break;
| 				}
|=20
| 			case EOB_ACT_CONTINUE_SCAN:
| 				(yy_c_buf_p) =3D
| 					(yytext_ptr) + yy_amount_of_matched_text;
|=20
| 				yy_current_state =3D yy_get_previous_state(  );
|=20
| 				yy_cp =3D (yy_c_buf_p);
| 				yy_bp =3D (yytext_ptr) + YY_MORE_ADJ;
| 				goto yy_match;
|=20
| 			case EOB_ACT_LAST_MATCH:
| 				(yy_c_buf_p) =3D
| 				&YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[(yy_n_chars)];
|=20
| 				yy_current_state =3D yy_get_previous_state(  );
|=20
| 				yy_cp =3D (yy_c_buf_p);
| 				yy_bp =3D (yytext_ptr) + YY_MORE_ADJ;
| 				goto yy_find_action;
| 			}
| 		break;
| 		}
|=20
| 	default:
| 		YY_FATAL_ERROR(
| 			"fatal flex scanner internal error--no action found" );
| 	} /* end of action switch */
| 		} /* end of scanning one token */
| } /* end of yylex */
|=20
| /* yy_get_next_buffer - try to read in a new buffer
|  *
|  * Returns a code representing an action:
|  *	EOB_ACT_LAST_MATCH -
|  *	EOB_ACT_CONTINUE_SCAN - continue scanning from current position
|  *	EOB_ACT_END_OF_FILE - end of file
|  */
| static int yy_get_next_buffer (void)
| {
|     	register char *dest =3D YY_CURRENT_BUFFER_LVALUE->yy_ch_buf;
| 	register char *source =3D (yytext_ptr);
| 	register int number_to_move, i;
| 	int ret_val;
|=20
| 	if ( (yy_c_buf_p) > &YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[(yy_n_chars) =
+ 1] )
| 		YY_FATAL_ERROR(
| 		"fatal flex scanner internal error--end of buffer missed" );
|=20
| 	if ( YY_CURRENT_BUFFER_LVALUE->yy_fill_buffer =3D=3D 0 )
| 		{ /* Don't try to fill the buffer, so this is an EOF. */
| 		if ( (yy_c_buf_p) - (yytext_ptr) - YY_MORE_ADJ =3D=3D 1 )
| 			{
| 			/* We matched a single character, the EOB, so
| 			 * treat this as a final EOF.
| 			 */
| 			return EOB_ACT_END_OF_FILE;
| 			}
|=20
| 		else
| 			{
| 			/* We matched some text prior to the EOB, first
| 			 * process it.
| 			 */
| 			return EOB_ACT_LAST_MATCH;
| 			}
| 		}
|=20
| 	/* Try to read more data. */
|=20
| 	/* First move last chars to start of buffer. */
| 	number_to_move =3D (int) ((yy_c_buf_p) - (yytext_ptr)) - 1;
|=20
| 	for ( i =3D 0; i < number_to_move; ++i )
| 		*(dest++) =3D *(source++);
|=20
| 	if ( YY_CURRENT_BUFFER_LVALUE->yy_buffer_status =3D=3D YY_BUFFER_EOF_P=
ENDING )
| 		/* don't do the read, it's not guaranteed to return an EOF,
| 		 * just force an EOF
| 		 */
| 		YY_CURRENT_BUFFER_LVALUE->yy_n_chars =3D (yy_n_chars) =3D 0;
|=20
| 	else
| 		{
| 			int num_to_read =3D
| 			YY_CURRENT_BUFFER_LVALUE->yy_buf_size - number_to_move - 1;
|=20
| 		while ( num_to_read <=3D 0 )
| 			{ /* Not enough room in the buffer - grow it. */
|=20
| 			YY_FATAL_ERROR(
| "input buffer overflow, can't enlarge buffer because scanner uses REJEC=
T" );
|=20
| 			}
|=20
| 		if ( num_to_read > YY_READ_BUF_SIZE )
| 			num_to_read =3D YY_READ_BUF_SIZE;
|=20
| 		/* Read in more data. */
| 		YY_INPUT( (&YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[number_to_move]),
| 			(yy_n_chars), (size_t) num_to_read );
|=20
| 		YY_CURRENT_BUFFER_LVALUE->yy_n_chars =3D (yy_n_chars);
| 		}
|=20
| 	if ( (yy_n_chars) =3D=3D 0 )
| 		{
| 		if ( number_to_move =3D=3D YY_MORE_ADJ )
| 			{
| 			ret_val =3D EOB_ACT_END_OF_FILE;
| 			yyrestart(yyin  );
| 			}
|=20
| 		else
| 			{
| 			ret_val =3D EOB_ACT_LAST_MATCH;
| 			YY_CURRENT_BUFFER_LVALUE->yy_buffer_status =3D
| 				YY_BUFFER_EOF_PENDING;
| 			}
| 		}
|=20
| 	else
| 		ret_val =3D EOB_ACT_CONTINUE_SCAN;
|=20
| 	if ((yy_size_t) ((yy_n_chars) + number_to_move) > YY_CURRENT_BUFFER_LV=
ALUE->yy_buf_size) {
| 		/* Extend the array by 50%, plus the number we really need. */
| 		yy_size_t new_size =3D (yy_n_chars) + number_to_move + ((yy_n_chars) =
>> 1);
| 		YY_CURRENT_BUFFER_LVALUE->yy_ch_buf =3D (char *) yyrealloc((void *) Y=
Y_CURRENT_BUFFER_LVALUE->yy_ch_buf,new_size  );
| 		if ( ! YY_CURRENT_BUFFER_LVALUE->yy_ch_buf )
| 			YY_FATAL_ERROR( "out of dynamic memory in yy_get_next_buffer()" );
| 	}
|=20
| 	(yy_n_chars) +=3D number_to_move;
| 	YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[(yy_n_chars)] =3D YY_END_OF_BUFFER=
_CHAR;
| 	YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[(yy_n_chars) + 1] =3D YY_END_OF_BU=
FFER_CHAR;
|=20
| 	(yytext_ptr) =3D &YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[0];
|=20
| 	return ret_val;
| }
|=20
| /* yy_get_previous_state - get the state just before the EOB char was r=
eached */
|=20
|     static yy_state_type yy_get_previous_state (void)
| {
| 	register yy_state_type yy_current_state;
| 	register char *yy_cp;
|    =20
| 	yy_current_state =3D (yy_start);
|=20
| 	(yy_state_ptr) =3D (yy_state_buf);
| 	*(yy_state_ptr)++ =3D yy_current_state;
|=20
| 	for ( yy_cp =3D (yytext_ptr) + YY_MORE_ADJ; yy_cp < (yy_c_buf_p); ++yy=
_cp )
| 		{
| 		register YY_CHAR yy_c =3D (*yy_cp ? yy_ec[YY_SC_TO_UI(*yy_cp)] : 1);
| 		while ( yy_chk[yy_base[yy_current_state] + yy_c] !=3D yy_current_stat=
e )
| 			{
| 			yy_current_state =3D (int) yy_def[yy_current_state];
| 			if ( yy_current_state >=3D 13 )
| 				yy_c =3D yy_meta[(unsigned int) yy_c];
| 			}
| 		yy_current_state =3D yy_nxt[yy_base[yy_current_state] + (unsigned int=
) yy_c];
| 		*(yy_state_ptr)++ =3D yy_current_state;
| 		}
|=20
| 	return yy_current_state;
| }
|=20
| /* yy_try_NUL_trans - try to make a transition on the NUL character
|  *
|  * synopsis
|  *	next_state =3D yy_try_NUL_trans( current_state );
|  */
|     static yy_state_type yy_try_NUL_trans  (yy_state_type yy_current_st=
ate )
| {
| 	register int yy_is_jam;
|    =20
| 	register YY_CHAR yy_c =3D 1;
| 	while ( yy_chk[yy_base[yy_current_state] + yy_c] !=3D yy_current_state=
 )
| 		{
| 		yy_current_state =3D (int) yy_def[yy_current_state];
| 		if ( yy_current_state >=3D 13 )
| 			yy_c =3D yy_meta[(unsigned int) yy_c];
| 		}
| 	yy_current_state =3D yy_nxt[yy_base[yy_current_state] + (unsigned int)=
 yy_c];
| 	yy_is_jam =3D (yy_current_state =3D=3D 12);
| 	if ( ! yy_is_jam )
| 		*(yy_state_ptr)++ =3D yy_current_state;
|=20
| 	return yy_is_jam ? 0 : yy_current_state;
| }
|=20
|     static void yyunput (int c, register char * yy_bp )
| {
| 	register char *yy_cp;
|    =20
|     yy_cp =3D (yy_c_buf_p);
|=20
| 	/* undo effects of setting up yytext */
| 	*yy_cp =3D (yy_hold_char);
|=20
| 	if ( yy_cp < YY_CURRENT_BUFFER_LVALUE->yy_ch_buf + 2 )
| 		{ /* need to shift things up to make room */
| 		/* +2 for EOB chars. */
| 		register int number_to_move =3D (yy_n_chars) + 2;
| 		register char *dest =3D &YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[
| 					YY_CURRENT_BUFFER_LVALUE->yy_buf_size + 2];
| 		register char *source =3D
| 				&YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[number_to_move];
|=20
| 		while ( source > YY_CURRENT_BUFFER_LVALUE->yy_ch_buf )
| 			*--dest =3D *--source;
|=20
| 		yy_cp +=3D (int) (dest - source);
| 		yy_bp +=3D (int) (dest - source);
| 		YY_CURRENT_BUFFER_LVALUE->yy_n_chars =3D
| 			(yy_n_chars) =3D YY_CURRENT_BUFFER_LVALUE->yy_buf_size;
|=20
| 		if ( yy_cp < YY_CURRENT_BUFFER_LVALUE->yy_ch_buf + 2 )
| 			YY_FATAL_ERROR( "flex scanner push-back overflow" );
| 		}
|=20
| 	*--yy_cp =3D (char) c;
|=20
| 	(yytext_ptr) =3D yy_bp;
| 	(yy_hold_char) =3D *yy_cp;
| 	(yy_c_buf_p) =3D yy_cp;
| }
|=20
| #ifndef YY_NO_INPUT
| #ifdef __cplusplus
|     static int yyinput (void)
| #else
|     static int input  (void)
| #endif
|=20
| {
| 	int c;
|    =20
| 	*(yy_c_buf_p) =3D (yy_hold_char);
|=20
| 	if ( *(yy_c_buf_p) =3D=3D YY_END_OF_BUFFER_CHAR )
| 		{
| 		/* yy_c_buf_p now points to the character we want to return.
| 		 * If this occurs *before* the EOB characters, then it's a
| 		 * valid NUL; if not, then we've hit the end of the buffer.
| 		 */
| 		if ( (yy_c_buf_p) < &YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[(yy_n_chars)=
] )
| 			/* This was really a NUL. */
| 			*(yy_c_buf_p) =3D '\0';
|=20
| 		else
| 			{ /* need more input */
| 			int offset =3D (yy_c_buf_p) - (yytext_ptr);
| 			++(yy_c_buf_p);
|=20
| 			switch ( yy_get_next_buffer(  ) )
| 				{
| 				case EOB_ACT_LAST_MATCH:
| 					/* This happens because yy_g_n_b()
| 					 * sees that we've accumulated a
| 					 * token and flags that we need to
| 					 * try matching the token before
| 					 * proceeding.  But for input(),
| 					 * there's no matching to consider.
| 					 * So convert the EOB_ACT_LAST_MATCH
| 					 * to EOB_ACT_END_OF_FILE.
| 					 */
|=20
| 					/* Reset buffer status. */
| 					yyrestart(yyin );
|=20
| 					/*FALLTHROUGH*/
|=20
| 				case EOB_ACT_END_OF_FILE:
| 					{
| 					if ( yywrap( ) )
| 						return EOF;
|=20
| 					if ( ! (yy_did_buffer_switch_on_eof) )
| 						YY_NEW_FILE;
| #ifdef __cplusplus
| 					return yyinput();
| #else
| 					return input();
| #endif
| 					}
|=20
| 				case EOB_ACT_CONTINUE_SCAN:
| 					(yy_c_buf_p) =3D (yytext_ptr) + offset;
| 					break;
| 				}
| 			}
| 		}
|=20
| 	c =3D *(unsigned char *) (yy_c_buf_p);	/* cast for 8-bit char's */
| 	*(yy_c_buf_p) =3D '\0';	/* preserve yytext */
| 	(yy_hold_char) =3D *++(yy_c_buf_p);
|=20
| 	return c;
| }
| #endif	/* ifndef YY_NO_INPUT */
|=20
| /** Immediately switch to a different input stream.
|  * @param input_file A readable stream.
|  *=20
|  * @note This function does not reset the start condition to @c INITIAL=
 .
|  */
|     void yyrestart  (FILE * input_file )
| {
|    =20
| 	if ( ! YY_CURRENT_BUFFER ){
|         yyensure_buffer_stack ();
| 		YY_CURRENT_BUFFER_LVALUE =3D
|             yy_create_buffer(yyin,YY_BUF_SIZE );
| 	}
|=20
| 	yy_init_buffer(YY_CURRENT_BUFFER,input_file );
| 	yy_load_buffer_state( );
| }
|=20
| /** Switch to a different input buffer.
|  * @param new_buffer The new input buffer.
|  *=20
|  */
|     void yy_switch_to_buffer  (YY_BUFFER_STATE  new_buffer )
| {
|    =20
| 	/* TODO. We should be able to replace this entire function body
| 	 * with
| 	 *		yypop_buffer_state();
| 	 *		yypush_buffer_state(new_buffer);
|      */
| 	yyensure_buffer_stack ();
| 	if ( YY_CURRENT_BUFFER =3D=3D new_buffer )
| 		return;
|=20
| 	if ( YY_CURRENT_BUFFER )
| 		{
| 		/* Flush out information for old buffer. */
| 		*(yy_c_buf_p) =3D (yy_hold_char);
| 		YY_CURRENT_BUFFER_LVALUE->yy_buf_pos =3D (yy_c_buf_p);
| 		YY_CURRENT_BUFFER_LVALUE->yy_n_chars =3D (yy_n_chars);
| 		}
|=20
| 	YY_CURRENT_BUFFER_LVALUE =3D new_buffer;
| 	yy_load_buffer_state( );
|=20
| 	/* We don't actually know whether we did this switch during
| 	 * EOF (yywrap()) processing, but the only time this flag
| 	 * is looked at is after yywrap() is called, so it's safe
| 	 * to go ahead and always set it.
| 	 */
| 	(yy_did_buffer_switch_on_eof) =3D 1;
| }
|=20
| static void yy_load_buffer_state  (void)
| {
|     	(yy_n_chars) =3D YY_CURRENT_BUFFER_LVALUE->yy_n_chars;
| 	(yytext_ptr) =3D (yy_c_buf_p) =3D YY_CURRENT_BUFFER_LVALUE->yy_buf_pos=
;
| 	yyin =3D YY_CURRENT_BUFFER_LVALUE->yy_input_file;
| 	(yy_hold_char) =3D *(yy_c_buf_p);
| }
|=20
| /** Allocate and initialize an input buffer state.
|  * @param file A readable stream.
|  * @param size The character buffer size in bytes. When in doubt, use @=
c YY_BUF_SIZE.
|  *=20
|  * @return the allocated buffer state.
|  */
|     YY_BUFFER_STATE yy_create_buffer  (FILE * file, int  size )
| {
| 	YY_BUFFER_STATE b;
|    =20
| 	b =3D (YY_BUFFER_STATE) yyalloc(sizeof( struct yy_buffer_state )  );
| 	if ( ! b )
| 		YY_FATAL_ERROR( "out of dynamic memory in yy_create_buffer()" );
|=20
| 	b->yy_buf_size =3D size;
|=20
| 	/* yy_ch_buf has to be 2 characters longer than the size given because=

| 	 * we need to put in 2 end-of-buffer characters.
| 	 */
| 	b->yy_ch_buf =3D (char *) yyalloc(b->yy_buf_size + 2  );
| 	if ( ! b->yy_ch_buf )
| 		YY_FATAL_ERROR( "out of dynamic memory in yy_create_buffer()" );
|=20
| 	b->yy_is_our_buffer =3D 1;
|=20
| 	yy_init_buffer(b,file );
|=20
| 	return b;
| }
|=20
| /** Destroy the buffer.
|  * @param b a buffer created with yy_create_buffer()
|  *=20
|  */
|     void yy_delete_buffer (YY_BUFFER_STATE  b )
| {
|    =20
| 	if ( ! b )
| 		return;
|=20
| 	if ( b =3D=3D YY_CURRENT_BUFFER ) /* Not sure if we should pop here. *=
/
| 		YY_CURRENT_BUFFER_LVALUE =3D (YY_BUFFER_STATE) 0;
|=20
| 	if ( b->yy_is_our_buffer )
| 		yyfree((void *) b->yy_ch_buf  );
|=20
| 	yyfree((void *) b  );
| }
|=20
| #ifndef __cplusplus
| extern int isatty (int );
| #endif /* __cplusplus */
|    =20
| /* Initializes or reinitializes a buffer.
|  * This function is sometimes called more than once on the same buffer,=

|  * such as during a yyrestart() or at EOF.
|  */
|     static void yy_init_buffer  (YY_BUFFER_STATE  b, FILE * file )
|=20
| {
| 	int oerrno =3D errno;
|    =20
| 	yy_flush_buffer(b );
|=20
| 	b->yy_input_file =3D file;
| 	b->yy_fill_buffer =3D 1;
|=20
|     /* If b is the current buffer, then yy_init_buffer was _probably_
|      * called from yyrestart() or through yy_get_next_buffer.
|      * In that case, we don't want to reset the lineno or column.
|      */
|     if (b !=3D YY_CURRENT_BUFFER){
|         b->yy_bs_lineno =3D 1;
|         b->yy_bs_column =3D 0;
|     }
|=20
|         b->yy_is_interactive =3D file ? (isatty( fileno(file) ) > 0) : =
0;
|    =20
| 	errno =3D oerrno;
| }
|=20
| /** Discard all buffered characters. On the next scan, YY_INPUT will be=
 called.
|  * @param b the buffer state to be flushed, usually @c YY_CURRENT_BUFFE=
R.
|  *=20
|  */
|     void yy_flush_buffer (YY_BUFFER_STATE  b )
| {
|     	if ( ! b )
| 		return;
|=20
| 	b->yy_n_chars =3D 0;
|=20
| 	/* We always need two end-of-buffer characters.  The first causes
| 	 * a transition to the end-of-buffer state.  The second causes
| 	 * a jam in that state.
| 	 */
| 	b->yy_ch_buf[0] =3D YY_END_OF_BUFFER_CHAR;
| 	b->yy_ch_buf[1] =3D YY_END_OF_BUFFER_CHAR;
|=20
| 	b->yy_buf_pos =3D &b->yy_ch_buf[0];
|=20
| 	b->yy_at_bol =3D 1;
| 	b->yy_buffer_status =3D YY_BUFFER_NEW;
|=20
| 	if ( b =3D=3D YY_CURRENT_BUFFER )
| 		yy_load_buffer_state( );
| }
|=20
| /** Pushes the new state onto the stack. The new state becomes
|  *  the current state. This function will allocate the stack
|  *  if necessary.
|  *  @param new_buffer The new state.
|  * =20
|  */
| void yypush_buffer_state (YY_BUFFER_STATE new_buffer )
| {
|     	if (new_buffer =3D=3D NULL)
| 		return;
|=20
| 	yyensure_buffer_stack();
|=20
| 	/* This block is copied from yy_switch_to_buffer. */
| 	if ( YY_CURRENT_BUFFER )
| 		{
| 		/* Flush out information for old buffer. */
| 		*(yy_c_buf_p) =3D (yy_hold_char);
| 		YY_CURRENT_BUFFER_LVALUE->yy_buf_pos =3D (yy_c_buf_p);
| 		YY_CURRENT_BUFFER_LVALUE->yy_n_chars =3D (yy_n_chars);
| 		}
|=20
| 	/* Only push if top exists. Otherwise, replace top. */
| 	if (YY_CURRENT_BUFFER)
| 		(yy_buffer_stack_top)++;
| 	YY_CURRENT_BUFFER_LVALUE =3D new_buffer;
|=20
| 	/* copied from yy_switch_to_buffer. */
| 	yy_load_buffer_state( );
| 	(yy_did_buffer_switch_on_eof) =3D 1;
| }
|=20
| /** Removes and deletes the top of the stack, if present.
|  *  The next element becomes the new top.
|  * =20
|  */
| void yypop_buffer_state (void)
| {
|     	if (!YY_CURRENT_BUFFER)
| 		return;
|=20
| 	yy_delete_buffer(YY_CURRENT_BUFFER );
| 	YY_CURRENT_BUFFER_LVALUE =3D NULL;
| 	if ((yy_buffer_stack_top) > 0)
| 		--(yy_buffer_stack_top);
|=20
| 	if (YY_CURRENT_BUFFER) {
| 		yy_load_buffer_state( );
| 		(yy_did_buffer_switch_on_eof) =3D 1;
| 	}
| }
|=20
| /* Allocates the stack if it does not exist.
|  *  Guarantees space for at least one push.
|  */
| static void yyensure_buffer_stack (void)
| {
| 	int num_to_alloc;
|    =20
| 	if (!(yy_buffer_stack)) {
|=20
| 		/* First allocation is just for 2 elements, since we don't know if th=
is
| 		 * scanner will even need a stack. We use 2 instead of 1 to avoid an
| 		 * immediate realloc on the next call.
|          */
| 		num_to_alloc =3D 1;
| 		(yy_buffer_stack) =3D (struct yy_buffer_state**)yyalloc
| 								(num_to_alloc * sizeof(struct yy_buffer_state*)
| 								);
| 		if ( ! (yy_buffer_stack) )
| 			YY_FATAL_ERROR( "out of dynamic memory in yyensure_buffer_stack()" )=
;
| 								 =20
| 		memset((yy_buffer_stack), 0, num_to_alloc * sizeof(struct yy_buffer_s=
tate*));
| 			=09
| 		(yy_buffer_stack_max) =3D num_to_alloc;
| 		(yy_buffer_stack_top) =3D 0;
| 		return;
| 	}
|=20
| 	if ((yy_buffer_stack_top) >=3D ((yy_buffer_stack_max)) - 1){
|=20
| 		/* Increase the buffer to prepare for a possible push. */
| 		int grow_size =3D 8 /* arbitrary grow size */;
|=20
| 		num_to_alloc =3D (yy_buffer_stack_max) + grow_size;
| 		(yy_buffer_stack) =3D (struct yy_buffer_state**)yyrealloc
| 								((yy_buffer_stack),
| 								num_to_alloc * sizeof(struct yy_buffer_state*)
| 								);
| 		if ( ! (yy_buffer_stack) )
| 			YY_FATAL_ERROR( "out of dynamic memory in yyensure_buffer_stack()" )=
;
|=20
| 		/* zero only the new slots.*/
| 		memset((yy_buffer_stack) + (yy_buffer_stack_max), 0, grow_size * size=
of(struct yy_buffer_state*));
| 		(yy_buffer_stack_max) =3D num_to_alloc;
| 	}
| }
|=20
| /** Setup the input buffer state to scan directly from a user-specified=
 character buffer.
|  * @param base the character buffer
|  * @param size the size in bytes of the character buffer
|  *=20
|  * @return the newly allocated buffer state object.=20
|  */
| YY_BUFFER_STATE yy_scan_buffer  (char * base, yy_size_t  size )
| {
| 	YY_BUFFER_STATE b;
|    =20
| 	if ( size < 2 ||
| 	     base[size-2] !=3D YY_END_OF_BUFFER_CHAR ||
| 	     base[size-1] !=3D YY_END_OF_BUFFER_CHAR )
| 		/* They forgot to leave room for the EOB's. */
| 		return 0;
|=20
| 	b =3D (YY_BUFFER_STATE) yyalloc(sizeof( struct yy_buffer_state )  );
| 	if ( ! b )
| 		YY_FATAL_ERROR( "out of dynamic memory in yy_scan_buffer()" );
|=20
| 	b->yy_buf_size =3D size - 2;	/* "- 2" to take care of EOB's */
| 	b->yy_buf_pos =3D b->yy_ch_buf =3D base;
| 	b->yy_is_our_buffer =3D 0;
| 	b->yy_input_file =3D 0;
| 	b->yy_n_chars =3D b->yy_buf_size;
| 	b->yy_is_interactive =3D 0;
| 	b->yy_at_bol =3D 1;
| 	b->yy_fill_buffer =3D 0;
| 	b->yy_buffer_status =3D YY_BUFFER_NEW;
|=20
| 	yy_switch_to_buffer(b  );
|=20
| 	return b;
| }
|=20
| /** Setup the input buffer state to scan a string. The next call to yyl=
ex() will
|  * scan from a @e copy of @a str.
|  * @param yystr a NUL-terminated string to scan
|  *=20
|  * @return the newly allocated buffer state object.
|  * @note If you want to scan bytes that may contain NUL values, then us=
e
|  *       yy_scan_bytes() instead.
|  */
| YY_BUFFER_STATE yy_scan_string (yyconst char * yystr )
| {
|    =20
| 	return yy_scan_bytes(yystr,strlen(yystr) );
| }
|=20
| /** Setup the input buffer state to scan the given bytes. The next call=
 to yylex() will
|  * scan from a @e copy of @a bytes.
|  * @param bytes the byte buffer to scan
|  * @param len the number of bytes in the buffer pointed to by @a bytes.=

|  *=20
|  * @return the newly allocated buffer state object.
|  */
| YY_BUFFER_STATE yy_scan_bytes  (yyconst char * yybytes, int  _yybytes_l=
en )
| {
| 	YY_BUFFER_STATE b;
| 	char *buf;
| 	yy_size_t n;
| 	int i;
|    =20
| 	/* Get memory for full buffer, including space for trailing EOB's. */
| 	n =3D _yybytes_len + 2;
| 	buf =3D (char *) yyalloc(n  );
| 	if ( ! buf )
| 		YY_FATAL_ERROR( "out of dynamic memory in yy_scan_bytes()" );
|=20
| 	for ( i =3D 0; i < _yybytes_len; ++i )
| 		buf[i] =3D yybytes[i];
|=20
| 	buf[_yybytes_len] =3D buf[_yybytes_len+1] =3D YY_END_OF_BUFFER_CHAR;
|=20
| 	b =3D yy_scan_buffer(buf,n );
| 	if ( ! b )
| 		YY_FATAL_ERROR( "bad buffer in yy_scan_bytes()" );
|=20
| 	/* It's okay to grow etc. this buffer, and we should throw it
| 	 * away when we're done.
| 	 */
| 	b->yy_is_our_buffer =3D 1;
|=20
| 	return b;
| }
|=20
| #ifndef YY_EXIT_FAILURE
| #define YY_EXIT_FAILURE 2
| #endif
|=20
| static void yy_fatal_error (yyconst char* msg )
| {
|     	(void) fprintf( stderr, "%s\n", msg );
| 	exit( YY_EXIT_FAILURE );
| }
|=20
| /* Redefine yyless() so it works in section 3 code. */
|=20
| #undef yyless
| #define yyless(n) \
| 	do \
| 		{ \
| 		/* Undo effects of setting up yytext. */ \
|         int yyless_macro_arg =3D (n); \
|         YY_LESS_LINENO(yyless_macro_arg);\
| 		yytext[yyleng] =3D (yy_hold_char); \
| 		(yy_c_buf_p) =3D yytext + yyless_macro_arg; \
| 		(yy_hold_char) =3D *(yy_c_buf_p); \
| 		*(yy_c_buf_p) =3D '\0'; \
| 		yyleng =3D yyless_macro_arg; \
| 		} \
| 	while ( 0 )
|=20
| /* Accessor  methods (get/set functions) to struct members. */
|=20
| /** Get the current line number.
|  *=20
|  */
| int yyget_lineno  (void)
| {
|        =20
|     return yylineno;
| }
|=20
| /** Get the input stream.
|  *=20
|  */
| FILE *yyget_in  (void)
| {
|         return yyin;
| }
|=20
| /** Get the output stream.
|  *=20
|  */
| FILE *yyget_out  (void)
| {
|         return yyout;
| }
|=20
| /** Get the length of the current token.
|  *=20
|  */
| int yyget_leng  (void)
| {
|         return yyleng;
| }
|=20
| /** Get the current token.
|  *=20
|  */
|=20
| char *yyget_text  (void)
| {
|         return yytext;
| }
|=20
| /** Set the current line number.
|  * @param line_number
|  *=20
|  */
| void yyset_lineno (int  line_number )
| {
|    =20
|     yylineno =3D line_number;
| }
|=20
| /** Set the input stream. This does not discard the current
|  * input buffer.
|  * @param in_str A readable stream.
|  *=20
|  * @see yy_switch_to_buffer
|  */
| void yyset_in (FILE *  in_str )
| {
|         yyin =3D in_str ;
| }
|=20
| void yyset_out (FILE *  out_str )
| {
|         yyout =3D out_str ;
| }
|=20
| int yyget_debug  (void)
| {
|         return yy_flex_debug;
| }
|=20
| void yyset_debug (int  bdebug )
| {
|         yy_flex_debug =3D bdebug ;
| }
|=20
| static int yy_init_globals (void)
| {
|         /* Initialization is the same as for the non-reentrant scanner.=

|      * This function is called from yylex_destroy(), so don't allocate =
here.
|      */
|=20
|     (yy_buffer_stack) =3D 0;
|     (yy_buffer_stack_top) =3D 0;
|     (yy_buffer_stack_max) =3D 0;
|     (yy_c_buf_p) =3D (char *) 0;
|     (yy_init) =3D 0;
|     (yy_start) =3D 0;
|=20
|     (yy_state_buf) =3D 0;
|     (yy_state_ptr) =3D 0;
|     (yy_full_match) =3D 0;
|     (yy_lp) =3D 0;
|=20
| /* Defined in main.c */
| #ifdef YY_STDINIT
|     yyin =3D stdin;
|     yyout =3D stdout;
| #else
|     yyin =3D (FILE *) 0;
|     yyout =3D (FILE *) 0;
| #endif
|=20
|     /* For future reference: Set errno on error, since we are called by=

|      * yylex_init()
|      */
|     return 0;
| }
|=20
| /* yylex_destroy is for both reentrant and non-reentrant scanners. */
| int yylex_destroy  (void)
| {
|    =20
|     /* Pop the buffer stack, destroying each element. */
| 	while(YY_CURRENT_BUFFER){
| 		yy_delete_buffer(YY_CURRENT_BUFFER  );
| 		YY_CURRENT_BUFFER_LVALUE =3D NULL;
| 		yypop_buffer_state();
| 	}
|=20
| 	/* Destroy the stack itself. */
| 	yyfree((yy_buffer_stack) );
| 	(yy_buffer_stack) =3D NULL;
|=20
|     yyfree ( (yy_state_buf) );
|     (yy_state_buf)  =3D NULL;
|=20
|     /* Reset the globals. This is important in a non-reentrant scanner =
so the next time
|      * yylex() is called, initialization will occur. */
|     yy_init_globals( );
|=20
|     return 0;
| }
|=20
| /*
|  * Internal utility routines.
|  */
|=20
| #ifndef yytext_ptr
| static void yy_flex_strncpy (char* s1, yyconst char * s2, int n )
| {
| 	register int i;
| 	for ( i =3D 0; i < n; ++i )
| 		s1[i] =3D s2[i];
| }
| #endif
|=20
| #ifdef YY_NEED_STRLEN
| static int yy_flex_strlen (yyconst char * s )
| {
| 	register int n;
| 	for ( n =3D 0; s[n]; ++n )
| 		;
|=20
| 	return n;
| }
| #endif
|=20
| void *yyalloc (yy_size_t  size )
| {
| 	return (void *) malloc( size );
| }
|=20
| void *yyrealloc  (void * ptr, yy_size_t  size )
| {
| 	/* The cast to (char *) in the following accommodates both
| 	 * implementations that use char* generic pointers, and those
| 	 * that use void* generic pointers.  It works with the latter
| 	 * because both ANSI C and C++ allow castless assignment from
| 	 * any pointer type to void*, and deal with argument conversions
| 	 * as though doing an assignment.
| 	 */
| 	return (void *) realloc( (char *) ptr, size );
| }
|=20
| void yyfree (void * ptr )
| {
| 	free( (char *) ptr );	/* see yyrealloc() for (char *) cast */
| }
|=20
| #define YYTABLES_NAME "yytables"
|=20
| #line 9 "conftest.l"
|=20
|=20
| #ifdef YYTEXT_POINTER
| extern char *yytext;
| #endif
| int
| main (void)
| {
|   return ! yylex () + ! yywrap ();
| }
configure:21188: result: none needed
configure:21194: checking whether yytext is a pointer
configure:21215: /home/malek/minisys/xenomai/buildroot/build_i686/staging=
_dir/usr/bin/i686-linux-uclibc-gcc -Os  -I/home/malek/minisys/xenomai/bui=
ldroot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/b=
uildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/x=
enomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xe=
nomai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpenti=
umpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 =
-o conftest    conftest.c   >&5
/tmp/cc6elDQQ.o: In function `input':
conftest.c:(.text+0xacb): undefined reference to `yywrap'
/tmp/cc6elDQQ.o: In function `yylex':
conftest.c:(.text+0xf88): undefined reference to `yywrap'
/tmp/cc6elDQQ.o: In function `main':
conftest.c:(.text+0x1065): undefined reference to `yywrap'
collect2: ld returned 1 exit status
configure:21221: $? =3D 1
configure: failed program was:
| #define YYTEXT_POINTER 1
|=20
| #line 3 "lex.yy.c"
|=20
| #define  YY_INT_ALIGNED short int
|=20
| /* A lexical scanner generated by flex */
|=20
| #define FLEX_SCANNER
| #define YY_FLEX_MAJOR_VERSION 2
| #define YY_FLEX_MINOR_VERSION 5
| #define YY_FLEX_SUBMINOR_VERSION 35
| #if YY_FLEX_SUBMINOR_VERSION > 0
| #define FLEX_BETA
| #endif
|=20
| /* First, we deal with  platform-specific or compiler-specific issues. =
*/
|=20
| /* begin standard C headers. */
| #include <stdio.h>
| #include <string.h>
| #include <errno.h>
| #include <stdlib.h>
|=20
| /* end standard C headers. */
|=20
| /* flex integer type definitions */
|=20
| #ifndef FLEXINT_H
| #define FLEXINT_H
|=20
| /* C99 systems have <inttypes.h>. Non-C99 systems may or may not. */
|=20
| #if defined (__STDC_VERSION__) && __STDC_VERSION__ >=3D 199901L
|=20
| /* C99 says to define __STDC_LIMIT_MACROS before including stdint.h,
|  * if you want the limit (max/min) macros for int types.=20
|  */
| #ifndef __STDC_LIMIT_MACROS
| #define __STDC_LIMIT_MACROS 1
| #endif
|=20
| #include <inttypes.h>
| typedef int8_t flex_int8_t;
| typedef uint8_t flex_uint8_t;
| typedef int16_t flex_int16_t;
| typedef uint16_t flex_uint16_t;
| typedef int32_t flex_int32_t;
| typedef uint32_t flex_uint32_t;
| #else
| typedef signed char flex_int8_t;
| typedef short int flex_int16_t;
| typedef int flex_int32_t;
| typedef unsigned char flex_uint8_t;=20
| typedef unsigned short int flex_uint16_t;
| typedef unsigned int flex_uint32_t;
| #endif /* ! C99 */
|=20
| /* Limits of integral types. */
| #ifndef INT8_MIN
| #define INT8_MIN               (-128)
| #endif
| #ifndef INT16_MIN
| #define INT16_MIN              (-32767-1)
| #endif
| #ifndef INT32_MIN
| #define INT32_MIN              (-2147483647-1)
| #endif
| #ifndef INT8_MAX
| #define INT8_MAX               (127)
| #endif
| #ifndef INT16_MAX
| #define INT16_MAX              (32767)
| #endif
| #ifndef INT32_MAX
| #define INT32_MAX              (2147483647)
| #endif
| #ifndef UINT8_MAX
| #define UINT8_MAX              (255U)
| #endif
| #ifndef UINT16_MAX
| #define UINT16_MAX             (65535U)
| #endif
| #ifndef UINT32_MAX
| #define UINT32_MAX             (4294967295U)
| #endif
|=20
| #endif /* ! FLEXINT_H */
|=20
| #ifdef __cplusplus
|=20
| /* The "const" storage-class-modifier is valid. */
| #define YY_USE_CONST
|=20
| #else	/* ! __cplusplus */
|=20
| /* C99 requires __STDC__ to be defined as 1. */
| #if defined (__STDC__)
|=20
| #define YY_USE_CONST
|=20
| #endif	/* defined (__STDC__) */
| #endif	/* ! __cplusplus */
|=20
| #ifdef YY_USE_CONST
| #define yyconst const
| #else
| #define yyconst
| #endif
|=20
| /* Returned upon end-of-file. */
| #define YY_NULL 0
|=20
| /* Promotes a possibly negative, possibly signed char to an unsigned
|  * integer for use as an array index.  If the signed char is negative,
|  * we want to instead treat it as an 8-bit unsigned char, hence the
|  * double cast.
|  */
| #define YY_SC_TO_UI(c) ((unsigned int) (unsigned char) c)
|=20
| /* Enter a start condition.  This macro really ought to take a paramete=
r,
|  * but we do it the disgusting crufty way forced on us by the ()-less
|  * definition of BEGIN.
|  */
| #define BEGIN (yy_start) =3D 1 + 2 *
|=20
| /* Translate the current start state into a value that can be later han=
ded
|  * to BEGIN to return to the state.  The YYSTATE alias is for lex
|  * compatibility.
|  */
| #define YY_START (((yy_start) - 1) / 2)
| #define YYSTATE YY_START
|=20
| /* Action number for EOF rule of a given start state. */
| #define YY_STATE_EOF(state) (YY_END_OF_BUFFER + state + 1)
|=20
| /* Special action meaning "start processing a new file". */
| #define YY_NEW_FILE yyrestart(yyin  )
|=20
| #define YY_END_OF_BUFFER_CHAR 0
|=20
| /* Size of default input buffer. */
| #ifndef YY_BUF_SIZE
| #define YY_BUF_SIZE 16384
| #endif
|=20
| /* The state buf must be large enough to hold one state per character i=
n the main buffer.
|  */
| #define YY_STATE_BUF_SIZE   ((YY_BUF_SIZE + 2) * sizeof(yy_state_type))=

|=20
| #ifndef YY_TYPEDEF_YY_BUFFER_STATE
| #define YY_TYPEDEF_YY_BUFFER_STATE
| typedef struct yy_buffer_state *YY_BUFFER_STATE;
| #endif
|=20
| extern int yyleng;
|=20
| extern FILE *yyin, *yyout;
|=20
| #define EOB_ACT_CONTINUE_SCAN 0
| #define EOB_ACT_END_OF_FILE 1
| #define EOB_ACT_LAST_MATCH 2
|=20
|     #define YY_LESS_LINENO(n)
|    =20
| /* Return all but the first "n" matched characters back to the input st=
ream. */
| #define yyless(n) \
| 	do \
| 		{ \
| 		/* Undo effects of setting up yytext. */ \
|         int yyless_macro_arg =3D (n); \
|         YY_LESS_LINENO(yyless_macro_arg);\
| 		*yy_cp =3D (yy_hold_char); \
| 		YY_RESTORE_YY_MORE_OFFSET \
| 		(yy_c_buf_p) =3D yy_cp =3D yy_bp + yyless_macro_arg - YY_MORE_ADJ; \
| 		YY_DO_BEFORE_ACTION; /* set up yytext again */ \
| 		} \
| 	while ( 0 )
|=20
| #define unput(c) yyunput( c, (yytext_ptr)  )
|=20
| #ifndef YY_TYPEDEF_YY_SIZE_T
| #define YY_TYPEDEF_YY_SIZE_T
| typedef size_t yy_size_t;
| #endif
|=20
| #ifndef YY_STRUCT_YY_BUFFER_STATE
| #define YY_STRUCT_YY_BUFFER_STATE
| struct yy_buffer_state
| 	{
| 	FILE *yy_input_file;
|=20
| 	char *yy_ch_buf;		/* input buffer */
| 	char *yy_buf_pos;		/* current position in input buffer */
|=20
| 	/* Size of input buffer in bytes, not including room for EOB
| 	 * characters.
| 	 */
| 	yy_size_t yy_buf_size;
|=20
| 	/* Number of characters read into yy_ch_buf, not including EOB
| 	 * characters.
| 	 */
| 	int yy_n_chars;
|=20
| 	/* Whether we "own" the buffer - i.e., we know we created it,
| 	 * and can realloc() it to grow it, and should free() it to
| 	 * delete it.
| 	 */
| 	int yy_is_our_buffer;
|=20
| 	/* Whether this is an "interactive" input source; if so, and
| 	 * if we're using stdio for input, then we want to use getc()
| 	 * instead of fread(), to make sure we stop fetching input after
| 	 * each newline.
| 	 */
| 	int yy_is_interactive;
|=20
| 	/* Whether we're considered to be at the beginning of a line.
| 	 * If so, '^' rules will be active on the next match, otherwise
| 	 * not.
| 	 */
| 	int yy_at_bol;
|=20
|     int yy_bs_lineno; /**< The line count. */
|     int yy_bs_column; /**< The column count. */
|    =20
| 	/* Whether to try to fill the input buffer when we reach the
| 	 * end of it.
| 	 */
| 	int yy_fill_buffer;
|=20
| 	int yy_buffer_status;
|=20
| #define YY_BUFFER_NEW 0
| #define YY_BUFFER_NORMAL 1
| 	/* When an EOF's been seen but there's still some text to process
| 	 * then we mark the buffer as YY_EOF_PENDING, to indicate that we
| 	 * shouldn't try reading from the input source any more.  We might
| 	 * still have a bunch of tokens to match, though, because of
| 	 * possible backing-up.
| 	 *
| 	 * When we actually see the EOF, we change the status to "new"
| 	 * (via yyrestart()), so that the user can continue scanning by
| 	 * just pointing yyin at a new input file.
| 	 */
| #define YY_BUFFER_EOF_PENDING 2
|=20
| 	};
| #endif /* !YY_STRUCT_YY_BUFFER_STATE */
|=20
| /* Stack of input buffers. */
| static size_t yy_buffer_stack_top =3D 0; /**< index of top of stack. */=

| static size_t yy_buffer_stack_max =3D 0; /**< capacity of stack. */
| static YY_BUFFER_STATE * yy_buffer_stack =3D 0; /**< Stack as an array.=
 */
|=20
| /* We provide macros for accessing buffer states in case in the
|  * future we want to put the buffer states in a more general
|  * "scanner state".
|  *
|  * Returns the top of the stack, or NULL.
|  */
| #define YY_CURRENT_BUFFER ( (yy_buffer_stack) \
|                           ? (yy_buffer_stack)[(yy_buffer_stack_top)] \
|                           : NULL)
|=20
| /* Same as previous macro, but useful when we know that the buffer stac=
k is not
|  * NULL or when we need an lvalue. For internal use only.
|  */
| #define YY_CURRENT_BUFFER_LVALUE (yy_buffer_stack)[(yy_buffer_stack_top=
)]
|=20
| /* yy_hold_char holds the character lost when yytext is formed. */
| static char yy_hold_char;
| static int yy_n_chars;		/* number of characters read into yy_ch_buf */
| int yyleng;
|=20
| /* Points to current character in buffer. */
| static char *yy_c_buf_p =3D (char *) 0;
| static int yy_init =3D 0;		/* whether we need to initialize */
| static int yy_start =3D 0;	/* start state number */
|=20
| /* Flag which is used to allow yywrap()'s to do buffer switches
|  * instead of setting up a fresh yyin.  A bit of a hack ...
|  */
| static int yy_did_buffer_switch_on_eof;
|=20
| void yyrestart (FILE *input_file  );
| void yy_switch_to_buffer (YY_BUFFER_STATE new_buffer  );
| YY_BUFFER_STATE yy_create_buffer (FILE *file,int size  );
| void yy_delete_buffer (YY_BUFFER_STATE b  );
| void yy_flush_buffer (YY_BUFFER_STATE b  );
| void yypush_buffer_state (YY_BUFFER_STATE new_buffer  );
| void yypop_buffer_state (void );
|=20
| static void yyensure_buffer_stack (void );
| static void yy_load_buffer_state (void );
| static void yy_init_buffer (YY_BUFFER_STATE b,FILE *file  );
|=20
| #define YY_FLUSH_BUFFER yy_flush_buffer(YY_CURRENT_BUFFER )
|=20
| YY_BUFFER_STATE yy_scan_buffer (char *base,yy_size_t size  );
| YY_BUFFER_STATE yy_scan_string (yyconst char *yy_str  );
| YY_BUFFER_STATE yy_scan_bytes (yyconst char *bytes,int len  );
|=20
| void *yyalloc (yy_size_t  );
| void *yyrealloc (void *,yy_size_t  );
| void yyfree (void *  );
|=20
| #define yy_new_buffer yy_create_buffer
|=20
| #define yy_set_interactive(is_interactive) \
| 	{ \
| 	if ( ! YY_CURRENT_BUFFER ){ \
|         yyensure_buffer_stack (); \
| 		YY_CURRENT_BUFFER_LVALUE =3D    \
|             yy_create_buffer(yyin,YY_BUF_SIZE ); \
| 	} \
| 	YY_CURRENT_BUFFER_LVALUE->yy_is_interactive =3D is_interactive; \
| 	}
|=20
| #define yy_set_bol(at_bol) \
| 	{ \
| 	if ( ! YY_CURRENT_BUFFER ){\
|         yyensure_buffer_stack (); \
| 		YY_CURRENT_BUFFER_LVALUE =3D    \
|             yy_create_buffer(yyin,YY_BUF_SIZE ); \
| 	} \
| 	YY_CURRENT_BUFFER_LVALUE->yy_at_bol =3D at_bol; \
| 	}
|=20
| #define YY_AT_BOL() (YY_CURRENT_BUFFER_LVALUE->yy_at_bol)
|=20
| /* Begin user sect3 */
|=20
| typedef unsigned char YY_CHAR;
|=20
| FILE *yyin =3D (FILE *) 0, *yyout =3D (FILE *) 0;
|=20
| typedef int yy_state_type;
|=20
| extern int yylineno;
|=20
| int yylineno =3D 1;
|=20
| extern char *yytext;
| #define yytext_ptr yytext
|=20
| static yy_state_type yy_get_previous_state (void );
| static yy_state_type yy_try_NUL_trans (yy_state_type current_state  );
| static int yy_get_next_buffer (void );
| static void yy_fatal_error (yyconst char msg[]  );
|=20
| /* Done after the current pattern has been matched and before the
|  * corresponding action - sets up yytext.
|  */
| #define YY_DO_BEFORE_ACTION \
| 	(yytext_ptr) =3D yy_bp; \
| 	(yytext_ptr) -=3D (yy_more_len); \
| 	yyleng =3D (size_t) (yy_cp - (yytext_ptr)); \
| 	(yy_hold_char) =3D *yy_cp; \
| 	*yy_cp =3D '\0'; \
| 	(yy_c_buf_p) =3D yy_cp;
|=20
| #define YY_NUM_RULES 8
| #define YY_END_OF_BUFFER 9
| /* This struct is not used in this scanner,
|    but its presence is necessary. */
| struct yy_trans_info
| 	{
| 	flex_int32_t yy_verify;
| 	flex_int32_t yy_nxt;
| 	};
| static yyconst flex_int16_t yy_acclist[23] =3D
|     {   0,
|         9,    7,    8,    8,    1,    7,    8,    2,    7,    8,
|         3,    7,    8,    4,    7,    8,    5,    7,    8,    6,
|         7,    8
|     } ;
|=20
| static yyconst flex_int16_t yy_accept[14] =3D
|     {   0,
|         1,    1,    1,    2,    4,    5,    8,   11,   14,   17,
|        20,   23,   23
|     } ;
|=20
| static yyconst flex_int32_t yy_ec[256] =3D
|     {   0,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    2,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    3,    4,    5,    6,
|=20
|         7,    8,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|=20
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
|         1,    1,    1,    1,    1
|     } ;
|=20
| static yyconst flex_int32_t yy_meta[9] =3D
|     {   0,
|         1,    1,    1,    1,    1,    1,    1,    1
|     } ;
|=20
| static yyconst flex_int16_t yy_base[13] =3D
|     {   0,
|         0,    0,    9,   10,   10,   10,   10,   10,   10,   10,
|        10,   10
|     } ;
|=20
| static yyconst flex_int16_t yy_def[13] =3D
|     {   0,
|        12,    1,   12,   12,   12,   12,   12,   12,   12,   12,
|        12,    0
|     } ;
|=20
| static yyconst flex_int16_t yy_nxt[19] =3D
|     {   0,
|         4,    5,    6,    7,    8,    9,   10,   11,   12,    3,
|        12,   12,   12,   12,   12,   12,   12,   12
|     } ;
|=20
| static yyconst flex_int16_t yy_chk[19] =3D
|     {   0,
|         1,    1,    1,    1,    1,    1,    1,    1,    3,   12,
|        12,   12,   12,   12,   12,   12,   12,   12
|     } ;
|=20
| extern int yy_flex_debug;
| int yy_flex_debug =3D 0;
|=20
| static yy_state_type *yy_state_buf=3D0, *yy_state_ptr=3D0;
| static char *yy_full_match;
| static int yy_lp;
| #define REJECT \
| { \
| *yy_cp =3D (yy_hold_char); /* undo effects of setting up yytext */ \
| yy_cp =3D (yy_full_match); /* restore poss. backed-over text */ \
| ++(yy_lp); \
| goto find_rule; \
| }
|=20
| static int yy_more_flag =3D 0;
| static int yy_more_len =3D 0;
| #define yymore() ((yy_more_flag) =3D 1)
| #define YY_MORE_ADJ (yy_more_len)
| #define YY_RESTORE_YY_MORE_OFFSET
| char *yytext;
| #line 1 "conftest.l"
| #line 468 "lex.yy.c"
|=20
| #define INITIAL 0
|=20
| #ifndef YY_NO_UNISTD_H
| /* Special case for "unistd.h", since it is non-ANSI. We include it way=

|  * down here because we want the user's section 1 to have been scanned =
first.
|  * The user has a chance to override it with an option.
|  */
| #include <unistd.h>
| #endif
|=20
| #ifndef YY_EXTRA_TYPE
| #define YY_EXTRA_TYPE void *
| #endif
|=20
| static int yy_init_globals (void );
|=20
| /* Accessor methods to globals.
|    These are made visible to non-reentrant scanners for convenience. */=

|=20
| int yylex_destroy (void );
|=20
| int yyget_debug (void );
|=20
| void yyset_debug (int debug_flag  );
|=20
| YY_EXTRA_TYPE yyget_extra (void );
|=20
| void yyset_extra (YY_EXTRA_TYPE user_defined  );
|=20
| FILE *yyget_in (void );
|=20
| void yyset_in  (FILE * in_str  );
|=20
| FILE *yyget_out (void );
|=20
| void yyset_out  (FILE * out_str  );
|=20
| int yyget_leng (void );
|=20
| char *yyget_text (void );
|=20
| int yyget_lineno (void );
|=20
| void yyset_lineno (int line_number  );
|=20
| /* Macros after this point can all be overridden by user definitions in=

|  * section 1.
|  */
|=20
| #ifndef YY_SKIP_YYWRAP
| #ifdef __cplusplus
| extern "C" int yywrap (void );
| #else
| extern int yywrap (void );
| #endif
| #endif
|=20
|     static void yyunput (int c,char *buf_ptr  );
|    =20
| #ifndef yytext_ptr
| static void yy_flex_strncpy (char *,yyconst char *,int );
| #endif
|=20
| #ifdef YY_NEED_STRLEN
| static int yy_flex_strlen (yyconst char * );
| #endif
|=20
| #ifndef YY_NO_INPUT
|=20
| #ifdef __cplusplus
| static int yyinput (void );
| #else
| static int input (void );
| #endif
|=20
| #endif
|=20
| /* Amount of stuff to slurp up with each read. */
| #ifndef YY_READ_BUF_SIZE
| #define YY_READ_BUF_SIZE 8192
| #endif
|=20
| /* Copy whatever the last rule matched to the standard output. */
| #ifndef ECHO
| /* This used to be an fputs(), but since the string might contain NUL's=
,
|  * we now use fwrite().
|  */
| #define ECHO fwrite( yytext, yyleng, 1, yyout )
| #endif
|=20
| /* Gets input and stuffs it into "buf".  number of characters read, or =
YY_NULL,
|  * is returned in "result".
|  */
| #ifndef YY_INPUT
| #define YY_INPUT(buf,result,max_size) \
| 	if ( YY_CURRENT_BUFFER_LVALUE->yy_is_interactive ) \
| 		{ \
| 		int c =3D '*'; \
| 		unsigned n; \
| 		for ( n =3D 0; n < max_size && \
| 			     (c =3D getc( yyin )) !=3D EOF && c !=3D '\n'; ++n ) \
| 			buf[n] =3D (char) c; \
| 		if ( c =3D=3D '\n' ) \
| 			buf[n++] =3D (char) c; \
| 		if ( c =3D=3D EOF && ferror( yyin ) ) \
| 			YY_FATAL_ERROR( "input in flex scanner failed" ); \
| 		result =3D n; \
| 		} \
| 	else \
| 		{ \
| 		errno=3D0; \
| 		while ( (result =3D fread(buf, 1, max_size, yyin))=3D=3D0 && ferror(y=
yin)) \
| 			{ \
| 			if( errno !=3D EINTR) \
| 				{ \
| 				YY_FATAL_ERROR( "input in flex scanner failed" ); \
| 				break; \
| 				} \
| 			errno=3D0; \
| 			clearerr(yyin); \
| 			} \
| 		}\
| \
|=20
| #endif
|=20
| /* No semi-colon after return; correct usage is to write "yyterminate()=
;" -
|  * we don't want an extra ';' after the "return" because that will caus=
e
|  * some compilers to complain about unreachable statements.
|  */
| #ifndef yyterminate
| #define yyterminate() return YY_NULL
| #endif
|=20
| /* Number of entries by which start-condition stack grows. */
| #ifndef YY_START_STACK_INCR
| #define YY_START_STACK_INCR 25
| #endif
|=20
| /* Report a fatal error. */
| #ifndef YY_FATAL_ERROR
| #define YY_FATAL_ERROR(msg) yy_fatal_error( msg )
| #endif
|=20
| /* end tables serialization structures and prototypes */
|=20
| /* Default declaration of generated scanner - a define so the user can
|  * easily add parameters.
|  */
| #ifndef YY_DECL
| #define YY_DECL_IS_OURS 1
|=20
| extern int yylex (void);
|=20
| #define YY_DECL int yylex (void)
| #endif /* !YY_DECL */
|=20
| /* Code executed at the beginning of each rule, after yytext and yyleng=

|  * have been set up.
|  */
| #ifndef YY_USER_ACTION
| #define YY_USER_ACTION
| #endif
|=20
| /* Code executed at the end of each rule. */
| #ifndef YY_BREAK
| #define YY_BREAK break;
| #endif
|=20
| #define YY_RULE_SETUP \
| 	YY_USER_ACTION
|=20
| /** The main scanner function which does all the work.
|  */
| YY_DECL
| {
| 	register yy_state_type yy_current_state;
| 	register char *yy_cp, *yy_bp;
| 	register int yy_act;
|    =20
| #line 1 "conftest.l"
|=20
| #line 652 "lex.yy.c"
|=20
| 	if ( !(yy_init) )
| 		{
| 		(yy_init) =3D 1;
|=20
| #ifdef YY_USER_INIT
| 		YY_USER_INIT;
| #endif
|=20
|         /* Create the reject buffer large enough to save one state per =
allowed character. */
|         if ( ! (yy_state_buf) )
|             (yy_state_buf) =3D (yy_state_type *)yyalloc(YY_STATE_BUF_SI=
ZE  );
|             if ( ! (yy_state_buf) )
|                 YY_FATAL_ERROR( "out of dynamic memory in yylex()" );
|=20
| 		if ( ! (yy_start) )
| 			(yy_start) =3D 1;	/* first start state */
|=20
| 		if ( ! yyin )
| 			yyin =3D stdin;
|=20
| 		if ( ! yyout )
| 			yyout =3D stdout;
|=20
| 		if ( ! YY_CURRENT_BUFFER ) {
| 			yyensure_buffer_stack ();
| 			YY_CURRENT_BUFFER_LVALUE =3D
| 				yy_create_buffer(yyin,YY_BUF_SIZE );
| 		}
|=20
| 		yy_load_buffer_state( );
| 		}
|=20
| 	while ( 1 )		/* loops until end-of-file is reached */
| 		{
| 		(yy_more_len) =3D 0;
| 		if ( (yy_more_flag) )
| 			{
| 			(yy_more_len) =3D (yy_c_buf_p) - (yytext_ptr);
| 			(yy_more_flag) =3D 0;
| 			}
| 		yy_cp =3D (yy_c_buf_p);
|=20
| 		/* Support of yytext. */
| 		*yy_cp =3D (yy_hold_char);
|=20
| 		/* yy_bp points to the position in yy_ch_buf of the start of
| 		 * the current run.
| 		 */
| 		yy_bp =3D yy_cp;
|=20
| 		yy_current_state =3D (yy_start);
|=20
| 		(yy_state_ptr) =3D (yy_state_buf);
| 		*(yy_state_ptr)++ =3D yy_current_state;
|=20
| yy_match:
| 		do
| 			{
| 			register YY_CHAR yy_c =3D yy_ec[YY_SC_TO_UI(*yy_cp)];
| 			while ( yy_chk[yy_base[yy_current_state] + yy_c] !=3D yy_current_sta=
te )
| 				{
| 				yy_current_state =3D (int) yy_def[yy_current_state];
| 				if ( yy_current_state >=3D 13 )
| 					yy_c =3D yy_meta[(unsigned int) yy_c];
| 				}
| 			yy_current_state =3D yy_nxt[yy_base[yy_current_state] + (unsigned in=
t) yy_c];
| 			*(yy_state_ptr)++ =3D yy_current_state;
| 			++yy_cp;
| 			}
| 		while ( yy_base[yy_current_state] !=3D 10 );
|=20
| yy_find_action:
| 		yy_current_state =3D *--(yy_state_ptr);
| 		(yy_lp) =3D yy_accept[yy_current_state];
| find_rule: /* we branch to this label when backing up */
| 		for ( ; ; ) /* until we find what rule we matched */
| 			{
| 			if ( (yy_lp) && (yy_lp) < yy_accept[yy_current_state + 1] )
| 				{
| 				yy_act =3D yy_acclist[(yy_lp)];
| 					{
| 					(yy_full_match) =3D yy_cp;
| 					break;
| 					}
| 				}
| 			--yy_cp;
| 			yy_current_state =3D *--(yy_state_ptr);
| 			(yy_lp) =3D yy_accept[yy_current_state];
| 			}
|=20
| 		YY_DO_BEFORE_ACTION;
|=20
| do_action:	/* This label is used only to access EOF actions. */
|=20
| 		switch ( yy_act )
| 	{ /* beginning of action switch */
| case 1:
| YY_RULE_SETUP
| #line 2 "conftest.l"
| { ECHO; }
| 	YY_BREAK
| case 2:
| YY_RULE_SETUP
| #line 3 "conftest.l"
| { REJECT; }
| 	YY_BREAK
| case 3:
| YY_RULE_SETUP
| #line 4 "conftest.l"
| { yymore (); }
| 	YY_BREAK
| case 4:
| YY_RULE_SETUP
| #line 5 "conftest.l"
| { yyless (1); }
| 	YY_BREAK
| case 5:
| YY_RULE_SETUP
| #line 6 "conftest.l"
| { yyless (input () !=3D 0); }
| 	YY_BREAK
| case 6:
| YY_RULE_SETUP
| #line 7 "conftest.l"
| { unput (yytext[0]); }
| 	YY_BREAK
| case 7:
| YY_RULE_SETUP
| #line 8 "conftest.l"
| { BEGIN INITIAL; }
| 	YY_BREAK
| case 8:
| YY_RULE_SETUP
| #line 9 "conftest.l"
| ECHO;
| 	YY_BREAK
| #line 790 "lex.yy.c"
| 			case YY_STATE_EOF(INITIAL):
| 				yyterminate();
|=20
| 	case YY_END_OF_BUFFER:
| 		{
| 		/* Amount of text matched not including the EOB char. */
| 		int yy_amount_of_matched_text =3D (int) (yy_cp - (yytext_ptr)) - 1;
|=20
| 		/* Undo the effects of YY_DO_BEFORE_ACTION. */
| 		*yy_cp =3D (yy_hold_char);
| 		YY_RESTORE_YY_MORE_OFFSET
|=20
| 		if ( YY_CURRENT_BUFFER_LVALUE->yy_buffer_status =3D=3D YY_BUFFER_NEW =
)
| 			{
| 			/* We're scanning a new file or input source.  It's
| 			 * possible that this happened because the user
| 			 * just pointed yyin at a new source and called
| 			 * yylex().  If so, then we have to assure
| 			 * consistency between YY_CURRENT_BUFFER and our
| 			 * globals.  Here is the right place to do so, because
| 			 * this is the first action (other than possibly a
| 			 * back-up) that will match for the new input source.
| 			 */
| 			(yy_n_chars) =3D YY_CURRENT_BUFFER_LVALUE->yy_n_chars;
| 			YY_CURRENT_BUFFER_LVALUE->yy_input_file =3D yyin;
| 			YY_CURRENT_BUFFER_LVALUE->yy_buffer_status =3D YY_BUFFER_NORMAL;
| 			}
|=20
| 		/* Note that here we test for yy_c_buf_p "<=3D" to the position
| 		 * of the first EOB in the buffer, since yy_c_buf_p will
| 		 * already have been incremented past the NUL character
| 		 * (since all states make transitions on EOB to the
| 		 * end-of-buffer state).  Contrast this with the test
| 		 * in input().
| 		 */
| 		if ( (yy_c_buf_p) <=3D &YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[(yy_n_cha=
rs)] )
| 			{ /* This was really a NUL. */
| 			yy_state_type yy_next_state;
|=20
| 			(yy_c_buf_p) =3D (yytext_ptr) + yy_amount_of_matched_text;
|=20
| 			yy_current_state =3D yy_get_previous_state(  );
|=20
| 			/* Okay, we're now positioned to make the NUL
| 			 * transition.  We couldn't have
| 			 * yy_get_previous_state() go ahead and do it
| 			 * for us because it doesn't know how to deal
| 			 * with the possibility of jamming (and we don't
| 			 * want to build jamming into it because then it
| 			 * will run more slowly).
| 			 */
|=20
| 			yy_next_state =3D yy_try_NUL_trans( yy_current_state );
|=20
| 			yy_bp =3D (yytext_ptr) + YY_MORE_ADJ;
|=20
| 			if ( yy_next_state )
| 				{
| 				/* Consume the NUL. */
| 				yy_cp =3D ++(yy_c_buf_p);
| 				yy_current_state =3D yy_next_state;
| 				goto yy_match;
| 				}
|=20
| 			else
| 				{
| 				yy_cp =3D (yy_c_buf_p);
| 				goto yy_find_action;
| 				}
| 			}
|=20
| 		else switch ( yy_get_next_buffer(  ) )
| 			{
| 			case EOB_ACT_END_OF_FILE:
| 				{
| 				(yy_did_buffer_switch_on_eof) =3D 0;
|=20
| 				if ( yywrap( ) )
| 					{
| 					/* Note: because we've taken care in
| 					 * yy_get_next_buffer() to have set up
| 					 * yytext, we can now set up
| 					 * yy_c_buf_p so that if some total
| 					 * hoser (like flex itself) wants to
| 					 * call the scanner after we return the
| 					 * YY_NULL, it'll still work - another
| 					 * YY_NULL will get returned.
| 					 */
| 					(yy_c_buf_p) =3D (yytext_ptr) + YY_MORE_ADJ;
|=20
| 					yy_act =3D YY_STATE_EOF(YY_START);
| 					goto do_action;
| 					}
|=20
| 				else
| 					{
| 					if ( ! (yy_did_buffer_switch_on_eof) )
| 						YY_NEW_FILE;
| 					}
| 				break;
| 				}
|=20
| 			case EOB_ACT_CONTINUE_SCAN:
| 				(yy_c_buf_p) =3D
| 					(yytext_ptr) + yy_amount_of_matched_text;
|=20
| 				yy_current_state =3D yy_get_previous_state(  );
|=20
| 				yy_cp =3D (yy_c_buf_p);
| 				yy_bp =3D (yytext_ptr) + YY_MORE_ADJ;
| 				goto yy_match;
|=20
| 			case EOB_ACT_LAST_MATCH:
| 				(yy_c_buf_p) =3D
| 				&YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[(yy_n_chars)];
|=20
| 				yy_current_state =3D yy_get_previous_state(  );
|=20
| 				yy_cp =3D (yy_c_buf_p);
| 				yy_bp =3D (yytext_ptr) + YY_MORE_ADJ;
| 				goto yy_find_action;
| 			}
| 		break;
| 		}
|=20
| 	default:
| 		YY_FATAL_ERROR(
| 			"fatal flex scanner internal error--no action found" );
| 	} /* end of action switch */
| 		} /* end of scanning one token */
| } /* end of yylex */
|=20
| /* yy_get_next_buffer - try to read in a new buffer
|  *
|  * Returns a code representing an action:
|  *	EOB_ACT_LAST_MATCH -
|  *	EOB_ACT_CONTINUE_SCAN - continue scanning from current position
|  *	EOB_ACT_END_OF_FILE - end of file
|  */
| static int yy_get_next_buffer (void)
| {
|     	register char *dest =3D YY_CURRENT_BUFFER_LVALUE->yy_ch_buf;
| 	register char *source =3D (yytext_ptr);
| 	register int number_to_move, i;
| 	int ret_val;
|=20
| 	if ( (yy_c_buf_p) > &YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[(yy_n_chars) =
+ 1] )
| 		YY_FATAL_ERROR(
| 		"fatal flex scanner internal error--end of buffer missed" );
|=20
| 	if ( YY_CURRENT_BUFFER_LVALUE->yy_fill_buffer =3D=3D 0 )
| 		{ /* Don't try to fill the buffer, so this is an EOF. */
| 		if ( (yy_c_buf_p) - (yytext_ptr) - YY_MORE_ADJ =3D=3D 1 )
| 			{
| 			/* We matched a single character, the EOB, so
| 			 * treat this as a final EOF.
| 			 */
| 			return EOB_ACT_END_OF_FILE;
| 			}
|=20
| 		else
| 			{
| 			/* We matched some text prior to the EOB, first
| 			 * process it.
| 			 */
| 			return EOB_ACT_LAST_MATCH;
| 			}
| 		}
|=20
| 	/* Try to read more data. */
|=20
| 	/* First move last chars to start of buffer. */
| 	number_to_move =3D (int) ((yy_c_buf_p) - (yytext_ptr)) - 1;
|=20
| 	for ( i =3D 0; i < number_to_move; ++i )
| 		*(dest++) =3D *(source++);
|=20
| 	if ( YY_CURRENT_BUFFER_LVALUE->yy_buffer_status =3D=3D YY_BUFFER_EOF_P=
ENDING )
| 		/* don't do the read, it's not guaranteed to return an EOF,
| 		 * just force an EOF
| 		 */
| 		YY_CURRENT_BUFFER_LVALUE->yy_n_chars =3D (yy_n_chars) =3D 0;
|=20
| 	else
| 		{
| 			int num_to_read =3D
| 			YY_CURRENT_BUFFER_LVALUE->yy_buf_size - number_to_move - 1;
|=20
| 		while ( num_to_read <=3D 0 )
| 			{ /* Not enough room in the buffer - grow it. */
|=20
| 			YY_FATAL_ERROR(
| "input buffer overflow, can't enlarge buffer because scanner uses REJEC=
T" );
|=20
| 			}
|=20
| 		if ( num_to_read > YY_READ_BUF_SIZE )
| 			num_to_read =3D YY_READ_BUF_SIZE;
|=20
| 		/* Read in more data. */
| 		YY_INPUT( (&YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[number_to_move]),
| 			(yy_n_chars), (size_t) num_to_read );
|=20
| 		YY_CURRENT_BUFFER_LVALUE->yy_n_chars =3D (yy_n_chars);
| 		}
|=20
| 	if ( (yy_n_chars) =3D=3D 0 )
| 		{
| 		if ( number_to_move =3D=3D YY_MORE_ADJ )
| 			{
| 			ret_val =3D EOB_ACT_END_OF_FILE;
| 			yyrestart(yyin  );
| 			}
|=20
| 		else
| 			{
| 			ret_val =3D EOB_ACT_LAST_MATCH;
| 			YY_CURRENT_BUFFER_LVALUE->yy_buffer_status =3D
| 				YY_BUFFER_EOF_PENDING;
| 			}
| 		}
|=20
| 	else
| 		ret_val =3D EOB_ACT_CONTINUE_SCAN;
|=20
| 	if ((yy_size_t) ((yy_n_chars) + number_to_move) > YY_CURRENT_BUFFER_LV=
ALUE->yy_buf_size) {
| 		/* Extend the array by 50%, plus the number we really need. */
| 		yy_size_t new_size =3D (yy_n_chars) + number_to_move + ((yy_n_chars) =
>> 1);
| 		YY_CURRENT_BUFFER_LVALUE->yy_ch_buf =3D (char *) yyrealloc((void *) Y=
Y_CURRENT_BUFFER_LVALUE->yy_ch_buf,new_size  );
| 		if ( ! YY_CURRENT_BUFFER_LVALUE->yy_ch_buf )
| 			YY_FATAL_ERROR( "out of dynamic memory in yy_get_next_buffer()" );
| 	}
|=20
| 	(yy_n_chars) +=3D number_to_move;
| 	YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[(yy_n_chars)] =3D YY_END_OF_BUFFER=
_CHAR;
| 	YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[(yy_n_chars) + 1] =3D YY_END_OF_BU=
FFER_CHAR;
|=20
| 	(yytext_ptr) =3D &YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[0];
|=20
| 	return ret_val;
| }
|=20
| /* yy_get_previous_state - get the state just before the EOB char was r=
eached */
|=20
|     static yy_state_type yy_get_previous_state (void)
| {
| 	register yy_state_type yy_current_state;
| 	register char *yy_cp;
|    =20
| 	yy_current_state =3D (yy_start);
|=20
| 	(yy_state_ptr) =3D (yy_state_buf);
| 	*(yy_state_ptr)++ =3D yy_current_state;
|=20
| 	for ( yy_cp =3D (yytext_ptr) + YY_MORE_ADJ; yy_cp < (yy_c_buf_p); ++yy=
_cp )
| 		{
| 		register YY_CHAR yy_c =3D (*yy_cp ? yy_ec[YY_SC_TO_UI(*yy_cp)] : 1);
| 		while ( yy_chk[yy_base[yy_current_state] + yy_c] !=3D yy_current_stat=
e )
| 			{
| 			yy_current_state =3D (int) yy_def[yy_current_state];
| 			if ( yy_current_state >=3D 13 )
| 				yy_c =3D yy_meta[(unsigned int) yy_c];
| 			}
| 		yy_current_state =3D yy_nxt[yy_base[yy_current_state] + (unsigned int=
) yy_c];
| 		*(yy_state_ptr)++ =3D yy_current_state;
| 		}
|=20
| 	return yy_current_state;
| }
|=20
| /* yy_try_NUL_trans - try to make a transition on the NUL character
|  *
|  * synopsis
|  *	next_state =3D yy_try_NUL_trans( current_state );
|  */
|     static yy_state_type yy_try_NUL_trans  (yy_state_type yy_current_st=
ate )
| {
| 	register int yy_is_jam;
|    =20
| 	register YY_CHAR yy_c =3D 1;
| 	while ( yy_chk[yy_base[yy_current_state] + yy_c] !=3D yy_current_state=
 )
| 		{
| 		yy_current_state =3D (int) yy_def[yy_current_state];
| 		if ( yy_current_state >=3D 13 )
| 			yy_c =3D yy_meta[(unsigned int) yy_c];
| 		}
| 	yy_current_state =3D yy_nxt[yy_base[yy_current_state] + (unsigned int)=
 yy_c];
| 	yy_is_jam =3D (yy_current_state =3D=3D 12);
| 	if ( ! yy_is_jam )
| 		*(yy_state_ptr)++ =3D yy_current_state;
|=20
| 	return yy_is_jam ? 0 : yy_current_state;
| }
|=20
|     static void yyunput (int c, register char * yy_bp )
| {
| 	register char *yy_cp;
|    =20
|     yy_cp =3D (yy_c_buf_p);
|=20
| 	/* undo effects of setting up yytext */
| 	*yy_cp =3D (yy_hold_char);
|=20
| 	if ( yy_cp < YY_CURRENT_BUFFER_LVALUE->yy_ch_buf + 2 )
| 		{ /* need to shift things up to make room */
| 		/* +2 for EOB chars. */
| 		register int number_to_move =3D (yy_n_chars) + 2;
| 		register char *dest =3D &YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[
| 					YY_CURRENT_BUFFER_LVALUE->yy_buf_size + 2];
| 		register char *source =3D
| 				&YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[number_to_move];
|=20
| 		while ( source > YY_CURRENT_BUFFER_LVALUE->yy_ch_buf )
| 			*--dest =3D *--source;
|=20
| 		yy_cp +=3D (int) (dest - source);
| 		yy_bp +=3D (int) (dest - source);
| 		YY_CURRENT_BUFFER_LVALUE->yy_n_chars =3D
| 			(yy_n_chars) =3D YY_CURRENT_BUFFER_LVALUE->yy_buf_size;
|=20
| 		if ( yy_cp < YY_CURRENT_BUFFER_LVALUE->yy_ch_buf + 2 )
| 			YY_FATAL_ERROR( "flex scanner push-back overflow" );
| 		}
|=20
| 	*--yy_cp =3D (char) c;
|=20
| 	(yytext_ptr) =3D yy_bp;
| 	(yy_hold_char) =3D *yy_cp;
| 	(yy_c_buf_p) =3D yy_cp;
| }
|=20
| #ifndef YY_NO_INPUT
| #ifdef __cplusplus
|     static int yyinput (void)
| #else
|     static int input  (void)
| #endif
|=20
| {
| 	int c;
|    =20
| 	*(yy_c_buf_p) =3D (yy_hold_char);
|=20
| 	if ( *(yy_c_buf_p) =3D=3D YY_END_OF_BUFFER_CHAR )
| 		{
| 		/* yy_c_buf_p now points to the character we want to return.
| 		 * If this occurs *before* the EOB characters, then it's a
| 		 * valid NUL; if not, then we've hit the end of the buffer.
| 		 */
| 		if ( (yy_c_buf_p) < &YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[(yy_n_chars)=
] )
| 			/* This was really a NUL. */
| 			*(yy_c_buf_p) =3D '\0';
|=20
| 		else
| 			{ /* need more input */
| 			int offset =3D (yy_c_buf_p) - (yytext_ptr);
| 			++(yy_c_buf_p);
|=20
| 			switch ( yy_get_next_buffer(  ) )
| 				{
| 				case EOB_ACT_LAST_MATCH:
| 					/* This happens because yy_g_n_b()
| 					 * sees that we've accumulated a
| 					 * token and flags that we need to
| 					 * try matching the token before
| 					 * proceeding.  But for input(),
| 					 * there's no matching to consider.
| 					 * So convert the EOB_ACT_LAST_MATCH
| 					 * to EOB_ACT_END_OF_FILE.
| 					 */
|=20
| 					/* Reset buffer status. */
| 					yyrestart(yyin );
|=20
| 					/*FALLTHROUGH*/
|=20
| 				case EOB_ACT_END_OF_FILE:
| 					{
| 					if ( yywrap( ) )
| 						return EOF;
|=20
| 					if ( ! (yy_did_buffer_switch_on_eof) )
| 						YY_NEW_FILE;
| #ifdef __cplusplus
| 					return yyinput();
| #else
| 					return input();
| #endif
| 					}
|=20
| 				case EOB_ACT_CONTINUE_SCAN:
| 					(yy_c_buf_p) =3D (yytext_ptr) + offset;
| 					break;
| 				}
| 			}
| 		}
|=20
| 	c =3D *(unsigned char *) (yy_c_buf_p);	/* cast for 8-bit char's */
| 	*(yy_c_buf_p) =3D '\0';	/* preserve yytext */
| 	(yy_hold_char) =3D *++(yy_c_buf_p);
|=20
| 	return c;
| }
| #endif	/* ifndef YY_NO_INPUT */
|=20
| /** Immediately switch to a different input stream.
|  * @param input_file A readable stream.
|  *=20
|  * @note This function does not reset the start condition to @c INITIAL=
 .
|  */
|     void yyrestart  (FILE * input_file )
| {
|    =20
| 	if ( ! YY_CURRENT_BUFFER ){
|         yyensure_buffer_stack ();
| 		YY_CURRENT_BUFFER_LVALUE =3D
|             yy_create_buffer(yyin,YY_BUF_SIZE );
| 	}
|=20
| 	yy_init_buffer(YY_CURRENT_BUFFER,input_file );
| 	yy_load_buffer_state( );
| }
|=20
| /** Switch to a different input buffer.
|  * @param new_buffer The new input buffer.
|  *=20
|  */
|     void yy_switch_to_buffer  (YY_BUFFER_STATE  new_buffer )
| {
|    =20
| 	/* TODO. We should be able to replace this entire function body
| 	 * with
| 	 *		yypop_buffer_state();
| 	 *		yypush_buffer_state(new_buffer);
|      */
| 	yyensure_buffer_stack ();
| 	if ( YY_CURRENT_BUFFER =3D=3D new_buffer )
| 		return;
|=20
| 	if ( YY_CURRENT_BUFFER )
| 		{
| 		/* Flush out information for old buffer. */
| 		*(yy_c_buf_p) =3D (yy_hold_char);
| 		YY_CURRENT_BUFFER_LVALUE->yy_buf_pos =3D (yy_c_buf_p);
| 		YY_CURRENT_BUFFER_LVALUE->yy_n_chars =3D (yy_n_chars);
| 		}
|=20
| 	YY_CURRENT_BUFFER_LVALUE =3D new_buffer;
| 	yy_load_buffer_state( );
|=20
| 	/* We don't actually know whether we did this switch during
| 	 * EOF (yywrap()) processing, but the only time this flag
| 	 * is looked at is after yywrap() is called, so it's safe
| 	 * to go ahead and always set it.
| 	 */
| 	(yy_did_buffer_switch_on_eof) =3D 1;
| }
|=20
| static void yy_load_buffer_state  (void)
| {
|     	(yy_n_chars) =3D YY_CURRENT_BUFFER_LVALUE->yy_n_chars;
| 	(yytext_ptr) =3D (yy_c_buf_p) =3D YY_CURRENT_BUFFER_LVALUE->yy_buf_pos=
;
| 	yyin =3D YY_CURRENT_BUFFER_LVALUE->yy_input_file;
| 	(yy_hold_char) =3D *(yy_c_buf_p);
| }
|=20
| /** Allocate and initialize an input buffer state.
|  * @param file A readable stream.
|  * @param size The character buffer size in bytes. When in doubt, use @=
c YY_BUF_SIZE.
|  *=20
|  * @return the allocated buffer state.
|  */
|     YY_BUFFER_STATE yy_create_buffer  (FILE * file, int  size )
| {
| 	YY_BUFFER_STATE b;
|    =20
| 	b =3D (YY_BUFFER_STATE) yyalloc(sizeof( struct yy_buffer_state )  );
| 	if ( ! b )
| 		YY_FATAL_ERROR( "out of dynamic memory in yy_create_buffer()" );
|=20
| 	b->yy_buf_size =3D size;
|=20
| 	/* yy_ch_buf has to be 2 characters longer than the size given because=

| 	 * we need to put in 2 end-of-buffer characters.
| 	 */
| 	b->yy_ch_buf =3D (char *) yyalloc(b->yy_buf_size + 2  );
| 	if ( ! b->yy_ch_buf )
| 		YY_FATAL_ERROR( "out of dynamic memory in yy_create_buffer()" );
|=20
| 	b->yy_is_our_buffer =3D 1;
|=20
| 	yy_init_buffer(b,file );
|=20
| 	return b;
| }
|=20
| /** Destroy the buffer.
|  * @param b a buffer created with yy_create_buffer()
|  *=20
|  */
|     void yy_delete_buffer (YY_BUFFER_STATE  b )
| {
|    =20
| 	if ( ! b )
| 		return;
|=20
| 	if ( b =3D=3D YY_CURRENT_BUFFER ) /* Not sure if we should pop here. *=
/
| 		YY_CURRENT_BUFFER_LVALUE =3D (YY_BUFFER_STATE) 0;
|=20
| 	if ( b->yy_is_our_buffer )
| 		yyfree((void *) b->yy_ch_buf  );
|=20
| 	yyfree((void *) b  );
| }
|=20
| #ifndef __cplusplus
| extern int isatty (int );
| #endif /* __cplusplus */
|    =20
| /* Initializes or reinitializes a buffer.
|  * This function is sometimes called more than once on the same buffer,=

|  * such as during a yyrestart() or at EOF.
|  */
|     static void yy_init_buffer  (YY_BUFFER_STATE  b, FILE * file )
|=20
| {
| 	int oerrno =3D errno;
|    =20
| 	yy_flush_buffer(b );
|=20
| 	b->yy_input_file =3D file;
| 	b->yy_fill_buffer =3D 1;
|=20
|     /* If b is the current buffer, then yy_init_buffer was _probably_
|      * called from yyrestart() or through yy_get_next_buffer.
|      * In that case, we don't want to reset the lineno or column.
|      */
|     if (b !=3D YY_CURRENT_BUFFER){
|         b->yy_bs_lineno =3D 1;
|         b->yy_bs_column =3D 0;
|     }
|=20
|         b->yy_is_interactive =3D file ? (isatty( fileno(file) ) > 0) : =
0;
|    =20
| 	errno =3D oerrno;
| }
|=20
| /** Discard all buffered characters. On the next scan, YY_INPUT will be=
 called.
|  * @param b the buffer state to be flushed, usually @c YY_CURRENT_BUFFE=
R.
|  *=20
|  */
|     void yy_flush_buffer (YY_BUFFER_STATE  b )
| {
|     	if ( ! b )
| 		return;
|=20
| 	b->yy_n_chars =3D 0;
|=20
| 	/* We always need two end-of-buffer characters.  The first causes
| 	 * a transition to the end-of-buffer state.  The second causes
| 	 * a jam in that state.
| 	 */
| 	b->yy_ch_buf[0] =3D YY_END_OF_BUFFER_CHAR;
| 	b->yy_ch_buf[1] =3D YY_END_OF_BUFFER_CHAR;
|=20
| 	b->yy_buf_pos =3D &b->yy_ch_buf[0];
|=20
| 	b->yy_at_bol =3D 1;
| 	b->yy_buffer_status =3D YY_BUFFER_NEW;
|=20
| 	if ( b =3D=3D YY_CURRENT_BUFFER )
| 		yy_load_buffer_state( );
| }
|=20
| /** Pushes the new state onto the stack. The new state becomes
|  *  the current state. This function will allocate the stack
|  *  if necessary.
|  *  @param new_buffer The new state.
|  * =20
|  */
| void yypush_buffer_state (YY_BUFFER_STATE new_buffer )
| {
|     	if (new_buffer =3D=3D NULL)
| 		return;
|=20
| 	yyensure_buffer_stack();
|=20
| 	/* This block is copied from yy_switch_to_buffer. */
| 	if ( YY_CURRENT_BUFFER )
| 		{
| 		/* Flush out information for old buffer. */
| 		*(yy_c_buf_p) =3D (yy_hold_char);
| 		YY_CURRENT_BUFFER_LVALUE->yy_buf_pos =3D (yy_c_buf_p);
| 		YY_CURRENT_BUFFER_LVALUE->yy_n_chars =3D (yy_n_chars);
| 		}
|=20
| 	/* Only push if top exists. Otherwise, replace top. */
| 	if (YY_CURRENT_BUFFER)
| 		(yy_buffer_stack_top)++;
| 	YY_CURRENT_BUFFER_LVALUE =3D new_buffer;
|=20
| 	/* copied from yy_switch_to_buffer. */
| 	yy_load_buffer_state( );
| 	(yy_did_buffer_switch_on_eof) =3D 1;
| }
|=20
| /** Removes and deletes the top of the stack, if present.
|  *  The next element becomes the new top.
|  * =20
|  */
| void yypop_buffer_state (void)
| {
|     	if (!YY_CURRENT_BUFFER)
| 		return;
|=20
| 	yy_delete_buffer(YY_CURRENT_BUFFER );
| 	YY_CURRENT_BUFFER_LVALUE =3D NULL;
| 	if ((yy_buffer_stack_top) > 0)
| 		--(yy_buffer_stack_top);
|=20
| 	if (YY_CURRENT_BUFFER) {
| 		yy_load_buffer_state( );
| 		(yy_did_buffer_switch_on_eof) =3D 1;
| 	}
| }
|=20
| /* Allocates the stack if it does not exist.
|  *  Guarantees space for at least one push.
|  */
| static void yyensure_buffer_stack (void)
| {
| 	int num_to_alloc;
|    =20
| 	if (!(yy_buffer_stack)) {
|=20
| 		/* First allocation is just for 2 elements, since we don't know if th=
is
| 		 * scanner will even need a stack. We use 2 instead of 1 to avoid an
| 		 * immediate realloc on the next call.
|          */
| 		num_to_alloc =3D 1;
| 		(yy_buffer_stack) =3D (struct yy_buffer_state**)yyalloc
| 								(num_to_alloc * sizeof(struct yy_buffer_state*)
| 								);
| 		if ( ! (yy_buffer_stack) )
| 			YY_FATAL_ERROR( "out of dynamic memory in yyensure_buffer_stack()" )=
;
| 								 =20
| 		memset((yy_buffer_stack), 0, num_to_alloc * sizeof(struct yy_buffer_s=
tate*));
| 			=09
| 		(yy_buffer_stack_max) =3D num_to_alloc;
| 		(yy_buffer_stack_top) =3D 0;
| 		return;
| 	}
|=20
| 	if ((yy_buffer_stack_top) >=3D ((yy_buffer_stack_max)) - 1){
|=20
| 		/* Increase the buffer to prepare for a possible push. */
| 		int grow_size =3D 8 /* arbitrary grow size */;
|=20
| 		num_to_alloc =3D (yy_buffer_stack_max) + grow_size;
| 		(yy_buffer_stack) =3D (struct yy_buffer_state**)yyrealloc
| 								((yy_buffer_stack),
| 								num_to_alloc * sizeof(struct yy_buffer_state*)
| 								);
| 		if ( ! (yy_buffer_stack) )
| 			YY_FATAL_ERROR( "out of dynamic memory in yyensure_buffer_stack()" )=
;
|=20
| 		/* zero only the new slots.*/
| 		memset((yy_buffer_stack) + (yy_buffer_stack_max), 0, grow_size * size=
of(struct yy_buffer_state*));
| 		(yy_buffer_stack_max) =3D num_to_alloc;
| 	}
| }
|=20
| /** Setup the input buffer state to scan directly from a user-specified=
 character buffer.
|  * @param base the character buffer
|  * @param size the size in bytes of the character buffer
|  *=20
|  * @return the newly allocated buffer state object.=20
|  */
| YY_BUFFER_STATE yy_scan_buffer  (char * base, yy_size_t  size )
| {
| 	YY_BUFFER_STATE b;
|    =20
| 	if ( size < 2 ||
| 	     base[size-2] !=3D YY_END_OF_BUFFER_CHAR ||
| 	     base[size-1] !=3D YY_END_OF_BUFFER_CHAR )
| 		/* They forgot to leave room for the EOB's. */
| 		return 0;
|=20
| 	b =3D (YY_BUFFER_STATE) yyalloc(sizeof( struct yy_buffer_state )  );
| 	if ( ! b )
| 		YY_FATAL_ERROR( "out of dynamic memory in yy_scan_buffer()" );
|=20
| 	b->yy_buf_size =3D size - 2;	/* "- 2" to take care of EOB's */
| 	b->yy_buf_pos =3D b->yy_ch_buf =3D base;
| 	b->yy_is_our_buffer =3D 0;
| 	b->yy_input_file =3D 0;
| 	b->yy_n_chars =3D b->yy_buf_size;
| 	b->yy_is_interactive =3D 0;
| 	b->yy_at_bol =3D 1;
| 	b->yy_fill_buffer =3D 0;
| 	b->yy_buffer_status =3D YY_BUFFER_NEW;
|=20
| 	yy_switch_to_buffer(b  );
|=20
| 	return b;
| }
|=20
| /** Setup the input buffer state to scan a string. The next call to yyl=
ex() will
|  * scan from a @e copy of @a str.
|  * @param yystr a NUL-terminated string to scan
|  *=20
|  * @return the newly allocated buffer state object.
|  * @note If you want to scan bytes that may contain NUL values, then us=
e
|  *       yy_scan_bytes() instead.
|  */
| YY_BUFFER_STATE yy_scan_string (yyconst char * yystr )
| {
|    =20
| 	return yy_scan_bytes(yystr,strlen(yystr) );
| }
|=20
| /** Setup the input buffer state to scan the given bytes. The next call=
 to yylex() will
|  * scan from a @e copy of @a bytes.
|  * @param bytes the byte buffer to scan
|  * @param len the number of bytes in the buffer pointed to by @a bytes.=

|  *=20
|  * @return the newly allocated buffer state object.
|  */
| YY_BUFFER_STATE yy_scan_bytes  (yyconst char * yybytes, int  _yybytes_l=
en )
| {
| 	YY_BUFFER_STATE b;
| 	char *buf;
| 	yy_size_t n;
| 	int i;
|    =20
| 	/* Get memory for full buffer, including space for trailing EOB's. */
| 	n =3D _yybytes_len + 2;
| 	buf =3D (char *) yyalloc(n  );
| 	if ( ! buf )
| 		YY_FATAL_ERROR( "out of dynamic memory in yy_scan_bytes()" );
|=20
| 	for ( i =3D 0; i < _yybytes_len; ++i )
| 		buf[i] =3D yybytes[i];
|=20
| 	buf[_yybytes_len] =3D buf[_yybytes_len+1] =3D YY_END_OF_BUFFER_CHAR;
|=20
| 	b =3D yy_scan_buffer(buf,n );
| 	if ( ! b )
| 		YY_FATAL_ERROR( "bad buffer in yy_scan_bytes()" );
|=20
| 	/* It's okay to grow etc. this buffer, and we should throw it
| 	 * away when we're done.
| 	 */
| 	b->yy_is_our_buffer =3D 1;
|=20
| 	return b;
| }
|=20
| #ifndef YY_EXIT_FAILURE
| #define YY_EXIT_FAILURE 2
| #endif
|=20
| static void yy_fatal_error (yyconst char* msg )
| {
|     	(void) fprintf( stderr, "%s\n", msg );
| 	exit( YY_EXIT_FAILURE );
| }
|=20
| /* Redefine yyless() so it works in section 3 code. */
|=20
| #undef yyless
| #define yyless(n) \
| 	do \
| 		{ \
| 		/* Undo effects of setting up yytext. */ \
|         int yyless_macro_arg =3D (n); \
|         YY_LESS_LINENO(yyless_macro_arg);\
| 		yytext[yyleng] =3D (yy_hold_char); \
| 		(yy_c_buf_p) =3D yytext + yyless_macro_arg; \
| 		(yy_hold_char) =3D *(yy_c_buf_p); \
| 		*(yy_c_buf_p) =3D '\0'; \
| 		yyleng =3D yyless_macro_arg; \
| 		} \
| 	while ( 0 )
|=20
| /* Accessor  methods (get/set functions) to struct members. */
|=20
| /** Get the current line number.
|  *=20
|  */
| int yyget_lineno  (void)
| {
|        =20
|     return yylineno;
| }
|=20
| /** Get the input stream.
|  *=20
|  */
| FILE *yyget_in  (void)
| {
|         return yyin;
| }
|=20
| /** Get the output stream.
|  *=20
|  */
| FILE *yyget_out  (void)
| {
|         return yyout;
| }
|=20
| /** Get the length of the current token.
|  *=20
|  */
| int yyget_leng  (void)
| {
|         return yyleng;
| }
|=20
| /** Get the current token.
|  *=20
|  */
|=20
| char *yyget_text  (void)
| {
|         return yytext;
| }
|=20
| /** Set the current line number.
|  * @param line_number
|  *=20
|  */
| void yyset_lineno (int  line_number )
| {
|    =20
|     yylineno =3D line_number;
| }
|=20
| /** Set the input stream. This does not discard the current
|  * input buffer.
|  * @param in_str A readable stream.
|  *=20
|  * @see yy_switch_to_buffer
|  */
| void yyset_in (FILE *  in_str )
| {
|         yyin =3D in_str ;
| }
|=20
| void yyset_out (FILE *  out_str )
| {
|         yyout =3D out_str ;
| }
|=20
| int yyget_debug  (void)
| {
|         return yy_flex_debug;
| }
|=20
| void yyset_debug (int  bdebug )
| {
|         yy_flex_debug =3D bdebug ;
| }
|=20
| static int yy_init_globals (void)
| {
|         /* Initialization is the same as for the non-reentrant scanner.=

|      * This function is called from yylex_destroy(), so don't allocate =
here.
|      */
|=20
|     (yy_buffer_stack) =3D 0;
|     (yy_buffer_stack_top) =3D 0;
|     (yy_buffer_stack_max) =3D 0;
|     (yy_c_buf_p) =3D (char *) 0;
|     (yy_init) =3D 0;
|     (yy_start) =3D 0;
|=20
|     (yy_state_buf) =3D 0;
|     (yy_state_ptr) =3D 0;
|     (yy_full_match) =3D 0;
|     (yy_lp) =3D 0;
|=20
| /* Defined in main.c */
| #ifdef YY_STDINIT
|     yyin =3D stdin;
|     yyout =3D stdout;
| #else
|     yyin =3D (FILE *) 0;
|     yyout =3D (FILE *) 0;
| #endif
|=20
|     /* For future reference: Set errno on error, since we are called by=

|      * yylex_init()
|      */
|     return 0;
| }
|=20
| /* yylex_destroy is for both reentrant and non-reentrant scanners. */
| int yylex_destroy  (void)
| {
|    =20
|     /* Pop the buffer stack, destroying each element. */
| 	while(YY_CURRENT_BUFFER){
| 		yy_delete_buffer(YY_CURRENT_BUFFER  );
| 		YY_CURRENT_BUFFER_LVALUE =3D NULL;
| 		yypop_buffer_state();
| 	}
|=20
| 	/* Destroy the stack itself. */
| 	yyfree((yy_buffer_stack) );
| 	(yy_buffer_stack) =3D NULL;
|=20
|     yyfree ( (yy_state_buf) );
|     (yy_state_buf)  =3D NULL;
|=20
|     /* Reset the globals. This is important in a non-reentrant scanner =
so the next time
|      * yylex() is called, initialization will occur. */
|     yy_init_globals( );
|=20
|     return 0;
| }
|=20
| /*
|  * Internal utility routines.
|  */
|=20
| #ifndef yytext_ptr
| static void yy_flex_strncpy (char* s1, yyconst char * s2, int n )
| {
| 	register int i;
| 	for ( i =3D 0; i < n; ++i )
| 		s1[i] =3D s2[i];
| }
| #endif
|=20
| #ifdef YY_NEED_STRLEN
| static int yy_flex_strlen (yyconst char * s )
| {
| 	register int n;
| 	for ( n =3D 0; s[n]; ++n )
| 		;
|=20
| 	return n;
| }
| #endif
|=20
| void *yyalloc (yy_size_t  size )
| {
| 	return (void *) malloc( size );
| }
|=20
| void *yyrealloc  (void * ptr, yy_size_t  size )
| {
| 	/* The cast to (char *) in the following accommodates both
| 	 * implementations that use char* generic pointers, and those
| 	 * that use void* generic pointers.  It works with the latter
| 	 * because both ANSI C and C++ allow castless assignment from
| 	 * any pointer type to void*, and deal with argument conversions
| 	 * as though doing an assignment.
| 	 */
| 	return (void *) realloc( (char *) ptr, size );
| }
|=20
| void yyfree (void * ptr )
| {
| 	free( (char *) ptr );	/* see yyrealloc() for (char *) cast */
| }
|=20
| #define YYTABLES_NAME "yytables"
|=20
| #line 9 "conftest.l"
|=20
|=20
| #ifdef YYTEXT_POINTER
| extern char *yytext;
| #endif
| int
| main (void)
| {
|   return ! yylex () + ! yywrap ();
| }
configure:21240: result: no
configure:21256: checking for target architecture
configure:21306: result: x86
configure:21320: checking for debug symbols
configure:21330: result: no
configure:21335: checking for SMP support
configure:21345: result: no
configure:21353: checking for x86 SEP instructions in syscalls
configure:21363: result: no
configure:21366: checking for x86 TSC support
configure:21376: result: y
configure:21505: checking whether building Linux in Xenomai build tree
configure:21518: result: no
configure:21686: checking for Doxygen documentation
configure:21707: result: no
configure:21713: checking for doxygen
configure:21729: found /usr/bin/doxygen
configure:21740: result: doxygen
configure:21757: checking for dot
configure:21785: result: NO
configure:21812: checking whether compiling Docbook XML documentation
configure:21835: result: no
configure:21854: checking for xmllint
configure:21870: found /usr/bin/xmllint
configure:21881: result: xmllint
configure:21899: checking for xsltproc
configure:21915: found /usr/bin/xsltproc
configure:21926: result: xsltproc
configure:21946: checking for fop.sh
configure:21976: result: no
configure:21991: checking whether Docbook XML documentation generation ca=
n use network.
configure:22007: result: no
configure:22017: checking for docbook-xml root dir
configure:22037: result: network
configure:22054: checking for docbook-xsl root dir
configure:22074: result: network
configure:22107: checking whether using LaTeX non-stop mode
configure:22117: result: no
configure:22143: checking mqueue.h usability
configure:22160: /home/malek/minisys/xenomai/buildroot/build_i686/staging=
_dir/usr/bin/i686-linux-uclibc-gcc -Os  -I/home/malek/minisys/xenomai/bui=
ldroot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/b=
uildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/x=
enomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xe=
nomai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpenti=
umpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 =
-c   conftest.c >&5
configure:22166: $? =3D 0
configure:22180: result: yes
configure:22184: checking mqueue.h presence
configure:22199: /home/malek/minisys/xenomai/buildroot/build_i686/staging=
_dir/usr/bin/i686-linux-uclibc-cpp -Os  -I/home/malek/minisys/xenomai/bui=
ldroot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/b=
uildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/x=
enomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xe=
nomai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpenti=
umpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 =
 conftest.c
configure:22205: $? =3D 0
configure:22219: result: yes
configure:22252: checking for mqueue.h
configure:22260: result: yes
configure:22345: checking for sched_setaffinity
configure:22373: /home/malek/minisys/xenomai/buildroot/build_i686/staging=
_dir/usr/bin/i686-linux-uclibc-gcc -Os  -I/home/malek/minisys/xenomai/bui=
ldroot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/b=
uildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/x=
enomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xe=
nomai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpenti=
umpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 =
-o conftest -Wimplicit-function-declaration -Werror -D_GNU_SOURCE   conft=
est.c  >&5
configure:22379: $? =3D 0
configure:22449: result: ok
configure:22464: checking for specific GCC switches
configure:22499: /home/malek/minisys/xenomai/buildroot/build_i686/staging=
_dir/usr/bin/i686-linux-uclibc-gcc -Os  -I/home/malek/minisys/xenomai/bui=
ldroot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/b=
uildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/x=
enomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xe=
nomai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpenti=
umpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 =
-c -Wno-strict-aliasing -Werror  conftest.c >&5
configure:22505: $? =3D 0
configure:22533: result: done
configure:22570: checking whether ld supports @file
configure:22593: /home/malek/minisys/xenomai/buildroot/build_i686/staging=
_dir/usr/bin/i686-linux-uclibc-gcc -Os  -I/home/malek/minisys/xenomai/bui=
ldroot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/b=
uildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/x=
enomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xe=
nomai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpenti=
umpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 =
-o conftest   -Wl,@/dev/null conftest.c  >&5
configure:22599: $? =3D 0
configure:22631: result: yes
configure:22636: checking whether the POSIX skin library automatically ca=
lls mlockall
configure:22646: result: no
configure:22656: checking whether the pSOS skin library automatically cal=
ls mlockall
configure:22666: result: no
configure:22676: checking whether the uITRON skin library automatically c=
alls mlockall
configure:22686: result: no
configure:22703: checking for shm_open
configure:22759: /home/malek/minisys/xenomai/buildroot/build_i686/staging=
_dir/usr/bin/i686-linux-uclibc-gcc -Os  -I/home/malek/minisys/xenomai/bui=
ldroot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/b=
uildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/x=
enomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xe=
nomai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpenti=
umpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 =
-o conftest    conftest.c  -lrt >&5
/tmp/ccQ6vfFD.o: In function `main':
conftest.c:(.text+0x12): undefined reference to `shm_open'
collect2: ld returned 1 exit status
configure:22765: $? =3D 1
configure: failed program was:
| /* confdefs.h.  */
| #define PACKAGE_NAME "Xenomai"
| #define PACKAGE_TARNAME "xenomai"
| #define PACKAGE_VERSION "2.4.5"
| #define PACKAGE_STRING "Xenomai 2.4.5"
| #define PACKAGE_BUGREPORT "xenomai@xenomai.org"
| #define CONFIG_XENO_BUILD_STRING "i386-pc-linux-gnu"
| #define CONFIG_XENO_HOST_STRING "i686-pc-linux-gnu"
| #define CONFIG_XENO_COMPILER "gcc version 4.2.4"
| #define PACKAGE "xenomai"
| #define VERSION "2.4.5"
| #define STDC_HEADERS 1
| #define HAVE_SYS_TYPES_H 1
| #define HAVE_SYS_STAT_H 1
| #define HAVE_STDLIB_H 1
| #define HAVE_STRING_H 1
| #define HAVE_MEMORY_H 1
| #define HAVE_STRINGS_H 1
| #define HAVE_INTTYPES_H 1
| #define HAVE_STDINT_H 1
| #define HAVE_UNISTD_H 1
| #define HAVE_DLFCN_H 1
| #define HAVE_MQUEUE_H 1
| #define CONFIG_XENO_VERSION_MAJOR 2
| #define CONFIG_XENO_VERSION_MINOR 4
| #define CONFIG_XENO_REVISION_LEVEL 5
| #define CONFIG_X86_TSC 1
| #define HAVE_RECENT_SETAFFINITY 1
| /* end confdefs.h.  */
| /* Define shm_open to an innocuous variant, in case <limits.h> declares=
 shm_open.
|    For example, HP-UX 11i <limits.h> declares gettimeofday.  */
| #define shm_open innocuous_shm_open
|=20
| /* System header to define __stub macros and hopefully few prototypes,
|     which can conflict with char shm_open (); below.
|     Prefer <limits.h> to <assert.h> if __STDC__ is defined, since
|     <limits.h> exists even on freestanding compilers.  */
|=20
| #ifdef __STDC__
| # include <limits.h>
| #else
| # include <assert.h>
| #endif
|=20
| #undef shm_open
|=20
| /* Override any GCC internal prototype to avoid an error.
|    Use char because int might match the return type of a GCC
|    builtin and then its argument prototype would still apply.  */
| #ifdef __cplusplus
| extern "C"
| #endif
| char shm_open ();
| /* The GNU C library defines this for functions which it implements
|     to always fail with ENOSYS.  Some functions are actually named
|     something starting with __ and the normal name is an alias.  */
| #if defined __stub_shm_open || defined __stub___shm_open
| choke me
| #endif
|=20
| int
| main ()
| {
| return shm_open ();
|   ;
|   return 0;
| }
configure:22783: result: no
configure:22703: checking for shm_unlink
configure:22759: /home/malek/minisys/xenomai/buildroot/build_i686/staging=
_dir/usr/bin/i686-linux-uclibc-gcc -Os  -I/home/malek/minisys/xenomai/bui=
ldroot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/b=
uildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/x=
enomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xe=
nomai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpenti=
umpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 =
-o conftest    conftest.c  -lrt >&5
/tmp/cceOZoDJ.o: In function `main':
conftest.c:(.text+0x12): undefined reference to `shm_unlink'
collect2: ld returned 1 exit status
configure:22765: $? =3D 1
configure: failed program was:
| /* confdefs.h.  */
| #define PACKAGE_NAME "Xenomai"
| #define PACKAGE_TARNAME "xenomai"
| #define PACKAGE_VERSION "2.4.5"
| #define PACKAGE_STRING "Xenomai 2.4.5"
| #define PACKAGE_BUGREPORT "xenomai@xenomai.org"
| #define CONFIG_XENO_BUILD_STRING "i386-pc-linux-gnu"
| #define CONFIG_XENO_HOST_STRING "i686-pc-linux-gnu"
| #define CONFIG_XENO_COMPILER "gcc version 4.2.4"
| #define PACKAGE "xenomai"
| #define VERSION "2.4.5"
| #define STDC_HEADERS 1
| #define HAVE_SYS_TYPES_H 1
| #define HAVE_SYS_STAT_H 1
| #define HAVE_STDLIB_H 1
| #define HAVE_STRING_H 1
| #define HAVE_MEMORY_H 1
| #define HAVE_STRINGS_H 1
| #define HAVE_INTTYPES_H 1
| #define HAVE_STDINT_H 1
| #define HAVE_UNISTD_H 1
| #define HAVE_DLFCN_H 1
| #define HAVE_MQUEUE_H 1
| #define CONFIG_XENO_VERSION_MAJOR 2
| #define CONFIG_XENO_VERSION_MINOR 4
| #define CONFIG_XENO_REVISION_LEVEL 5
| #define CONFIG_X86_TSC 1
| #define HAVE_RECENT_SETAFFINITY 1
| /* end confdefs.h.  */
| /* Define shm_unlink to an innocuous variant, in case <limits.h> declar=
es shm_unlink.
|    For example, HP-UX 11i <limits.h> declares gettimeofday.  */
| #define shm_unlink innocuous_shm_unlink
|=20
| /* System header to define __stub macros and hopefully few prototypes,
|     which can conflict with char shm_unlink (); below.
|     Prefer <limits.h> to <assert.h> if __STDC__ is defined, since
|     <limits.h> exists even on freestanding compilers.  */
|=20
| #ifdef __STDC__
| # include <limits.h>
| #else
| # include <assert.h>
| #endif
|=20
| #undef shm_unlink
|=20
| /* Override any GCC internal prototype to avoid an error.
|    Use char because int might match the return type of a GCC
|    builtin and then its argument prototype would still apply.  */
| #ifdef __cplusplus
| extern "C"
| #endif
| char shm_unlink ();
| /* The GNU C library defines this for functions which it implements
|     to always fail with ENOSYS.  Some functions are actually named
|     something starting with __ and the normal name is an alias.  */
| #if defined __stub_shm_unlink || defined __stub___shm_unlink
| choke me
| #endif
|=20
| int
| main ()
| {
| return shm_unlink ();
|   ;
|   return 0;
| }
configure:22783: result: no
configure:22999: creating ./config.status

## ---------------------- ##
## Running config.status. ##
## ---------------------- ##

This file was extended by Xenomai config.status 2.4.5, which was
generated by GNU Autoconf 2.61.  Invocation command line was

  CONFIG_FILES    =3D=20
  CONFIG_HEADERS  =3D=20
  CONFIG_LINKS    =3D=20
  CONFIG_COMMANDS =3D=20
  $ ./config.status=20

on localhost.localdomain

config.status:833: creating Makefile
config.status:833: creating config/Makefile
config.status:833: creating scripts/Makefile
config.status:833: creating scripts/xeno-config
config.status:833: creating scripts/xeno-load
config.status:833: creating scripts/xeno-test
config.status:833: creating src/Makefile
config.status:833: creating src/rtdk/Makefile
config.status:833: creating src/skins/Makefile
config.status:833: creating src/skins/posix/Makefile
config.status:833: creating src/skins/native/Makefile
config.status:833: creating src/skins/vxworks/Makefile
config.status:833: creating src/skins/psos+/Makefile
config.status:833: creating src/skins/vrtx/Makefile
config.status:833: creating src/skins/rtdm/Makefile
config.status:833: creating src/skins/rtai/Makefile
config.status:833: creating src/skins/uitron/Makefile
config.status:833: creating src/include/Makefile
config.status:833: creating src/testsuite/Makefile
config.status:833: creating src/testsuite/latency/Makefile
config.status:833: creating src/testsuite/switchbench/Makefile
config.status:833: creating src/testsuite/cyclic/Makefile
config.status:833: creating src/testsuite/switchtest/Makefile
config.status:833: creating src/testsuite/irqbench/Makefile
config.status:833: creating src/testsuite/clocktest/Makefile
config.status:833: creating src/testsuite/klatency/Makefile
config.status:833: creating src/utils/Makefile
config.status:833: creating src/utils/can/Makefile
config.status:833: creating include/Makefile
config.status:833: creating include/asm-generic/Makefile
config.status:833: creating include/asm-generic/bits/Makefile
config.status:833: creating include/asm-blackfin/Makefile
config.status:833: creating include/asm-blackfin/bits/Makefile
config.status:833: creating include/asm-x86/Makefile
config.status:833: creating include/asm-x86/bits/Makefile
config.status:833: creating include/asm-powerpc/Makefile
config.status:833: creating include/asm-powerpc/bits/Makefile
config.status:833: creating include/asm-ia64/Makefile
config.status:833: creating include/asm-ia64/bits/Makefile
config.status:833: creating include/asm-arm/Makefile
config.status:833: creating include/asm-arm/bits/Makefile
config.status:833: creating include/asm-sim/Makefile
config.status:833: creating include/asm-sim/bits/Makefile
config.status:833: creating include/native/Makefile
config.status:833: creating include/nucleus/Makefile
config.status:833: creating include/posix/Makefile
config.status:833: creating include/posix/sys/Makefile
config.status:833: creating include/psos+/Makefile
config.status:833: creating include/rtai/Makefile
config.status:833: creating include/rtdm/Makefile
config.status:833: creating include/uitron/Makefile
config.status:833: creating include/vrtx/Makefile
config.status:833: creating include/vxworks/Makefile
config.status:833: creating doc/Makefile
config.status:833: creating doc/txt/Makefile
config.status:833: creating doc/man/Makefile
config.status:833: creating doc/man/clocktest.man
config.status:833: creating doc/man/cyclictest.man
config.status:833: creating doc/man/irqbench.man
config.status:833: creating doc/man/irqloop.man
config.status:833: creating doc/man/klatency.man
config.status:833: creating doc/man/latency.man
config.status:833: creating doc/man/rtcanconfig.man
config.status:833: creating doc/man/rtcanrecv.man
config.status:833: creating doc/man/rtcansend.man
config.status:833: creating doc/man/switchbench.man
config.status:833: creating doc/man/switchtest.man
config.status:833: creating doc/man/runinfo.man
config.status:833: creating doc/man/xeno-config.man
config.status:833: creating doc/man/xeno-info.man
config.status:833: creating doc/man/xeno-load.man
config.status:833: creating doc/man/xeno-test.man
config.status:833: creating doc/doxygen/Makefile
config.status:833: creating doc/doxygen/Doxyfile-common
config.status:833: creating doc/doxygen/Doxyfile
config.status:833: creating doc/doxygen/Doxyfile-native
config.status:833: creating doc/doxygen/Doxyfile-nucleus
config.status:833: creating doc/doxygen/Doxyfile-posix
config.status:833: creating doc/doxygen/Doxyfile-rtdm
config.status:833: creating doc/docbook/Makefile
config.status:833: creating doc/docbook/catalog
config.status:833: creating doc/docbook/custom-stylesheets/Makefile
config.status:833: creating doc/docbook/custom-stylesheets/xsl/Makefile
config.status:833: creating doc/docbook/custom-stylesheets/xsl/common/Mak=
efile
config.status:833: creating doc/docbook/custom-stylesheets/xsl/fo/Makefil=
e
config.status:833: creating doc/docbook/custom-stylesheets/xsl/html/Makef=
ile
config.status:833: creating doc/docbook/custom-stylesheets/xsl/html/chunk=
=2Exsl
config.status:833: creating doc/docbook/custom-stylesheets/xsl/html/onech=
unk.xsl
config.status:833: creating doc/docbook/xenomai/Makefile
config.status:833: creating src/include/xeno_config.h
config.status:1069: src/include/xeno_config.h is unchanged
config.status:1120: linking ./include/asm-x86 to src/include/asm/xenomai
config.status:1120: linking ./include/asm-generic to src/include/asm-gene=
ric/xenomai
config.status:1142: executing depfiles commands

## ---------------- ##
## Cache variables. ##
## ---------------- ##

ac_cv_build=3Di386-pc-linux-gnu
ac_cv_build_prog_CPP=3D'/usr/lib/ccache/gcc -E'
ac_cv_build_prog_cc_g=3Dno
ac_cv_c_bigendian=3Dno
ac_cv_c_compiler_gnu=3Dyes
ac_cv_cxx_compiler_gnu=3Dyes
ac_cv_env_CCASFLAGS_set=3D
ac_cv_env_CCASFLAGS_value=3D
ac_cv_env_CCAS_set=3D
ac_cv_env_CCAS_value=3D
ac_cv_env_CCC_set=3D
ac_cv_env_CCC_value=3D
ac_cv_env_CC_set=3Dset
ac_cv_env_CC_value=3D'/home/malek/minisys/xenomai/buildroot/build_i686/st=
aging_dir/usr/bin/i686-linux-uclibc-gcc -Os  -I/home/malek/minisys/xenoma=
i/buildroot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xeno=
mai/buildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/mini=
sys/xenomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minis=
ys/xenomai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3D=
pentiumpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D=
64'
ac_cv_env_CFLAGS_set=3D
ac_cv_env_CFLAGS_value=3D
ac_cv_env_CPPFLAGS_set=3D
ac_cv_env_CPPFLAGS_value=3D
ac_cv_env_CPP_set=3Dset
ac_cv_env_CPP_value=3D'/home/malek/minisys/xenomai/buildroot/build_i686/s=
taging_dir/usr/bin/i686-linux-uclibc-cpp -Os  -I/home/malek/minisys/xenom=
ai/buildroot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xen=
omai/buildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/min=
isys/xenomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/mini=
sys/xenomai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3D=
pentiumpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D=
64'
ac_cv_env_CXXCPP_set=3D
ac_cv_env_CXXCPP_value=3D
ac_cv_env_CXXFLAGS_set=3D
ac_cv_env_CXXFLAGS_value=3D
ac_cv_env_CXX_set=3Dset
ac_cv_env_CXX_value=3D'/home/malek/minisys/xenomai/buildroot/build_i686/s=
taging_dir/usr/bin/i686-linux-uclibc-g++ -Os  -I/home/malek/minisys/xenom=
ai/buildroot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xen=
omai/buildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/min=
isys/xenomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/mini=
sys/xenomai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3D=
pentiumpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D=
64'
ac_cv_env_F77_set=3D
ac_cv_env_F77_value=3D
ac_cv_env_FFLAGS_set=3D
ac_cv_env_FFLAGS_value=3D
ac_cv_env_LDFLAGS_set=3D
ac_cv_env_LDFLAGS_value=3D
ac_cv_env_LIBS_set=3D
ac_cv_env_LIBS_value=3D
ac_cv_env_build_alias_set=3Dset
ac_cv_env_build_alias_value=3Di386-pc-linux-gnu
ac_cv_env_host_alias_set=3Dset
ac_cv_env_host_alias_value=3Di686-linux
ac_cv_env_target_alias_set=3Dset
ac_cv_env_target_alias_value=3Di686-linux
ac_cv_f77_compiler_gnu=3Dyes
ac_cv_func_memcmp_working=3Dyes
ac_cv_func_mmap_fixed_mapped=3Dyes
ac_cv_func_shm_open=3Dno
ac_cv_func_shm_unlink=3Dno
ac_cv_gcc_wnoalias=3Dyes
ac_cv_header_dlfcn_h=3Dyes
ac_cv_header_inttypes_h=3Dyes
ac_cv_header_memory_h=3Dyes
ac_cv_header_mqueue_h=3Dyes
ac_cv_header_stdc=3Dyes
ac_cv_header_stdint_h=3Dyes
ac_cv_header_stdlib_h=3Dyes
ac_cv_header_string_h=3Dyes
ac_cv_header_strings_h=3Dyes
ac_cv_header_sys_stat_h=3Dyes
ac_cv_header_sys_types_h=3Dyes
ac_cv_header_unistd_h=3Dyes
ac_cv_host=3Di686-pc-linux-gnu
ac_cv_lbl_unaligned_fail=3Dno
ac_cv_ld_file_option=3Dyes
ac_cv_lib_lex=3D'none needed'
ac_cv_objext=3Do
ac_cv_path_EGREP=3D'/bin/grep -E'
ac_cv_path_GREP=3D/bin/grep
ac_cv_path_install=3D'/usr/bin/install -c'
ac_cv_path_mkdir=3D/bin/mkdir
ac_cv_prog_AR=3D/home/malek/minisys/xenomai/buildroot/build_i686/staging_=
dir/usr/bin/i686-linux-uclibc-ar
ac_cv_prog_AWK=3Dgawk
ac_cv_prog_CC=3D'/home/malek/minisys/xenomai/buildroot/build_i686/staging=
_dir/usr/bin/i686-linux-uclibc-gcc -Os  -I/home/malek/minisys/xenomai/bui=
ldroot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/b=
uildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/x=
enomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xe=
nomai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpenti=
umpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64'=

ac_cv_prog_CC_FOR_BUILD=3D/usr/lib/ccache/gcc
ac_cv_prog_CPP=3D'/home/malek/minisys/xenomai/buildroot/build_i686/stagin=
g_dir/usr/bin/i686-linux-uclibc-cpp -Os  -I/home/malek/minisys/xenomai/bu=
ildroot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/=
buildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/=
xenomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/x=
enomai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpent=
iumpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64=
'
ac_cv_prog_CXXCPP=3D'/home/malek/minisys/xenomai/buildroot/build_i686/sta=
ging_dir/usr/bin/i686-linux-uclibc-g++ -Os  -I/home/malek/minisys/xenomai=
/buildroot/build_i686/staging_dir/usr/include -I/home/malek/minisys/xenom=
ai/buildroot/build_i686/staging_dir/include --sysroot=3D/home/malek/minis=
ys/xenomai/buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisy=
s/xenomai/buildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dp=
entiumpro -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D=
64 -E'
ac_cv_prog_DBX_LINT=3Dxmllint
ac_cv_prog_DBX_XSLTPROC=3Dxsltproc
ac_cv_prog_DOXYGEN=3Ddoxygen
ac_cv_prog_DOXYGEN_HAVE_DOT=3DNO
ac_cv_prog_LEX=3Dflex
ac_cv_prog_RANLIB=3D/home/malek/minisys/xenomai/buildroot/build_i686/stag=
ing_dir/usr/bin/i686-linux-uclibc-ranlib
ac_cv_prog_STRIP=3D/home/malek/minisys/xenomai/buildroot/build_i686/stagi=
ng_dir/usr/bin/i686-linux-uclibc-strip
ac_cv_prog_ac_ct_F77=3Dgfortran
ac_cv_prog_cc_c89=3D
ac_cv_prog_cc_g=3Dyes
ac_cv_prog_cxx_g=3Dyes
ac_cv_prog_f77_g=3Dyes
ac_cv_prog_lex_root=3Dlex.yy
ac_cv_prog_lex_yytext_pointer=3Dno
ac_cv_prog_make_make_set=3Dyes
ac_cv_sched_setaffinity=3Dnew
ac_cv_target=3Di686-pc-linux-gnu
am_cv_CCAS_dependencies_compiler_type=3Dgcc3
am_cv_CC_dependencies_compiler_type=3Dgcc3
am_cv_CXX_dependencies_compiler_type=3Dgcc3
lt_cv_deplibs_check_method=3Dpass_all
lt_cv_file_magic_cmd=3D'$MAGIC_CMD'
lt_cv_file_magic_test_file=3D
lt_cv_ld_reload_flag=3D-r
lt_cv_objdir=3D.libs
lt_cv_path_LD=3D'/home/malek/minisys/xenomai/buildroot/build_i686/staging=
_dir/usr/bin/i686-linux-uclibc-ld -L/home/malek/minisys/xenomai/buildroot=
/build_i686/staging_dir/lib -L/home/malek/minisys/xenomai/buildroot/build=
_i686/staging_dir/usr/lib --sysroot=3D/home/malek/minisys/xenomai/buildro=
ot/build_i686/staging_dir/'
lt_cv_path_LDCXX=3D'/home/malek/minisys/xenomai/buildroot/build_i686/stag=
ing_dir/usr/bin/i686-linux-uclibc-ld -L/home/malek/minisys/xenomai/buildr=
oot/build_i686/staging_dir/lib -L/home/malek/minisys/xenomai/buildroot/bu=
ild_i686/staging_dir/usr/lib --sysroot=3D/home/malek/minisys/xenomai/buil=
droot/build_i686/staging_dir/'
lt_cv_path_NM=3D/home/malek/minisys/xenomai/buildroot/build_i686/staging_=
dir/usr/bin/i686-linux-uclibc-nm
lt_cv_path_SED=3D/home/malek/minisys/xenomai/buildroot/toolchain_build_i6=
86/bin/sed
lt_cv_prog_compiler_c_o=3Dyes
lt_cv_prog_compiler_c_o_CXX=3Dyes
lt_cv_prog_compiler_c_o_F77=3Dyes
lt_cv_prog_compiler_pic_works=3Dyes
lt_cv_prog_compiler_pic_works_CXX=3Dyes
lt_cv_prog_compiler_pic_works_F77=3Dyes
lt_cv_prog_compiler_rtti_exceptions=3Dno
lt_cv_prog_compiler_static_works=3Dyes
lt_cv_prog_compiler_static_works_CXX=3Dno
lt_cv_prog_compiler_static_works_F77=3Dyes
lt_cv_prog_gnu_ld=3Dyes
lt_cv_prog_gnu_ldcxx=3Dyes
lt_cv_sys_global_symbol_pipe=3D'sed -n -e '\''s/^.*[ 	]\([ABCDGIRSTW][ABC=
DGIRSTW]*\)[ 	][ 	]*\([_A-Za-z][_A-Za-z0-9]*\)$/\1 \2 \2/p'\'''
lt_cv_sys_global_symbol_to_c_name_address=3D'sed -n -e '\''s/^: \([^ ]*\)=
 $/  {\"\1\", (lt_ptr) 0},/p'\'' -e '\''s/^[BCDEGRST] \([^ ]*\) \([^ ]*\)=
$/  {"\2", (lt_ptr) \&\2},/p'\'''
lt_cv_sys_global_symbol_to_cdecl=3D'sed -n -e '\''s/^. .* \(.*\)$/extern =
int \1;/p'\'''
lt_cv_sys_lib_dlsearch_path_spec=3D'/lib /usr/lib /usr/lib/atlas /usr/lib=
/mysql /usr/lib/nvidia /usr/lib/qt-3.3/lib /usr/lib/tcl8.5 /usr/lib/xulru=
nner-1.9 '
lt_cv_sys_lib_search_path_spec=3D'/home/malek/minisys/xenomai/buildroot/b=
uild_i686/staging_dir/usr/lib/gcc/i686-linux-uclibc/4.2.4 /home/malek/min=
isys/xenomai/buildroot/build_i686/staging_dir/usr/lib/gcc /home/malek/min=
isys/xenomai/buildroot/build_i686/staging_dir/usr/i686-linux-uclibc/lib /=
home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/lib /home/mal=
ek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/lib'
lt_cv_sys_max_cmd_len=3D1966080
lt_lt_cv_prog_compiler_c_o=3D'"yes"'
lt_lt_cv_prog_compiler_c_o_CXX=3D'"yes"'
lt_lt_cv_prog_compiler_c_o_F77=3D'"yes"'
lt_lt_cv_sys_global_symbol_pipe=3D'"sed -n -e '\''s/^.*[ 	]\\([ABCDGIRSTW=
][ABCDGIRSTW]*\\)[ 	][ 	]*\\([_A-Za-z][_A-Za-z0-9]*\\)\$/\\1 \\2 \\2/p'\'=
'"'
lt_lt_cv_sys_global_symbol_to_c_name_address=3D'"sed -n -e '\''s/^: \\([^=
 ]*\\) \$/  {\\\"\\1\\\", (lt_ptr) 0},/p'\'' -e '\''s/^[BCDEGRST] \\([^ ]=
*\\) \\([^ ]*\\)\$/  {\"\\2\", (lt_ptr) \\&\\2},/p'\''"'
lt_lt_cv_sys_global_symbol_to_cdecl=3D'"sed -n -e '\''s/^. .* \\(.*\\)\$/=
extern int \\1;/p'\''"'

## ----------------- ##
## Output variables. ##
## ----------------- ##

ACLOCAL=3D'${SHELL} /home/malek/minisys/xenomai/buildroot/build_i686/xeno=
mai-2.4.5/config/missing --run aclocal-1.10'
ADEOS_PATCH=3D''
AMDEPBACKSLASH=3D'\'
AMDEP_FALSE=3D'#'
AMDEP_TRUE=3D''
AMTAR=3D'${SHELL} /home/malek/minisys/xenomai/buildroot/build_i686/xenoma=
i-2.4.5/config/missing --run tar'
AR=3D'/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bi=
n/i686-linux-uclibc-ar'
AUTOCONF=3D'${SHELL} /home/malek/minisys/xenomai/buildroot/build_i686/xen=
omai-2.4.5/config/missing --run autoconf'
AUTOHEADER=3D'${SHELL} /home/malek/minisys/xenomai/buildroot/build_i686/x=
enomai-2.4.5/config/missing --run autoheader'
AUTOMAKE=3D'${SHELL} /home/malek/minisys/xenomai/buildroot/build_i686/xen=
omai-2.4.5/config/missing --run automake-1.10'
AWK=3D'gawk'
BUILD_EXEEXT=3D''
BUILD_OBJEXT=3D''
CC=3D'/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bi=
n/i686-linux-uclibc-gcc -Os  -I/home/malek/minisys/xenomai/buildroot/buil=
d_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/buildroot/bu=
ild_i686/staging_dir/include --sysroot=3D/home/malek/minisys/xenomai/buil=
droot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xenomai/build=
root/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LA=
RGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64'
CC=3D'/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/bi=
n/i686-linux-uclibc-gcc -Os  -I/home/malek/minisys/xenomai/buildroot/buil=
d_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/buildroot/bu=
ild_i686/staging_dir/include --sysroot=3D/home/malek/minisys/xenomai/buil=
droot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xenomai/build=
root/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_LA=
RGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64'
CCAS=3D'/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/=
bin/i686-linux-uclibc-gcc -Os  -I/home/malek/minisys/xenomai/buildroot/bu=
ild_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/buildroot/=
build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/xenomai/bu=
ildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xenomai/bui=
ldroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_=
LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64'
CCASDEPMODE=3D'depmode=3Dgcc3'
CCASFLAGS=3D''
CCDEPMODE=3D'depmode=3Dgcc3'
CC_FOR_BUILD=3D'/usr/lib/ccache/gcc'
CFLAGS=3D''
CFLAGS=3D''
CFLAGS_FOR_BUILD=3D''
CONFIG_STATUS_DEPENDENCIES=3D'$(top_srcdir)/src/skins/posix/posix.wrapper=
s'
CONFIG_XENO_DOC_DOX_FALSE=3D''
CONFIG_XENO_DOC_DOX_TRUE=3D'#'
CPP=3D'/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/b=
in/i686-linux-uclibc-cpp -Os  -I/home/malek/minisys/xenomai/buildroot/bui=
ld_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/buildroot/b=
uild_i686/staging_dir/include --sysroot=3D/home/malek/minisys/xenomai/bui=
ldroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xenomai/buil=
droot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_L=
ARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64'
CPP=3D'/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/b=
in/i686-linux-uclibc-cpp -Os  -I/home/malek/minisys/xenomai/buildroot/bui=
ld_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/buildroot/b=
uild_i686/staging_dir/include --sysroot=3D/home/malek/minisys/xenomai/bui=
ldroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xenomai/buil=
droot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_L=
ARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64'
CPPFLAGS=3D''
CPPFLAGS=3D''
CPPFLAGS=3D''
CPPFLAGS_FOR_BUILD=3D''
CPP_FOR_BUILD=3D'/usr/lib/ccache/gcc -E'
CXX=3D'/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr/b=
in/i686-linux-uclibc-g++ -Os  -I/home/malek/minisys/xenomai/buildroot/bui=
ld_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/buildroot/b=
uild_i686/staging_dir/include --sysroot=3D/home/malek/minisys/xenomai/bui=
ldroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xenomai/buil=
droot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpro -D_L=
ARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64'
CXXCPP=3D'/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/us=
r/bin/i686-linux-uclibc-g++ -Os  -I/home/malek/minisys/xenomai/buildroot/=
build_i686/staging_dir/usr/include -I/home/malek/minisys/xenomai/buildroo=
t/build_i686/staging_dir/include --sysroot=3D/home/malek/minisys/xenomai/=
buildroot/build_i686/staging_dir/ -isysroot /home/malek/minisys/xenomai/b=
uildroot/build_i686/staging_dir -mtune=3Dpentiumpro -march=3Dpentiumpro -=
D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -E'
CXXDEPMODE=3D'depmode=3Dgcc3'
CXXFLAGS=3D'-g -O2'
CYGPATH_W=3D'echo'
DBX_ABS_SRCDIR_FALSE=3D''
DBX_ABS_SRCDIR_TRUE=3D'#'
DBX_DOC_FALSE=3D''
DBX_DOC_ROOT=3D'doc/docbook'
DBX_DOC_TRUE=3D'#'
DBX_FOP=3D''
DBX_GEN_DOC_ROOT=3D'doc/generated'
DBX_LINT=3D'xmllint'
DBX_MAYBE_NONET=3D'--nonet'
DBX_ROOT=3D'http://www.oasis-open.org/docbook/xml/4.2/'
DBX_XSLTPROC=3D'xsltproc'
DBX_XSL_ROOT=3D'http://http://docbook.sourceforge.net/release/xsl/current=
'
DEFS=3D'-DHAVE_CONFIG_H'
DEPDIR=3D'.deps'
DOXYGEN=3D'doxygen'
DOXYGEN_HAVE_DOT=3D'NO'
DOXYGEN_SHOW_INCLUDE_FILES=3D'YES'
DSYMUTIL=3D''
ECHO=3D'echo'
ECHO_C=3D''
ECHO_N=3D'-n'
ECHO_T=3D''
EGREP=3D'/bin/grep -E'
EXEEXT=3D''
F77=3D'gfortran'
FFLAGS=3D'-g -O2'
GREP=3D'/bin/grep'
INSTALL_DATA=3D'${INSTALL} -m 644'
INSTALL_PROGRAM=3D'${INSTALL}'
INSTALL_SCRIPT=3D'${INSTALL}'
INSTALL_STRIP_PROGRAM=3D'$(install_sh) -c -s'
LATEX_BATCHMODE=3D'YES'
LATEX_MODE=3D'batchmode'
LDFLAGS=3D''
LD_FILE_OPTION=3D'yes'
LEX=3D'flex'
LEXLIB=3D''
LEX_OUTPUT_ROOT=3D'lex.yy'
LIBOBJS=3D''
LIBS=3D''
LIBTOOL=3D'$(SHELL) $(top_builddir)/libtool'
LNDIR=3D''
LN_S=3D'ln -s'
LTLIBOBJS=3D''
MAINT=3D'#'
MAINTAINER_MODE_FALSE=3D''
MAINTAINER_MODE_TRUE=3D'#'
MAKEINFO=3D'${SHELL} /home/malek/minisys/xenomai/buildroot/build_i686/xen=
omai-2.4.5/config/missing --run makeinfo'
NMEDIT=3D''
OBJEXT=3D'o'
PACKAGE=3D'xenomai'
PACKAGE_BUGREPORT=3D'xenomai@xenomai.org'
PACKAGE_NAME=3D'Xenomai'
PACKAGE_STRING=3D'Xenomai 2.4.5'
PACKAGE_TARNAME=3D'xenomai'
PACKAGE_VERSION=3D'2.4.5'
PATH_SEPARATOR=3D':'
RANLIB=3D'/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/us=
r/bin/i686-linux-uclibc-ranlib'
SED=3D'/home/malek/minisys/xenomai/buildroot/toolchain_build_i686/bin/sed=
'
SET_MAKE=3D''
SHELL=3D'/bin/sh'
STRIP=3D'/home/malek/minisys/xenomai/buildroot/build_i686/staging_dir/usr=
/bin/i686-linux-uclibc-strip'
VERSION=3D'2.4.5'
XENO_BUILD_LINUX_FALSE=3D''
XENO_BUILD_LINUX_TRUE=3D'#'
XENO_BUILD_STRING=3D'i386-pc-linux-gnu'
XENO_HOST_STRING=3D'i686-pc-linux-gnu'
XENO_LINUX_ALL_TARGETS=3D''
XENO_LINUX_ARCH=3D'i386'
XENO_LINUX_ARCH_I386_FALSE=3D'#'
XENO_LINUX_ARCH_I386_TRUE=3D''
XENO_LINUX_IMAGE=3D''
XENO_LINUX_INSTALL_TARGET=3D'install'
XENO_MAYBE_DOCDIR=3D'doc'
XENO_POSIX_WRAPPERS=3D'-Wl,@/home/malek/minisys/xenomai/buildroot/build_i=
686/xenomai-2.4.5/src/skins/posix/posix.wrappers'
XENO_TARGET_ARCH=3D'x86'
XENO_USER_APP_CFLAGS=3D'-D_GNU_SOURCE -D_REENTRANT'
XENO_USER_APP_LDFLAGS=3D''
XENO_USER_CFLAGS=3D'-O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -fstrict-a=
liasing -Wno-strict-aliasing -D__XENO__ -D__IN_XENO__ -Wstrict-prototypes=
'
XENO_USER_LDFLAGS=3D''
ac_ct_CC=3D''
ac_ct_CC_FOR_BUILD=3D''
ac_ct_CXX=3D''
ac_ct_F77=3D'gfortran'
am__fastdepCCAS_FALSE=3D'#'
am__fastdepCCAS_TRUE=3D''
am__fastdepCC_FALSE=3D'#'
am__fastdepCC_TRUE=3D''
am__fastdepCXX_FALSE=3D'#'
am__fastdepCXX_TRUE=3D''
am__include=3D'include'
am__isrc=3D''
am__leading_dot=3D'.'
am__quote=3D''
am__tar=3D'${AMTAR} chof - "$$tardir"'
am__untar=3D'${AMTAR} xf -'
bindir=3D'${exec_prefix}/bin'
build=3D'i386-pc-linux-gnu'
build_alias=3D'i386-pc-linux-gnu'
build_cpu=3D'i386'
build_os=3D'linux-gnu'
build_vendor=3D'pc'
datadir=3D'${datarootdir}'
datarootdir=3D'${prefix}/share'
docdir=3D'${datarootdir}/doc/${PACKAGE_TARNAME}'
dvidir=3D'${docdir}'
exec_prefix=3D'/usr'
host=3D'i686-pc-linux-gnu'
host_alias=3D'i686-linux'
host_cpu=3D'i686'
host_os=3D'linux-gnu'
host_vendor=3D'pc'
htmldir=3D'${docdir}'
includedir=3D'${prefix}/include'
infodir=3D'${datarootdir}/info'
install_sh=3D'$(SHELL) /home/malek/minisys/xenomai/buildroot/build_i686/x=
enomai-2.4.5/config/install-sh'
libdir=3D'${exec_prefix}/lib'
libexecdir=3D'${exec_prefix}/libexec'
localedir=3D'${datarootdir}/locale'
localstatedir=3D'${prefix}/var'
mandir=3D'${datarootdir}/man'
mkdir_p=3D'/bin/mkdir -p'
oldincludedir=3D'/usr/include'
pdfdir=3D'${docdir}'
prefix=3D'/usr/xenomai'
program_transform_name=3D''
psdir=3D'${docdir}'
sbindir=3D'${exec_prefix}/sbin'
sharedstatedir=3D'${prefix}/com'
sysconfdir=3D'/etc'
target=3D'i686-pc-linux-gnu'
target_alias=3D'i686-linux'
target_cpu=3D'i686'
target_os=3D'linux-gnu'
target_vendor=3D'pc'

## ----------- ##
## confdefs.h. ##
## ----------- ##

#define PACKAGE_NAME "Xenomai"
#define PACKAGE_TARNAME "xenomai"
#define PACKAGE_VERSION "2.4.5"
#define PACKAGE_STRING "Xenomai 2.4.5"
#define PACKAGE_BUGREPORT "xenomai@xenomai.org"
#define CONFIG_XENO_BUILD_STRING "i386-pc-linux-gnu"
#define CONFIG_XENO_HOST_STRING "i686-pc-linux-gnu"
#define CONFIG_XENO_COMPILER "gcc version 4.2.4"
#define PACKAGE "xenomai"
#define VERSION "2.4.5"
#define STDC_HEADERS 1
#define HAVE_SYS_TYPES_H 1
#define HAVE_SYS_STAT_H 1
#define HAVE_STDLIB_H 1
#define HAVE_STRING_H 1
#define HAVE_MEMORY_H 1
#define HAVE_STRINGS_H 1
#define HAVE_INTTYPES_H 1
#define HAVE_STDINT_H 1
#define HAVE_UNISTD_H 1
#define HAVE_DLFCN_H 1
#define HAVE_MQUEUE_H 1
#define CONFIG_XENO_VERSION_MAJOR 2
#define CONFIG_XENO_VERSION_MINOR 4
#define CONFIG_XENO_REVISION_LEVEL 5
#define CONFIG_X86_TSC 1
#define HAVE_RECENT_SETAFFINITY 1

configure: exit 0

--------------040209060401070907080507--

