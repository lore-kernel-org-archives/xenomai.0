Message-ID: <43B6569D.30506@domain.hid>
Date: Sat, 31 Dec 2005 10:59:57 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Adeos-main] Re: [Xenomai-core] I-pipe + latency tracing patch
References: <43B5658D.3030004@domain.hid> <43B58FED.6070404@domain.hid>
	<43B5AB49.7040704@domain.hid> <43B5B0A1.6030409@domain.hid>
In-Reply-To: <43B5B0A1.6030409@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: adeos-main@gna.org, xenomai@xenomai.org

Jan Kiszka wrote:
> Philippe Gerum wrote:
> 
>>Jan Kiszka wrote:
>>
>>
>>>Philippe Gerum wrote:
>>>
>>>
>>>>I've just rolled out two patches, the first issue of the 1.1 series for
>>>>x86, and the accompanying tracer patch contributed by Jan Kiszka and
>>>>Luotao Fu. With the latter patch, the I-pipe shall trace the longest
>>>>stalled path of the domain with the highest priority. Apply them in that
>>>>order:
>>>>
>>>>http://download.gna.org/adeos/patches/v2.6/adeos/i386/adeos-ipipe-2.6.14-i386-1.1-00.patch
>>>>
>>>>
>>>>http://download.gna.org/adeos/patches/v2.6/adeos/i386/tracer/ipipe-tracer-2.6.14-i386-1.1-00.patch
>>>>
>>>>
>>>
>>>
>>>Two remarks: First, the tracer patch claims more in its config option
>>>than it actually provides - mea culpa. The patch itself does not contain
>>>any instrumentation of ipipe. This has to be fixed. Meanwhile, please
>>>have a look at this posting for instrumentation options:
>>>https://mail.gna.org/public/xenomai-core/2005-12/msg00076.html
>>>
>>>Philippe, do you remember the issues I described about my original
>>>ipipe_trace.instr? How can we avoid too short worst-case traces due to
>>>domain unstalling followed by re-stalling inside the same IRQ context?
>>>Do you see further issues with this approach? I think it would be best
>>>if we can provide a clean CONFIG_IPIPE_TRACE_STALLS for the highest (or
>>>later maybe even for an arbitrary) domain together with the tracer.
>>>
>>
>>+static inline void ipipe_trace_stall(struct ipipe_domain *ipd, int code)
>>+{
>>+    if (__ipipe_pipeline_head_p(ipd) && (ipd != ipipe_root_domain))
>>+        ipipe_trace_begin(code);
>>+}
>>+
>>+static inline void ipipe_trace_unstall(struct ipipe_domain *ipd, int code)
>>+{
>>+    if (__ipipe_pipeline_head_p(ipd) && (ipd != ipipe_root_domain))
>>+        ipipe_trace_end(code);
>>+}
>>
>>The test is wrong in both case. You need to check that ipd is above or
>>equal to ipipe_current_domain in the pipeline. To determine that quickly
>>while tracing, you will probably need to insert an integer giving the
>>position of each domain into the ipipe_domain struct.
> 
> 
> So the orderning in __ipipe_pipeline does say nothing about the priority
> of the domain? Then this seems to have worked only by chance so far for me.
> 

Of course it does. The thing is that your test must reflect the fact 
that stalling above and up to the current domain actually blocks the 
interrupts for the latter, and unstalling at least from your current 
domain unblocks them. The position value is just a suggestion to quickly 
compare the effective priority of two domains given their descriptor, 
without being stuck with the uncertainty of ipd->priority which might be 
the same for multiple domains, and without having to scan the pipeline 
top-down.

> Anyway, fixing this does not seem to address the other issue I
> mentioned. I once also traced the evaluation of those two conditions and
> found no indication that this triggers the preliminary end-of-stall
> reports I'm facing.
> 
> 
>>>And second, the separation between both patches is not clean. There are
>>>tracer related fragments in the 1.1-00 base patch, intentionally? What's
>>>the idea of the separated patches? I mean, doesn't this increase the
>>>maintenance effort?
>>>
>>
>>It's intentional, those (very few) bits always evaluate to false when
>>the tracer is not in, and become conditional depending on the value of
>>CONFIG_IPIPE_TRACE when the support available. IOW, they should be seen
>>as sleeping hooks serving the purpose of allowing a further optional
>>extension of the I-pipe.
> 
> 
> I see. Then these hooks are intended to keep the effort of breaking up
> the patches low.
> 

Yes. Actually, the latency tracer is merged into the Adeos CVS tree on 
top of the core system; it's just my patch release script that splits 
them since they are well separated. The remaining hooks do the necessary 
glue between them.

> 
>>The key issue here is not about ease of maintenance for us, but rather
>>about ease of use for the people who don't necessarily want to drag
>>what's fundamentally a debug infrastructure into the codebase of
>>production systems, even if it's passive and can be compiled out. Adeos
>>for x86 is about 151k without tracing, and goes beyond 189k with the
>>tracer, which is nearly a 20% increase. Add to this that since a latency
>>tracer is now available for vanilla Linux as an independent patch, it's
>>likely wiser to allow people to keep the I-pipe tracing facility as a
>>patch option too, so that you won't create conflicts (e.g. mcount).
> 
> 
> Actually, both traces should not collide as long as only one is active
> at the same time.
>

Unfortunately, we can't bet on this for the vanilla kernel part, who 
knows what's going to happen to this support in the future?

> Anyway, I already assumed that this more or less psychological aspect of
> patch size makes a difference. I don't have a problem with this separation!
> 
> Jan


-- 

Philippe.

