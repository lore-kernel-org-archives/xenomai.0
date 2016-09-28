References: <1cd6ace8-e63d-dd46-4ec9-8e636ef5b43c@foxmail.com>
 <a56e7261-41fc-b1a5-cf86-3314b97d7520@foxmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <e75aadf4-880f-af0a-cb39-0a7c498f9ae3@xenomai.org>
Date: Wed, 28 Sep 2016 20:57:04 +0200
MIME-Version: 1.0
In-Reply-To: <a56e7261-41fc-b1a5-cf86-3314b97d7520@foxmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Real-time Performance Improvement
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jack Lee <jacklee11@foxmail.com>, xenomai <xenomai@xenomai.org>

On 09/26/2016 05:08 AM, Jack Lee wrote:
> 
> 
> On 09/22/2016 02:43 PM, Jack Lee wrote:
>> Hi, everyone,
>>
>> My board is advantech MIO-5251 (J1900 version), linux kernel version
>> is 4.1.18,
>>
>> xenomai version is 3.0.3. As mentioned before, the real-time
>> performance I got was
>>
>> not good.
>>
>> But I found something here:
>> http://rtt-lwr.readthedocs.io/en/latest/rtpc/xenomai.html.
>>
>> After "i915.enable_rc6=0 i915.modset=1 noapic" was added to the kernel
>> command
>>
>> line, the real-time performance improved a lot, which means latency
>> tests (-t0, t1, t2)
>>
>> has no overruns (less than 80us) in 13+ hours, but when other
>> real-time applications
>>
>> was running, overruns occurred sometimes.
>>
>> I found that "intel_powerclamp" "intel_rapl" was in the "lsmod" list.
>> After I removed them,
>>
>> real-time performance of the system is quite good now.
>>
>> I found configs below exist in the original .config file, except
>> "CONFIG_CPU_THERMAL". These
>>
>> configs do not appear on the official website as far as I know. Is it
>> necessary to disable them to
>>
>> improve real-time performance?
>>
>> Generic Thermal sysfs driver
>> CONFIG_THERMAL
>>
>> Fair-share thermal governor
>> CONFIG_THERMAL_GOV_FAIR_SHARE
>>
>> Step_wise thermal governor
>> CONFIG_THERMAL_GOV_STEP_WISE
>>
>> User_space thermal governor
>> CONFIG_THERMAL_GOV_USER_SPACE
>>
>> generic cpu cooling support
>> CONFIG_CPU_THERMAL(n)
>>
>> Thermal emulation mode support
>> CONFIG_THERMAL_EMULATION
>>
>> Intel PowerClamp idle injection driver
>> CONFIG_INTEL_POWERCLAMP
>>
>> By the way, I found my two Ethernet cards and the can board have the
>> same interrupt number.I removed the igb module.
>>
>> Is it possible to assign interrupt numbers manuallly? When I started
>> from different kernels, the number is not the same.
>>
>>
>> Good luck!
>>
> [    0.004106] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
> [    0.004114] ENERGY_PERF_BIAS: View and update with
> x86_energy_perf_policy(8)
> 
> I found the above message in the "dmesg" output.
> This was solved by:
>     sudo modprobe msr
>     sudo cd $(knlsrc)/tools/power/x86/x86_energy_perf_policy
>     sudo make
>     sudo ./x86_energy_perf_policy performance
> "rdmsr -a 0x1b0" outputs "6 6 6 6" and "0 0 0 0" previously and
> subsequently.
> "wrmsr" should works too.
> 

Since this is a model specific register for the Celeron J1900, could you
point us to the Intel documentation you referred to, to understand what
these settings are doing?

Thanks,

-- 
Philippe.

