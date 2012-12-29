Message-ID: <50DF1FAE.5090907@xenomai.org>
Date: Sat, 29 Dec 2012 17:51:58 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50dd6f0ee3dc65.48983574@wp.pl>
In-Reply-To: <50dd6f0ee3dc65.48983574@wp.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Odp: Re: Xenomai 2.6.2 + Kernel 3.5.3 + AMD Phenom II
 X6 1055
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Mariusz Janiak <mariuszjaniak@wp.pl>
Cc: Xenomai <xenomai@xenomai.org>

On 12/28/2012 11:06 AM, Mariusz Janiak wrote:

>    If you find useful please add bellow text to the TROUBLESHOOTING.adoc
>    file.
> 
>    On AMD x86_64
>    ^^^^^^^^^^^^^
>    You will most likely also see the following message:
>    --------------------------------------------
>    I-pipe: cannot use LAPIC as a tick device
>    I-pipe: disable C1E power state in your BIOS
>    --------------------------------------------
>    Xenomai sends this message if C1E option is enabled in a BIOS. To fix
>    this issue please disable C1E support in the BIOS. In some Award BIOS
>    this option is located in the +Advanced BIOS Features->+ menu (+AMD
>    C1E Support+).
>    On some systems, above message may not appear in the system log.
>    IMPORTANT: Disabling +AMD K8 Cool&Quiet+ option in a BIOS does not
>    solve the problem.


Hi Mariusz,

thanks for the help text. Could you try the following patch 
to see if it restores the message?

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 7f07610..6cc9208 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -545,7 +545,8 @@ static void __cpuinit setup_APIC_timer(void)
 	memcpy(levt, &lapic_clockevent, sizeof(*levt));
 	levt->cpumask = cpumask_of(smp_processor_id());
 #ifdef CONFIG_IPIPE
-	if (!(lapic_clockevent.features & CLOCK_EVT_FEAT_DUMMY))
+	if (!(lapic_clockevent.features & CLOCK_EVT_FEAT_DUMMY)
+	    && !cpu_has_amd_erratum(amd_erratum_400))
 		levt->ipipe_timer = &__get_cpu_var(lapic_itimer);
 	else {
 	       printk(KERN_INFO


-- 
                                                                Gilles.

