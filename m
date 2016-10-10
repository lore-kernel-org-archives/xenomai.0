References: <1770847975.249497.1476065440623.ref@mail.yahoo.com>
 <1770847975.249497.1476065440623@mail.yahoo.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <9411ec08-4bef-001b-24d3-375654710b84@xenomai.org>
Date: Mon, 10 Oct 2016 08:56:45 +0200
MIME-Version: 1.0
In-Reply-To: <1770847975.249497.1476065440623@mail.yahoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] multiple definition of `xenomai_main'
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Shen Felix <wishnextyear@yahoo.com.tw>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 10/10/2016 04:10 AM, Shen Felix wrote:
> Hi,
> I am building Etherlab ethercat master application with RTDM interface.
> The steps I used as follows:
> step 1. Installing the Xenomai libraries and toolsA. get Xenomail release tarball: xenomai-3.0.1.tar.bz2B. building:$ export xenomai_root="/work/develop/xenomai-3.0.1"$ export build_root="/work/tmp/xenomai/build_root"$ mkdir $build_root/xenomai && cd $build_root/xenomai$ xenomai_root/configure CFLAGS="-march=armv7-a -mfpu=vfp3" LDFLAGS="-march=armv7-a -mfpu=vfp3" --build=i686-pc-linux-gnu --host=arm-linux-gnueabihf --with-core=cobalt$ make installNow, I got Xenomia libraries and tools under /usr/xenomai.So, I build application after got Xenomai libraries.

Please use 3.0.3.

> 
> step 2. Building Etherlab(ethercat-1.5.2) softwareA. get and extract ethercat-1.5.2.tar.bz2B. building:$ export ethercatpath=/work/tmp/ethercat-hg$ export kernelpath=/work/develop/botbone_os_kernel$ export targetpath=${ethercatpath}/target/xenomai$ export xenomaipath=/usr/xenomaimkdir -p ${targetpath}cd ${ethercatpath}$ ./configure --with-devices=2 --enable-8139too=no --enable-generic=yes --enable-rtdm --with-xenomai-dir=${xenomaipath} --with-linux-dir=${kernelpath} CC=arm-linux-gnueabihf-gcc CXX=arm-linux-gnueabihf-g++ CPP=arm-linux-gnueabihf-cpp --host=arm-none-linux-gnueabi$ make 
> But, I failed to compile the application and got error as follows:.../usr/xenomai/lib/xenomai/bootstrap.o: In function `__wrap_main':bootstrap.c:(.text+0x0): multiple definition of `xenomai_main'/usr/xenomai/lib/xenomai/bootstrap.o:bootstrap.c:(.text+0x0): first defined here/work/tmp/ethercat-hg/lib/.libs/libethercat_rtdm.so: undefined reference to `rt_dev_ioctl'/work/tmp/ethercat-hg/lib/.libs/libethercat_rtdm.so: undefined reference to `rt_dev_open'/work/tmp/ethercat-hg/lib/.libs/libethercat_rtdm.so: undefined reference to `rt_dev_close'collect2: error: ld returned 1 exit statusmake[4]: *** [ec_xenomai_example] Error 1make[4]: Leaving directory `/work/tmp/ethercat-hg/examples/xenomai'make[3]: *** [all-recursive] Error 1make[3]: Leaving directory `/work/tmp/ethercat-hg/examples'make[2]: *** [all] Error 2make[2]: Leaving directory `/work/tmp/ethercat-hg/examples'make[1]: *** [all-recursive] Error 1make[1]: Leaving directory `/work/tmp/ethercat-hg'make: *** [all] Error 2
> 
> I don't understand what happened because I just compiled source code.So, It's sure I make wrong setting for those two configure process.Or, I forgot to set any correct libraries path for compiling?Could anyone give me any suggestion for these errors?Thank you in advance.
> 

It looks like the Ethercat build system was not updated for using
Xenomai 3.x, at least to enable the backward compatibility mode for
using the obsolete rt_dev_* API. The double definition of xenomai_main()
denotes an issue with the LDFLAGS.

-- 
Philippe.

