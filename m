From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4C35BAEF.5020308@domain.hid>
References: <AANLkTik-cpk4RfJGxj422mOvU1xQFdQCfB8gno7uzD7N@mail.gmail.com>
	<4C34438D.9020905@domain.hid>
	<AANLkTiklX49KAfAlZND9FhVaTJZpdADFpuUIO-lkm6f6@domain.hid>
	<4C34EF76.2040602@domain.hid>
	<AANLkTik9RCKn90TnCj3JWBQF_XWaHbH0vSgp2vOu8HfH@mail.gmail.com>
	<4C3508E1.7090100@domain.hid>
	<1278578261.1810.67.camel@domain.hid>
	<4C359326.1090509@domain.hid>
	<1278582612.1810.124.camel@domain.hid>
	<4C35A094.4010206@domain.hid>
	<1278584354.1810.137.camel@domain.hid>
	<4C35BAEF.5020308@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 08 Jul 2010 17:01:30 +0200
Message-ID: <1278601290.1810.150.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] native: A 32k stack is not always a 'reasonable'
 size
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-help <xenomai@xenomai.org>

On Thu, 2010-07-08 at 13:47 +0200, Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
> > If I understand the glibc code properly, the stack cache is not
> > pre-filled, but merely serves to recycle old stacks from terminated
> > stacks. So, at least until a stack area could actually be reused from
> > that cache, fresh new stack space for new threads is always obtained via
> > mmap(), which means that we may have non-contiguous stack spaces most of
> > the time. It seems that things would start to hit the crapper when some
> > recycling takes place, in which case an overflow situation could cause a
> > stack to overflow on its neighbor.
> 
> I am not sure I understand what you mean. So, I am going to try and show
> you what I mean. I run the following program:
> 
> #include <stdio.h>
> 
> #include <pthread.h>
> #include <unistd.h>
> 
> void *thread(void *cookie)
> {
>         int x;
>         printf("sp: %p\n", &x);
>         pause();
>         return cookie;
> }
> 
> int main(void)
> {
>         pthread_t ida, idb;
>         pthread_create(&ida, NULL, thread, NULL);
>         pthread_create(&idb, NULL, thread, NULL);
>         pthread_join(ida, NULL);
>         return 0;
> }
> 
> On an ARMv7 (no FCSE involved) platform. It prints:
> sp: 0x411a2ddc
> sp: 0x409a2ddc
> 
> I then dump the process mappings, and I get everything contiguous:
> 401a4000-401a5000 ---p 00000000 00:00 0
> 401a5000-409a4000 rw-p 00000000 00:00 0
> 409a4000-409a5000 ---p 00000000 00:00 0
> 409a5000-411a4000 rw-p 00000000 00:00 0
> 
> So, it looks to me like if the thread with the highest stack address go
> past below the guard page limit, it will overrun the other thread's stack.

I mean that glibc does not pre-allocate pieces of anon memory to honor
requests for stack chunks, it gets them on the fly from an internal
cache if one matches, or mmaps its. Besides, the cache itself is only
fed with recycled stacks from terminated threads it seems, so we can't
predict whether all stacks there would be contiguous.

For instance, I'm assuming that tweaking your code like below would
likely prevent the stack segments from being contiguous:

        pthread_create(&ida, NULL, thread, NULL);
      +	mmap(NULL, 8*1024*1024, PROT_READ, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
	pthread_create(&idb, NULL, thread, NULL);
        pthread_join(ida, NULL);

If so, it is indeed likely that segments would be contiguous if threads
are started the way you did; on the other hand, it is possible that a
more complex application does not suffer this. Granted, this does not
help us that much anyway.

My point is that nothing guarantees us either contiguous or sparse stack
address ranges, so we probably should not rely on those assumptions.

> 
> On x86, this is a different story. I guess because the kernel or glibc
> has a stack top randomization strategy.
> 

-- 
Philippe.



