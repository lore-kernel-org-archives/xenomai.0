Message-ID: <53A73556.1040003@xenomai.org>
Date: Sun, 22 Jun 2014 21:58:14 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <53A2C543.8060706@geensyde.fr>	<53A2DC06.10005@geensyde.fr>
 <CADVgf9m7nLm3RKyQus62aC6gYDK42O09ipScEqD3AfYce0e_ig@mail.gmail.com>
In-Reply-To: <CADVgf9m7nLm3RKyQus62aC6gYDK42O09ipScEqD3AfYce0e_ig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Fwd: Periodic high latency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Matthew Fornero <mfornero.lists@gmail.com>, thierry mallard <thierry.mallard@geensyde.fr>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 06/20/2014 10:21 PM, Matthew Fornero wrote:
> On Thu, Jun 19, 2014 at 8:48 AM, thierry mallard
> <thierry.mallard@geensyde.fr> wrote:
>>
>> Hi,
>>
>> I have installed xenomai 2.6.3 with a kernel 2.6.38.8 on my dell laptop
>> using adeos-ipipe-2.6.38.8-x86-2.11-03.patch.
>> CPU is i5-3230M.
>>
>>
>> When running xeno latency, I get the following results.
>> What can be the cause of the high latencies that I get periodically?
> 
> You may want to check whether C1E is enabled, it can cause latency
> spikes with newer Intel processors. You can disable it by writing to
> the MSR_POWER_CTL register (google for this).

I had a look at this register. The "intel_idle" (which Xenomai
documentation recommends to disable) disables this bit. So, we have
several choices here:
- only allow C1 state in the "intel_idle" driver, and ask user to
reenable this driver
- copy this driver logic somewhere in the I-pipe kernel to disable C1E
on all CPUs where it makes sense (since the function must disable the
bit on all cpus, we have to find an init function called for each cpu)
- copy the driver logic in xenomai code like the smi workaround(this
means we have to do the job twice, once for 2.6, once for -forge).

For reference, the said logic looks like:

#include <asm/cpu_device_id.h>
#include <asm/msr.h>

/* (...) */

#define ICPU(model) \
	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_MWAIT, 1UL }

static const struct x86_cpu_id c1e_ids[] = {
	ICPU(0x1a),
	ICPU(0x1e),
	ICPU(0x1f),
	ICPU(0x25),
	ICPU(0x2c),
	ICPU(0x2e),
	ICPU(0x2f),
	ICPU(0x2a),
	ICPU(0x2d),
	ICPU(0x3a),
	ICPU(0x3e),
	ICPU(0x3c),
	ICPU(0x3f),
	ICPU(0x45),
	ICPU(0x46),
	ICPU(0x4D),
	{}
};
#undef ICPU

/* (...) */

	const struct x86_cpu_id *id;

	id = x86_match_cpu(c1e_ids);
	if (id)
		/*
		 * cpu uses C1E, disable this feature (copied from
		 * intel_idle driver)
		 */
		on_each_cpu(c1e_promotion_disable, NULL, 1);

> 
> Best Regards,
> 
> Matt
> 
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
> 


-- 
                                                                Gilles.

