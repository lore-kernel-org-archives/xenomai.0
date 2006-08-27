Message-ID: <44F1B01C.9090504@domain.hid>
Date: Sun, 27 Aug 2006 16:45:48 +0200
From: Steve Kreyer <steve.kreyer@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Timer problems?
References: <1903864415@domain.hid> <1154964748.4322.31.camel@domain.hid>	
	<44EF17E8.5040606@domain.hid> <44EF37BE.70207@domain.hid>
	<44F0B06B.6050102@domain.hid>	 <44F17616.9080701@domain.hid>
	<1156680494.4325.68.camel@domain.hid>	 <44F1A267.1040305@domain.hid>
	<1156688557.4325.76.camel@domain.hid> <1156688736.4325.80.camel@domain.hid>
In-Reply-To: <1156688736.4325.80.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: steve.kreyer@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
> On Sun, 2006-08-27 at 16:22 +0200, Philippe Gerum wrote:
>   
>> On Sun, 2006-08-27 at 15:47 +0200, Steve Kreyer wrote:
>>     
>>> Philippe Gerum wrote:
>>>       
>>>>> Moreover, and that's likely another reason for troubles here, you have
>>>>> CONFIG_VT on. This normally unproblematic features collides with the TSC
>>>>> emulation of Xenomai.
>>>>>     
>>>>>           
>>>> I'll jump on this, since this likely deserves some detailed
>>>> explanations:
>>>>
>>>> The general problem with CONFIG_VT, is the tone generator it uses to
>>>> send bell events to the user, issued by the keyboard management code. On
>>>> x86, the related kernel code fiddles with the legacy programmable
>>>> interrupt timer (PIT) to create an audible tone, specifically this
>>>> chip's channels #0 and #2.
>>>>
>>>> And the problem starts here: when there is no TSC available to the
>>>> kernel, whether because there is none provided by the CPU, or its
>>>> support has been disabled in the kernel configuration (i.e.
>>>> CONFIG_X86_TSC unset), then Xenomai uses the PIT to emulate a kind of
>>>> poor man's TSC, so that it can eventually get a monotonic clock. To this
>>>> end, Xenomai will also use the PIT's channel #2, as a free running
>>>> counter. Hence the conflict with CONFIG_VT.
>>>>
>>>> But there is more: On x86, Xenomai also uses the PIT's channels #0 and
>>>> #1 when undergoing the oneshot timing mode, exclusively for kernel
>>>> configurations which do not provide APIC support (i.e.
>>>> CONFIG_X86_LOCAL_APIC unset, because none of CONFIG_X86_UP_APIC and
>>>> CONFIG_SMP are set). In such a case, the PC speaker management code
>>>> generating the tone will badly conflict with the Xenomai system timer
>>>> too, causing all sorts of erratic behaviours, since both step on each
>>>> other's toes when programming the PIT's channel #0.
>>>>
>>>> With Linux 2.4, the sound generator is reached through a callback
>>>> pointer, so Xenomai just routes the latter to a dummy routine, and we
>>>> are done. With Linux 2.6, the callback has disappeared from the vanilla
>>>> kernel, and sound event requests are sent to the input sub-system for
>>>> processing, where we have currently no hack to void them. This is the
>>>> reason why disabling CONFIG_VT entirely is recommended when there is a
>>>> risk of conflict (which is rather drastic, I agree).
>>>>
>>>> To sum up:
>>>> - The CONFIG_VT issue is in fact a conflict between the regular PC
>>>> speaker code and Xenomai.
>>>> - It is strictly a x86 issue.
>>>> - It is automatically solved by Xenomai over Linux 2.4, and should be
>>>> solved by disabling CONFIG_VT entirely over Linux 2.6 for configurations
>>>> which do not provide APIC or even TSC support, at least until Adeos
>>>> eventually silences this code, on demand, to help us.
>>>>
>>>> Since you have a P4, you do have a local APIC on your chip, so you
>>>> should enable it for a uni-processor configuration (CONFIG_X86_UP_APIC),
>>>> since it has far better performances latency-wise than the legacy
>>>> programmable interrupt controller. You also have a TSC, and the kernel
>>>> should use it automatically, provided the P4 CPU is properly selected in
>>>> your kernel configuration, as Jan pointed out.
>>>> With this configuration, you should not have to care about CONFIG_VT
>>>> anymore.
>>>>
>>>>   
>>>>         
>>> Ok I try to sum up the points to see if I understand your explanation right:
>>> On an x86 architecture xenomai uses the PIT to emulate a tsc,
>>>       
>> and provide oneshot timing support,
>>
>>     
>>>  but the
>>> PIT is also used by the VT to generate the speaker tone. And if I don't
>>> disable CONFIG_VT, or the Linux speaker code, things get messed up.
>>> But If I had an pentium architecture where tsc is provided, xenomai can
>>> take care of this and directly uses the tsc supported by the pentium 
>>> chip, assumed that the kernel
>>> is configured to a pentium.
>>> Am I right, could you ack this?
>>>
>>>       
>> Ack.
>>     
>
> ... provided you also enable CONFIG_X86_LOCAL_APIC for solving the
> oneshot timing issue.
>
>   
>>> Regards,
>>> Steve
>>>
>>>       
Ah ok.

Thanks again for the fine explanation on this issue.

Regards,
Steve

