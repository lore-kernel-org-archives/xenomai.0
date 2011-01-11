Message-ID: <4D2C80FC.7040903@domain.hid>
Date: Tue, 11 Jan 2011 17:10:36 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <alpine.DEB.1.10.1101111320530.16506@domain.hid>
In-Reply-To: <alpine.DEB.1.10.1101111320530.16506@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] blackfin kernel oops under heavy load
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenoka09@domain.hid
Cc: Xenomai GNA <xenomai@xenomai.org>

Kolja Waschk wrote:
> Hi,
> 
> I'd first like to report that I haven't yet been able
> to further examine the problems with gdb and pthread_cond_wait, which I asked
> about here some days ago. I found the bugs in my program which I was actually
> searching for with other tools, but will have another look when there's time.
> 
> Now I experience kernel OOPS under heavy load. From the Hardware Trace, it
> looks like the problem is somehow Xenomai-related which is why I post about it here.
> 
> Details about the situation: In /proc/xenomai/stat the two most busy tasks in my
> application consume each around 45 %CPU during stress tests. One of the threads
> receives data from a RTDM driver, and, because I have no RT driver for that
> channel yet, sometimes writes a few bytes to a non-RT serial port
> (/dev/ttyBF1). In other low prio tasks, IP network communication and stdio
> output takes place.
> 
> The OOPS come as a "Illegal use of supervisor resource" or "NULL pointer
> access". In both cases, the Hardware Trace looks very similar - the oldest
> entries name _xnpod_schedule_deferred+0x26, followed by
> ___ipipe_sync_root+0x3a, _systen_call, __common_int_entry, and then either
> ___ipipe_trigger_irq (NULL pointer access) and _trap or __ipipe_sync_root
> (Illegal use of supervisor resource) and _trap.
> 
> I use stock Blackfin 2.6.34-7 kernel (from dist 2010R1-RC5) with updated I-Pipe
> 1.14-02 and Xenomai 2.5.5.2 in kernel and userland on BF537.

Ok. Could you try with current xenomai-2.5 tip? We fixed a few things
which might, possibly, with some luck, be the cause of this issue.

To checkout current xenomai-2.5 tip, type:
git clone git://git.xenomai.org/xenomai-2.5.git

-- 
					    Gilles.

