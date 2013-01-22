Message-ID: <50FF16E9.7050902@xenomai.org>
Date: Tue, 22 Jan 2013 23:47:05 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAD1EtogQBZ5f=7w5mZz19rrnQVB_BP=t-f4rKtq12wKn9cd1Yw@mail.gmail.com>	<50FF1249.2070807@xenomai.org>
	<CAD1EtoiMKsipxzaDZOHFHfzQWRX1Oub=HspCCn01UNC3C9e53A@mail.gmail.com>
In-Reply-To: <CAD1EtoiMKsipxzaDZOHFHfzQWRX1Oub=HspCCn01UNC3C9e53A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] x86 Linux with xenomai and i915 graphics stall
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Daniel M. Drucker, Ph.D." <dmd@interactive-motion.com>
Cc: xenomai@xenomai.org

On 01/22/2013 11:29 PM, Daniel M. Drucker, Ph.D. wrote:

> 
>     And you are sure that it is not an SMI issue? Could you post your kernel
>     configuration?
> 
> 
> Here it
> is: https://gist.github.com/raw/4599242/0eea44377371e4d7213eea28cd33823950afeaca/gistfile1


You can try disabling CONFIG_PM_RUNTIME

What could take long in __xnpod_schedule is locking the spinlock, that
could be because another CPU has the lock, in which case you will be
able to catch the culprit by enabling CONFIG_XENO_OPT_DEBUG_XNLOCK

or because the bus is locked for a long time, you could also try
disabling CONFIG_MTRR or CONFIG_X86_PAT.

Finally, what may happen is an NMI, the perf system uses NMIs and
oprofile as well. You can avoid compiling oprofile, but I am not sure
perf can be disabled, but you can comment out the code enabling the NMI
with the following patch:

diff --git a/arch/x86/kernel/cpu/perf_event.c
b/arch/x86/kernel/cpu/perf_event.c
index bb8e034..a26df66 100644
--- a/arch/x86/kernel/cpu/perf_event.c
+++ b/arch/x86/kernel/cpu/perf_event.c
@@ -1324,6 +1324,8 @@ static int __init init_hw_perf_events(void)
 	struct event_constraint *c;
 	int err;

+	return 0;
+	
 	pr_info("Performance Events: ");

 	switch (boot_cpu_data.x86_vendor) {

-- 
                                                                Gilles.

