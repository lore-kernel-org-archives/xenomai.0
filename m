Date: Sat, 10 Mar 2018 12:34:14 +0200 (EET)
From: =?windows-1251?B?2OXi9+Xt6u4g0uDw4PEgw/Do4+7w/OXi6Pc=?=
 <shevchenko.taras@triolcorp.com.ua>
Message-ID: <257160912.3337070.1520678054386.JavaMail.zimbra@triolcorp.com.ua>
In-Reply-To: <0810a571-c3a3-5e17-7054-42ec68b9787a@xenomai.org>
References: <2114790524.3335654.1520673402537.JavaMail.zimbra@triolcorp.com.ua>
 <0810a571-c3a3-5e17-7054-42ec68b9787a@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] -Werror=format-security
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai <xenomai@xenomai.org>



I cloned repo just yesterday
and now this issue is not fixed

so i decide to use   xenomai-3.0.6.tar.bz2  and successfully install it
/usr/xenomai/sbin# ./version=20
Xenomai/cobalt v3.0.6

./xeno-config=20
xeno-config --verbose
        --core=3Dcobalt
        --version=3D"3.0.6"
        --cc=3D"gcc"
        --ccld=3D"/usr/xenomai/bin/wrap-link.sh gcc"
        --arch=3D"x86"
        --prefix=3D"/usr/xenomai"
        --library-dir=3D"/usr/xenomai/lib"


but the same errors get when compile rtdm modules and  add #include <rtdm/r=
tdm.h> in my *.c

I need help cause ready to give up

make -C /usr/src/linux-headers-4.9.51-xenomai/ M=3D/home/yeti/develop/rtdm_=
hello modules
make[1]: Entering directory '/usr/src/linux-headers-4.9.51-xenomai'
  CC [M]  /home/yeti/develop/rtdm_hello/rtdm_hello.o
In file included from include/xenomai/rtdm/fd.h:27:0,
                 from include/xenomai/rtdm/rtdm.h:28,
                 from /home/yeti/develop/rtdm_hello/rtdm_hello.c:3:
./include/asm-generic/xenomai/syscall.h:24:34: fatal error: asm/xenomai/fea=
tures.h: No such file or directory
compilation terminated.
scripts/Makefile.build:299: recipe for target '/home/yeti/develop/rtdm_hell=
o/rtdm_hello.o' failed
make[2]: *** [/home/yeti/develop/rtdm_hello/rtdm_hello.o] Error 1
Makefile:1493: recipe for target '_module_/home/yeti/develop/rtdm_hello' fa=
iled
make[1]: *** [_module_/home/yeti/develop/rtdm_hello] Error 2
make[1]: Leaving directory '/usr/src/linux-headers-4.9.51-xenomai'
Makefile:3: recipe for target 'all' failed
make: *** [all] Error 2


----- Original Message -----
From: "Philippe Gerum" <rpm@xenomai.org>
To: "=D8=E5=E2=F7=E5=ED=EA=EE =D2=E0=F0=E0=F1 =C3=F0=E8=E3=EE=F0=FC=E5=E2=
=E8=F7" <shevchenko.taras@triolcorp.com.ua>, "xenomai" <xenomai@xenomai.org=
>
Sent: Saturday, March 10, 2018 12:08:11 PM
Subject: Re: [Xenomai] -Werror=3Dformat-security

On 03/10/2018 10:16 AM, =D8=E5=E2=F7=E5=ED=EA=EE =D2=E0=F0=E0=F1 =C3=F0=E8=
=E3=EE=F0=FC=E5=E2=E8=F7 wrote:
> Now my new attempt=20
>=20
> git clone [ https://git.xenomai.org/xenomai-3.git | https://git.xenomai.o=
rg/xenomai-3.git ]=20
> git checkout stable-3.0.x=20
> cd xenomai-3=20
> ./script/bootstrap=20
> ./configure --with-pic --with-core=3Dcobalt --enable-smp --disable-tls --=
enable-dlopen-libs=20
> make -j4=20
>=20
>=20
> and get error=20
>=20
> make[3]: Entering directory '/usr/src/xenomai-3/testsuite/smokey/dlopen'=
=20
> CC libdlopen_a-dlopen.o=20
> CC libalchemy_test_la-libalchemy-test.lo=20
> CC libposix_test_la-libposix-test.lo=20
> CC dlopentest-dlopentest.o=20
> dlopentest.c: In function =91my_dlopen=92:=20
> dlopentest.c:46:4: error: format not a string literal and no format argum=
ents [-Werror=3Dformat-security]=20
> error(1, errno, dlerror());=20
> ^=20
> cc1: all warnings being treated as errors=20
> Makefile:671: recipe for target 'dlopentest-dlopentest.o' failed=20
>=20
>=20
> should I disable some options gcc or make changes in code ?=20

Your compiler seems to have -Wformat-security enabled by default. Either
drop --enable-dlopen-libs unless you actually need this, or pull the
latest changes from the repository where this issue is now fixed.

Whenever you may have a solution to the issue being reported, do not
hesitate to send a patch fixing it along with such report. If
maintainers don't agree with the change, well, no big deal, they will
simply enter a discussion, explaining the issue they might have with the
suggested fix. Or they should just merge the fix if they are fine with it.

In either cases, bugs are being fixed, knowledge is being shared, this
will always be a win.

--=20
Philippe.

