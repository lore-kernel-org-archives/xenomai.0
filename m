Message-ID: <50730FB7.3060604@xenomai.org>
Date: Mon, 08 Oct 2012 19:39:03 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50729DAB.2080909@gmail.com>
In-Reply-To: <50729DAB.2080909@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Oops while running "cat /proc/xenomai/stat"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Stefan Roese <stefan.roese@gmail.com>
Cc: xenomai@xenomai.org

On 10/08/2012 11:32 AM, Stefan Roese wrote:

> Hi,
> 
> I'm currently developing an RTDM driver communicating with an FPGA
> located on the LPB on an MPC5200 PowerPC. This driver already seems
> to work quite well. But when I run my test application
> communicating with the device driver, and I try to check the
> Xenomai stat's, I get a kernel crash:
> 
> root@generic-powerpc:~# cat /proc/xenomai/stat 
> [   43.722984] Oops: Kernel access of bad area, sig: 11 [#1]
> [   43.728503] mpc5200-simple-platform
> [   43.732057] Modules linked in: rt_fpga(O) rt_mpc52xx_lpbfifo(O)
> [   43.738107] NIP: c00646a8 LR: c0098b84 CTR: c0098b34
> [   43.743173] REGS: c7025b40 TRAP: 0300   Tainted: G           O  (3.5.3-00253-g4699145-dirty)
> [   43.751776] MSR: 00001032 <ME,IR,DR,RI>  CR: 24424488  XER: 20000000
> [   43.758279] DAR: 00000000, DSISR: 22000000
> [   43.762454] TASK = c7b75360[1430] 'cat' THREAD: c7024000
> GPR00: 00000000 c7025bf0 c7b75360 c7b1ca0c 00000002 02000007 00000000 00000031 
> GPR08: c7ab0000 c7b1cc00 00000000 00000000 c0098b34 100a5a74 10017830 10006834 
> GPR16: 10006770 10006774 c7b1cc00 00000000 00000002 c033d385 c03264ac 00000025 
> GPR24: c0320000 00000001 00000002 c03b3460 00000000 00000000 c7a6ccc4 c7a6ccb4 
> [   43.796697] Call Trace:
> [   43.799189] [c7025bf0] [c004c540] 0xc004c540 (unreliable)
> [   43.804698] [c7025c20] [c0098b84] 0xc0098b84
> [   43.809051] [c7025c40] [c90e4588] 0xc90e4588
> [   43.813406] [c7025c50] [c90d8114] 0xc90d8114
> [   43.817758] [c7025c60] [c005e85c] 0xc005e85c
> [   43.822113] [c7025ca0] [c005aef0] 0xc005aef0
> [   43.826465] [c7025cc0] [c000d664] 0xc000d664
> [   43.830819] [c7025cd0] [c000f710] 0xc000f710
> [   43.835175] --- Exception: 501 at 0xc01b2614
> 
> This happens reproducible upon the "cat" command from the shell.
> 
> Looking at the NIP (c00646a8), the PPC is currently executing
> xnsynch_flush().
> 
> Other proc files from the xenomai directory like "irq" don't cause
> this crash. And accessing "stat" when this application is not
> running also works fine:
> 
> root@generic-powerpc:~# cat /proc/xenomai/stat 
> CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
>   0  0      0          0          0     00500080  100.0  ROOT
>   0  0      0          0          0     00000000    0.0  IRQ145: rtcan_mscan
>   0  0      0          0          0     00000000    0.0  IRQ151: mpc52xx-lpbfifo
>   0  0      0          0          0     00000000    0.0  IRQ194: mpc52xx-lpbfifo-rx
>   0  0      0          17619      0     00000000    0.0  IRQ512: [timer]
> 
> Any idea what might go wrong here? 


Please enable CONFIG_KALLSYMS so that the backtrace contains readable
function names, otherwise, without a disassembly of your kernel, we have
no idea what functions the backtrace is referring to.

> 
> Thanks,
> Stefan
> 
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
> 



-- 
                                                                Gilles.

