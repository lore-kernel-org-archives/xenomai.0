Message-ID: <4DD3EAAF.2010902@domain.hid>
Date: Wed, 18 May 2011 17:50:07 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <294B28951EBE8146839AF99A61CB5FCE6B3F1A7999@domain.hid>	<4DCD0DFC.7050506@domain.hid>
	<294B28951EBE8146839AF99A61CB5FCE6B3F1A7DDD@SI-MBX17.de.bosch.com>
	<4DD25DF5.1070609@domain.hid>
	<294B28951EBE8146839AF99A61CB5FCE6B3FF1946E@SI-MBX17.de.bosch.com>
In-Reply-To: <294B28951EBE8146839AF99A61CB5FCE6B3FF1946E@SI-MBX17.de.bosch.com>
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
To: "Benner Bernd (MH/EES)" <B.Benner@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2011-05-18 17:40, Benner Bernd (MH/EES) wrote:
> Hello,
> 
>   I have rebuild my Kernel 2.6.37.6-x86 and uses xenomai-head.git. ( is this xenomai-2.6 git ? )
> This version has the same problems on the Core 2 Duo E8400 machines.
> 
>   But there are some strange kernel messages on startup:
> 
> May 18 16:07:33 (none) user.warn kernel: CE: hpet3 increased min_delta_ns to 7500 nsec
> May 18 16:07:33 (none) user.warn kernel: CE: hpet3 increased min_delta_ns to 11250 nsec
> May 18 16:07:33 (none) user.warn kernel: hrtimer: interrupt took 5978 ns
> ...
> May 18 16:07:33 (none) user.warn kernel: CE: hpet2 increased min_delta_ns to 11250 nsec
> ...
>   after a start of latency ( via ssh ) the linux domain will slow down and the sata driver will come in trouble.
> 
> 
>   If I rebuild my Kernel with CONFIG_HPET_TIMER disabled, latency will run normally on the Core 2 Duo E8400 machines.
> 
>   CONFIG_HPET_TIMER has to be disabled on faster Core 2 Duo machines! There must be a consistency problem! ( probably in
> io_apic- handling with CONFIG_HPET_TIMER enabled )
> 
>   I will rebuild and test my kernel with stable 2.5.X xenomai versions and ADEOS patches with CONFIG_HPET_TIMER disabled!

Ah! I bet you have >3 HPET timers, and they are MSI capable. In that
case, Linux will actually prefer them over the LAPIC as clockevent
device, and Xenomai breaks apart. I didn't discovered this as my test
"machine" (QEMU/KVM) requires extra switches to enable that scenario.
However, it's getting more and more common on modern hardware, we should
take some measures to catch this conflict.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

