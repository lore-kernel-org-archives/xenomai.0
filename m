References: <30CDC0E48A9B4ED496A94C7F5B511635@itd206>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <55FBCD72.8020305@xenomai.org>
Date: Fri, 18 Sep 2015 10:38:10 +0200
MIME-Version: 1.0
In-Reply-To: <30CDC0E48A9B4ED496A94C7F5B511635@itd206>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Reg: Linux OOps
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Sureshvs <sureshvs@datapatterns.co.in>, xenomai@xenomai.org
Cc: SDG'08@dP_JagatBhusan, jagat.bhusan@datapatterns.co.in, sureshvsmca@gmail.com

On 09/16/2015 04:15 PM, Sureshvs wrote:
> Hi
> 
> ARCH=powerPC
> Processor: MPC8641
> Linux Kernel : 3.10.32
> Xenomai patch version: xenomai-2.6.3
> 
> We are getting the below oops randomly.kindly help us to isolate the problem with the stack trace given below.
> 
> 
> Oops: Kernel access of bad area, sig: 11 [#1]
> [12981.709964] VPX
> [12981.711706] Modules linked in: dp_elpc_rt(O) xeno_16550A DPXMC5022_DRV(O) dpxmc1107xen(O) dpvpx5849xen(O) dp1553bxt(O) DPVPX0689_WDT_drv(O) DPVPX0689_Timer(O) DPVPX0689_NVSRAM_drv(O) DPVPX0689TS(O) [last unloaded: dp_elpc_rt]
> [12981.731718] CPU: 0 PID: 3941 Comm: PROGRESS_THREAD Tainted: G           O 3.10.32-dpvpx0689 #177
> [12981.740494] task: cf497840 ti: cf052000 task.ti: cf052000
> [12981.745882] NIP: 00000000 LR: a007477c CTR: 00000000
> [12981.750836] REGS: cf053c40 TRAP: 0400   Tainted: G           O  (3.10.32-dpvpx0689)
> [12981.758479] MSR: 40001032 <ME,IR,DR,RI>  CR: 24004422  XER: 00000000
> [12981.764839] 
> GPR00: a007477c cf053cf0 cf497840 00000203 00000000 00000000 00010000 a0649728 
> GPR08: 00000000 00000000 00000000 40fd2a34 24004422 1001b5d8 00000000 00000000 
> GPR16: 3c033000 9fe21d58 9fe21d68 0ff52518 00000003 3c022018 00021000 0ffc81c4 
> GPR24: cf053f50 00000200 00000001 a0670000 a0649728 a06ceb80 a06d2c00 00000203 
> [12981.794546] NIP [00000000]   (null)
> [12981.798033] LR [a007477c] __ipipe_do_sync_stage+0x13c/0x1ec

Jump to NULL handler from the IRQ log syncer over a SMP platform, you
likely need this fix:
http://git.xenomai.org/ipipe.git/commit/?h=ipipe-3.10&id=593309f48b1c7bc7c4f9b650167e08fd67361004

-- 
Philippe.

