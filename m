Message-ID: <50FE45E9.1040909@xenomai.org>
Date: Tue, 22 Jan 2013 08:55:21 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <OF682F5C70.F8F7AA50-ON85257AF1.005F580A-85257AF1.005F580C@aanddtech.com>	<50F3DD9A.9050306@gmail.com>
	<OF5CF00330.868585F8-ON85257AFA.00801D57-85257AFB.00000E92@aanddtech.com>
In-Reply-To: <OF5CF00330.868585F8-ON85257AFA.00801D57-85257AFB.00000E92@aanddtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Porting Ipipe to new ARM SoC (Xilinx Zynq)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: mfornero@aanddtech.com
Cc: Xenomai@xenomai.org

On 01/22/2013 01:00 AM, mfornero@aanddtech.com wrote:

> The issue seems to be somewhat erratic, as I was able to run the latency 
> test for a couple of hours this morning without observing it. Now however, 
> it seems to show up on every boot (I don't believe I changed anything, but 
> it's possible).
> 
> For reference, I'm booting from a SDHC partitioned as such:
>         1) vfat         256 MB <-- This partition holds the first stage 
> bootloader, uboot, the device tree and the Kernel zImage
>         2) ext4         768 MB <-- This partition is the rootfs (busybox + 
> xenomai)
> 
> The kernel boot command line is:
>         bootargs = "console=ttyPS0,115200 root=/dev/mmcblk0p2 rw 
> earlyprintk rootfstype=ext4 rootwait devtmpfs.mount=1";
> 
> And I'm using the uboot compilation shipped with the ZedBoard.
> 
> My ipipe port can be found here:
> git://github.com/mfornero/ipipe.git


At a quick glance, you are missing this change:
http://xenomai.org/index.php/I-pipe-core:ArmPorting#GPIOs_as_interrupt_sources

In drivers/gpio/gpio-xilinxps.c

-- 
                                                                Gilles.

