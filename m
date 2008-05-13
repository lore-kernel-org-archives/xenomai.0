Date: Tue, 13 May 2008 10:53:13 +0200
Message-Id: <749025575@domain.hid>
MIME-Version: 1.0
From: Joachim Meyer <Jogi95@domain.hid>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Cross-Compile Xenomai
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

Hi

I try to cross compile Xenomai for an embedded PPC405. 
I already patched the Linux Kernel and now I try to crosscompile Xenomai like I read in the README:

2.2 Building for the PowerPC architecture
-----------------------------------------

A typical cross-compilation setup, in order to build Xenomai for a
PowerPC-405-based system:

$ $xenomai_root/scripts/prepare-kernel.sh --arch=powerpc \
  --adeos=$xenomai_root/ksrc/arch/powerpc/patches/adeos-ipipe-2.6.14-ppc-X.Y-ZZ.patch \
  --linux=$linux_tree
$ cd $linux_tree
$ mkdir ../build-powerpc-405-2.6.14
$ make ARCH=ppc CROSS_COMPILE=powerpc-405-linux-gnu- O=../build-powerpc-405-2.6.14 xconfig/gconfig/menuconfig 
# select the kernel and Xenomai options
$ make ARCH=ppc CROSS_COMPILE=powerpc-405-linux-gnu- O=../build-powerpc-405-2.6.14 bzImage modules 
# then install as needed
$ mkdir $build_root && cd $build_root
$ $xenomai_root/configure --build=i686-linux --host=powerpc-405-linux-gnu
$ make install

Now, everything seems to be fine but when I try make install, I get errors because I have now root privileges and so I can't create a folder:

make[4]: Entering directory `/home/meyer/xenomai/xenroot2/src/skins/native'
test -z "/usr/xenomai/lib" || mkdir -p -- "/usr/xenomai/lib"
mkdir: cannot create directory `/usr/xenomai': Permission denied
make[4]: *** [install-libLTLIBRARIES] Error 1
make[4]: Leaving directory `/home/meyer/xenomai/xenroot2/src/skins/native'
make[3]: *** [install-am] Error 2
make[3]: Leaving directory `/home/meyer/xenomai/xenroot2/src/skins/native'
make[2]: *** [install-recursive] Error 1
make[2]: Leaving directory `/home/meyer/xenomai/xenroot2/src/skins'
make[1]: *** [install-recursive] Error 1
make[1]: Leaving directory `/home/meyer/xenomai/xenroot2/src'
make: *** [install-recursive] Error 1

Can I crosscompile Xenomai without root privileges?

Greez
Joachim

_____________________________________________________________________
Der WEB.DE SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen!
http://smartsurfer.web.de/?mc=100071&distributionid=000000000066


