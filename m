From: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Date: Wed, 21 Sep 2016 12:41:56 +0200
Message-ID: <3935349.0HzBK4jDub@soho>
In-Reply-To: <1caa297c-4095-401e-cc16-def2070b5422@xenomai.org>
References: <1560138.jJyhniltkJ@indiana> <3202879.l8ld4jIH5k@soho>
 <1caa297c-4095-401e-cc16-def2070b5422@xenomai.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Subject: Re: [Xenomai] Cannot create a share library linked against Xenomai
	libs
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai Users list <xenomai@xenomai.org>

El Dimecres, 21 de setembre de 2016, a les 10:30:43, Philippe Gerum va 
escriure:

[...]
> 
> This option is a shorthand for people with a very specific requirement
> for building a shared library with Xenomai auto-init capabilities,

just to build a shared library. This is new form Xenomai 3

> instead of crafting an obscure set of link flags manually for this
> purpose. The intended use case is about having a regular executable not
> linked with Xenomai libs, but using the dlopen() interface to attach
> Xenomai-dependent libs dynamically at runtime, in which case one may want
> the latter to kick the Xenomai services transparently when loaded.
> 
> Reading your proposal, I'm now wondering whether building a
> shared library of that sort with automatic Xenomai bootstrap is your goal.
> Is it?

Yes, to build a shared library using Xenomai stuff in the way that a user of 
hat library (developer) just need to know some minimal knowledge of Xenomai.

> > Second, because you make a difference between creating a executable and
> > create a shared library and I don't know if we have a lot of benefits
> > making that distinction. Gcc documentation explain:
> > 
> > "If supported for the target machine, emit position-independent code,
> > suitable for dynamic linking and avoiding any limit on the size of the
> > global offset table. This option makes a difference on AArch64, m68k,
> > PowerPC and SPARC."
> I don't get your point. Xenomai supports two of those architectures, and
> you could add blackfin to that list, so this is not a matter of benefit,
> this is a matter of requirement.

I'm sorry, maybe I was confused. I followed several threads in debian-devel 
about to add this option by default [1], [2],[3] [4]. However, Debian is a 
general linux distro and Xenomai has a different target. 

> > And lastly, although the first error is solved,
> 
> Which illustrates the benefit of emiting PIC when required, otherwise one
> gets relocation errors as you observed.
>  I got another error:
> > Linking C shared library libsoem_rt.so
> > /usr/bin/cmake -E cmake_link_script
> > CMakeFiles/soem_dynamic_rt.dir/link.txt -- verbose=1
> > /usr/bin/cc  -fPIC -D_FORTIFY_SOURCE=2 -Wno-format-security -Wformat=0 -O2
> > -g -DNDEBUG -Wl,@/usr/xenomai/lib/cobalt.wrappers
> > /usr/xenomai/lib/xenomai/bootstrap.o -Wl,--wrap=main -Wl,--dynamic-
> > list=/usr/xenomai/lib/dynlist.ld -Wl,--no-undefined -shared -Wl,-
> > soname,libsoem_rt.so.1 -o libsoem_rt.so.1.3
> > CMakeFiles/soem_dynamic_rt.dir/soem/ethercatdc.c.o
> > CMakeFiles/soem_dynamic_rt.dir/soem/ethercatfoe.c.o
> > CMakeFiles/soem_dynamic_rt.dir/soem/ethercatmain.c.o
> > CMakeFiles/soem_dynamic_rt.dir/soem/ethercatprint.c.o
> > CMakeFiles/soem_dynamic_rt.dir/soem/ethercatconfig.c.o
> > CMakeFiles/soem_dynamic_rt.dir/soem/ethercatsoe.c.o
> > CMakeFiles/soem_dynamic_rt.dir/soem/ethercatbase.c.o
> > CMakeFiles/soem_dynamic_rt.dir/soem/ethercatcoe.c.o
> > CMakeFiles/soem_dynamic_rt.dir/osal/linux/osal.c.o
> > CMakeFiles/soem_dynamic_rt.dir/oshw/linux/nicdrv.c.o
> > CMakeFiles/soem_dynamic_rt.dir/oshw/linux/oshw.c.o -L/usr/xenomai/lib
> > -lcobalt -lpthread -lrt
> > /usr/xenomai/lib/xenomai/bootstrap.o: In function `xenomai_main':
> > bootstrap.c:(.text+0x2c): undefined reference to `main'
> > bootstrap.c:(.text+0x40): undefined reference to `main'
> > collect2: error: ld returned 1 exit status
> > 
> > 
> > so, the POSIX script to build a POSIX code fails when you wants to build a
> > shared library. Dropping "-Wl,--wrap=main " the library is built.
> > 
> > So, from my point of view, xeno-config is not giving an accurate answer
> > and the --auto-init-solib doesn't help too much. I would like to propose
> > this:
> > 
> > as --[no-]auto-init is meaningful only with --ldflags, and to link against
> > (*)- pic is for shared libraries I would add an option to xeno-config,
> > --ldflags- shared, or --ldflags-shared-libs where
> > /usr/xenomai/lib/xenomai/bootstrap-pic.o i set and "-Wl,--wrap=main" is
> > dropped.
> > 
> > What do you think?
> 
> Using --auto-init-solib is not about building a generic shared library,
> there is nothing Xenomai-specific in doing so, and it's not
> xeno-config's business to determine the right ldflags for this.
> 

Sorry, I misunderstand the documentation. From here [5]

This switch enables the auto-initialization feature described above for a 
shared library target instead of a pure executable. 

I understood that it was for building a shared library.

> xeno-config is the documented way to retrieve the extra flags required to
> compile and link object files for which dependencies on Xenomai exist.
> --auto-init-solib extends this by providing a shorthand for retrieving the
> additional ldflags required for including a version of the _bootstrap_ code
> suitable for a shared library, so that e.g. Cobalt binding code runs when
> the library is dlopened, or the Copperplate layer automatically initializes
> before a non-POSIX API is used.
> 
> So the issue is not with xeno-config lacking yet another switch for
> specifically linking shared libraries in general, but with
> --auto-init-solib wrongly trying to wrap the main symbol when turning on
> the automatic bootstrap mode, which it should only do with plain
> executables. As a corollary, the bootstrap module should not create any
> reference to the main() routine when built for a shared library,

well, there's a bug here. I'm agree that  --auto-init-solib should not wrap 
the main symbol.

> i.e something along these lines:
> 
> diff --git a/scripts/xeno-config-cobalt.in b/scripts/xeno-config-cobalt.in
> index 38f8208..802b778 100644

[...]


yes, the patch worked. Now it compiled and links. Please could you push it?

Thanks,

Leopold
---

[1] https://lists.debian.org/debian-devel/2016/05/msg00028.html
[2] https://lists.debian.org/debian-devel/2016/05/msg00228.html
[3] https://lists.debian.org/debian-devel/2016/05/msg00306.html
[4] https://lists.debian.org/debian-devel/2016/09/msg00217.html
[5] http://www.xenomai.org/documentation/xenomai-3/html/man1/xeno-config/index.html


-- 
--
Linux User 152692     GPG: 05F4A7A949A2D9AA
Catalonia
-------------------------------------
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

