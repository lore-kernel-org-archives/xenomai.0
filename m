From: Lowell Gilbert <kludge@be-well.ilk.org>
Subject: crash on accessing =?iso-8859-1?Q?=2Fproc=2Fxenomai=2Fsched=2F=C2?=
Date: Tue, 29 Jan 2019 16:06:47 -0500
Message-ID: <44k1infa1k.fsf@be-well.ilk.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I was trying to update to 3.0.8, and looking at stat or acct in the
sched branch of the proc tree gives me an instant kernel crash, usually
with a null pointer access from a bogus code address, although the
locations aren't always the same. This is without even having my kernel
module or application loaded.

The system is a dual-core Cortex-A9.

Any idea what might be going on? Details follow.

[  121.205418] Unable to handle kernel NULL pointer dereference at virtual address 00000000
[  121.213493] pgd = ee7e0000
[  121.216198] [00000000] *pgd=3f8ff831
[  121.219787] Internal error: Oops: 80000007 [#1] SMP ARM
[  121.225000] Modules linked in:
[  121.228066] CPU: 0 PID: 1113 Comm: cat Not tainted 4.14.73-ltsi-09035-gb67570c09362-dirty #2
[  121.236474] Hardware name: Altera SOCFPGA
[  121.240475] I-pipe domain: Linux
[  121.243699] task: ef302e00 task.stack: ee656000
[  121.248221] PC is at 0x0
[  121.250776] LR is at __ipipe_ack_hrtimer_irq+0x48/0x80
[  121.255901] pc : [<00000000>]    lr : [<c01be9cc>]    psr: a0060193
[  121.262149] sp : ee657c60  ip : ee657c60  fp : ee657c74
[  121.267360] r10: 00000001  r9 : 00000012  r8 : ee657ce8
[  121.272571] r7 : 00000011  r6 : 00000000  r5 : ef004900  r4 : ef7c01b0
[  121.279077] r3 : 00000000  r2 : c0c919c0  r1 : 00000001  r0 : ef004900
[  121.285587] Flags: NzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
[  121.292786] Control: 10c5387d  Table: 2e7e004a  DAC: 00000051
[  121.298517] Process cat (pid: 1113, stack limit = 0xee656220)

and

[  121.727414] Unable to handle kernel NULL pointer dereference at virtual address 00000024
[  121.735477] pgd = c0004000
[  121.738183] [00000024] *pgd=00000000
[  121.741763] Internal error: Oops: 17 [#2] SMP ARM
[  121.746455] Modules linked in:
[  121.749517] CPU: 0 PID: 1113 Comm: cat Tainted: G      D         4.14.73-ltsi-09035-gb67570c09362-dirty #2
[  121.759134] Hardware name: Altera SOCFPGA
[  121.763133] I-pipe domain: Linux
[  121.766356] task: ef302e00 task.stack: ee656000
[  121.770880] PC is at unmap_page_range+0x6c/0x624
[  121.775488] LR is at unmap_single_vma+0x8c/0x94
[  121.780008] pc : [<c026a678>]    lr : [<c026acbc>]    psr: 20060113
[  121.786255] sp : ee657920  ip : c026a624  fp : ee6579a4
[  121.791464] r10: ee657a08  r9 : c0939688  r8 : 00010000
[  121.796675] r7 : ee657a08  r6 : 00010000  r5 : eea41f00  r4 : 00000001
[  121.803181] r3 : 00000000  r2 : 00000000  r1 : 00018000  r0 : c0ccb3c0
[  121.809689] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[  121.816800] Control: 10c5387d  Table: 2e7e004a  DAC: 00000051
[  121.822530] Process cat (pid: 1113, stack limit = 0xee656220)
[  121.828259] Stack: (0xee657920 to 0xee658000)

