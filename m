From: Krzysztof =?UTF-8?Q?B=C5=82aszkowski?= <kb@domain.hid>
In-Reply-To: <4C6B146D.9010004@domain.hid>
References: <1282047938.5255.89.camel@domain.hid>
	<4C6B146D.9010004@domain.hid>
Content-Type: text/plain; charset="utf-8"
Date: Wed, 18 Aug 2010 12:22:54 +0200
Message-Id: <1282126974.5255.262.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai-core] xenomai 2.5.3/native, kernel 2.6.31.8 and fork()
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Wed, 2010-08-18 at 00:59 +0200, Gilles Chanteperdrix wrote:
> Krzysztof Błaszkowski wrote:
> > Hello,
> > 
> > I found recently that large application uses to segfault before fork()
> > leaves its glibc wrapper.
> > 
> > I included here a test suite which can be easily used to verify what
> > goes wrong. It may be necessary to adjust makefile to compile the code.
> > So, the console is missing output from line #89. We can see instead a
> > message that getpid couldn't be linked which is 1st sign of memory
> > corruption.
> > 
> > i used to think that this issue could be related to not unbinding heap
> > before fork() but it turned out that it is enough to link userspace with
> > xenomai libraries.
> > 
> > I wonder if this is known issue and if there is any fix, does 2.5.4 work
> > same ? or maybe there is something wrong with the kernel i use (or adeos
> > patch)
> > 
> > Another question is why rt_task_create() is marked deprecated in native
> > skin. Does it mean that native skin is going to be removed from source
> > tree ?
> 
> Ok. Tried your test on:
> - 2.6.33 armv5
> - 2.6.34 x86_64
> - 2.6.31 x86_64
> - 2.6.31 x86_32
> 
> And everything works fine.
> 
> The result of the last experience is:
> # xeno-shmem-fork
> main:43 heap 0xb76be000
> /root
> main:60 [4365] pid 4367
> main:53
> main:54 [4367] pid 0
> main:63 [4365] pid 4367, status 00000b00
> main:64 [4365] pid 4367, WIFSIGNALED 0, WIFEXITED 1, rc 11
> 0
> # cat /proc/ipipe/version
> 2.4-09
> # cat /proc/xenomai/version
> 2.5.4
> # uname -a
> Linux atom 2.6.31.8 #5 SMP Wed Aug 18 00:44:17 CEST 2010 i686 GNU/Linux
> 
> There does not seem to be anything wrong in xenomai rt_heap code, as
> this code is platform-independent, so if there was something wrong with
> it, we would see it on all platforms.
> 
> Some clues about what could be wrong:
> - I am not sure your makefile works: the .o file has the same name for
> the kernel module and the executable. I do not think this could matter
> (if you could get it wrong, the module or the executable would not run),
> but in any case, this is a bad idea, and since the kernel module and
> user-space application do not share any code, it seems simpler to put
> them in separate files.

in this example having both kernel and userland in one single file
doesn't matter because userland is compiled without any inter-linking
stage (-c switch, also i could different object names, so it is ok). gcc
produces directly executable.

i removed any objects and just commented out building kernel part since
i have got this already.

new executable works the same way as previous on my atom.



> - I have not really checked your user-space compilation flags, I am
> using xeno-config to get the correct ones.

xeno-config --skin=native --cflags gives:

-I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -D__XENO__


note that there is no xenomai installed on my r&d server
in /usr/xenomai/

i build xenomai per kernel and install it in kernel's INSTALL sub-dir
(DESTDIR=) as well as kernel's modules and other related stuff for this
particular kernel.
(otherwise i would go mad soon due to various versions ..)


xeno-config --skin=native --ldflags gives:

-lnative -L/usr/xenomai/lib -lxenomai -lpthread

and indeed i missed libpthread but otoh userland without pthread even
does not depend directly on pthreads:

ldd xeno-shmem-fork
	linux-gate.so.1 =>  (0xffffe000)
	libnative.so.3 => not found
	libxenomai.so.0 => not found
	libc.so.6 => /lib/libc.so.6 (0xf7da5000)
	/lib/ld-linux.so.2 (0xf7f10000)

when compiled without pthreads.


*ANYWAY* with pthreads i got exactly what i observed in the app i am
interested in. (build process is properly configured according to the
art ie without any simplifications i did in my makefile)


atest:~/xeno-test-254 # ./.try.sh
main:79 heap 0x401be000
/root/xeno-test-254
main:96 [1062] pid 1064
main:99 [1062] pid 1064, status 0000000b
main:100 [1062] pid 1064, WIFSIGNALED 1, WIFEXITED 0, rc 0
4
atest:~/xeno-test-254 # 


children got a signal.

i added also exact cflags from xeno-config. these cflags don't change
anything, so with libpthread children segfaults, without it getpid()
can't be resolved in children process still.


> - your user-space code was missing #include <unistd.h>

i added. it changed nothing.


> - some subtle difference in the glibc

hmm, i'd say that is rather out my control. i use by default opensuse
for r&d.

does this mean that this distro is broken ?

(otoh many things are - especially gnome)

> - some x86_32 specific I-pipe bug triggered by some kernel configuration
> option

i can send config if you like.


> - some local patches in your kernel
> 

i use now nothing except adeos for testing "fork". i use also
compiled-in driver for rtl8103 which is out of kernel tree but i don't
think it could induce this issue. i reckon probability is close to 0.0
and without driver target is useless. (it is 100% diskless r&d test box)

> In any case, without further information, it is hard for me to dig any
> further tonight. Regards.

i see. want you me to send .config file ? anything else ?

Regards,

-- 
Krzysztof Blaszkowski


