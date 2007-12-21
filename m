Message-ID: <476BAE70.5080600@domain.hid>
Date: Fri, 21 Dec 2007 13:15:44 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <47373B12.7020808@domain.hid>	<47373CB9.2010104@domain.hid>	<18231.25399.331189.714344@domain.hid>
	<47381AC0.6020502@domain.hid>
In-Reply-To: <47381AC0.6020502@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] x86_64: problems with syscall tracing?
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Philippe Gerum wrote:
>>  > Jan Kiszka wrote:
>>  > > Philippe,
>>  > > 
>>  > > you recently said there is a bug in the x86_64 support when syscall
>>  > > tracing is enabled. Now I think I stepped on it as well: In order to
>>  > > validate my APIC frequency patches for that arch, I wanted to use LTTng
>>  > > there. But as soon as I start the trace, the latency test fails to run,
>>  > > prematurely exiting due to a segfault.
>>  > 
>>  > Exactly what Gilles sees on his box too, latency segfaulting at startup.
>>  > On mine, the kernel does not even boot.
>>  > 
>>  >  Gdb and the kernel say that user
>>  > > land jumped to address 0, I just yet failed to find out where they come
>>  > > from. I strongly assume LTTng enables syscall tracing, because its
>>  > > entry/exit instrumentations are inside the hook function
>>  > > (syscall_trace_entry/leave).
>>  > > 
>>  > > Do you have any further details on your tracing issue? Does may
>>  > > observation correlates with yours?
>>  > 
>>  > Quite frankly, I did not dig the issue that far yet, but yes, my first
>>  > impression is that something is broken in the syscall return path (or
>>  > entry?), and it shows when the return path to user-space is diverted in
>>  > some way, either for security auditing, or likely for tracing like
>>  > you've just reported.
>>
>> From what I have read in some comments, the syscall auditing function
>> kmallocs some memory that is kfreed on syscall return. Obviously, this
>> can not work with Xenomai.
>>
> 
> Just a short update on this: Right before going mad over this bug, I
> recalled some posting on ltt-dev by Mathieu Desnoyers about x86_64 and
> some syscall tracing race. With this patch [1] applied, things work
> again as they should! Then I followed his thread on LKML and tried the
> second version of the patch [2], but that one does not work for us. Now
> I wonder (but didn't analyse yet) if the first patch just moves some
> race window around or actually fixes the bug for us?
> 
> Jan
> 
> [1]http://listserv.shafik.org/pipermail/ltt-dev/2007-October/002519.html
> [2]http://lkml.org/lkml/2007/10/28/160

I just once again ran into this issue - this time without any LTTng
patch applied. Sigh.

Philippe, we need [2] in the x86-64 Adeos patch to allow for
CONFIG_AUDITSYSCALL. In my case, leaving out --enable-sep during Xenomai
user land build worked around this, but that's no solution.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

