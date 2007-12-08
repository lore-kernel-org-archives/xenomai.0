Message-ID: <475A72DA.5090008@domain.hid>
Date: Sat, 08 Dec 2007 11:32:58 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <200712072347.07847.niklaus.giger@domain.hid>
In-Reply-To: <200712072347.07847.niklaus.giger@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Are these results running the xeno-test on a
 Sequoia board okay?
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: niklaus.giger@domain.hid
Cc: xenomai@xenomai.org

Niklaus Giger wrote:
> Hi
> 
> I ran xeno-test on my sequoia board and am puzzled about three points:
> 
> 1) When xeno-test was running the latency test, I loaded the system a little
> bit by pinging, then doing a login on /dev/ttyS0 the numbers suddenly
> changed to "inf"
> RTD|      -0.862|      -0.816|      12.962|       0|      -1.236|      29.857
> RTD|         inf|         inf|         inf|       0|         inf|         inf
> 
> 2) Running switchtest I got
> Error after context switch from task 8(rtup-8) to task 10(rtup_ufpp-10),
> FPU registers were set to 1000 (maybe task sleeper_ufps-0)
> RTT|  00:00:00
> RTH|ctx switches|-------total
> RTD|          28|          28
> 
> 3) I had to recompile my C++-testsuite adding mhard-float to CXXFLAGS to
> make it work correctly. Though it seems to me that setting CXX=ppc_4xxFP-g++
> was not enough. I have no idea whether this has a something to do with the
> problems spotted above.
> 
> I attach the used .config and xeno-test.log.
> 
> I built it like this using the DENX-kernel
> cd /home/hcu/celsius/linux-2.6-xenomai
> /home/hcu/celsius/xenomai-trunk/scripts/prepare-kernel.sh --linux=/home/hcu/celsius/linux-2.6-xenomai --adeos=/home/hcu/celsius/xenomai-trunk/ksrc/arch/powerpc/patches/adeos-ipipe-2.6.23-powerpc-DENX-2.0-03.patch --arch=powerpc

You need to use adeos-ipipe-2.6.23-ppc-1.6-00.patch for the sequoia
since it still depends on the ppc/ tree, on top of DENX-v2.6.23.8.
Passing --arch=ppc to prepare-kernel.sh instead of --arch=powerpc
without specifying an Adeos patch would pre-select the right one.

> make  ARCH=powerpc CROSS_COMPILE=ppc_4xxFP- O=/home/hcu/celsius/build-xeno-sequoia-powerpc-DENX-v2.6.23.9 oldconfig
> make  ARCH=powerpc CROSS_COMPILE=ppc_4xxFP- O=/home/hcu/celsius/build-xeno-sequoia-powerpc-DENX-v2.6.23.9 zImage modules
> sudo make  ARCH=powerpc CROSS_COMPILE=ppc_4xxFP- O=/home/hcu/celsius/build-xeno-sequoia-powerpc-DENX-v2.6.23.9 PATH=$/usr/local/bin:/opt/eldk/4_1/usr/bin:/usr/bin:/bin INSTALL_MOD_PATH=/opt/eldk/4_1/ppc_4xxFP modules_install
> sudo cp -v /home/hcu/celsius/build-xeno-sequoia-powerpc-DENX-v2.6.23.9/arch/powerpc/boot/zImage /tftpboot/buildbot/zImage-sequoia
> sudo cp -v /home/hcu/celsius/build-xeno-sequoia-powerpc-DENX-v2.6.23.9/arch/powerpc/boot/zImage /tftpboot/sequoia/zImage
> cd /home/hcu/celsius/build-xeno-sequoia-powerpc-DENX-v2.6.23.9
> /home/hcu/celsius/xenomai-trunk/configure --build=i686-linux --host=powerpc CROSS_COMPILE=ppc_4xxFP CC=ppc_4xxFP-gcc CXX=ppc_4xxFP-g++ LD=ppc_4xxFP-ld
> make  clean
> make
> sudo make  PATH=/usr/local/bin:/opt/eldk/4_1/usr/bin:/usr/bin:/bin  DESTDIR=/opt/eldk/4_1/ppc_4xxFP install
> cd /home/hcu/celsius
> 
> Best regards
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
Philippe.

