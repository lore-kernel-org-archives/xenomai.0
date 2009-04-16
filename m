Message-Id: <91569DDB-D66D-41FA-B8C4-7B40FC526EBC@comcast.net>
From: Steven Seeger <steven.seeger@domain.hid>
In-Reply-To: <Pine.LNX.4.64.0904161059220.24221@domain.hid>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v930.3)
Date: Thu, 16 Apr 2009 14:43:13 -0400
References: <Pine.LNX.4.64.0904081243120.22300@domain.hid>
	<Pine.LNX.4.64.0904081659110.22300@domain.hid>
	<Pine.LNX.4.64.0904101250540.4820@domain.hid>
	<Pine.LNX.4.64.0904101708030.4820@domain.hid>
	<6C68EA7C-72E4-482D-917A-24C7C6DA31C9@domain.hid>
	<Pine.LNX.4.64.0904101729031.4820@domain.hid>
	<49E08F6F.8000604@domain.hid>
	<Pine.LNX.4.64.0904111233180.32647@domain.hid>
	<49E0F887.40805@domain.hid>
	<Pine.LNX.4.64.0904111820330.6444@domain.hid>
	<49E1B05A.4040705@domain.hid>
	<Pine.LNX.4.64.0904121206040.23562@domain.hid>
	<49E23FB1.5030505@domain.hid>
	<Pine.LNX.4.64.0904151951500.9694@domain.hid>
	<4F0B1E98-862D-4031-B22E-D7DAEA554EEB@comcast.net>
	<Pine.LNX.4.64.0904161059220.24221@domain.hid>
Subject: Re: [Xenomai-help] Running xeno-test
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Martin Shepherd <mcs@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Sorry I wasn't clear. I want to test the timing of sleep while the  
system has no load. The issue we had was a timing problem, so unless  
interrupts were firing the system timer was off by like a factor of  
1000.

Such a small clock drift is probably normal just within the tolerances  
of the RTC and the CPU's crystal.

Weird that dd dropped so much in top. Aren't you the one with the  
failing memtest sometimes? Perhaps you should wait for that new  
computer. :)

Steven

On Apr 16, 2009, at 2:32 PM, Martin Shepherd wrote:

>
> On Thu, 16 Apr 2009, Steven Seeger wrote:
>> With xenomai's modules loaded (at least nucleus and a skin) can you  
>> please just type sleep 10 at a prompt and be sure that it takes 10  
>> seconds before returning? Maybe use a stopwatch.
>
> This worked fine. I timed a 10 second sleep and a 60 second sleep with
> my watch, while running clocktest (clocktest uses the nucleus and the
> posix skin). As far as I could tell with my stopwatch, both sleeps
> lasted the requested durations.
>
> Just in case this is significant, note that running clocktest just
> after one reboot gave numbers like the following:
>
> CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
> --- -------------------- ---------------- ---------- --------------
>   0            1163142.7            0.001          0            0.0
>
> Then rebooting and running clocktest again, a couple of minutes later,
> gave numbers like:
>
> CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
> --- -------------------- ---------------- ---------- --------------
>   0            -353036.6            0.035          0            0.0
>
> Shouldn't the ToD offset be closer to zero than these numbers, just
> after a reboot? Note that the ToD offset stays pretty constant during
> a given session (even if I run dd if=/dev/zero of=/dev/null for a
> short time).
>
> Interestingly, running "dd if=/dev/zero of=/dev/null" while running
> clocktest, didn't crash the computer. However within a few seconds of
> killing clocktest, the computer hung. I happened to be watching top at
> that time, and instead of dd taking over the CPU time that clocktest
> had been using, its CPU usage quickly dropped, ending up at just
> 12.3%, while nothing else appeared to be taking any significant
> time. The following is what top showed when the computer crashed:
>
> top - 11:20:37 up 10 min,  3 users,  load average: 1.15, 0.58, 0.27
> Tasks:  70 total,   3 running,  67 sleeping,   0 stopped,   0 zombie
> Cpu(s): 42.1%us, 57.9%sy,  0.0%ni,  0.0%id,  0.0%wa,  0.0%hi,   
> 0.0%si,  0.0%st
> Mem:    382648k total,   148212k used,   234436k free,     7348k  
> buffers
> Swap:   875500k total,        0k used,   875500k free,    76144k  
> cached
>
>   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
>  4170 root      20   0  3156  724  600 R 12.3  0.2   1:10.15 dd
>     1 root      20   0  3056 1900  576 S  0.0  0.5   0:00.63 init
>     2 root      15  -5     0    0    0 S  0.0  0.0   0:00.00 kthreadd
>     3 root      15  -5     0    0    0 S  0.0  0.0   0:00.02  
> ksoftirqd/0
>     4 root      15  -5     0    0    0 S  0.0  0.0   0:00.00 events/0
>   etc...
>
> Martin


