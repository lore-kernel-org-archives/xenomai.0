Message-ID: <43E30B8D.6030507@domain.hid>
Date: Fri, 03 Feb 2006 08:51:41 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] some results on my laptop
References: <43E288AA.3050203@domain.hid> <43E28EE8.3020103@domain.hid>
	<43E2A31D.9000807@domain.hid>
In-Reply-To: <43E2A31D.9000807@domain.hid>
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
To: Jim Cromie <jim.cromie@domain.hid>
Cc: xenomai@xenomai.org

Jim Cromie wrote:
> Philippe Gerum wrote:
> 
>>
>>>
>>> Ive been running an ipipe kernel as the default since shortly after 1/7.
>>> Since then, Ive had a couple of freezes on boot,
>>> and sometimes bash's auto-complete takes longer to complete,
>>
>>
>> Eh? Maybe the CONFIG_PCI_MSI syndrom again?
> 
> 
> Um, does this tell you anything ?
> 
> $ zcat /proc/config.gz | grep PCI_MSI
> # CONFIG_PCI_MSI is not set
> 
> I noticed the slow completion when doing some heavy disk stuff,
> lndir on a kernel tree, and probably diff -r on 2 kernel trees,
> so the laptop was pretty busy.
> 
> 
>>>
>>> This was run on a pentium-M laptop,
>>> with cpu-clock running at 600 MHz, (capable of 1.7 GHz)
>>> I presume this might explain the negative latancies.
>>> Im aware this is un-supported ..
>>>
>>
>> The negative values are just there because even at 600Mhz, the timing 
>> anticipation applied by the nucleus to compensate for the intrinsic 
>> latency of the box is too high; i.e. the nucleus performs a bit too 
>> well latency-wise, so the anticipated timer ticks end up being a bit 
>> early on schedule. IOW, all is fine. Given the figures above, you 
>> could probably reduce the anticipation factor by setting the 
>> CONFIG_XENO_HW_SCHED_LATENCY (Machine menu) parameter to, say, 2500 
>> nanoseconds (the default null value tells the nucleus to use the 
>> pre-calibrated value, which might be higher than this for your setup).
>>
> Ok.  with latencies == 0, calibration happens at runtime, so it would
> reflect the current workload (and with cpufreq on) also would reflect
> the current clock frequency, correct ?
> 

With latency == 0, a pre-calibrated latency value is extracted from 
asm-i386/calibration.h.

> 
>> Btw, I'm not sure if you enabled the local APIC in your kernel config; 
>> if you did not, you should: there is no reason to keep using the 
>> braindamage 8254 PIT when a LAPIC is available with your CPU.
>>
> Ok, now running this.
> 
> zcat /proc/config.gz | grep APIC
> CONFIG_X86_GOOD_APIC=y
> CONFIG_X86_UP_APIC=y
> CONFIG_X86_UP_IOAPIC=y
> CONFIG_X86_LOCAL_APIC=y
> CONFIG_X86_IO_APIC=y
> 
> [jimc@domain.hid latency]$ sudo ./run -- -T60 -s -t1
> Password:
> *
> *
> * Type ^C to stop this application.
> *
> *
> == Sampling period: 100 us
> == Test mode: in-kernel periodic task
> warming up...
> RTT|  00:00:05  (in-kernel periodic task, 100 us period)
> RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat 
> worst
> RTD|       -2165|      127216|     1399358|    7582|       -2165|     
> 1399358

ACPI is still on, it seems. ACPI, and PM must be off. They are responsible for 
hw-generated latencies. Additionally, you may want to switch on the "SMI disable" 
option from the Xeno config, to see if things improve.

> RTD|       -2188|     -205817|     1403255|   16431|       -2188|     
> 1403255
> RTD|       -2178|     -207605|     1399828|   25271|       -2188|     
> 1403255
> RTD|       -2186|     -208602|     1402253|   34096|       -2188|     
> 1403255
> RTD|       -2163|     -206835|     1399144|   42943|       -2188|     
> 1403255
> RTD|       -2175|     -206848|     1401346|   51785|       -2188|     
> 1403255
> RTD|       -2184|     -210270|     1396823|   60621|       -2188|     
> 1403255
> RTD|       -2167|     -208781|     1399323|   69453|       -2188|     
> 1403255
> RTD|       -2169|     -211121|     1397365|   78267|       -2188|     
> 1403255
> RTD|       -2173|     -210119|     1398349|   87084|       -2188|     
> 1403255
> RTD|       -2168|     -208425|     1400764|   95922|       -2188|     
> 1403255
> RTD|       -2173|      211271|     1397470|  104678|       -2188|     
> 1403255
> RTD|       -2170|     -208130|     1399794|  113508|       -2188|     
> 1403255
> RTD|       -2161|     -208400|     1397968|  122334|       -2188|     
> 1403255
> RTD|       -2162|     -211225|     1397581|  131139|       -2188|     
> 1403255
> RTD|       -2175|     -210500|     1397274|  139951|       -2188|     
> 1403255
> RTD|       -2179|     -207530|     1396890|  148781|       -2188|     
> 1403255
> RTD|       -2178|     -207890|     1399275|  157611|       -2188|     
> 1403255
> RTD|       -2172|     -207750|     1397386|  166432|       -2188|     
> 1403255
> RTD|       -2175|     -206057|     1399763|  175260|       -2188|     
> 1403255
> HSH|--param|--samples-|--average--|---stddev--
> HSS|    min|        20|      2.000|      0.000
> HSS|    avg|    205060|     90.399|     25.538
> HSS|    max|        20|     99.000|      0.000
> ---|------------|------------|------------|--------|------------------------- 
> 
> RTS|       -2188|     -170670|     1403255|  175260|    00:01:00/00:01:00
> 
> 
> Obviously, the numbers dont look so good.
> The test duration comments still apply.
> 
>> You should disable the ACPI support if enabled, and especially 
>> everything related to the CPUfreq scaling and power suspend.
>>
> Given that Im not really developing any RT code,
> and I like the laptop quiet and cool, Im inclined to keep
> the CPUfreq scaling on, at least for my everyday kernel.
> How much does CPUfreq invalidate results I might send (periodically)
>

Well, it basically totally wrecks the timing...

> 
> thanks
> 


-- 

Philippe.

