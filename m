Message-ID: <4E89DF1E.7040608@domain.hid>
Date: Mon, 03 Oct 2011 18:13:18 +0200
From: =?UTF-8?B?UGV0ciDEjGVydmVua2E=?= <grugh@domain.hid>
MIME-Version: 1.0
References: <20110926090226.9C75AD68@domain.hid>
	<20111003103914.8A2B636C@centrum.cz>
	<CAPASGLohhztGb0h97QAReSS1z3p++iPOEhNfEGXew3A9P5VmZw@domain.hid>
In-Reply-To: <CAPASGLohhztGb0h97QAReSS1z3p++iPOEhNfEGXew3A9P5VmZw@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Frequency downscaling of new intel CPU
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Eric Noulard <eric.noulard@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

I'm sure that CPU_FREQ, ACPI_PROCESSOR, CPU_IDLE, INTEL_IDLE and 
7300_IDLE were disabled in kernel configuration and no cpufreq module is 
loaded (or even created).

Later I tried (desperately) to enable most of these settings and 
although I set performance governor to cpufreq, no measurable change 
happened (using acpi_cpufreq module).
But cpuidle (when compiled in kernel) shows that a lot of time is spent 
in power saving states 
(/sys/devices/system/cpu/cpu<n>/cpuidle/state<i>/..., where <i> is also 
2 and 3).

And on one of the mainboards I tried, the acpi_cpufreq was unable to 
load, perhaps because of the disabled BIOS settings).

I'm now working with windows, so the sysfs path is what I remember 
(maybe not so well).

Petr

Dne 3.10.2011 10:47, Eric Noulard napsal(a):
> 2011/10/3 Petr Cervenka<grugh@domain.hid>:
>> Hello again.
>> I know, that my problem is not so close related with the xenomai. But I think many of xenomai users with new intel CPUs have similar problem.
>> I tried it it with two different main boards and none of the BIOS settings helped. (C-states: disabled, Speedstep: disabled, CPU idle: high performance, TurboBoost: disabled, ...). My theory is that the linux kernel overrides BIOS settings, but I don't know how to prove it.
>> Any ideas that could help me?
> Did you verify that you don't have any cpufred related module loaded?
>
> What does
>
> $ lsmod | grep cpu
>
> indicate?
>
> You can try that one too:
>
> $ find /sys/devices/system -name "cpufreq"
>
>

