Message-ID: <4522A377.5030503@domain.hid>
Date: Tue, 03 Oct 2006 11:52:55 -0600
From: Jim Cromie <jim.cromie@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] possible future conflict w LOCAL_APIC
References: <451C586A.7020309@domain.hid> <1159628606.5014.33.camel@domain.hid>
In-Reply-To: <1159628606.5014.33.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
> On Thu, 2006-09-28 at 17:19 -0600, Jim Cromie wrote:
>
> [...]
>
>   
>> BTW I was planning to make LOCAL_APIC unconditional on i386 too like on x86-64.
>> There is basically no reason ever to disable it, and the bug work around
>> for buggy BIOS one can be done at runtime. Overall the #ifdef / compile breakage
>> ratio vs saved code on disabled APIC code is definitely unbalanced.
>>
>> -Andi
>>
>>
>>
>> This looks like it may become a problem:
>>
>> Q: The kernel message log says:
>>    "Xenomai: Local APIC absent or disabled!
>>     Disable APIC support or pass "lapic" as bootparam."
>>
>> A: Xenomai sends this message if the kernel configuration Xenomai was
>>    compiled against enables the local APIC support
>>    (CONFIG_X86_LOCAL_APIC), but the processor status gathered at boot
>>    time by the kernel says that no local APIC support is available.
>>    There are two options for fixing this issue:
>>
>>    o either your CPU really has _no_ local APIC hw, then you need to
>>      rebuild a kernel with LAPIC support disabled, before rebuilding
>>      Xenomai against the latter;
>>
>>
>>
>> Is this something fundamental or merely inconvenient ?
>>
>>     
>
> Inconvenient because this would require some surgery, and a bit less
> efficient, since we would have to select the proper timing mode handlers
> dynamically through function pointers, right in the hot path (e.g. PIT
> programming in oneshot mode), not to speak of leaving dead code at
> runtime. Fortunately, this would be made simpler by the
> periodic-over-aperiodic mode emulation which is planned, since the
> periodic hw management code would go away as a result of such change.
>
> This said, the impact of forcing CONFIG_X86_LOCAL_APIC on would be
> limited to a handful of files, Xenomai-wise. Adeos-wise, this would have
> the same impact than for the rest of the x86 kernel code: less ifdefs,
> more dead code at runtime.
>
>   

update:

Ingo Molnar has voiced strong preference that the config option remain,
citing 60kb growth in its removal.  So its probably safe for now ;-)



