Subject: Re: [Xenomai-core] [PATCH] optimise syscall mux-code calculation
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44B8A1E9.7080004@domain.hid>
References: <44B62AE7.8080503@domain.hid> <1152930271.5027.69.camel@domain.hid>
	<44B8A1E9.7080004@domain.hid>
Content-Type: text/plain
Date: Sat, 15 Jul 2006 10:31:00 +0200
Message-Id: <1152952260.5057.15.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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

On Sat, 2006-07-15 at 10:06 +0200, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > On Thu, 2006-07-13 at 13:13 +0200, Jan Kiszka wrote:
> >> Hi,
> >>
> >> some may recall the "micro-optimisation" thread I once started. Here is
> >> now a simple approach to deal with the yet suboptimal mux-code
> >> calculation in user-space. Code saving:
> >>
> >> Before:
> >>    text    data     bss     dec     hex filename
> >>   18004     476       8   18488    4838 native/.libs/libnative.so
> >>   27445     696       4   28145    6df1 posix/.libs/libpthread_rt.so
> >>
> >> After:
> >>    text    data     bss     dec     hex filename
> >>   17172     476       8   17656    44f8 native/.libs/libnative.so
> >>   26805     696       4   27505    6b71 posix/.libs/libpthread_rt.so
> >>
> >> Of course, this also results in a few ops less being executed on each
> >> Xenomai syscall invocation (not many cycles, though).
> >>
> >> Tested without problems on x86 so far.
> >>
> > 
> > This is post 2.2 stuff since we need to check this critical change
> > against each and every supported arch. 
> 
> Agree, there is no need to hurry in 2.2.
> 
> > Since this breaks the ABI
> > including the ascending compatibility between old apps and new kernel
> > support, this won't make it during the v2 series either.
> 
> The ABI chance just took place due to my laziness - I didn't want to
> touch every skin library. Anyway, this ABI breakage can be avoided with
> slightly more effort, i.e. by doing the shift in user-space during the
> binding.
> 

Yes, the mangling should be done in xeno_user_skin_init().

> > 
> >> Jan
> >> plain text document attachment (optimise-muxcode-calculation.patch)
> >> ---
> >>  include/asm-arm/syscall.h      |   25 +++++++++++++------------
> >>  include/asm-blackfin/syscall.h |    4 +++-
> >>  include/asm-i386/syscall.h     |    3 ++-
> >>  include/asm-ia64/syscall.h     |   23 ++++++++++++-----------
> >>  include/asm-powerpc/syscall.h  |    3 ++-
> >>  ksrc/nucleus/shadow.c          |    3 ++-
> >>  6 files changed, 34 insertions(+), 27 deletions(-)
> >>
> >> Index: xenomai/include/asm-arm/syscall.h
> >> ===================================================================
> >> --- xenomai.orig/include/asm-arm/syscall.h
> >> +++ xenomai/include/asm-arm/syscall.h
> >> @@ -26,6 +26,7 @@
> >>  #include <asm-generic/xenomai/syscall.h>
> >>  
> >>  #define __xn_mux_code(id,op)    ((op << 24)|((id << 16) & 0xff0000)|(__xn_sys_mux & 0xffff))
> >> +#define __xn_mux_code_shft(shifted_id,op) ((op << 24)|shifted_id|(__xn_sys_mux & 0xffff))
> > 
> > +#define __xn_mux_code_shft(shifted_id,op) ((op << 24)|shifted_id)
> > 
> > should be enough.
> 
> Given my current calculation of the muxid in the kernel, yes. But the
> original variant has zero effect on the code and looks more consistent
> to me.

I don't get why actually. If the point is about reducing the number of
micro operations per syscall, then leaving this redundancy is pointless.
The relative obfuscation this optimization brings to the code is already
there, regardless of when the mux tag is crammed into the syscall code:
in any case, we have an half-baked syscall code which is going to be
adjusted at invocation time.

> 
> > 
> > <snip>
> > 
> >> Index: xenomai/include/asm-blackfin/syscall.h
> >> ===================================================================
> >> --- xenomai.orig/include/asm-blackfin/syscall.h
> >> +++ xenomai/include/asm-blackfin/syscall.h
> >> @@ -27,6 +27,7 @@
> >>     (i.e. negative syscall number in orig_p0 meaning "non-syscall
> >>     entry"). */
> >>  #define __xn_mux_code(id,op)   ((id << 24)|((op << 16) & 0xff0000)|(__xn_sys_mux & 0xffff))
> >> +#define __xn_mux_code_fast(shifted_id,op) ((op << 24)|shifted_id|(__xn_sys_mux & 0xffff))
> >>  
> > 
> > Breakage alert.
> > 
> 
> Oops.
> 
> Ok, I will rework this patch.
> 
> Jan
> 
-- 
Philippe.



