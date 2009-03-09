Message-ID: <49B55407.9000700@domain.hid>
Date: Mon, 09 Mar 2009 18:38:15 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <49B3A126.6000602@domain.hid> <49B53AC3.10707@domain.hid>
	<49B54780.6040504@domain.hid> <49B54D2C.5080001@domain.hid>
	<49B55175.2070205@domain.hid>
In-Reply-To: <49B55175.2070205@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Watchdog / immediate Linux signal delivery
Reply-To: rpm@xenomai.org
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
> Philippe Gerum wrote:
>> Jan Kiszka wrote:
>>> Meanwhile I played with some light-weight approach to relax a thread
>>> that received a signal (according to do_sigwake_event). Worked, but only
>>> once due to a limitation (if not bug) of I-pipe x86: in __ipipe_run_isr,
>>> it does not handle the case that a non-root handler may alter the
>>> current domain, causing corruptions to the IPIPE_SYNC_FLAG states of the
>>> involved domains.
>> It is not a bug, this is wanted. ISR must neither change the current
>> domain nor migrate CPU; allowing this would open Pandora's box.
> 
> And if there is no way to migrate from within an ISR, we can bury any
> attempt to deliver signals to spinning Xenomai threads - or what other
> context would remain to Xenomai for triggering migration?
>

The two-phase solution I have mentioned would work.

> Jan
> 


-- 
Philippe.

