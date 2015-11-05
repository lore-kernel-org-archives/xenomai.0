References: <OF6134003B.3BB84DA5-ONC1257EF4.002BF1E4-C1257EF4.002EC9DB@zodiacaerospace.com>
From: Stefan Roese <sr@denx.de>
Message-ID: <563B36E9.9070809@denx.de>
Date: Thu, 5 Nov 2015 12:00:57 +0100
MIME-Version: 1.0
In-Reply-To: <OF6134003B.3BB84DA5-ONC1257EF4.002BF1E4-C1257EF4.002EC9DB@zodiacaerospace.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai on Linux 3.18 on Zynq
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe.Corbel@zodiacaerospace.com, xenomai@xenomai.org

Hi Philippe,

On 05.11.2015 09:31, Philippe.Corbel@zodiacaerospace.com wrote:
> I just subscribe to the mailing list to ask you for a few insight on my
> potential problem.
>
> I'm having the same behaviour that Andreas Galauner observed on his board
> and since there have been no news since April, I'm restarting this
> thread...
>
> I'm currently developping for a custom designed board based on a Zynq
> 7c020 and hoped to use Xenomai 3.0 on it.
> Standard Linux (Xilinx version not Vanilla) is running fine on the board
> but if I use the cobalt core, I'm having the same behaviour previously
> described ie the system seems to hang for a random duration then becomes
> responsive again as if nothing happened (several times).
> It happens at each boot during:
> - kernel decompression
> - VFS/Rootfs mount
> - console access
> And after, it occurs randomly on command entered on console...
>
> Also, it seems that network is not working with cobalt core enabled in
> kernel (but with random freezes, I can't look at this issue for the
> moment)
>
> I'm suspecting some timer issue as Gilles supposed previously but I can't
> find the beginning of a solution: I've followed the Guide "Porting Xenomai
> dual kernel to a new ARM SoC" but as the arm core of the Zynq is a Cortex
> A9, in theory, I've practically nothing to modify to have it working...
>
> I've also enabled debug in I-Pipe and Xenoami and got no trace at all...
>
> What I've seen so far is an enormous amount of interruptions on the twd
> timer (and this is just after the boot!):
>
> # cat /proc/interrupts
>             CPU0       CPU1
>   27:          0          0       GIC  27  gt
>   29:   37426949   16329631       GIC  29  twd
>   35:          0          0       GIC  35  f800c000.ocmc
>   39:         43          0       GIC  39  f8007100.adc
>   40:          0          0       GIC  40  f8007000.devcfg
>   41:          0          0       GIC  41  f8005000.watchdog
>   43:          0          0       GIC  43  ttc_clockevent
>   45:          0          0       GIC  45  f8003000.dmac
>   46:          0          0       GIC  46  f8003000.dmac
>   47:          0          0       GIC  47  f8003000.dmac
>   48:          0          0       GIC  48  f8003000.dmac
>   49:          0          0       GIC  49  f8003000.dmac
>   51:          0          0       GIC  51  e000d000.spi
>   54:          0          0       GIC  54  eth0
>   72:          0          0       GIC  72  f8003000.dmac
>   73:          0          0       GIC  73  f8003000.dmac
>   74:          0          0       GIC  74  f8003000.dmac
>   75:          0          0       GIC  75  f8003000.dmac
>   82:         49          0       GIC  82  xuartps
> IPI1:          0          0  Timer broadcast interrupts
> IPI2:        559        435  Rescheduling interrupts
> IPI3:          0          0  Function call interrupts
> IPI4:         25          8  Single function call interrupts
> IPI5:          0          0  CPU stop interrupts
> IPI6:          0          0  IRQ work interrupts
> IPI7:          0          0  completion interrupts
> Err:          0
>
> To be more precise about my system, I'm using Linux 3.18.20 with the Adeos
> I-Pipe patch for arm found in Xenomai 3.0 (Exact Zero) tarball on a
> busybox-based rootfs.
> I've taken a look at branch for-ipipe-3.18 in ipipe-gch.git but it seems
> to be the same as  Xenomai 3.0's patch...
>
> Does anyone have some idea where to look for a way to attack this issue?
>
> Thanks in advance,
>
> PS: If necessary I can post the kernel's config, but I did not want to put
> too much data in this mail

Without looking too deep into your problem, I remember that
Zynq had similar problem with I-pipe enabled and the
frequency scaling kernel options enabled (I don't remember
the exact CONFIG_ name out of my head). So please make sure
to disable these config options.

Thanks,
Stefan


