From: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Date: Tue, 20 Sep 2016 12:56:49 +0200
Message-ID: <3202879.l8ld4jIH5k@soho>
In-Reply-To: <c81239b6-2473-13c2-b04c-0cf64646f83c@xenomai.org>
References: <1560138.jJyhniltkJ@indiana>
 <c81239b6-2473-13c2-b04c-0cf64646f83c@xenomai.org>
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

El Dimarts, 20 de setembre de 2016, a les 09:04:55, Philippe Gerum va 
escriure:
> On 09/19/2016 10:45 PM, Leopold Palomo-Avellaneda wrote:
> > Hi,
> > 
> > 
> > I'm trying to build a shared library, using the posix skin with Xenomai
> > 3.0.3. I have built xenomai with:
> > 
> > '--with-core=cobalt' '--enable-smp' '--enable-pshared' '--enable-fortify'
> > '--enable-shared
> > 
> > I built withour any error. However, when I try to build a library (shared)
> > that uses xenomai I got this error:
> > 
> > /usr/bin/ld: /usr/xenomai/lib/xenomai/bootstrap.o: relocation R_X86_64_32
> > against `.rodata.str1.1' can not be used when making a shared object;
> > recompile with -fPIC
> > 
> > Static libs build perfect.
> > 
> > Any idea,
> > 
> > Best regards,
> > 
> > Leopold
> 
> You may want to check --auto-init-solib from xeno-config:
> 
> http://www.xenomai.org/documentation/xenomai-3/html/man1/xeno-config/index.h
> tml

I partially solved the problem but your email worries me more. First of all 
because in 3.0.2 that option was not there. And it's an important issue.

Second, because you make a difference between creating a executable and create 
a shared library and I don't know if we have a lot of benefits making that 
distinction. Gcc documentation explain:

"If supported for the target machine, emit position-independent code, suitable 
for dynamic linking and avoiding any limit on the size of the global offset 
table. This option makes a difference on AArch64, m68k, PowerPC and SPARC."


And lastly, although the first error is solved, I got another error:

Linking C shared library libsoem_rt.so
/usr/bin/cmake -E cmake_link_script CMakeFiles/soem_dynamic_rt.dir/link.txt --
verbose=1
/usr/bin/cc  -fPIC -D_FORTIFY_SOURCE=2 -Wno-format-security -Wformat=0 -O2 -g 
-DNDEBUG -Wl,@/usr/xenomai/lib/cobalt.wrappers 
/usr/xenomai/lib/xenomai/bootstrap.o -Wl,--wrap=main -Wl,--dynamic-
list=/usr/xenomai/lib/dynlist.ld -Wl,--no-undefined -shared -Wl,-
soname,libsoem_rt.so.1 -o libsoem_rt.so.1.3 
CMakeFiles/soem_dynamic_rt.dir/soem/ethercatdc.c.o 
CMakeFiles/soem_dynamic_rt.dir/soem/ethercatfoe.c.o 
CMakeFiles/soem_dynamic_rt.dir/soem/ethercatmain.c.o 
CMakeFiles/soem_dynamic_rt.dir/soem/ethercatprint.c.o 
CMakeFiles/soem_dynamic_rt.dir/soem/ethercatconfig.c.o 
CMakeFiles/soem_dynamic_rt.dir/soem/ethercatsoe.c.o 
CMakeFiles/soem_dynamic_rt.dir/soem/ethercatbase.c.o 
CMakeFiles/soem_dynamic_rt.dir/soem/ethercatcoe.c.o 
CMakeFiles/soem_dynamic_rt.dir/osal/linux/osal.c.o 
CMakeFiles/soem_dynamic_rt.dir/oshw/linux/nicdrv.c.o 
CMakeFiles/soem_dynamic_rt.dir/oshw/linux/oshw.c.o -L/usr/xenomai/lib -lcobalt 
-lpthread -lrt 
/usr/xenomai/lib/xenomai/bootstrap.o: In function `xenomai_main':
bootstrap.c:(.text+0x2c): undefined reference to `main'
bootstrap.c:(.text+0x40): undefined reference to `main'
collect2: error: ld returned 1 exit status


so, the POSIX script to build a POSIX code fails when you wants to build a 
shared library. Dropping "-Wl,--wrap=main " the library is built.

So, from my point of view, xeno-config is not giving an accurate answer and the 
--auto-init-solib doesn't help too much. I would like to propose this:

as --[no-]auto-init is meaningful only with --ldflags, and to link against (*)-
pic is for shared libraries I would add an option to xeno-config, --ldflags-
shared, or --ldflags-shared-libs where /usr/xenomai/lib/xenomai/bootstrap-pic.o 
i set and "-Wl,--wrap=main" is dropped.

What do you think?

Leopold



-- 
--
Linux User 152692     GPG: 05F4A7A949A2D9AA
Catalonia
-------------------------------------
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?


-- 
--
Linux User 152692     GPG: 05F4A7A949A2D9AA
Catalonia
-------------------------------------
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

