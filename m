Message-ID: <52EBE4B7.6060800@xenomai.org>
Date: Fri, 31 Jan 2014 19:00:23 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAN1+YZVvgPNNHFub5QAkw6SeSUPuf1dv_94kYGqhbjMpNt70Sg@mail.gmail.com>
 <CAN1+YZWOjxf=s+6LH3Xymzx_mwWa6XmO_Xt7SHF589RzJCANBA@mail.gmail.com>
 <52D8609C.5050903@xenomai.org>
 <CAN1+YZW+nJgMb0hLy2JWZW6JrxA+mZzA+-oN-gjQgeGTcoe0jg@mail.gmail.com>
 <CAN1+YZUY_3FExF=qrUtMQDQxTqossnQsPCy6zfPjfqp8PitZCg@mail.gmail.com>
 <52D9984F.9080203@xenomai.org>
 <CAN1+YZWnLC=MLxWqYd9xH1URimWnOdEhU4mwZ0S3QFdpghUaGQ@mail.gmail.com>
 <52DAE756.3070606@xenomai.org>
 <CAN1+YZWmjvsu7My92EBktFhWYhheRJvdYrEq=r3+Ravp_Wzoyw@mail.gmail.com>
 <52DBC5FE.6060806@xenomai.org> <52DBD649.2000908@xenomai.org>
 <CAN1+YZWCMh4mR0ccw2v7FeuLKpYDUoPoB-FGHZmutj623DW7hw@mail.gmail.com>
 <52EB6BBC.8040600@xenomai.org>
 <CAN1+YZUhzb1zRE=dhjX+_1_b2cD2vEWatP6-je7b9NdNPosFvA@mail.gmail.com>
In-Reply-To: <CAN1+YZUhzb1zRE=dhjX+_1_b2cD2vEWatP6-je7b9NdNPosFvA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Fwd: Kernel Compilation Problems
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Andy Pugh <andy@bodgesoc.org>
Cc: xenomai <xenomai@xenomai.org>

On 01/31/2014 06:48 PM, Andy Pugh wrote:
> On 31 January 2014 09:24, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
>
>> Use the xeno_hal.supported_cpus parameter, it is a bitfield, so 1 is for
>> cpu 0.
>
> I have tried this, but I am not sure how to tell if it is working.
>
> The Udoo board seems a bit strange. The only way I have found to use
> setenv is to connect via a serial terminal and interrupt the boot
> sequence. At that point setenv / printenv work (this is also what is
> suggested in the Udoo docs).
> printenv shows:
>
> boot_fdt=try
> bootargs=isolcpus=0
> bootcmd=mmc dev ${mmcdev}; if mmc rescan; then if run loadbootscript;
> then run bootscript; else if run loaduimage; then run mmcboot; else
> run netboot; fi; fi; else run netboot; fi
>
> and
>
> update_sd_firmware_filename=u-boot.imx
> xeno_hal.supported_cpus=1
> Environment size: 2097/8188 bytes
>
> However dmesg contains:
>
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
> Total pages: 227328
> [    0.000000] Kernel command line: console=ttymxc1,115200
> root=/dev/mmcblk0p1 rootwait rw fbmem=24M
> video=mxcfb0:dev=hdmi,1920x1080M@60,bpp=32
> [    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
>
> and cat /proc/cmdline returns:
>
> andypugh@udoo:~$ cat /proc/cmdline
> console=ttymxc1,115200 root=/dev/mmcblk0p1 rootwait rw fbmem=24M
> video=mxcfb0:dev=hdmi,1920x1080M@60,bpp=32
>
> So I suspect that there is more to adding to the kernel command line
> than a simple "setenv" in this case. (I also suspect that this is a
> question for the Udoo forums rather than Xenomai)
>

xeno_hal.supported_cpus=1 is a kernel argument, thus it should be added 
to the boot arguments, like isolcpus. Since you do not see isolcpus on 
the kernel command line, I guess the loadbootcscript, bootscript, 
loaduimage, mmcboot or netboot script overrides the boot arguments. If 
you are booting from SD card, maybe you can find the script on the SD 
card itself?

I am afraid this is off-topic on this mailing list.

-- 
					    Gilles.

