Date: Mon, 10 Oct 2016 02:10:40 +0000 (UTC)
From: Shen Felix <wishnextyear@yahoo.com.tw>
Message-ID: <1770847975.249497.1476065440623@mail.yahoo.com>
MIME-Version: 1.0
References: <1770847975.249497.1476065440623.ref@mail.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] multiple definition of `xenomai_main'
Reply-To: Shen Felix <wishnextyear@yahoo.com.tw>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,
I am building Etherlab ethercat master application with RTDM interface.
The steps I used as follows:
step 1. Installing the Xenomai libraries and toolsA. get Xenomail release t=
arball: xenomai-3.0.1.tar.bz2B. building:$ export xenomai_root=3D"/work/dev=
elop/xenomai-3.0.1"$ export build_root=3D"/work/tmp/xenomai/build_root"$ mk=
dir $build_root/xenomai && cd $build_root/xenomai$ xenomai_root/configure C=
FLAGS=3D"-march=3Darmv7-a -mfpu=3Dvfp3" LDFLAGS=3D"-march=3Darmv7-a -mfpu=
=3Dvfp3" --build=3Di686-pc-linux-gnu --host=3Darm-linux-gnueabihf --with-co=
re=3Dcobalt$ make installNow, I got Xenomia libraries and tools under /usr/=
xenomai.So, I build application after got Xenomai libraries.

step 2. Building Etherlab(ethercat-1.5.2) softwareA. get and extract etherc=
at-1.5.2.tar.bz2B. building:$ export ethercatpath=3D/work/tmp/ethercat-hg$ =
export kernelpath=3D/work/develop/botbone_os_kernel$ export targetpath=3D${=
ethercatpath}/target/xenomai$ export xenomaipath=3D/usr/xenomaimkdir -p ${t=
argetpath}cd ${ethercatpath}$ ./configure --with-devices=3D2 --enable-8139t=
oo=3Dno --enable-generic=3Dyes --enable-rtdm --with-xenomai-dir=3D${xenomai=
path} --with-linux-dir=3D${kernelpath} CC=3Darm-linux-gnueabihf-gcc CXX=3Da=
rm-linux-gnueabihf-g++ CPP=3Darm-linux-gnueabihf-cpp --host=3Darm-none-linu=
x-gnueabi$ make=C2=A0
But, I failed to compile the application and got error as follows:.../usr/x=
enomai/lib/xenomai/bootstrap.o: In function `__wrap_main':bootstrap.c:(.tex=
t+0x0): multiple definition of `xenomai_main'/usr/xenomai/lib/xenomai/boots=
trap.o:bootstrap.c:(.text+0x0): first defined here/work/tmp/ethercat-hg/lib=
/.libs/libethercat_rtdm.so: undefined reference to `rt_dev_ioctl'/work/tmp/=
ethercat-hg/lib/.libs/libethercat_rtdm.so: undefined reference to `rt_dev_o=
pen'/work/tmp/ethercat-hg/lib/.libs/libethercat_rtdm.so: undefined referenc=
e to `rt_dev_close'collect2: error: ld returned 1 exit statusmake[4]: *** [=
ec_xenomai_example] Error 1make[4]: Leaving directory `/work/tmp/ethercat-h=
g/examples/xenomai'make[3]: *** [all-recursive] Error 1make[3]: Leaving dir=
ectory `/work/tmp/ethercat-hg/examples'make[2]: *** [all] Error 2make[2]: L=
eaving directory `/work/tmp/ethercat-hg/examples'make[1]: *** [all-recursiv=
e] Error 1make[1]: Leaving directory `/work/tmp/ethercat-hg'make: *** [all]=
 Error 2

I don't understand what happened because I just compiled source code.So, It=
's sure I make wrong setting for those two configure process.Or, I forgot t=
o set any correct libraries path for compiling?Could anyone give me any sug=
gestion for these errors?Thank you in advance.

