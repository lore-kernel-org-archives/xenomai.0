References: <259BFDBD42EA42CB9CCA8C1BAA3C3939@itd206>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <495cf683-50cd-bea0-af19-188e267e906f@xenomai.org>
Date: Thu, 1 Sep 2016 16:46:06 +0200
MIME-Version: 1.0
In-Reply-To: <259BFDBD42EA42CB9CCA8C1BAA3C3939@itd206>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Machine Check Exception
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Sureshvs <sureshvs@datapatterns.co.in>, xenomai@xenomai.org
Cc: sureshvsmca@gmail.com

On 09/01/2016 04:36 PM, Sureshvs wrote:
> Hi
> ARCH=powerPC
> Processor: MPC8641
> Linux Kernel : 3.10.32
> Xenomai patch version: xenomai-2.6.3
> ipipe : ipipe-core-3.10.32-powerpc-2.patch
> 
> We are getting the below assertion randomly.
> 
> kindly help us to isolate the problem, stack trace during assertion is given below

> 
> [ 830.444860] Machine check in kernel mode.
> 
> [ 830.449136] Caused by (from SRR1=149030): Transfer error ack signal
> 
> [ 830.457936] Oops: Machine check, sig: 7 [#1]
> 
> [ 830.463554] VPX
> 
> [ 830.465295] Modules linked in: DPVPX0689_NVSRAM_drv(O) dpvpx5270(O) DP_SRIO_drv(O) [last unloaded: DPVPX0689_NVSRAM_drv]
> 
> [ 830.476171] CPU: 0 PID: 886 Comm: DP-RDR-8044-RSC Tainted: G O 3.10.32-dpvpx0689 #207
> 
> [ 830.484860] task: cf309f40 ti: ca908000 task.ti: ca908000
> 
> [ 830.490247] NIP: d20ca454 LR: d20c8fe4 CTR: d20ca4b4
> 
> [ 830.495202] REGS: ca909da0 TRAP: 0200 Tainted: G O (3.10.32-dpvpx0689)
> 
> [ 830.502845] MSR: 00149030 <EE,ME,IR,DR> CR: 42004448 XER: 00000000
> 
> [ 830.509205] 
> 
> [ 830.509205] GPR00: d20c8fe4 ca909e50 cf309f40 cf2bec00 00000800 f4300850 3e9fecbc 000079d7 
> 
> [ 830.509205] GPR08: 00000000 00000080 ffff66a0 28002422 a0015ddc 100414f8 00000000 00000000 
> 
> [ 830.509205] GPR16: 00000000 00000000 00000000 100c78cc 100c78ec 00000000 00000000 00000000 
> 
> [ 830.509205] GPR24: ca909f50 a06b0000 a06f14e0 cf2bec00 c00e6107 0000000e 3e9fec8a ca8f3310 
> 
> [ 830.538911] NIP [d20ca454] +0x64/0xcc [dpvpx5270]
> 
> [ 830.545257] LR [/0x1450 [dpvpx5270]
> 
> [ 830.551425] Call Trace:d20c8fe4] dpvpx5270_ioctl+0x82c
> 
> [ 830.553863] [ca909e50] [0000000e] 0xe (unreliable)
> 
> [ 830.558650] [ca909e60] [d20c8fe4] dpvpx5270_ioctl+0x82c/0x1450 [dpvpx5270]
>

You should check your driver, specifically the routine mentioned above
in the backtrace. MCE is typically thrown when some code dereferences a
memory address which is not mapped to any hardware.

-- 
Philippe.

