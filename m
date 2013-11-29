Date: Fri, 29 Nov 2013 11:44:25 +0100
From: Bukuli Norbert <norbert.bukuli@mediso.hu>
Message-ID: <20131129114425.037c1cab.norbert.bukuli@mediso.hu>
In-Reply-To: <52985FBF.8090608@xenomai.org>
References: <20131128143152.04ac3eab.norbert.bukuli@mediso.hu>
 <5297BD30.4060007@xenomai.org>
 <20131129094157.3d7202e1.norbert.bukuli@mediso.hu>
 <52985E94.4070101@xenomai.org> <52985FBF.8090608@xenomai.org>
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



On Fri, 29 Nov 2013 10:34:55 +0100
Philippe Gerum <rpm@xenomai.org> wrote:
> On 11/29/2013 10:29 AM, Philippe Gerum wrote:
> > On 11/29/2013 09:41 AM, Bukuli Norbert wrote:
> >> (gdb) cont
> >> Continuing.
> >> warning: Could not load shared library symbols for
> >> linux-vdso32.so.1. Do you need "set solib-search-path" or "set
> >> sysroot"? warning: .dynamic section for
> >> "/opt/eldk-5.4/powerpc/sysroots/powerpc-linux/usr/xenomai/lib/libpthread_rt.so.1"
> >> is not at the expected address (wrong library or version mismatch?)
> >> warning: .dynamic section for
> >> "/opt/eldk-5.4/powerpc/sysroots/powerpc-linux/usr/xenomai/lib/libxenomai.so.0"
> >> is not at the expected address (wrong library or version mismatch?)
> >
> > These warnings may trigger with recent broken gdbserver releases,
> > let's ignore them.
> > https://sourceware.org/ml/gdb-patches/2013-06/msg00054.html
> >
> >> [New Thread 280]
> >>
> >> Program received signal SIGILL, Illegal instruction.
> >> [Switching to Thread 280]
> >> 0x0fdf4e74 in ?? () from
> >> /opt/eldk-5.4/powerpc/sysroots/powerpc-linux/lib/libc.so.6
> >>
> >
> > (gdb) disass $pc-64 $pc+20
> >
> > would help at this point.
> >
> >> (gdb) bt
> >> #0  0x0fdf4e74 in ?? () from
> >> /opt/eldk-5.4/powerpc/sysroots/powerpc-linux/lib/libc.so.6
> >> #1  0x0ffd8af8 in sched_setconfig_np ()
> >>     from
> >> /opt/eldk-5.4/powerpc/sysroots/powerpc-linux/usr/xenomai/lib/libpthread_rt.so.1
> >>
> >> #2  0x0ff7ba68 in start_thread (arg=0xbffffdd0) at
> >> pthread_create.c:313
> >
> > Is sched_setconfig_np() really the start routine given to
> > pthread_create() in your application, I guess not. Or could this
> > weird backtrace reveal a stack overflow?
> 
> Or maybe just too much frame information is optimized out, too 
> aggressively. You may want to turn on debug symbols for building the 
> Xenomai libraries, using --enable-debug.
> 

Recompiled xenomai with --enable-debug. Backtrace of clocktest is now:
(gdb) bt 
#0  0x0fdf4e74 in ?? () from /opt/eldk-5.4/powerpc/sysroots/powerpc-linux/lib/libc.so.6
#1  0x0ffd8af8 in sched_setconfig_np ()
   from /opt/eldk-5.4/powerpc/sysroots/powerpc-linux/usr/xenomai/lib/libpthread_rt.so.1
#2  0x0ff7ba68 in start_thread (arg=0xbffffdd0) at pthread_create.c:313
#3  0x4802ff18 in _rtld_global_ro () from /opt/eldk-5.4/powerpc/sysroots/powerpc-linux/lib/ld.so.1
Backtrace stopped: frame did not save the PC


Unfortunately it does not matter if I load the proper libxenoma.so and
libpthread_rt.so before I continue the application:
(gdb) info sharedlibrary
>From        To          Syms Read   Shared Object Library
0x48001ff0  0x4801b014  Yes         /opt/eldk-5.4/powerpc/sysroots/powerpc-linux/lib/ld.so.1
                        No          linux-vdso32.so.1
0x0ffd7b1c  0x0ffdeab0  Yes (*)     /opt/eldk-5.4/powerpc/sysroots/powerpc-linux/usr/xenomai/lib/libpthread_rt.so.1
0x0ffaf588  0x0ffb2bb8  Yes (*)     /opt/eldk-5.4/powerpc/sysroots/powerpc-linux/usr/xenomai/lib/libxenomai.so.0
0x0ff78b84  0x0ff873fc  Yes         /opt/eldk-5.4/powerpc/sysroots/powerpc-linux/lib/libpthread.so.0
0x0fe0a5c0  0x0ff1d844  Yes         /opt/eldk-5.4/powerpc/sysroots/powerpc-linux/lib/libc.so.6
0x0fdc3a94  0x0fdc799c  Yes         /opt/eldk-5.4/powerpc/sysroots/powerpc-linux/lib/librt.so.1
(*): Shared library is missing debugging information.

Disassembly of the section:
(gdb) disass $pc-64,$pc+20
Dump of assembler code from 0xfdf4e34 to 0xfdf4e88:
   0x0fdf4e34:	.long 0x3894
   0x0fdf4e38:	.long 0x12b8a4
   0x0fdf4e3c:	.long 0x80
   0x0fdf4e40:	vaddfp  v16,v0,v0
   0x0fdf4e44:	.long 0x19fb
   0x0fdf4e48:	.long 0xe99c8
   0x0fdf4e4c:	.long 0xa0
   0x0fdf4e50:	vaddfp  v16,v0,v0
   0x0fdf4e54:	.long 0x2742
   0x0fdf4e58:	.long 0xe375c
   0x0fdf4e5c:	.long 0x4c
   0x0fdf4e60:	subfic  r16,r0,10
   0x0fdf4e64:	.long 0x378a
   0x0fdf4e68:	.long 0xf834c
   0x0fdf4e6c:	.long 0x58
   0x0fdf4e70:	vaddfp  v16,v0,v0
=> 0x0fdf4e74:	.long 0x5a3e
   0x0fdf4e78:	.long 0xe286c
   0x0fdf4e7c:	.long 0x68
   0x0fdf4e80:	vaddfp  v16,v0,v0
   0x0fdf4e84:	.long 0x80e
End of assembler dump.

Shall I turn off FPU support from the kernel entirely?
(In our application FPU is needed.)

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
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20131129/8bdf9359/attachment.sig>
