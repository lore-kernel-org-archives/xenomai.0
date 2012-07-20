Message-ID: <5009A292.4060508@grandegger.com>
Date: Fri, 20 Jul 2012 20:25:22 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
References: <CE2E43470FE5444A811B580382FE5EDF2113D8D95A@KEMPMAIL2.woodward.com>
In-Reply-To: <CE2E43470FE5444A811B580382FE5EDF2113D8D95A@KEMPMAIL2.woodward.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai installation on P1020RDB
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lukasz Zemla <Lukasz.Zemla@woodward.com>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

Hi Lukasz,

On 07/20/2012 04:31 PM, Lukasz Zemla wrote:
> Hello,
> 
> Has anyone some experience with installing Xenomai on P1020RDB board? I'd like to perform some benchmarks on this board.
> I'm trying to install it using the latest Freescale SDK 1.2 based on Yocto. But hints for SDK 1.0.3 would be also fine. Finally every way for getting it working... ;-)
> 
> What I'm doing is getting Freescale kernel (3.0.34):

If you can, use a *mainline* kernel. The latest Xenomai patch is for
Linux 3.2.21 and that version does well support the P1020RDB, IIRC.

>                bitbake -c unpack virtual/kernel
> and then trying manually to run prepare-kernel.sh pointing to directory where sources where unpacked. I tried all i-pipe 3.x patches - but all of them returned error.
> 
> Is it true that i-pipe can be applied _only_ to the _vanilla_ kernel with version which _exactly_ matches i-pipe patch version?

If you are lucky it will apply to other (rather close) versions as
well, but it is no surprise if it fails. 

> Next I tried to install Xenomai on vanilla 3.1.10 kernel. I got compilation error:
> 
>         arch/powerpc/sysdev/fsl_lbc.c: In function 'fsl_lbc_ctrl_irq':
>         arch/powerpc/sysdev/fsl_lbc.c:247:3: error: 'TASK_NORMAL' undeclared (first use in this function)

That has nothing to do with Xenomai. Did you try to build the vanilla
kernel first?

> I fixed it by adding '#include <linux/sched.h>' in arch/powerpc/sysdev/fsl_lbc.c file. After successful build the kernel hung just after loading DTB.
> 
> 
> 
> Filename 'p1020rdb-pc.dtb'.
> 
> Load address: 0xc00000
> 
> Loading: ###
> 
> done
> 
> Bytes transferred = 12888 (3258 hex)
> 
> WARNING: adjusting available memory to 30000000
> 
> ## Booting kernel from Legacy Image at 01000000 ...
> 
>    Image Name:   Linux-3.1.10
> 
>    Created:      2012-07-20  13:54:54 UTC
> 
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
> 
>    Data Size:    3757211 Bytes = 3.6 MiB
> 
>    Load Address: 00000000
> 
>    Entry Point:  00000000
> 
>    Verifying Checksum ... OK
> 
> ## Loading init Ramdisk from Legacy Image at 02000000 ...
> 
>    Image Name:   fsl-image-minimal-ww-p1020rdb-20
> 
>    Created:      2012-07-18   9:30:13 UTC
> 
>    Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
> 
>    Data Size:    4596585 Bytes = 4.4 MiB
> 
>    Load Address: 00000000
> 
>    Entry Point:  00000000
> 
>    Verifying Checksum ... OK
> 
> ## Flattened Device Tree blob at 00c00000
> 
>    Booting using the fdt blob at 0xc00000
> 
>    Uncompressing Kernel Image ... OK
> 
>    Loading Ramdisk to 2fb9d000, end 2ffff369 ... OK
> 
>    Loading Device Tree to 00ff9000, end 00fff257 ... OK

This is also not related to Xenomai. Did you set the console properly?
You may be able to list the kernel log buffer after a soft-reset at
address "grep __log_buf System.map | cut -d" " -f1" - 0xc0000000
using the U-Boot command "md".

I tested Xenomai recently on a P2020 with mainline Linux 3.2.x with the
new iPipe-Patch and got very good latency results, especially with CPU
isolation: 65 us without and *8* us with CPU isolation. [I'm still puzzled
about the good results with CPU isolation. Maybe that's due to the new
iPipe-Patch. Need to re-test when time permits). I have listed the results
below.

Hope this info is useful.

Wolfgang.


Latency-Test *without* CPU isolation:
=====================================

- After 4 hours and concurrent load generation via

  # while sleep 5; do ./hackbench 50; done
  # while true; do ./calibrator 1200 256M calib.dat; done

in two separate ssh sessions I got:

  RTT|  04:15:31  (periodic user-mode task, 10000 us period, priority 99)
  RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat worst
  RTD|     16.360|     20.640|     29.146|       0|     0|      0.666|     65.986
  RTD|     16.733|     21.093|     27.333|       0|     0|      0.666|     65.986
  ...
  ^C
  ---|-----------|-----------|-----------|--------|------|-------------------------
  RTS|      0.666|     14.493|     65.986|       0|     0|    04:15:43/04:15:43


Latency-Test *with* CPU isolation:
==================================

- Boot Linux with bootargs "isolcpus=1".

- Set smp_affinity for all interrupts:

  # echo 1 > /proc/irq/default_smp_affinity
  # for f in `ls /proc/irq/[0-9]*/smp_affinity`; do echo 1 > $f; done

- Generate load in two separate ssh sessions:

  # while sleep 5; do ./hackbench 50; done
  # while true; do ./calibrator 1200 256M calib.dat; done

- Run latency test on the second CPU:

  # cat /proc/xenomai/latency
  1986
  # latency -p10000 -c1
  ...
  RTT|  04:13:46  (periodic user-mode task, 10000 us period, priority 99)
  RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat worst
  RTD|      0.946|      1.546|      2.280|       0|     0|      0.466|      7.386
  RTD|      1.013|      1.746|      3.053|       0|     0|      0.466|      7.386
  ...
  ^C
  ---|-----------|-----------|-----------|--------|------|-------------------------
  RTS|      0.466|      1.480|      7.386|       0|     0|    04:13:50/04:13:50




