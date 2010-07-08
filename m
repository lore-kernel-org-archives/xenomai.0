Message-ID: <4C35FDC7.8000908@domain.hid>
Date: Thu, 08 Jul 2010 18:33:11 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
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
	<1278601290.1810.150.camel@domain.hid>
In-Reply-To: <1278601290.1810.150.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-help <xenomai@xenomai.org>

Philippe Gerum wrote:
> I mean that glibc does not pre-allocate pieces of anon memory to honor
> requests for stack chunks, it gets them on the fly from an internal
> cache if one matches, or mmaps its. Besides, the cache itself is only
> fed with recycled stacks from terminated threads it seems, so we can't
> predict whether all stacks there would be contiguous.
> 
> For instance, I'm assuming that tweaking your code like below would
> likely prevent the stack segments from being contiguous:
> 
>         pthread_create(&ida, NULL, thread, NULL);
>       +	mmap(NULL, 8*1024*1024, PROT_READ, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> 	pthread_create(&idb, NULL, thread, NULL);
>         pthread_join(ida, NULL);
> 
> If so, it is indeed likely that segments would be contiguous if threads
> are started the way you did; on the other hand, it is possible that a
> more complex application does not suffer this. Granted, this does not
> help us that much anyway.
> 
> My point is that nothing guarantees us either contiguous or sparse stack
> address ranges, so we probably should not rely on those assumptions.

So the worst case, in case of massive stack overflow, or in a system
without MMU is silent corruption of unrelated data.

I am not sure of what we can do about that. Not sure
-fstack-protector/-fstack-check is a solution.

-- 
					    Gilles.

