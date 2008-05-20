Message-ID: <2ff1a98a0805200023i53f138a7l375a3c736f1a4d8f@domain.hid>
Date: Tue, 20 May 2008 09:23:44 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <483278B2.9040805@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <18459.38249.462320.715909@domain.hid>
	<18480.25075.894860.415321@domain.hid>
	<4830677C.9050401@domain.hid>
	<18480.27194.137841.953471@domain.hid>
	<48306CDD.8050607@domain.hid>
	<18480.28886.48710.503957@domain.hid>
	<48307BDF.1010906@domain.hid>
	<18482.1009.89042.272689@domain.hid>
	<48327587.5000600@domain.hid> <483278B2.9040805@domain.hid>
Subject: Re: [Xenomai-core] [Patch 7/7] Re-implementation of mutexes,
	user-space support.
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
Cc: xenomai@xenomai.org

On Tue, May 20, 2008 at 9:07 AM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> Philippe Gerum wrote:
>> Gilles Chanteperdrix wrote:
>>> Philippe Gerum wrote:
>>>  > Gilles Chanteperdrix wrote:
>>>  > > Jan Kiszka wrote:
>>>  > >  > Gilles Chanteperdrix wrote:
>>>  > >  > > Jan Kiszka wrote:
>>>  > >  > >  > Gilles Chanteperdrix wrote:
>>>  > >  > >  > > Philippe Gerum wrote:
>>>  > >  > >  > >  > Gilles Chanteperdrix wrote:
>>>  > >  > >  > >  > > Since binding of the semaphore heaps is now made by xeno_skin_bind, there is
>>>  > >  > >  > >  > > much less modifications in src/skins/posix/init.c. However, I had to do
>>>  > >  > >  > >  > > something really ugly: since binding the semaphore heaps by xeno_skin_bind
>>>  > >  > >  > >  > > requires calls to open, ioctl, mmap, close and munmap, I redefined these symbols
>>>  > >  > >  > >  > > to be the __real_ variants before including bind.h.
>>>  > >  > >  > >  >
>>>  > >  > >  > >  > Is there any upside to do this instead of simply calling the __real_*
>>>  > >  > >  > >  > placeholders, since we do already provide weak wrappers for those when the
>>>  > >  > >  > >  > linker's wrapping magic is not invoked?
>>>  > >  > >  > >
>>>  > >  > >  > > The point is that the wrappers and linker magic only take place for
>>>  > >  > >  > > POSIX skins. Other skins have to call the genuine open, ioctl, mmap,
>>>  > >  > >  > > close and munmap services.
>>>  > >  > >  >
>>>  > >  > >  > What about controlling the desired prefix for generic functions in
>>>  > >  > >  > bind.h via some #define that the caller has to/can set before including
>>>  > >  > >  > the header:
>>>  > >  > >  >
>>>  > >  > >  > #define POSIX_PREFIX    __real_
>>>  > >  > >  > #include <asm-generic/bits/bind.h>
>>>  > >  > >  >
>>>  > >  > >  > and there we would have:
>>>  > >  > >  >
>>>  > >  > >  > POSIX_PREFIX##open(...);
>>>  > >  > >  >
>>>  > >  > >  > Looks a bit cleaner to me.
>>>  > >  > >
>>>  > >  > > Well, in this case we end up cluttering the code with the POSIX_PREFIX
>>>  > >  > > macro, even in the non posix case where no prefix is needed.
>>>  > >  >
>>>  > >  > Yes, but there are only few spots. The advantage of this strategy is
>>>  > >  > that it is explicit in-place (ie. inside bind.h). That avoids potential
>>>  > >  > collateral damage in the future when other services are added to that
>>>  > >  > helper which shall not be wrapped.
>>>  > >
>>>  > > Actually, the only important call is open. Since once the file
>>>  > > descriptor has been created with __real_open, all syscall wrappers will
>>>  > > automatically fall back to the __real syscall variants.
>>>  > >
>>>  >
>>>  > Then let's just provide __real_open() as a weak symbol in all libs; that's less
>>>  > error-prone that fiddling with the preprocessor.
>>>
>>> For now, I kept a solution based on the preprocessor. If I remember
>>> correctly, the __real stuff needs to be in a separate object, this
>>> means that we cannot put __real_open definition in bind.h, we have to
>>> generate an open_wrapper.lo object and link every library with this
>>> object. Is this really what we want ?
>>>
>>
>> bind.h is meant to be included exclusively from init.c files. So yes, as far as
>> possible, we don't want to mess with the preprocessor.
>
> Then better let the caller decide which version to call. A simple
> argument to xeno_bind_skin can be passed through to map_sem_heap and
> define there if open or __real_open is used. As the functions are
> inlined, we shouldn't see the other symbol after the compilation.

Except the day when would compile without optimization... I will
implement the open_wrapper.lo solution.

-- 
 Gilles

