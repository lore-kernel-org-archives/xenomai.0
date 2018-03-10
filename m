Date: Sat, 10 Mar 2018 11:16:42 +0200 (EET)
From: =?windows-1251?B?2OXi9+Xt6u4g0uDw4PEgw/Do4+7w/OXi6Pc=?=
 <shevchenko.taras@triolcorp.com.ua>
Message-ID: <2114790524.3335654.1520673402537.JavaMail.zimbra@triolcorp.com.ua>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] -Werror=format-security
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

Now my new attempt=20

git clone [ https://git.xenomai.org/xenomai-3.git | https://git.xenomai.org=
/xenomai-3.git ]=20
git checkout stable-3.0.x=20
cd xenomai-3=20
./script/bootstrap=20
./configure --with-pic --with-core=3Dcobalt --enable-smp --disable-tls --en=
able-dlopen-libs=20
make -j4=20


and get error=20

make[3]: Entering directory '/usr/src/xenomai-3/testsuite/smokey/dlopen'=20
CC libdlopen_a-dlopen.o=20
CC libalchemy_test_la-libalchemy-test.lo=20
CC libposix_test_la-libposix-test.lo=20
CC dlopentest-dlopentest.o=20
dlopentest.c: In function =91my_dlopen=92:=20
dlopentest.c:46:4: error: format not a string literal and no format argumen=
ts [-Werror=3Dformat-security]=20
error(1, errno, dlerror());=20
^=20
cc1: all warnings being treated as errors=20
Makefile:671: recipe for target 'dlopentest-dlopentest.o' failed=20


should I disable some options gcc or make changes in code ?=20
