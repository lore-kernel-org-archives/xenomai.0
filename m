Subject: Re: [Adeos-main] Re: Patch/Code maintanance
From: Philippe Gerum <rpm@xenomai.org>
Reply-To: rpm@xenomai.org
In-Reply-To: <40C03997.5040805@domain.hid>
References: <40BF7732.801@domain.hid> <1086251506.682.28.camel@domain.hid>
	 <40C03997.5040805@domain.hid>
Content-Type: text/plain
Message-Id: <1086253742.680.8.camel@domain.hid>
Mime-Version: 1.0
Date: Thu, 03 Jun 2004 11:09:02 +0200
Content-Transfer-Encoding: 7bit
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: Wolfgang Grandegger <wolfgang.grandegger@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

On Fri, 2004-06-04 at 10:57, Wolfgang Grandegger wrote:
> On 06/03/2004 10:31 AM Philippe Gerum wrote:
> > On Thu, 2004-06-03 at 21:08, Wolfgang Grandegger wrote:
> >> Hi Philippe,
> >> 
> >> I started porting ADEOS to PowerPC with "2.4r11c1" and now I want to
> >> catch up with "24r13c2" before I release it. I realized that there are
> >> quite some differences and I wonder how you maintain the ADEOS code,
> >> especially how do you get or handle the files in "linux" and "patches".
> >> 
> > 
> > There are two major trees, one for 2.4, the other for 2.6, respectively
> > available under linux/v2.4 and linux/v2.6.
> > 
> > For each supported kernel version, I simply create some "shadow tree"
> > under linux/v2.x/<kernel-ver>-<arch>, only containing the kernel files
> > modified by Adeos.
> > 
> > The generic Adeos support which is the same for any version of the host
> > kernel in a given major branch is stored under linux/v2.x/adeos-core.
> > 
> > Basically, merging a kernel-specific tree with the Adeos generic support
> > gives you all the files applicable to a genuine kernel tree in order to
> > Adeos-enable it. This way, for working on Adeos, you just need to untar
> > the vanilla kernel tree of interest, and replace the set of affected
> > files by symlinks to the corresponding files in the CVS tree.
> > 
> > When a development milestone has been reached for a given kernel release
> > / Adeos revision, I simply build a patch against the corresponding
> > vanilla tree, and feed patches/ with it. The same patch is then copied
> > to the download area on GNA, and a news is published there.
> 
> OK, and when you modify files on one shadow tree you adapt the files on
> the other trees manually!? Hm, unfortunately, this is the most tedious part.
> 

Indeed yes, especially for x86 with an increasing number of supported
versions (I tend to discontinue the oldest one from times to times,
though). But fortunately, not that many changes occur in the
kernel-dependent portions these days, but most of them concern the
generic Adeos parts.

> I have now updated to 2.4r13c2 and it still works :-). I took the files
> from the "adeos-core" sub-directory as they are and adapted the rest
> manually. Finally, beginning of next week I want to check the PowerPC
> port in. Most parts do not affect other code. Just the examples need
> some attention as I have not tested them on X86. They now supports cross
> compilation and add some PowerPC related timing code for the nice
> latency test modules from "Der Herr Hofrat". I have attached a patch in
> case you (or somebody else) want to have a look.
> 

I will. Many thanks for your contribution.

