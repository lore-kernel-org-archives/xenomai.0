Message-ID: <4561705B.9030002@domain.hid>
Date: Mon, 20 Nov 2006 10:07:39 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <DD39B5C3F4963040ADC9768BE7E430CB0154E8D7@domain.hid>
	<1163784779.4980.47.camel@domain.hid> <455E025B.5030906@domain.hid>
In-Reply-To: <455E025B.5030906@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: XENO_OPT_DEBUG impact
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Philippe Gerum wrote:
> 
>>...
>>Disable CONFIG_XENO_OPT_DEBUG from your kernel configuration, this is
>>the source of the PTE misses you are seeing now on ppc. This is not to
>>say that those errors are normal, and this issue still remains to be
>>fixed, but unless you want to debug the Xenomai nucleus, you don't need
>>this option on (additionally, it adds a large overhead which translates
>>in significantly augmented jitter).
> 
> 
> CONFIG_XENO_OPT_DEBUG should not add large jitters - that's what e.g.
> CONFIG_XENO_OPT_DEBUG_QUEUES is now for.
> 
> I'm currently seeing two potential "misuses" of the common switch:
> 
>  - the posix skin (Gilles, how heavy-weighted are those checks?)
>    => CONFIG_XENO_OPT_DEBUG_POSIX

The posix skin printks are issued by the root thread without holding the
nklock, so they should have no impact on the maximum latency.

> 
>  - CONFIG_XENO_SPINLOCK_DEBUG => CONFIG_XENO_OPT_DEBUG_SPINLOCK
> 
> Both should be explicitly controllable in Kconfig.
> 
> Gilles, is CONFIG_XENO_OPT_DEBUG_BHEAP used in any way? Doesn't seem so.

What about using CONFIG_XENO_OPT_DEBUG_QUEUE instead ?

-- 
                                                 Gilles Chanteperdrix

