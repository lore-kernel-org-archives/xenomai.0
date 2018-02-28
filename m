Date: Wed, 28 Feb 2018 16:13:00 +0200 (EET)
From: =?windows-1251?B?2OXi9+Xt6u4g0uDw4PEgw/Do4+7w/OXi6Pc=?=
 <shevchenko.taras@triolcorp.com.ua>
Message-ID: <500456767.8825156.1519827180703.JavaMail.zimbra@triolcorp.com.ua>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] RTnet
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org


Hi!=20

I do it first time and followed http://rtt-lwr.readthedocs.io/en/latest/rtp=
c/rtnet.html=20

I tried to install rtnet and get some error=20
taras@prog-pc12:~/RTnet$ sudo make menuconfig=20
make[1]: Entering directory '/home/taras/RTnet/scripts/kconfig'=20
#=20
# using defaults found in ../../.rtnet_config=20
#=20


*** End of RTnet configuration.=20
*** Execute 'make' to build RTnet or try 'make help'.=20

make[1]: Leaving directory '/home/taras/RTnet/scripts/kconfig'=20
/bin/sh: 3: /home/taras/RTnet/configure: not found=20
makefile:51: recipe for target 'config.status' failed=20
make: *** [config.status] Error 1=20



or if i do  ./configure    a get=20
checking for main in -lncurses... yes=20
checking for RTnet Kconfig file... ./defconfig (default)=20

checking for RT-extension... /usr/xenomai (Xenomai 2.0.x)=20
checking for Xenomai version... configure: error: *** Unsupported Xenomai v=
ersion 3.0.5 in /usr/xenomai=20
taras@prog-pc12:~/RTnet$=20

What s wrong ? Please help/=20

some outputs=20

taras@prog-pc12:/usr/xenomai/bin$ ./xeno-config --info|grep -i build=20
Build args: --with-pic --with-core=3Dcobalt --enable-smp --disable-tls --en=
able-dlopen-libs --disable-clock-monotonic-raw=20

taras@prog-pc12:/usr/xenomai/bin$ cd /usr/xenomai/sbin/=20
taras@prog-pc12:/usr/xenomai/sbin$ ./version=20
Xenomai/cobalt v3.0.5=20

taras@prog-pc12:/usr/xenomai/sbin$ uname -r=20
4.9.38-xenomai-3.0.5=20



=D1 =F3=E2=E0=E6=E5=ED=E8=E5=EC =E8 =ED=E0=E4=E5=E6=E4=EE=E9 =ED=E0 =F1=EE=
=F2=F0=F3=E4=ED=E8=F7=E5=F1=F2=E2=EE,=20
=D8=E5=E2=F7=E5=ED=EA=EE =D2.=C3.=20
