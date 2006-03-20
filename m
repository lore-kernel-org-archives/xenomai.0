Message-ID: <441EEB67.2030307@domain.hid>
Date: Mon, 20 Mar 2006 18:50:31 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] yet another test tool
References: <441DD89A.4000501@domain.hid>	<17438.51347.702261.525919@domain.hid>
	<441EE46E.3080604@domain.hid> <441EE837.4000406@domain.hid>
In-Reply-To: <441EE837.4000406@domain.hid>
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
> Philippe Gerum wrote:
> 
>>Gilles Chanteperdrix wrote:
>>
>>>Jan Kiszka wrote:
>>> > (...)As Xenomai does not support hard-RT signal delivery yet (...)
>>>
>>>This is the next feature missing to the POSIX skin. I would like to
>>>implement this, but I am not sure which way to go :
>>>- either, if it is possible, getting Linux signals services to run in
>>>  every domain at Adeos level, by replacing spinlocks with spinlocks_hw
>>>  and such kind of tricks;
>>
>>Would be a nightmare, I think. Way too many paths are involved in the
>>vanilla kernel, and this would be overkill wrt what we want to do.
>>Actually, what we need is basically exposing the nucleus signal
>>interface to user-space, and map Linux RT signals over nucleus signals.
>>Other (non-RT) Linux signals would keep on being handled in secondary
>>mode the way they are now.
>>
>>
>>>- or adding a generic service at the adeos layer (a hook called when
>>>  returning to user-space), building a generic user-space signals
>>>  service at the nucleus level, and finally building all posix signals
>>>  services on top of this.
>>
>>A (maybe easier) third option would be to generalize some kind of
>>pseudo-asynchronous call support, with a worker thread operating on a
>>dedicated priority level inside applications registering for
>>asynchronous notifications. The kernel-side would handle the server
>>wakeups, providing a unified interface for pending on hooks, signals,
>>watchdogs etc. It would also need to properly multiplex those events
>>notified from within the skins, and wake up the right pending server in
>>user-space, which would in turn fire the user provided handler, all in
>>primary mode. In any case, this would not be more costly latency-wise
>>than implementing mere callouts, since most of the switching cost comes
>>from the MMU switch, which we would have to do in both cases, anyway.
> 
> 
> We would need a "shadow" priority level for each real one so that those
> handlers do not cause any priority inversions (the main RT issue of
> servers).

Not if the worker threads inherit the priority of the target threads 
dynamically.

  Moreover, it would require a bulk of extra threads, actually
> one per used prio level, to handle all those calls with the correct
> priority. My feeling: too costly, memory-wise.

You would just need one worker thread per-application and per-cpu. Async 
calls are always serialized, at least on a given CPU. The idea is to 
provide some event multiplexing capabilities to the kernel-side, instead 
of implementing a worker for each and every pended event.

The only thing that would differ from a real signal handling is the 
actual backtrace of the handler.

Another option without worker thread would be to implement the same kind 
of pending event detection the kernel does on the return path from 
Xenomai syscalls using some reserved CPU register, and ask the kernel 
side about the callout to fire and the argument to pass the handler 
whenever some pending event is detected.

> 
> Jan
> 


-- 

Philippe.

