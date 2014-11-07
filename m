Date: Fri, 7 Nov 2014 21:26:10 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141107202610.GE17476@sisyphus.hd.free.fr>
References: <46e9aebbd25e45f8a3bb4732562bb97f@SI-MBX1019.de.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46e9aebbd25e45f8a3bb4732562bb97f@SI-MBX1019.de.bosch.com>
Subject: Re: [Xenomai] Perf makes kernel panic
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Ren Yuan (DC-IA/EAN3)" <Yuan.Ren@boschrexroth.nl>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Fri, Nov 07, 2014 at 04:28:57PM +0000, Ren Yuan (DC-IA/EAN3) wrote:
> Hi,
> 
> I've encountered a problem to use perf to get the performance of our code on Linux kernel(3.14) with Xenomai(2.6.4) on ARM based board.
> When I use perf on Linux kernel with Xenomai, even a simple test without any xenomai tasks running reports an error "Unable to handle kernel NULL pointer dereference at virtual address 00000000".
> But if use perf on Linux kernel without Xenomai, it works.
> Could anyone give me some advices how to fix it? Any help would be appreciated.

Ok, I just had a look at perf_callchain_kernel, and it uses the irq
registers. When running Xenomai though, the registers passed are
phony (they correspond to the registers of the last timer irq), and
since an irq can be played back some time after it has been
received, it does not make sense to try and unwind the stack frame
from the value of these registers.

IOW, perf_callchain_kernel can not easily be made to work with
CONFIG_IPIPE. So, what you can try is apply this patch:

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 4238bcb..737ef33 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -621,6 +621,9 @@ perf_callchain_kernel(struct perf_callchain_entry *entry, struct pt_regs *regs)
                 return;
         }
 
+        if (IS_ENABLED(CONFIG_IPIPE))
+                return;
+
         fr.fp = regs->ARM_fp;
         fr.sp = regs->ARM_sp;
         fr.lr = regs->ARM_lr;


And hope perf will manage to work without that (apparently it can,
since this function is also disabled when running Linux as a KVM
guest).

-- 
					    Gilles.

