Message-ID: <5073F2BA.3060009@xenomai.org>
Date: Tue, 09 Oct 2012 11:47:38 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50729DAB.2080909@gmail.com> <50730FB7.3060604@xenomai.org>
	<5073C8C8.7000606@gmail.com>
In-Reply-To: <5073C8C8.7000606@gmail.com>
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

On 10/09/2012 08:48 AM, Stefan Roese wrote:
> root@generic-powerpc:~# cat /proc/xenomai/stat 
> [   65.215600] Oops: Kernel access of bad area, sig: 11 [#1]
> [   65.221118] mpc5200-simple-platform
> [   65.224671] Modules linked in: rt_fpga(O) rt_mpc52xx_lpbfifo(O)
> [   65.230718] NIP: c0066914 LR: c009adf0 CTR: c009ada0
> [   65.235784] REGS: c716bac0 TRAP: 0300   Tainted: G           O  (3.5.3-00253-g4699145-dirty)
> [   65.244386] MSR: 00001032 <ME,IR,DR,RI>  CR: 24000488  XER: 20000000
> [   65.250888] DAR: 00000000, DSISR: 22000000
> [   65.255064] TASK = c705cba0[1400] 'cat' THREAD: c716a000
> GPR00: 00000000 c716bb70 c705cba0 c7b3060c 00000002 02000006 00000000 00000030 
> GPR08: c70f0000 c7b30800 00000000 00000000 c009ada0 100a5a74 10017830 10006834 
> GPR16: 10006770 10006774 100170f4 00010000 c00733d8 c75e4a60 00000000 c03ee068 
> GPR24: 00000002 00000001 00000002 c03ec460 00000000 00000000 c7a6ccc4 c7a6ccb4 
> [   65.289337] NIP [c0066914] xnsynch_flush+0x64/0x100

Could you show us the diassembly of xnsynch_flush in the corresponding
kernel?

-- 
					    Gilles.

