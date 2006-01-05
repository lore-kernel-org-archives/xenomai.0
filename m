Message-ID: <43BCD298.30704@domain.hid>
Date: Thu, 05 Jan 2006 09:02:32 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Adeos-main] Re: [Xenomai-core] I-pipe + latency tracing patch
References: <43B5658D.3030004@domain.hid>	<43B58FED.6070404@domain.hid>	<43B5AB49.7040704@domain.hid>	<43B5B0A1.6030409@domain.hid>
	<43B6569D.30506@domain.hid> <43BA977F.9040303@domain.hid>
In-Reply-To: <43BA977F.9040303@domain.hid>
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
>>>>Jan Kiszka wrote:
>>>>
>>>>
>>>>
>>>>>Philippe Gerum wrote:
>>>>>
>>>>>
>>>>>
>>>>>>I've just rolled out two patches, the first issue of the 1.1 series
>>>>>>for
>>>>>>x86, and the accompanying tracer patch contributed by Jan Kiszka and
>>>>>>Luotao Fu. With the latter patch, the I-pipe shall trace the longest
>>>>>>stalled path of the domain with the highest priority. Apply them in
>>>>>>that
>>>>>>order:
>>>>>>
>>>>>>http://download.gna.org/adeos/patches/v2.6/adeos/i386/adeos-ipipe-2.6.14-i386-1.1-00.patch
>>>>>>
>>>>>>
>>>>>>
>>>>>>http://download.gna.org/adeos/patches/v2.6/adeos/i386/tracer/ipipe-tracer-2.6.14-i386-1.1-00.patch
>>>>>>
>>>>>>
>>>>>>
>>>>>
>>>>>
>>>>>Two remarks: First, the tracer patch claims more in its config option
>>>>>than it actually provides - mea culpa. The patch itself does not
>>>>>contain
>>>>>any instrumentation of ipipe. This has to be fixed. Meanwhile, please
>>>>>have a look at this posting for instrumentation options:
>>>>>https://mail.gna.org/public/xenomai-core/2005-12/msg00076.html
>>>>>
>>>>>Philippe, do you remember the issues I described about my original
>>>>>ipipe_trace.instr? How can we avoid too short worst-case traces due to
>>>>>domain unstalling followed by re-stalling inside the same IRQ context?
>>>>>Do you see further issues with this approach? I think it would be best
>>>>>if we can provide a clean CONFIG_IPIPE_TRACE_STALLS for the highest (or
>>>>>later maybe even for an arbitrary) domain together with the tracer.
>>>>>
>>>>
>>>>+static inline void ipipe_trace_stall(struct ipipe_domain *ipd, int
>>>>code)
>>>>+{
>>>>+    if (__ipipe_pipeline_head_p(ipd) && (ipd != ipipe_root_domain))
>>>>+        ipipe_trace_begin(code);
>>>>+}
>>>>+
>>>>+static inline void ipipe_trace_unstall(struct ipipe_domain *ipd, int
>>>>code)
>>>>+{
>>>>+    if (__ipipe_pipeline_head_p(ipd) && (ipd != ipipe_root_domain))
>>>>+        ipipe_trace_end(code);
>>>>+}
>>>>
>>>>The test is wrong in both case. You need to check that ipd is above or
>>>>equal to ipipe_current_domain in the pipeline. To determine that quickly
>>>>while tracing, you will probably need to insert an integer giving the
>>>>position of each domain into the ipipe_domain struct.
>>>
>>>
>>>
>>>So the orderning in __ipipe_pipeline does say nothing about the priority
>>>of the domain? Then this seems to have worked only by chance so far
>>>for me.
>>>
>>
>>Of course it does. The thing is that your test must reflect the fact
>>that stalling above and up to the current domain actually blocks the
>>interrupts for the latter, and unstalling at least from your current
>>domain unblocks them. The position value is just a suggestion to quickly
>>compare the effective priority of two domains given their descriptor,
>>without being stuck with the uncertainty of ipd->priority which might be
>>the same for multiple domains, and without having to scan the pipeline
>>top-down.
> 
> 
> As I'm looking for the stall-time of the highest order domain, I don't
> get this point for the stall.

My point was about defining the proper test to check for the stalled 
state, regardless of the number of domains above Linux in the pipeline.

  Regarding unstall: Is it the case that an
> unstall below the highest domain currently stalled (e.g. Xenomai and
> below is stalled, Linux gets unstalled) will also unstall the domains
> above?

If the pipeline shows like: Domain(A,stalled) -- (B) -- (C)
then unstalling C won't change the situation: the interrupts will still 
be blocked by stage A.

  In that case and when only looking at the highest domain (which I
> will likely keep for simplicity), ipipe_trace_unstall() would simply
> have to trace unconditionally.
> 
> 
>>>Anyway, fixing this does not seem to address the other issue I
>>>mentioned. I once also traced the evaluation of those two conditions and
>>>found no indication that this triggers the preliminary end-of-stall
>>>reports I'm facing.
>>>
> 
> 
> ...and this needs a closer look now.
> 
> Jan
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main


-- 

Philippe.

