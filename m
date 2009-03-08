Message-ID: <49B3D98C.2070805@domain.hid>
Date: Sun, 08 Mar 2009 15:43:24 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <49B3A126.6000602@domain.hid> <49B3CAFF.6090406@domain.hid>
	<49B3D4C9.2000801@domain.hid>
In-Reply-To: <49B3D4C9.2000801@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Watchdog / immediate Linux signal delivery
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
>> Jan Kiszka wrote:
>>> Linux (e.g. via xnpod_suspend_thread(<cpu-hog>). Unfortunately, there is
>>> no way to force a shadow thread into secondary mode to handle pending
>>> Linux signals unless that thread issues a syscall once in a while. And
>>> that raises the question if we shouldn't improve this as well while we
>>> are on it.
>>>
>>> Granted, non-broken Xenomai user space threads always issue frequent
>>> syscalls, otherwise the system would starve (and the watchdog would come
>>> around). On the other hand, delaying signals till syscall prologues is
>>> different from plain Linux behaviour...
>>>
>>> Comments, ideas?
>> We discussed the issue of having a way to force threads to relax with
>> Philippe, and we both had patches to make this work. However, the issue
>> we recently had with the emulated iret on x86 makes me think that we can
>> not relax at any point in time, the code surrounding the relax has to be
>> made to allow a relax to occur.
>>
> 
> Those issues were fixed. If we have similar problems around
> __ipipe_handle_irq (I would expect the relaxation to take place in
> xnintr_*_handler), then they should be fixed as well.
> 
> The problem is that I currently do not see any other way of cleanly
> terminating or debugging some Xenomai user space thread doing "while
> (1);" (or any more complicated variation).

I am not really opposed to the "force relax upon signal", thing, but the
current approach used to work, at least with v2.3.x, so it must be my
recent rework of thread termination which broke things, maybe we can
repair them?

-- 
					    Gilles.

