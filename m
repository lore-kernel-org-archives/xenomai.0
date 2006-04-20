Message-ID: <444784BF.7080603@domain.hid>
Date: Thu, 20 Apr 2006 14:55:27 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [RFC] shadow threads with prio 0 / SCHED_NORMAL
References: <4446B348.10403@domain.hid>
In-Reply-To: <4446B348.10403@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
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
> Hi,
> 
> this is an experimental hack to open the non-rt priority levels of Linux
> to Xenomai shadow threads, i.e. allow shadows to be scheduled under
> SCHED_NORMAL when in secondary mode. The scenario are typical borderline
> threads between RT and non-RT: they share a critical code path with RT
> threads, maybe mutex protected, but they are mostly time-sharing threads
> which do not need SCHED_FIFO for this.
> 
> The patch (be careful, quick-hack!) addresses the prio level 0 in the
> ipipe patch, the nucleus/shadow subsystem, and the native skin. A quick
> test with the attached demo showed the expected behaviour so far: no
> lock-up during busy-waiting in secondary mode, prio-boost when holding
> the lock (visible via /proc/xenomai/sched), no obvious side effects.
> 
> Any comments? Does this break other things in a subtle way?
> 

Normally, the fixes that went in 2.1 regarding the internal 
synchronization of the thread hardening/relaxing services should allow 
this since we don't care anymore of the underlying Linux scheduling 
class. I'm queuing this patch for further testing, but I basically agree 
with its purpose, since it's another step toward deep integration with 
Linux. Thanks.

-- 

Philippe.

