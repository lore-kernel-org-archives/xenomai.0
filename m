Message-ID: <4DD4F242.2000507@domain.hid>
Date: Thu, 19 May 2011 12:34:42 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <294B28951EBE8146839AF99A61CB5FCE6B3F1A7999@domain.hid>	<4DCD0DFC.7050506@domain.hid>	<294B28951EBE8146839AF99A61CB5FCE6B3F1A7DDD@SI-MBX17.de.bosch.com>	<4DD25DF5.1070609@domain.hid>	<294B28951EBE8146839AF99A61CB5FCE6B3FF1946E@SI-MBX17.de.bosch.com>
	<4DD3EAAF.2010902@domain.hid> <4DD4F11A.4060506@domain.hid>
In-Reply-To: <4DD4F11A.4060506@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Same problems with ipipe-2.6.37-x86-branch and
 xenoami-head.git on Core 2 Duo E8400 - fixed with CONFIG_HPET_TIMER
 disabled
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Anders Blomdell <anders.blomdell@domain.hid>
Cc: "Benner Bernd (MH/EES)" <B.Benner@domain.hid>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2011-05-19 12:29, Anders Blomdell wrote:
> On 05/18/2011 05:50 PM, Jan Kiszka wrote:
>> On 2011-05-18 17:40, Benner Bernd (MH/EES) wrote:
>>> Hello,
>>>
>>>    I have rebuild my Kernel 2.6.37.6-x86 and uses xenomai-head.git. ( is this xenomai-2.6 git ? )
>>> This version has the same problems on the Core 2 Duo E8400 machines.
>>>
>>>    But there are some strange kernel messages on startup:
>>>
>>> May 18 16:07:33 (none) user.warn kernel: CE: hpet3 increased min_delta_ns to 7500 nsec
>>> May 18 16:07:33 (none) user.warn kernel: CE: hpet3 increased min_delta_ns to 11250 nsec
>>> May 18 16:07:33 (none) user.warn kernel: hrtimer: interrupt took 5978 ns
>>> ...
>>> May 18 16:07:33 (none) user.warn kernel: CE: hpet2 increased min_delta_ns to 11250 nsec
>>> ...
>>>    after a start of latency ( via ssh ) the linux domain will slow down and the sata driver will come in trouble.
>>>
>>>
>>>    If I rebuild my Kernel with CONFIG_HPET_TIMER disabled, latency will run normally on the Core 2 Duo E8400 machines.
>>>
>>>    CONFIG_HPET_TIMER has to be disabled on faster Core 2 Duo machines! There must be a consistency problem! ( probably in
>>> io_apic- handling with CONFIG_HPET_TIMER enabled )
>>>
>>>    I will rebuild and test my kernel with stable 2.5.X xenomai versions and ADEOS patches with CONFIG_HPET_TIMER disabled!
>>
>> Ah! I bet you have>3 HPET timers, and they are MSI capable. In that
>> case, Linux will actually prefer them over the LAPIC as clockevent
>> device, and Xenomai breaks apart. I didn't discovered this as my test
>> "machine" (QEMU/KVM) requires extra switches to enable that scenario.
>> However, it's getting more and more common on modern hardware, we should
>> take some measures to catch this conflict.
> Very timely report, this explains why my new powerful i7 (8 comparators) 
> machine hangs when WATCHDOG is enabled. This leaves me three choices (I 
> think):
> 
> 1. Disable watchdog (not desirable)
> 2. Disable MSI support -> more IRQ conflicts between devices, making it 
> harder to get a system without conflicts between Linux and Xenomai.

Right, it's impractical to work with modern PCs without MSI. We really
need to drop this needless recommendation for x86 (it may still apply to
other archs, as we've seen recently).

> 3. Disable HPET timers.
> 
> Are there any known problems (or performance considerations) with only 
> disabling HPET timers?

I think the reason for Linux to prefer MSI-capable HPET over APIC is the
fact that APICs may stop in certain deep power-saving states and HPETs
not. Given that such states are undesirable for RT anyway, I see no
drawbacks in disabling HPET support for Xenomai scenarios.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

