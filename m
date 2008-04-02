Message-ID: <47F41AD3.2020809@domain.hid>
Date: Wed, 02 Apr 2008 19:46:27 -0400
From: Tomas Kalibera <kalibera@domain.hid>
MIME-Version: 1.0
References: <47ED5DE3.60202@domain.hid>	<47F17B32.7070505@domain.hid>	<18417.52630.8850.939898@domain.hid>	<47F23E9E.7060801@domain.hid>	<2ff1a98a0804010703v7090d7dbhbbff114a51badd6d@domain.hid>	<47F258AD.3000103@domain.hid>	<2ff1a98a0804010858kb009b37y764667cf1fa56c6@domain.hid>	<47F2A7CC.4050301@domain.hid>	<2ff1a98a0804020142r55bab884x8896c8191f8580d5@domain.hid>	<47F3A00E.1020700@domain.hid>	<2ff1a98a0804020807t4d2cc718x493ae3c48e9a042f@domain.hid>	<47F3E0B3.2030805@domain.hid>	<18419.57862.758026.458669@domain.hid>	<47F3FE7E.6020302@domain.hid>
	<18420.2520.32895.319766@domain.hid>
In-Reply-To: <18420.2520.32895.319766@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Kernel crash with Xenomai (caused by fork?)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Of course, we are looking for all bugs. But please tell me: do you get
> the lock-up even before fork is called ? If not, could you verify that
> at least some Xenomai programs run correctly, for instance latency ?
>   
The lock up with patch 5 happens before fork is called, but after a 
real-time task is started by the program. I don't know better now - I'd 
have to add more logging.  If I run in strace, the lock-up does not happen.

Thinking about that, it can be a bug in my program. If I understand the 
concept of Xenomai correctly, I can just write a real-time task that 
would starve the Linux kernel indefinitely, correct ? My program 
definitely does have bugs. So I'll do more debugging.

The lock-up does NOT happen with latency. But, the bug in the kernel 
without patch 5 (the one that lead to a stack trac, after call to fork), 
did not appear in latency, either.
> Looking at the code, I think I found a bug, but I doubt it could cause a
> lockup. The definition of VM_PINNED in include/linux/mm.h collides with
> another bit used by Linux, so this defintion should be changed from:
> #define VM_PINNED 0x08000000
> to:
> #define VM_PINNED 0x10000000
>
> I will now try, if possible, to reproduce the bug on a x86 box of mine
> and will keep you informed.
>   
Thanks ! I'll indeed build kernel with patch 6, test again, and test my 
application.

Tomas


