Date: Fri, 29 Nov 2013 11:27:36 +0100
From: Bukuli Norbert <norbert.bukuli@mediso.hu>
Message-ID: <20131129112736.3be45065.norbert.bukuli@mediso.hu>
In-Reply-To: <52985E94.4070101@xenomai.org>
References: <20131128143152.04ac3eab.norbert.bukuli@mediso.hu>
 <5297BD30.4060007@xenomai.org>
 <20131129094157.3d7202e1.norbert.bukuli@mediso.hu>
 <52985E94.4070101@xenomai.org>
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



On Fri, 29 Nov 2013 10:29:56 +0100
Philippe Gerum <rpm@xenomai.org> wrote:
> On 11/29/2013 09:41 AM, Bukuli Norbert wrote:
> > (gdb) cont
> > Continuing.
> > warning: Could not load shared library symbols for
> > linux-vdso32.so.1. Do you need "set solib-search-path" or "set
> > sysroot"? warning: .dynamic section for
> > "/opt/eldk-5.4/powerpc/sysroots/powerpc-linux/usr/xenomai/lib/libpthread_rt.so.1"
> > is not at the expected address (wrong library or version mismatch?)
> > warning: .dynamic section for
> > "/opt/eldk-5.4/powerpc/sysroots/powerpc-linux/usr/xenomai/lib/libxenomai.so.0"
> > is not at the expected address (wrong library or version mismatch?)
> 
> These warnings may trigger with recent broken gdbserver releases,
> let's ignore them.
> https://sourceware.org/ml/gdb-patches/2013-06/msg00054.html
OK

> 
> > [New Thread 280]
> >
> > Program received signal SIGILL, Illegal instruction.
> > [Switching to Thread 280]
> > 0x0fdf4e74 in ?? ()
> > from /opt/eldk-5.4/powerpc/sysroots/powerpc-linux/lib/libc.so.6
> >
> 
> (gdb) disass $pc-64 $pc+20
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
End of assembler dump

> 
> would help at this point.
> 
> > (gdb) bt
> > #0  0x0fdf4e74 in ?? ()
> > from /opt/eldk-5.4/powerpc/sysroots/powerpc-linux/lib/libc.so.6 #1
> > 0x0ffd8af8 in sched_setconfig_np ()
> > from /opt/eldk-5.4/powerpc/sysroots/powerpc-linux/usr/xenomai/lib/libpthread_rt.so.1
> > #2  0x0ff7ba68 in start_thread (arg=0xbffffdd0) at
> > pthread_create.c:313
> 
> Is sched_setconfig_np() really the start routine given to 
> pthread_create() in your application, I guess not. Or could this
> weird backtrace reveal a stack overflow?
This is the clocktest, not my trivial posix skin test. The start
routine in that is "cpu_thread()" in clocktest.c:196 in xenomai-2.6.3.

Debugging of the trivial posix skin test (my application):
(gdb) set sysroot /opt/eldk-5.4/powerpc/sysroots/powerpc-linux
(gdb) cont
The program is not being run.
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
[New Thread 336]

Program received signal SIGTRAP, Trace/breakpoint trap.
[Switching to Thread 336]
0x480319f8 in ?? ()
(gdb) bt 
#0  0x480319f8 in ?? ()
#1  0x0ffd8af8 in sched_setconfig_np ()
   from /opt/eldk-5.4/powerpc/sysroots/powerpc-linux/usr/xenomai/lib/libpthread_rt.so.1
#2  0x0ff7ba68 in start_thread (arg=0xbffffdd0) at pthread_create.c:313
#3  0x4802ff18 in _rtld_global_ro () from /opt/eldk-5.4/powerpc/sysroots/powerpc-linux/lib/ld.so.1
Backtrace stopped: frame did not save the PC

(gdb) disass $pc-64,$pc+20
Dump of assembler code from 0x480319b8 to 0x48031a0c:
   0x480319b8:	.long 0x0
   0x480319bc:	.long 0x0
   0x480319c0:	.long 0x0
   0x480319c4:	.long 0x0
   0x480319c8:	.long 0x0
   0x480319cc:	.long 0x0
   0x480319d0:	cmpi    cr6,1,r21,29554
   0x480319d4:	cmpi    cr6,1,r24,25966
   0x480319d8:	xoris   r13,r27,24937
   0x480319dc:	cmpi    cr6,1,r12,26978
   0x480319e0:	cmpi    cr6,1,r12,26978
   0x480319e4:	andi.   r20,r3,26738
   0x480319e8:	oris    r1,r11,25695
   0x480319ec:	andi.   r20,r19,11891
   0x480319f0:	xoris   r14,r25,12544
   0x480319f4:	.long 0x0
