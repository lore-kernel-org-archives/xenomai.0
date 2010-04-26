Message-ID: <4BD5BE1F.1070701@domain.hid>
Date: Mon, 26 Apr 2010 18:23:59 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4B9A5CDA.7080704@domain.hid>	
	<1272020668.9515.763.camel@domain.hid>	
	<4BD18F79.6080708@domain.hid>	
	<1272032336.28983.21.camel@domain.hid>	
	<1272033034.28983.28.camel@domain.hid>
	<4BD1E55E.2080604@domain.hid>
	<1272058731.28983.119.camel@domain.hid>
In-Reply-To: <1272058731.28983.119.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Adeos-main]  [RFC] KVM over Xenomai and I-pipe
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>, xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
> On Fri, 2010-04-23 at 20:22 +0200, Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> On Fri, 2010-04-23 at 16:18 +0200, Philippe Gerum wrote:
>>>> On Fri, 2010-04-23 at 14:15 +0200, Jan Kiszka wrote:
>>>>> [ dropping xenomai-help before going into details ]
>>>>>
>>>>> Philippe Gerum wrote:
>>>>>> On Fri, 2010-03-12 at 16:25 +0100, Jan Kiszka wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> this is still in the state "study", but it is working fairly nicely so far:
>>>>>>>
>>>>>>> These two patches harden latest KVM for use over I-pipe kernels and make
>>>>>>> Xenomai aware of the lazy host state restoring that KVM uses for
>>>>>>> performance reasons. The latter basically means calling the sched-out
>>>>>>> notifier that KVM registers with the kernel when switching from a Linux
>>>>>>> task to some shadow. This is safe in all recent versions of KVM and
>>>>>>> still gives nice KVM performance (that of KVM before 2.6.32) without
>>>>>>> significant impact on the RT latency (Note: if you have an old VT-x CPU,
>>>>>>> guest-issued wbinvd will ruin RT as it is not intercepted by the hardware!).
>>>>>>>
>>>>>>> To test it, you need to apply the kernel patch on top of current kvm.git
>>>>>>> master [1], obtain kvm-kmod.git [2], run configure on it (assuming your
>>>>>>> host kernel is a Xenomai one, otherwise use --kerneldir) and then "make
>>>>>>> sync-kmod LINUX=/path/to/kvm.git". After a final make && make install,
>>>>>>> you will have recent kvm modules that are I-pipe aware. The Xenomai
>>>>>>> patch simply appies to the 2.5 tree. This has been tested with
>>>>>>> ipipe-2.6.32-x86-2.6-01 + [3] and Xenomai-2.5 git.
>>>>>>>
>>>>>>> Feedback welcome, specifically if you think it's worth integrating both
>>>>>>> patches into upstream. The kernel bits would make sense over some
>>>>>>> 2.6.33-x86, but additional work will be required to account for the
>>>>>>> user-return notifiers introduced with that release (kvm-kmod currently
>>>>>>> wraps them away for older kernels).
>>>>>> No concern on the final goal, running a Xenomai-enabled kernel
>>>>>> rock-solid over KVM is a must.
>>>>>>
>>>>>> The KVM code ironing from the 1st patch looks fine to me, no big deal to
>>>>>> maintain AFAICS. I would be only concerned by the 2nd patch,
>>>>>> specifically how the KVM callout is invoked from the Xenomai context
>>>>>> switching code:
>>>>>>
>>>>>> - depending on CONFIG_PREEMPT_NOTIFIERS is much broader than required; I
>>>>>> guess that CONFIG_KVM would be enough.
>>>>> So far, only CONFIG_KVM enables CONFIG_PREEMPT_NOTIFIERS. Granted, this
>>>>> could change in the future. But letting our invocation depend on
>>>>> CONFIG_KVM would not automatically remove the need to review those new
>>>>> notifiers (BTW, there would be a fairly high probability that those will
>>>>> be of some use for Xenomai as well).
>>>>>
>>>>>> - calling the KVM callout directly instead of going through the notifier
>>>>>> list would be more acceptable, so that we don't assume anything from the
>>>>>> non-KVM hooks (whether they exist or not), albeit we may assume that we
>>>>>> have complete information about which KVM callout has to be run for a
>>>>>> particular kernel version.
>>>>> Possible, but hacky. We would have to
>>>>>
>>>>> - export the callback from the KVM module
>>>>>   (this will also mean the nucleus will depend on CONFIG_KVM if the
>>>>>   latter is on)
>>>> Which is already the case for a number of knobs anyway (particularly on
>>>> x86*).
>> The difference is that kvm can be configured as _module_. Simply
>> exporting won't be enough.
>>
> 
> Quite frankly, I see no showstopper in forcing a statically built KVM
> whenever Xenomai is enabled, provided we do that onmy when say,
> CONFIG_XENOMAI_VMCLIENT is switched on. Would you see a significant
> feature loss in removing modular support for KVM in this context?

I finally realized that, due to the dynamic nature of KVM's
registration, this would not work at all. We need a callback that KVM
actively registers (along with the right cookie).

Moreover, it makes sense to do the deregistration atomically along
voluntary sched_out calls of KVM. So establishing some tiny
ipipe_preempt_notifier has its benefits (or is even mandatory). Will
hack up something like that for 2.6.34 and come back once it works.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

