Message-ID: <4F0ADAAF.70504@domain.hid>
Date: Mon, 09 Jan 2012 13:16:47 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <BLU166-W368BD6DC25E9423818DC75C49A0@domain.hid>
	<BLU166-W50364F5FF2956D7D3F6F78C49B0@domain.hid>
In-Reply-To: <BLU166-W50364F5FF2956D7D3F6F78C49B0@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Questio about the Xenomai Scheduler
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan-Erik Lange <jan0385@domain.hid>
Cc: xenomai@xenomai.org

On 01/08/2012 01:06 PM, Jan-Erik Lange wrote:
> 
> Is it perhaps this way?:
> 
> When the RT-Task migrated into the secondary domain, it is scheduled
> by the Linux-Scheduler:
> 
> -> It inherits the RT-priority from her life in the primary domain
> and is timely priviliged compared to other tasks scheduled by the
> linux scheduler, which have a lower priority.

No, a linux task with a higher priority than the RT task running in
secondary mode may preempt the RT task running in secondary mode.

> -> But it can always be
> preempted by an RT-Task, that runs in the primary domain and that is
> scheduled by the Xenomai Scheduler, because this scheduler can
> preempt all standard linux kernel activities. 

Yes if root priority inheritance is disabled, not if it is enabled (the
default).

> -> Still it is
> protected from preempting by an Linux interrupt handler, because the
> I-Pipe is block the interrupts.

No, this used to be true a long time ago, but is no longer the case.

You have to consider that an RT task running in secondary mode is an
ordinary linux task. Only tasks remaining in primary mode are deterministic.

-- 
                                                                Gilles.