=> 0x480319f8:	twi     31,r29,16384
   0x480319fc:	b       0x480633cc
   0x48031a00:	twi     31,r30,-3476
   0x48031a04:	b       0x480636cc
   0x48031a08:	b       0x48062e90
End of assembler dump.

(gdb) frame 1
#1  0x0ffd8af8 in sched_setconfig_np ()
   from /opt/eldk-5.4/powerpc/sysroots/powerpc-linux/usr/xenomai/lib/libpthread_rt.so.1
(gdb) disass $pc-64,$pc+20
Dump of assembler code from 0xffd8ab8 to 0xffd8b0c:
   0x0ffd8ab8 <pthread_set_name_np+52>:	bl      0xffef720 <sigemptyset@plt>
   0x0ffd8abc <pthread_set_name_np+56>:	addi    r3,r31,20
   0x0ffd8ac0 <pthread_set_name_np+60>:	bl      0xffef540 <__real_sem_post@plt>
   0x0ffd8ac4 <pthread_set_name_np+64>:	lwz     r9,8(r1)
   0x0ffd8ac8 <pthread_set_name_np+68>:	cmpw    cr7,r9,r25
   0x0ffd8acc <pthread_set_name_np+72>:	beq-    cr7,0xffd8b38 <sched_setconfig_np+84>
   0x0ffd8ad0 <pthread_set_name_np+76>:	cmpwi   cr7,r28,0
   0x0ffd8ad4 <pthread_set_name_np+80>:	beq-    cr7,0xffd8aec <sched_setconfig_np+8>
   0x0ffd8ad8 <pthread_set_name_np+84>:	lis     r0,512
   0x0ffd8adc <pthread_set_name_np+88>:	li      r3,1
   0x0ffd8ae0:	ori     r0,r0,555
   0x0ffd8ae4 <sched_setconfig_np+0>:	sc      
   0x0ffd8ae8 <sched_setconfig_np+4>:	mfcr    r0
   0x0ffd8aec <sched_setconfig_np+8>:	mtctr   r27
   0x0ffd8af0 <sched_setconfig_np+12>:	mr      r3,r26
   0x0ffd8af4 <sched_setconfig_np+16>:	bctrl
=> 0x0ffd8af8 <sched_setconfig_np+20>:	li      r4,0
   0x0ffd8afc <sched_setconfig_np+24>:	mr      r31,r3
   0x0ffd8b00 <sched_setconfig_np+28>:	lis     r3,4
   0x0ffd8b04 <sched_setconfig_np+32>:	bl      0xffef5e0 <open@plt>
   0x0ffd8b08 <sched_setconfig_np+36>:	lwz     r0,68(r1)
End of assembler dump.

Please, note, that the file, in frame 1 in not equal to the actually used one, I do not use Xenomai provided by ELDK, I compiled it separately.

> 
> >> gdb will give you the faulty location in symbolic form.
> > If you can suggest, please, how I can override loaded libraries in
> > gdb, then I will repeat the tests.
> 
> You could set solib-search-path appropriately or load them manually 
> using file (-readnow), but I don't think this would help in 
> understanding this particular issue. It somewhat behaves as if broken 
> Xenomai syscall code was output by the compiler - this is something
> we faced a couple of times already on arm and ppc in the past years. 
> Checking the disassembled code surrounding the fault location may
> help figuring this out.

I see. Can I check somehow whether this happened?

> 
> >>
> >>> I have read in a previous messages on this list, that the
> >>> CONFIG_XENO_HW_UNLOCKED_SWITCH option should be turned off, but
> >>> unfortunately this did not help.
> >>>
> >>
> >> Unlocked switching is no more an issue with 3.8.13 and beyond.
> > Then I will turn it on again.
> 
> You can also leave it off. On architectures with sane caches (e.g.
> not armv5 and its aliasing issues), it basically depends on whether
> shorter (real-time) interrupt latencies [on] are preferred over
> shorter task scheduling latencies [off]. The difference will likely
> only amount for a couple of micro-seconds max on most platforms
> though, however both options are available with 3.8+ pipelines.
> 
I see. I left it off in the tests mentioned above.


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
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20131129/a062f4cc/attachment.sig>
