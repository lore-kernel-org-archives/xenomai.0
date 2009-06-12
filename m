Message-ID: <4A325189.5060905@domain.hid>
Date: Fri, 12 Jun 2009 15:00:57 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <634c78ce0906120240t694ded8cpfa7fcd9dfb2c3b8@domain.hid>	<200906121148.37732.smolorz@domain.hid>
	<4A3235BF.5090201@domain.hid> <4A324D3D.9060505@domain.hid>
In-Reply-To: <4A324D3D.9060505@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Running Xenomai in a virtual machine
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Johan Visser <johan.visser@domain.hid>
Cc: xenomai@xenomai.org

Johan Visser wrote:
> Jan Kiszka schreef:
>> Sebastian Smolorz wrote:
>>  
>>> Peter Soetens wrote:
>>>    
>>>> I'm looking for a more agile way to run my unit tests (and build farm)
>>>> on a Xenomai system, without running them directly my development
>>>> system (nor rebooting to a Xenomai patched kernel). I was hoping that
>>>> a virtualisation solution would do the trick. Does anyone have
>>>> experience with running a Xenomai patched kernel + applicaiton in
>>>> vmware or another virtualisation package ?
>>>>
>>>>       
>>> Xenomai runs perfectly inside qemu, without real-time guarantees, of
>>> course.
>>>
>>>     
>>
>> Most of the time we are developing on and for Xenomai inside qemu-kvm,
>> often using '-smp 2' (or more) and an SMP host so that the more
>> interesting races are triggered. In contrast to other hypervisors, this
>> offers the chance to do source-level kernel debugging, also when the
>> target hopelessly locked up deep inside I-pipe - situations that are
>> almost undebugable on real x86 hardware.
>>
>> For sure, you don't get reasonable latencies this way (though evaluating
>> kvm under -rt /wrt soft-rt is on my to-do list for the next weeks), but
>> a lot of testing does not require this anyway. Moreover, qemu/kvm
>> cleanly integrates with Linux, thus can easily be scripted. If you plan
>> to set up some test farm, you may also want to have a look at
>> kvm-autotest (currently under merge into autotest).
>>
>> Jan
>>
>>   
> Just the last few days we were trying to do the same with our XENOMAI
> system and application.
> 
> According the package info I can not use KVM because the processor of my
> laptop does not have hardware virtualisation support.

If /proc/cpuinfo lacks vmx (intel) or svm (amd) *and* there is no magic
switch in your notebook's bios to enable virtualization, then you are
out of luck /wrt accelerated qemu(-kvm) use. You could still use qemu in
emulation mode, but that is 10..40 times slower than native (but still
better than nothing if you have to debug the guest kernel - I've done
this before kvm arrived).

> Virtualbox failed on a standard PC , it took 5 minutes to boot my guest
> and then after that froze.
> VMware runs, but gives heavy CPU load ( about 38 % ) instead of 6-8 % on
> a real system.

That's expected if your CPU actually lacks hardware virtualization.

> The application runs, but of course it is not realtime.
> 
> The system i am using on my laptop is a standard Ubuntu system.
> 
> I was wondering if the kernel running on my host system is of importance
> too.
> Now it schedules at 250 HZ. I tried to use a -rt kernel fom the ubuntu
> repository ( 1000 Hz ) but this will not work on my system some how.

All modern distros have high-resolution timers enabled, so the kernel's
scheduler tick doesn't really matter anymore (unless the hypervisor
screws it up...). I can watch best-case 'latency' results under kvm that
are in the order of some ten microseconds. But the worst case is more
about some ten ms on a normal distro kernel (CONFIG_PREEMPT_VOLUNTARY
here, still need to try PREEMPT_RT). But even with -RT, there will
remain critical code paths in the hypervisor that go through RT-unsuited
host kernel subsystems, so you will get a better average, but no guarantees.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

