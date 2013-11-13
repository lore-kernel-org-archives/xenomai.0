Message-ID: <52837DD0.1050405@siemens.com>
Date: Wed, 13 Nov 2013 14:25:36 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <528290CE.1030002@xenomai.org>
In-Reply-To: <528290CE.1030002@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] issues with debugging enabled
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Xenomai <xenomai@xenomai.org>

On 2013-11-12 21:34, Gilles Chanteperdrix wrote:
> 
> Hi,
> 
> for a change, I ran the xeno-regression-test with a lot of debugging and
> options known to having caused problems in the past and found two issues:
> 
> on x86 SMP, with full dynticks and debugging enabled (preemptible kernel
> debugging, mutex, spinlocks, and sleep inside spinlocks), I get the
> series of warnings at the end of the mail.

We are currently facing crashes inside __switch_to, FPU related
(non-existing save area). Once that is sorted out, we can have a look at
that scenario as well. Do you have the .config online somewhere?

> 
> on ARM, when a fault occurs, the fault ode is entered with hardware irqs
> off (this is a recent change in the mainline kernel, this code used to
> be executed with hardware irqs on), so I do:
> 
> ipipe_stall_root();
> hard_local_irq_enabled();
> 
> But the context checking does not like that.
> 
> Any idea how to fix these?

Only ARM's SMP version of ipipe_stall_root() contains
ipipe_stall_root(), UP and at least x86 do not have this. I understand
that it makes sense to deny this call over non-root, but as it is about
fixing up imbalances in the pipeline state, ipipe_stall_root() is likely
not the best choice. What about open-coding the relevant check for the
domain? Maybe it also works to push the check to the end of
ipipe_stall_root, i.e. after fixing up the pipeline state.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

