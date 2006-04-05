Message-ID: <44336E08.2000707@domain.hid>
Date: Wed, 05 Apr 2006 09:13:12 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Frozen timer IRQ
References: <4432E540.1010108@domain.hid>
In-Reply-To: <4432E540.1010108@domain.hid>
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
> my colleagues and I need some hint where to continue our search for the
> cause of a weird cleanup issue:
> 
> An application of our robotics framework sometimes terminates (though
> successfully) in a way that the system timer IRQ no longer arrives
> afterwards or no re-program takes place anymore.

Assuming that the APIC is disabled in the kernel configuration, so that 
there could be an issue with the nucleus host timer, I would try to look 
at the state of this timer (XNTIMER_DEQUEUED?) right after the cleanup. 
I would also try to store a copy of the last timer object seen by 
xntimer_next_local_shot(), so that the timer id (htimer or not 
basically) and the programmed tick date could be looked at after the 
cleanup phase. Normally, if no other application timer is active, the 
host timer should be the only one to tick periodically until 
xnpod_shutdown is called, and thus should keep on being reprogrammed by 
xntimer_next_local_shot().

If xnpod_shutdown is called, then this is another story, and 
rthal_timer_release() should be inspected instead.

  All other Linux IRQs
> are fine (Ethernet, keyboard, etc.). I cannot provide an easy test case
> yet as besides the framework some expensive gyroscope and the 16550A
> driver are involved.
> 
> Fortunately, we found a clean way of stabilising the application by
> fixing our broken code :) and improving the serial driver (RTIOC_PURGE),
> so that the original problem is solved now (unreliable startup and
> cleanup). Anyway, the stopped timer is not yet explainable, and that's
> why we plan to dig deeper.
> 
> Jan
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 

Philippe.