> Thanks.
> 
> Wolfgang.
> 
> 
> 
> ______________________________________________________________________
> + diff -u linux/examples/measurement/irq_jitter.c.ORIG linux/examples/measurement/irq_jitter.c
> --- linux/examples/measurement/irq_jitter.c.ORIG	Sun Feb 29 19:31:34 2004
> +++ linux/examples/measurement/irq_jitter.c	Fri Jun  4 00:38:28 2004
> @@ -46,8 +46,22 @@
>  #if defined(CONFIG_X86) && defined(CONFIG_X86_TSC)
>  #include <asm/msr.h> /* rdtscll - ia32 specific */
>  #define hwtimer(x) rdtscll(x)
> +#elif defined(CONFIG_PPC)
> +#include <asm/time.h>
> +static inline void ppc_timebase(long long *x)
> +{
> +    unsigned long tbl, tbu1, tbu2;
> +    do 
> +	{
> +	tbu1 = get_tbu();
> +	tbl  = get_tbl();
> +	tbu2 = get_tbu();	
> +	} while (tbu1 != tbu2);
> +    *x = (long long)tbl + ((long long)tbu1 << 32);
> +}
> +#define hwtimer(x) ppc_timebase(&(x))
>  #else
> -	#error "Only X86 supported for now"
> +	#error "Only X86 and PPC supported for now"
>  #endif
>  
> 
> @@ -88,7 +102,8 @@
>  			     IPIPE_DYNAMIC_MASK);
>  	}
>  
> -    scaller = cpu_khz/1000;
> +    /* might be incorrect due to rounding effects */
> +    scaller = (unsigned long)sys_info.cpufreq / 1000000;
>      period = (1000/HZ)*1000;
>      printk("scaller set to %ld\n",(unsigned long) scaller);
>      printk("period set to %ld\n",(long) period);
> + diff -u linux/examples/measurement/Makefile.ORIG linux/examples/measurement/Makefile
> --- linux/examples/measurement/Makefile.ORIG	Sun Feb 29 19:31:34 2004
> +++ linux/examples/measurement/Makefile	Fri Jun  4 00:00:56 2004
> @@ -3,21 +3,35 @@
>  # Environment" feature in the general setup when configuring this
>  # kernel.
>  
> +ifndef LINUXSRC
>  LINUXSRC = /usr/src/linux
> -ARCH = i686
> +endif
> +
> +DEBUG	= -g -ggdb
> +DEFINES = -D__KERNEL__ -DMODULE $(DEBUG)
>  
> -DEFINES = -D__KERNEL__  -DMODULE -DEXPORT_SYMTAB
> +include $(LINUXSRC)/.config
> +
> +ifdef CONFIG_PPC
> +CFLAGS = $(DEFINES) -O2 -Wall -Wstrict-prototypes -Wno-trigraphs \
> +         -fno-strict-aliasing -fno-common -fomit-frame-pointer \
> +	 -fsigned-char -msoft-float -pipe -ffixed-r2 \
> +	 -Wno-uninitialized -mmultiple -mstring \
> +	-I$(LINUXSRC)/include -I$(LINUXSRC)/arch/ppc
> +else
> +ARCH = i686
>  CFLAGS = $(DEFINES) -I$(LINUXSRC)/include -Wall -Wstrict-prototypes \
>  	-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing \
>  	-fno-common -mpreferred-stack-boundary=2 -march=${ARCH}
> +endif
>  
>  all: irq_jitter.o virtual_irq_jitter.o
>  
>  virtual_irq_jitter.o: virtual_irq_jitter.c
> -	gcc $(CFLAGS) -o $@ -c $<
> +	$(CROSS_COMPILE)gcc $(CFLAGS) -o $@ -c $<
>  
>  irq_jitter.o: irq_jitter.c
> -	gcc $(CFLAGS) -o $@ -c $<
> +	$(CROSS_COMPILE)gcc $(CFLAGS) -o $@ -c $<
>  
>  clean:
>  	rm -f *.o
> + diff -u linux/examples/measurement/virtual_irq_jitter.c.ORIG linux/examples/measurement/virtual_irq_jitter.c
> --- linux/examples/measurement/virtual_irq_jitter.c.ORIG	Fri Jun  4 00:24:42 2004
> +++ linux/examples/measurement/virtual_irq_jitter.c	Fri Jun  4 01:04:49 2004
> @@ -134,9 +134,13 @@
>          unsigned int a1, a2;
>          unsigned long long res;
>  
> +#ifdef __LITTLE_ENDIAN
>          a1 = ((unsigned int*)&a)[0];
>          a2 = ((unsigned int*)&a)[1];
> -
> +#else
> +        a1 = ((unsigned int*)&a)[1];
> +        a2 = ((unsigned int*)&a)[0];
> +#endif
>          res = a1/b0 +
>                  (unsigned long long)a2 * (unsigned long long)(0xffffffff/b0) +
>                  a2 / b0 +
> + diff -u linux/examples/simple/Makefile.ORIG linux/examples/simple/Makefile
> --- linux/examples/simple/Makefile.ORIG	Sun Feb 29 19:31:33 2004
> +++ linux/examples/simple/Makefile	Fri Jun  4 00:01:24 2004
> @@ -3,23 +3,38 @@
>  # Environment" feature in the general setup when configuring this
>  # kernel.
>  
> +ifndef LINUXSRC
>  LINUXSRC = /usr/src/linux
> +endif
>  
> -DEFINES = -D__KERNEL__  -DMODULE -DEXPORT_SYMTAB
> -CFLAGS = $(DEFINES) -I$(LINUXSRC)/include -Wall -Wstrict-prototypes -Wno-trigraphs \
> -        -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common \
> -        -mpreferred-stack-boundary=2 -march=i686
> +DEBUG	= -g -ggdb
> +DEFINES = -D__KERNEL__ -DMODULE $(DEBUG)
> +
> +include $(LINUXSRC)/.config
> +
> +ifdef CONFIG_PPC
> +CFLAGS = $(DEFINES) -O2 -Wall -Wstrict-prototypes -Wno-trigraphs \
> +         -fno-strict-aliasing -fno-common -fomit-frame-pointer \
> +	 -fsigned-char -msoft-float -pipe -ffixed-r2 \
> +	 -Wno-uninitialized -mmultiple -mstring \
> +	-I$(LINUXSRC)/include -I$(LINUXSRC)/arch/ppc
> +else
> +ARCH = i686
> +CFLAGS = $(DEFINES) -I$(LINUXSRC)/include -Wall -Wstrict-prototypes \
> +	-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing \
> +	-fno-common -mpreferred-stack-boundary=2 -march=${ARCH}
> +endif
>  
>  all: adtest.o interdomain_irq.o interdomain_mutex.o
>  
>  adtest.o: adtest.c
> -	gcc $(CFLAGS) -o $@ -c $<
> +	$(CROSS_COMPILE)gcc $(CFLAGS) -o $@ -c $<
>  
>  interdomain_irq.o: interdomain_irq.c
> -	gcc $(CFLAGS) -o $@ -c $<
> +	$(CROSS_COMPILE)gcc $(CFLAGS) -o $@ -c $<
>  
>  interdomain_mutex.o: interdomain_mutex.c
> -	gcc $(CFLAGS) -o $@ -c $<
> +	$(CROSS_COMPILE)gcc $(CFLAGS) -o $@ -c $<
>  
>  clean:
>  	rm -f *.o
-- 

Philippe.


