Message-ID: <54687601.5020805@free.fr>
Date: Sun, 16 Nov 2014 11:01:37 +0100
From: Thierry Bultel <tbultel@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Some questions and issues about Xenomai 3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,
I am currently attempting to port my application from xenomai-2.6.(3/4) 
to xenomai-3-rc2

My application uses the canfestival package, which uses rt_socket_can.
The distribution is buildroot, and I have hacked it a little to support 
the build of mercury, because it is not supported yet.

For info, I have basically added this:
XENOMAI_CONF_OPT += --with-core=mercury
XENOMAI_CONF_OPT += --enable-smp
XENOMAI_CONF_OPT += --enable-pshared
XENOMAI_CONF_OPT += --enable-registry

I am encountering several issues:

1) xeno-config
a) it says an error with posix skin
localuser@thierry-desktop ~/workspace/agv (STD_ITG_15.03)*$ 
/nous/BASYSTEMES/buildroot/buildroot_agv_v15_amos820/host/usr/arm-buildroot-linux-gnueabihf/sysroot/usr/bin/xeno-config 
--skin=posix --cflags
unknown RTOS skin: posix

b) --compat fails, and is not mentioned in the Usage
 
/nous/BASYSTEMES/buildroot/buildroot_agv_v15_amos820/host/usr/arm-buildroot-linux-gnueabihf/sysroot/usr/bin/xeno-config 
--skin=native --cflags --compat
-I/usr/include/xenomai/mercury -I/usr/include/xenomai 
-D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -pipe 
-Os -D_GNU_SOURCE -D_REENTRANT -D__MERCURY__ -I/usr/include/xenomai/alchemy
Usage xeno-config OPTIONS
Options :
         --help
         --v,--verbose
         --version
         --cc
         --ccld
         --arch
         --prefix
         --[skin=]posix|vxworks|psos|alchemy|rtdm|smokey
         --auto-init|no-auto-init
         --cflags
         --ldflags
         --lib*-dir,--libdir,--user-libdir
         --core
         --info

c) provided that is should work, and that b) is related to an error of 
mine, would --compat fix the headers issue for applications that 
explicitly use #include <native/...> ? For now and testing I have SEDed 
them.

2) I have read in the manual that rtcan.h has been renamed to can.h
But after the install step, can.h is not installed in the staging.
buildroot was using "make install-user" for doing so. Changing to "make 
install" does not help.

3) More general question, about rtcan:
prepare_kernel.sh seems definitively needed for Cobalt kernel only. So 
how can the rtcan drivers be built in the PREEMPT_RT kernel ?
Sorry for my dummy question.

Regards
Thierry

