Date: Thu, 16 Nov 2017 11:08:24 -0500
Message-ID: <20171116160824.7ojj63bg5va4nyfe@csclub.uwaterloo.ca>
References: <F02BB7EFB632496685EA867D9DF7E500@itd206>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F02BB7EFB632496685EA867D9DF7E500@itd206>
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Subject: Re: [Xenomai] Reg: Xenomai -3 FPU Exception
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Sureshvs <sureshvs@datapatterns.co.in>
Cc: sureshvsmca@gmail.com, xenomai@xenomai.org

On Thu, Nov 16, 2017 at 07:04:58PM +0530, Sureshvs wrote:
> Hi
> 
> ARCH=PowerPc (MPC8641D)
> vanilla kernel : linux-3.10.32
> ipipe :  ipipe-core-3.10.32-powerpc-9.patch
> Xenomai version : xenomai- 3.0.3 
> 
>   We are using PowerPC processor with above mentioned kernel and xenomai version (with cobalt configuration)
>  
> Our application running in userspace.When using floating point operation in rt_task we are  getting below fpu exception.
> Kindly help us to fix the issue.
> 
> 
> Unrecoverable FP Unavailable Exception 801 at a0003870
> Oops: Unrecoverable FP Unavailable Exception, sig: 6 [#1]
> DPVPX0899
> Modules linked in: DPVPX0899_FPGA_drv(O) DPVPX0899_NVSRAM_drv(O) DPVPX0899_SRIO_drv(O) [last unloaded: DPVPX0899_SRIO_drv]
> CPU: 0 PID: 839 Comm: COMM_Task Tainted: G           O 3.10.32-dpvpx0899 #35
> task: bbe4d200 ti: be570000 task.ti: be570000
> NIP: a0003870 LR: a0006478 CTR: a008f68c
> REGS: be571e40 TRAP: 0801   Tainted: G           O  (3.10.32-dpvpx0899)
> MSR: 00009032 <EE,ME,IR,DR,RI>  CR: 28044428  XER: 20000000
> 
> GPR00: a000646c be571ef0 bbe4d200 be571ef8 be571efc 00003032 00000000 00004000 
> GPR08: 0000d032 a0440000 00000000 00000000 28002422 
> NIP [a0003870] cvt_df+0x0/0xc
> LR [a0006478] fix_alignment+0x1d0/0x8b8
> Call Trace:
> [be571ef0] [a000646c] fix_alignment+0x1c4/0x8b8 (unreliable)
> [be571f30] [a000c2d8] alignment_exception+0xbc/0x100
> [be571f40] [a00105d0] ret_from_except_full+0x0/0x4c

Are you trying to do floating point with unaligned data?

If you are, then answer probably is "Don't do that".

Powerpc allows unaligned interger loads up to 32 bit, but 64 bit floating
point must be aligned when loaded, or it traps to the kernel to fix it
(at a massive performance penalty), which if you are in realtime mode
is a very bad idea.  Your code must have the alignment done right.

-- 
Len Sorensen

