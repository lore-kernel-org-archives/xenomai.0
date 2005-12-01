Message-ID: <438EF1D6.9090004@domain.hid>
Date: Thu, 01 Dec 2005 13:51:34 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Problem building MVM: "error: The X11 library
	'-lX11' could not be found"
References: <8DF1258D5F0FC94EBF5810BF2C7BF2FB3FFDE3@domain.hid>
In-Reply-To: <8DF1258D5F0FC94EBF5810BF2C7BF2FB3FFDE3@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Ashri, Sarit" <Sashri@domain.hid>
Cc: xenomai@xenomai.org

Ashri, Sarit wrote:
>>Ashri, Sarit wrote:
>>
>>>Hi Philippe,
>>>
>>>I did read the files. What I don't understand is how to build the 
>>>Xenomai With Simulator support?
>>>When I build Xenomai without simulator support - everything 
>>
>>works just 
>>
>>>fine (crossed compiled to work on PPC with Linux 2.6.13.4).
>>>As soon as I mark Simulator->Minute Virtual Machine I get that error
>>>(X11 library..).
>>>I understood from reading previous mails on the internet 
>>
>>that I should 
>>
>>>be able to build the MVM on my host computer which is NOT 
>>
>>patched by 
>>
>>>Adeos (RHEL3.0 Linux on i686) through Regular Xenomai 
>>
>>CROSS_COMPILING 
>>
>>>and installation.
>>
>>Try this:
>>
>>- Build your target system first without the simulator using 
>>cross-compilation for ppc. Let's say that you installed the 
>>results under /usr/realtime, which is the default.
>>
>>- Then, build the simulator separately for the host:
>>
>>$ mkdir sim-build && cd sim-build
>>$ .../xenomai/sim/configure --with-xeno-dir=/usr/realtime
>>--with-gcc-tarball=/something/gcc-2.95.3.tar.bz2
>>$ make install
>>
> 
> Everything compiled fine, but when I tried to compile the native demo
> for the
> Simulator I received the following error:
> cd .../skins/native/demos
> [demos]$ /usr/realtime/bin/gcic -o satch_s.o -c satch.c -g -I
> /opt/nfs_root/usr/realtime/include
> In file included from
> /opt/nfs_root/usr/realtime/include/nucleus/asm/atomic.h:23,
>                  from
> /opt/nfs_root/usr/realtime/include/nucleus/system.h:33,
>                  from
> /opt/nfs_root/usr/realtime/include/nucleus/asm-generic/system.h:560,
>                  from
> /opt/nfs_root/usr/realtime/include/nucleus/asm/system.h:23,
>                  from
> /opt/nfs_root/usr/realtime/include/nucleus/types.h:40,
>                  from
> /opt/nfs_root/usr/realtime/include/nucleus/queue.h:23,
>                  from
> /opt/nfs_root/usr/realtime/include/nucleus/timer.h:23,
>                  from
> /opt/nfs_root/usr/realtime/include/nucleus/thread.h:23,
>                  from
> /opt/nfs_root/usr/realtime/include/native/task.h:26,
>                  from satch.c:4:
> /usr/include/asm/atomic.h:40: warning: #warning Using kernel header in
> userland program. BAD!
> In file included from
> /opt/nfs_root/usr/realtime/include/nucleus/system.h:33,
>                  from

Gah. Ok, my mistake. Since you are cross-compiling for your target, you 
need to have two Xenomai installations, once for the ppc target to run 
the real stuff, another one to run the virtual simulation environment 
for the x86 host.

So, ...

- Configure and cross-compile Xenomai for ppc without simulation support 
for installing to /opt/nfsroot
- Configure and compile Xenomai natively for x86 with simulation support 
for installing to, e.g. /opt/local

This way at least, you won't need to build the simulator apart, it will 
be built as part of the second step. Most of the native x86 support 
won't be used (aside of the simulator, of course), but at least, this 
will work. On the host, you will need to set your PATH and 
LD_LIBRARY_PATH to /opt/local/bin, and /opt/local/lib respectively, so 
that the simulation libs and tools are found.

The #warning won't go away though; only v2.1 gets rid of this by 
avoiding any kernel header inclusion in user-space. Debian systems would 
not bother you with this (at least sarge doesn't), but RH actually do.

-- 

Philippe.

