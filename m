Date: Fri, 29 Nov 2013 09:41:57 +0100
From: Bukuli Norbert <norbert.bukuli@mediso.hu>
Message-ID: <20131129094157.3d7202e1.norbert.bukuli@mediso.hu>
In-Reply-To: <5297BD30.4060007@xenomai.org>
References: <20131128143152.04ac3eab.norbert.bukuli@mediso.hu>
 <5297BD30.4060007@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] test suite programs crash with Illegal instruction on
 MPC5200
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>



On Thu, 28 Nov 2013 23:01:20 +0100
Philippe Gerum <rpm@xenomai.org> wrote:
> On 11/28/2013 02:31 PM, Bukuli Norbert wrote:
> > Hello!
> >
> > I am having a little problem with some programs from the Xenomai
> > test suite. The clocktest, cyclictest and switchtest crashes with
> > "Illegal instruction":
> >
> > ~ # /usr/xenomai/bin/clocktest
> > == Tested clock: 0 (CLOCK_REALTIME)
> > CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
> > --- -------------------- ---------------- ---------- --------------
> >    0                  0.0            0.000          0            0.0
> > Illegal instruction
> >
> >
> 
> Please make sure you are using a compiler for the 6xx processor
> family, for building the user-space programs for an
> icecube/lite52xx/tqm5200 board.
I use eldk-switch in this way:
$ eldk-switch -r 5.4 gccb
[ gccb is using MPC5200 ]
Setup for powerpc (using ELDK 5.4)

with the following modification on the eldk-map.dat:
gccb            MPC5200

(GCCB is our custom MPC5200 based board)

$ echo $CC
powerpc-linux-gcc -m32 -mhard-float --sysroot=/opt/eldk-5.4/powerpc/sysroots/powerpc-linux
$ echo $CFLAGS 
-O2 -pipe -g -feliminate-unused-debug-types

$ powerpc-linux-gcc -dumpspecs | grep 603
...  %{mcpu=603: -mppc} %{mcpu=603e: -mppc} ...

I set the -mcpu=603e compilation flag on the trivial posix test, but this did not help.

> 
> If the issue is still there, you should run the failing test over
> gdb, then paste the backtrace output ("bt" command) obtained after
> the fault to this list.

Because there is limited amount of memory in our embedded system (32 MiB), I did the following:
On the target system:
~ # gdbserver 172.31.2.11:2001 /usr/xenomai/bin/clocktest

On the host system:
$ eldk-switch -r 5.4 gccb
[ gccb is using MPC5200 ]
Setup for powerpc (using ELDK 5.4)

$ powerpc-linux-gdb usr/xenomai/bin/clocktest
(gdb) set sysroot /opt/eldk-5.4/powerpc/sysroots/powerpc-linux

(gdb) target remote 172.31.2.11:2001
Remote debugging using 172.31.2.11:2001
Reading symbols from /opt/eldk-5.4/powerpc/sysroots/powerpc-linux/lib/ld.so.1...Reading symbols from /opt/eldk-5.4/powerpc/sysroots/powerpc-linux/lib/.debug/ld-2.17.so...done.
done.
Loaded symbols for /opt/eldk-5.4/powerpc/sysroots/powerpc-linux/lib/ld.so.1
_start () at ../sysdeps/powerpc/powerpc32/dl-start.S:32
32	../sysdeps/powerpc/powerpc32/dl-start.S: No such file or directory.

(gdb) cont
Continuing.
warning: Could not load shared library symbols for linux-vdso32.so.1.
Do you need "set solib-search-path" or "set sysroot"?
warning: .dynamic section for "/opt/eldk-5.4/powerpc/sysroots/powerpc-linux/usr/xenomai/lib/libpthread_rt.so.1" is not at the expected address (wrong library or version mismatch?)
warning: .dynamic section for "/opt/eldk-5.4/powerpc/sysroots/powerpc-linux/usr/xenomai/lib/libxenomai.so.0" is not at the expected address (wrong library or version mismatch?)
[New Thread 280]

Program received signal SIGILL, Illegal instruction.
[Switching to Thread 280]
0x0fdf4e74 in ?? () from /opt/eldk-5.4/powerpc/sysroots/powerpc-linux/lib/libc.so.6

(gdb) bt
#0  0x0fdf4e74 in ?? () from /opt/eldk-5.4/powerpc/sysroots/powerpc-linux/lib/libc.so.6
#1  0x0ffd8af8 in sched_setconfig_np ()
   from /opt/eldk-5.4/powerpc/sysroots/powerpc-linux/usr/xenomai/lib/libpthread_rt.so.1
#2  0x0ff7ba68 in start_thread (arg=0xbffffdd0) at pthread_create.c:313
#3  0x4802ff18 in _rtld_global_ro () from /opt/eldk-5.4/powerpc/sysroots/powerpc-linux/lib/ld.so.1
Backtrace stopped: frame did not save the PC

As you can see, I have some problems with the GDB search paths, but the significant information is conspicuous.

> 
> > When I turn the debug.exception-trace kernel option on,
> > and run the clocktest, I have got the following kernel message:
> >
> > clocktest[243]: unhandled signal 4 at 0fdf4e74 nip 0fdf4e74 lr
> > 0ffd8af8 code 30001
> >
> 
> gdb will give you the faulty location in symbolic form.
If you can suggest, please, how I can override loaded libraries in gdb, then I will repeat the tests.
> 
> > I have read in a previous messages on this list, that the
> > CONFIG_XENO_HW_UNLOCKED_SWITCH option should be turned off, but
> > unfortunately this did not help.
> >
> 
> Unlocked switching is no more an issue with 3.8.13 and beyond.
Then I will turn it on again.
> 


-- 
Norbert Bukuli
software engineer
embedded development

Mediso Ltd.
Tel.: +36 1 3993 030 Fax.: +36 1 3993 040
Mailing address: Hungary, H-1047 Budapest, Baross utca 91-95.
Billing address: Hungary, H-1022 Budapest, Alsotorokvesz 14.
norbert.bukuli@mediso.com
www.mediso.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 490 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20131129/1634a7b5/attachment.sig>
