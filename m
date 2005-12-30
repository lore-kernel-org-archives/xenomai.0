Message-ID: <43B5AF3F.9040605@domain.hid>
Date: Fri, 30 Dec 2005 23:05:51 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Adeos-main] Re: [Xenomai-core] I-pipe + latency tracing patch
References: <43B5658D.3030004@domain.hid> <43B58FED.6070404@domain.hid>
	<43B5AB49.7040704@domain.hid>
In-Reply-To: <43B5AB49.7040704@domain.hid>
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main@gna.org, Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

Philippe Gerum wrote:
> Jan Kiszka wrote:
> 
>> Philippe Gerum wrote:
>>
>>> I've just rolled out two patches, the first issue of the 1.1 series for
>>> x86, and the accompanying tracer patch contributed by Jan Kiszka and
>>> Luotao Fu. With the latter patch, the I-pipe shall trace the longest
>>> stalled path of the domain with the highest priority. Apply them in that
>>> order:
>>>
>>> http://download.gna.org/adeos/patches/v2.6/adeos/i386/adeos-ipipe-2.6.14-i386-1.1-00.patch 
>>>
>>>
>>> http://download.gna.org/adeos/patches/v2.6/adeos/i386/tracer/ipipe-tracer-2.6.14-i386-1.1-00.patch 
>>>
>>>
>>
>>
>> Two remarks: First, the tracer patch claims more in its config option
>> than it actually provides - mea culpa. The patch itself does not contain
>> any instrumentation of ipipe. This has to be fixed. Meanwhile, please
>> have a look at this posting for instrumentation options:
>> https://mail.gna.org/public/xenomai-core/2005-12/msg00076.html
>>
>> Philippe, do you remember the issues I described about my original
>> ipipe_trace.instr? How can we avoid too short worst-case traces due to
>> domain unstalling followed by re-stalling inside the same IRQ context?
>> Do you see further issues with this approach? I think it would be best
>> if we can provide a clean CONFIG_IPIPE_TRACE_STALLS for the highest (or
>> later maybe even for an arbitrary) domain together with the tracer.
>>
> 
> +static inline void ipipe_trace_stall(struct ipipe_domain *ipd, int code)
> +{
> +    if (__ipipe_pipeline_head_p(ipd) && (ipd != ipipe_root_domain))
> +        ipipe_trace_begin(code);
> +}
> +
> +static inline void ipipe_trace_unstall(struct ipipe_domain *ipd, int code)
> +{
> +    if (__ipipe_pipeline_head_p(ipd) && (ipd != ipipe_root_domain))
> +        ipipe_trace_end(code);
> +}
> 
> The test is wrong in both case. You need to check that ipd is above or 
> equal to ipipe_current_domain in the pipeline. To determine that quickly 
> while tracing, you will probably need to insert an integer giving the 
> position of each domain into the ipipe_domain struct.
> 
>> And second, the separation between both patches is not clean. There are
>> tracer related fragments in the 1.1-00 base patch, intentionally? What's
>> the idea of the separated patches? I mean, doesn't this increase the
>> maintenance effort?
>>
> 
> It's intentional, those (very few) bits always evaluate to false when 
> the tracer is not in, and become conditional depending on the value of 
> CONFIG_IPIPE_TRACE when the support available. IOW, they should be seen 
> as sleeping hooks serving the purpose of allowing a further optional 
> extension of the I-pipe.
> 
> The key issue here is not about ease of maintenance for us, but rather 
> about ease of use for the people who don't necessarily want to drag 
> what's fundamentally a debug infrastructure into the codebase of 
> production systems, even if it's passive and can be compiled out. Adeos 
> for x86 is about 151k without tracing, and goes beyond 189k with the 
> tracer, which is nearly a 20% increase. Add to this that since a latency

To be fair, it's rather 151k compared to 179k actually, which leads us 
to a 15% increase.

> tracer is now available for vanilla Linux as an independent patch, it's 
> likely wiser to allow people to keep the I-pipe tracing facility as a 
> patch option too, so that you won't create conflicts (e.g. mcount).
> 
> In any case, I do see the tracer as a first-class citizen, regardless of 
> the way we distribute it, be it inside the core support or as a broken 
> out patch.
> 
>> Jan
>>
>>
>> ------------------------------------------------------------------------
>>
>> _______________________________________________
>> Adeos-main mailing list
>> Adeos-main@domain.hid
>> https://mail.gna.org/listinfo/adeos-main
> 
> 
> 


-- 

Philippe.

