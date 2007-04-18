From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <46265FC8.1070207@domain.hid>
References: <46265FC8.1070207@domain.hid>
Content-Type: text/plain
Date: Wed, 18 Apr 2007 22:07:16 +0200
Message-Id: <1176926837.5010.90.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [BUG] target width of shifts on 64 bits
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

On Wed, 2007-04-18 at 20:13 +0200, Jan Kiszka wrote:
> Hi Philippe,
> 
> here is an explanation of the scalable scheduler issue I face on x86_64
> under different gcc compilers:
> 
>         unsigned long x = 0;
>         int n = 32;
> 
>         x |= 1 << n;
> 
> The last instruction translates to:
> 
> 	mov    0xfffffffffffffffc(%rbp),%ecx
> 	mov    $0x1,%eax
> 	shl    %cl,%eax
> 	cltq
> 	or     %rax,0xfffffffffffffff0(%rbp)
> 

Blast. Good spot.

> That means we only shift with 32-bit precision although the target type
> is 64 bit. We find such code for setting the queue usage bits in
> addmlq(), but probably elsewhere too. This variant lets gcc generate the
> desired code:
> 
> 	x |= (unsigned long)1 << n;
> 
> Compiler issue, x86_64-specific oddity, or generic 64-bit problem we may
> have across the ipipe and Xenomai code (ppc64, ia64?)?
> 

A brief look at the I-pipe code base shows that most shift expressions
have righthand sides limited to small values (at least always < 32), and
when they don't, the lefthand side is properly cast to long long values,
so this should be ok.

BUT, it's a general 64bit port issue for Xenomai, which is not specific
to the multi-level queue implementation. We have the same issue going on
with at least:

- the posix registry
- the message pipe support from the nucleus
- the vrtx id generator

Gentlemen, it's time for bug hunting.

> After patching nucleus/queue.h appropriately, my oopses disappear, but
> RT threads still do not run (no CSW to the threads latency creates).
> Jan
> 
> 
> PS: If you are interested, I could post a modified qemu patch that
> enables gdb kernel debugging under x86_64.
> 

Yes please. I would have a look to the remaining issue I have here
exclusively over qemu, which seems unrelated to the multi-level queue
issue though.

-- 
Philippe.



