Message-ID: <47373CB9.2010104@domain.hid>
Date: Sun, 11 Nov 2007 18:32:41 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <47373B12.7020808@domain.hid>
In-Reply-To: <47373B12.7020808@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] x86_64: problems with syscall tracing?
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
> Philippe,
> 
> you recently said there is a bug in the x86_64 support when syscall
> tracing is enabled. Now I think I stepped on it as well: In order to
> validate my APIC frequency patches for that arch, I wanted to use LTTng
> there. But as soon as I start the trace, the latency test fails to run,
> prematurely exiting due to a segfault.

Exactly what Gilles sees on his box too, latency segfaulting at startup.
On mine, the kernel does not even boot.

 Gdb and the kernel say that user
> land jumped to address 0, I just yet failed to find out where they come
> from. I strongly assume LTTng enables syscall tracing, because its
> entry/exit instrumentations are inside the hook function
> (syscall_trace_entry/leave).
> 
> Do you have any further details on your tracing issue? Does may
> observation correlates with yours?

Quite frankly, I did not dig the issue that far yet, but yes, my first
impression is that something is broken in the syscall return path (or
entry?), and it shows when the return path to user-space is diverted in
some way, either for security auditing, or likely for tracing like
you've just reported.

> 
> Jan
> 


-- 
Philippe.

