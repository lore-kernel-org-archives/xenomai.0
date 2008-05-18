Message-ID: <48307BDF.1010906@domain.hid>
Date: Sun, 18 May 2008 20:56:31 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <18459.38249.462320.715909@domain.hid>	<18459.38430.835407.942336@domain.hid>	<18459.38500.720338.652195@domain.hid>	<18459.38558.684426.240775@domain.hid>	<18459.38644.699369.801548@domain.hid>	<18459.38704.252719.734650@domain.hid>	<18459.38785.367098.763153@domain.hid>	<18459.38879.202210.838294@domain.hid>	<48305C5D.3020601@domain.hid>	<18480.25075.894860.415321@domain.hid>	<4830677C.9050401@domain.hid>	<18480.27194.137841.953471@domain.hid>	<48306CDD.8050607@domain.hid>
	<18480.28886.48710.503957@domain.hid>
In-Reply-To: <18480.28886.48710.503957@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [Patch 7/7] Re-implementation of mutexes,
 user-space support.
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > Gilles Chanteperdrix wrote:
>  > > Jan Kiszka wrote:
>  > >  > Gilles Chanteperdrix wrote:
>  > >  > > Philippe Gerum wrote:
>  > >  > >  > Gilles Chanteperdrix wrote:
>  > >  > >  > > Since binding of the semaphore heaps is now made by xeno_skin_bind, there is
>  > >  > >  > > much less modifications in src/skins/posix/init.c. However, I had to do
>  > >  > >  > > something really ugly: since binding the semaphore heaps by xeno_skin_bind
>  > >  > >  > > requires calls to open, ioctl, mmap, close and munmap, I redefined these symbols
>  > >  > >  > > to be the __real_ variants before including bind.h.
>  > >  > >  > 
>  > >  > >  > Is there any upside to do this instead of simply calling the __real_*
>  > >  > >  > placeholders, since we do already provide weak wrappers for those when the
>  > >  > >  > linker's wrapping magic is not invoked?
>  > >  > > 
>  > >  > > The point is that the wrappers and linker magic only take place for
>  > >  > > POSIX skins. Other skins have to call the genuine open, ioctl, mmap,
>  > >  > > close and munmap services.
>  > >  > 
>  > >  > What about controlling the desired prefix for generic functions in
>  > >  > bind.h via some #define that the caller has to/can set before including
>  > >  > the header:
>  > >  > 
>  > >  > #define POSIX_PREFIX	__real_
>  > >  > #include <asm-generic/bits/bind.h>
>  > >  > 
>  > >  > and there we would have:
>  > >  > 
>  > >  > POSIX_PREFIX##open(...);
>  > >  > 
>  > >  > Looks a bit cleaner to me.
>  > > 
>  > > Well, in this case we end up cluttering the code with the POSIX_PREFIX
>  > > macro, even in the non posix case where no prefix is needed.
>  > 
>  > Yes, but there are only few spots. The advantage of this strategy is
>  > that it is explicit in-place (ie. inside bind.h). That avoids potential
>  > collateral damage in the future when other services are added to that
>  > helper which shall not be wrapped.
> 
> Actually, the only important call is open. Since once the file
> descriptor has been created with __real_open, all syscall wrappers will
> automatically fall back to the __real syscall variants.
> 

Then let's just provide __real_open() as a weak symbol in all libs; that's less
error-prone that fiddling with the preprocessor.

-- 
Philippe.

