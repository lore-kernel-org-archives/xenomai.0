From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45CDC6A0.1020407@domain.hid>
References: <45CDAA95.1070900@domain.hid> <45CDC5AE.5010903@domain.hid>
	<45CDC6A0.1020407@domain.hid>
Content-Type: text/plain
Date: Sun, 11 Feb 2007 23:42:08 +0100
Message-Id: <1171233728.5035.22.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: [Adeos-main] Re: tracer broken on 2.6.20-i386
Reply-To: rpm@xenomai.org
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

On Sat, 2007-02-10 at 14:20 +0100, Jan Kiszka wrote:
> Jan Kiszka wrote:
> > Jan Kiszka wrote:
> > 
> >> Philippe,
> >>
> >> have you had to adopt any tracer-related code while switching to 2.6.20?
> >> The same .config that worked fine for 2.6.19 doesn't boot here on
> >> 2.6.20. The kernel hangs during or after decompression. Disabling the
> >> tracer resolves this.
> >>   
> > 
> > I had a look at latest -rt and found some new change (which turned out
> > to be a hack). Playing with it, I understood its motivation (avoid
> > instrumentation of the decompressor). Here comes a cleaner variant for
> > 2.6.20 (all archs). Tracer boots fine again. :)
>           ^^^^^^^^^
> Strike that, I lost the overview for a while. It remains an i386 issue.
> 

The tracer still has a problem when booting 2.6.20 here (UP, LAPIC,
static Xenomai build, default configuration for both Xeno and the
pipeline+tracer, your latest patch against boot/compressed/Makefile
applied).

__ipipe_trace seems to be called before the trace log has been setup,
hence the box jumps out of the window upon an invalid data reference
when storing some mcount data. Enabling the VMALLOC log option clears
the issue.


> > 
> > Jan
> > 
> > 
> > Index: linux-2.6.20/arch/i386/boot/compressed/Makefile
> > ===================================================================
> > --- linux-2.6.20.orig/arch/i386/boot/compressed/Makefile
> > +++ linux-2.6.20/arch/i386/boot/compressed/Makefile
> > @@ -9,6 +9,7 @@ targets		:= vmlinux vmlinux.bin vmlinux.
> >  EXTRA_AFLAGS	:= -traditional
> >  
> >  LDFLAGS_vmlinux := -T
> > +CFLAGS := $(subst -pg,,$(CFLAGS))
> >  CFLAGS_misc.o += -fPIC
> >  hostprogs-y	:= relocs
> >  
> > 
> > 
> 
> 
-- 
Philippe.



