Message-ID: <48AE852D.3020506@domain.hid>
Date: Fri, 22 Aug 2008 11:21:49 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48ADC134.7060605@domain.hid>
	<48ADC224.9030409@domain.hid>	<48ADC3B0.4080204@domain.hid>
	<48ADC493.7000009@domain.hid> <48ADC7C4.8040902@domain.hid>
	<48AE8481.40905@domain.hid>
In-Reply-To: <48AE8481.40905@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Fast userspace locks for native skin
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> decision (we could store the first pending thread priority in a
>> user/kernel shared area, with the complication that we would need
>> updating this priority if it ever changes, but to get the priority of
>> the current thread, we also need a syscall, moreover switching to
>> secondary mode).
> 
> I'm not thinking about the case where there is already someone waiting.
> That will need a kernel entry anyway (the low-prio waiter may sit on
> some other CPU...). But in case signaling always happens before pending,
> there is no need at all to consult the kernel.

In this case, you can avoid calling pthread_cond_signal at all... So, if
you are stupid enough to call pthread_cond_signal when no-one is
waiting, you deserve a syscall anyway.

-- 
                                                 Gilles.

