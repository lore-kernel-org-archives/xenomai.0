Date: Mon, 2 Dec 2013 11:16:34 +0100
From: Bukuli Norbert <norbert.bukuli@mediso.hu>
Message-ID: <20131202111634.55b92203.norbert.bukuli@mediso.hu>
In-Reply-To: <529C59D2.3030703@xenomai.org>
References: <20131128143152.04ac3eab.norbert.bukuli@mediso.hu>
 <5297BD30.4060007@xenomai.org>
 <20131129094157.3d7202e1.norbert.bukuli@mediso.hu>
 <52985E94.4070101@xenomai.org>
 <20131129225320.5327838040F@gemini.denx.de>
 <20131202095057.175411b7.norbert.bukuli@mediso.hu>
 <529C59D2.3030703@xenomai.org>
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



On Mon, 2 Dec 2013 10:58:42 +0100
Philippe Gerum <rpm@xenomai.org> wrote:
> On 12/02/2013 09:50 AM, Bukuli Norbert wrote:
> >
> >
> > On Fri, 29 Nov 2013 23:53:20 +0100
> > Wolfgang Denk <wd@denx.de> wrote:
> >> Dear Philippe Gerum,
> >>
> >> In message <52985E94.4070101@xenomai.org> you wrote:
> >>> On 11/29/2013 09:41 AM, Bukuli Norbert wrote:
> >>>> (gdb) cont
> >>>> Continuing.
> >>>> warning: Could not load shared library symbols for
> >>>> linux-vdso32.so.1. Do you need "set solib-search-path" or "set
> >>>> sysroot"? warning: .dynamic section for
> >>>> "/opt/eldk-5.4/powerpc/sysroots/powerpc-linux/usr/xenomai/lib/libpthread_rt.so.1"
> >>>> is not at the expected address (wrong library or version
> >>>> mismatch?) warning: .dynamic section for
> >>>> "/opt/eldk-5.4/powerpc/sysroots/powerpc-linux/usr/xenomai/lib/libxenomai.so.0"
> >>>> is not at the expected address (wrong library or version
> >>>> mismatch?)
> >>>
> >>> These warnings may trigger with recent broken gdbserver releases,
> >>> let's ignore them.
> >>
> >> I don't think this is a good idea.  The actual problem is in the
> >> previous warning:
> >>
> >> warning: Could not load shared library symbols for
> >> linux-vdso32.so.1. Do you need "set solib-search-path" or "set
> >> sysroot"?
> >>
> >> You must set solib-search-path.
> >
> > As Philippe Gerum asked it, I have used the Xenomai libraries
> > provided by the ELDK 5.4 and kept my kernel. In the following test
> > I set the solib-search path and the sysroot properly, however the
> > powerpc-linux-gdb was unable to find linux-vdso32.so.1. I installed
> > it from the kernel with vdso_install but it creates
> > only /lib/modules/3.8.13/vdso/vdso32.so file.
> >
> > What is the proper way to make the gdb know the linux-vdso32.so.1
> > file? Shall I create a simlink to the vdso32.so file?
> >
> > Anyway, after I created the simlink on the target system like this :
> > root@generic-powerpc:/lib# ln -s /lib/modules/3.8.13/vdso/vdso32.so
> > linux-vdso32
> >
> > and on the host system like this:
> > # cd $(POWERPC-SYSROOT)/lib/modules/3.8.13/vdso
> > # ln -s vdso32.so linux-vdso32.so.1
> >
> > gdb found all libraries. However, there is no debugging info in the
> > shared libraries, but I think the disassembled code around the
> > crash point will be sufficient.
> >
> > GDB output (irrelevant parts are removed):
> > $ powerpc-linux-gdb usr/xenomai/bin/powerpc-linux-clocktest
> > ...
> > Reading symbols
> > from /srv/tftpboot/172.31.2.11/usr/xenomai/bin/powerpc-linux-clocktest...(nodebugging
> > symbols found)...done.
> >
> > (gdb) set solib-search-path
> > "/srv/tftpboot/172.31.2.11/lib/:/srv/tftpboot/172.31.2.11/usr/lib/:/srv/tftpboot/172.31.2.11/usr/xenomai/lib/:/srv/tftpboot/172.31.2.11/lib/modules/3.8.13/vdso/
> > (gdb) set sysroot /opt/eldk-5.4/powerpc/sysroots/powerpc-linux
> >
> > (gdb) target remote 172.31.2.11:2001
> > Remote debugging using 172.31.2.11:2001
> > Reading symbols
> > from /opt/eldk-5.4/powerpc/sysroots/powerpc-linux/lib/ld.so.1...Reading
> > symbols
> > from /opt/eldk-5.4/powerpc/sysroots/powerpc-linux/lib/.debug/ld-2.17.so...done.
> > done. Loaded symbols
> > for /opt/eldk-5.4/powerpc/sysroots/powerpc-linux/lib/ld.so.1
> > 0x0ffd76e8 in ?? ()
> >
> > (gdb) cont
> > Continuing.
> > [New Thread 338]
> >
> > Program received signal SIGILL, Illegal instruction.
> > [Switching to Thread 338]
> > 0x4800ce74 in ?? ()
> >
> > (gdb) bt
> > #0  0x4800ce74 in ?? ()
> > #1  0x0ff98534 in ?? ()
> > #2  0x0fe17a68 in ?? ()
> > #3  0x480eba4c in ?? ()
> >
> > (gdb) info sharedlibrary
> >  From        To          Syms Read   Shared Object Library
> > 0x00001ff0  0x0001b014
> > Yes         /opt/eldk-5.4/powerpc/sysroots/powerpc-linux/lib/ld.so.1
> > 0x00100360  0x00100648
> > No          /srv/tftpboot/172.31.2.11/lib/modules/3.8.13/vdso/linux-vdso32.so.1
> > 0x0ff979b4  0x0ff9e948
> > No          /opt/eldk-5.4/powerpc/sysroots/powerpc-linux/usr/xenomai/lib/libpthread_rt.so.1
> > 0x0ff6fba0  0x0ff731d0
> > No          /opt/eldk-5.4/powerpc/sysroots/powerpc-linux/usr/xenomai/lib/libxenomai.so.0
> > 0x0fe14b84  0x0fe233fc
> > No          /opt/eldk-5.4/powerpc/sysroots/powerpc-linux/lib/libpthread.so.0
> > 0x480225c0  0x48135844
> > No          /opt/eldk-5.4/powerpc/sysroots/powerpc-linux/lib/libc.so.6
> > 0x0fdf1a94  0x0fdf599c
> > No          /opt/eldk-5.4/powerpc/sysroots/powerpc-linux/lib/librt.so.1
> >
> > (gdb) disass $pc-64,$pc+20
> > Dump of assembler code from 0x4800ce34 to 0x4800ce88:
> >     0x4800ce34:	.long 0x3894
> >     0x4800ce38:	twi     31,r22,-18268
> >     0x4800ce3c:	.long 0x80
> >     0x4800ce40:	vaddfp  v16,v0,v0
> >     0x4800ce44:	.long 0x19fb
> >     0x4800ce48:	twi     31,r18,-26168
> >     0x4800ce4c:	.long 0xa0
> >     0x4800ce50:	vaddfp  v16,v0,v0
> >     0x4800ce54:	.long 0x2742
> >     0x4800ce58:	twi     31,r18,14172
> >     0x4800ce5c:	.long 0x4c
> >     0x4800ce60:	subfic  r16,r0,10
> >     0x4800ce64:	.long 0x378a
> >     0x4800ce68:	twi     31,r19,-31924
> >     0x4800ce6c:	.long 0x58
> >     0x4800ce70:	vaddfp  v16,v0,v0
> > => 0x4800ce74:	.long 0x5a3e
> >     0x4800ce78:	twi     31,r18,10348
> >     0x4800ce7c:	.long 0x68
> >     0x4800ce80:	vaddfp  v16,v0,v0
> >     0x4800ce84:	.long 0x80e
> > End of assembler dump.
> >
> 
> While we are at it, could please you paste-bin a larger disassembly ( 
> $pc-256, $pc + 256) of frame #1, just below this one? I'd like to see 
> the call site.

This is the disassembly of frame #1
   0x0ff98434:	stw     r27,44(r1)
   0x0ff98438:	stw     r29,52(r1)
   0x0ff9843c:	bl      0xffaf2e0
   0x0ff98440:	stw     r3,16(r1)
   0x0ff98444:	stw     r3,24(r1)
   0x0ff98448:	bl      0xffaf278
   0x0ff9844c:	lwz     r9,16(r31)
   0x0ff98450:	mr      r5,r1
   0x0ff98454:	lwz     r28,8(r31)
   0x0ff98458:	stwu    r9,8(r5)
   0x0ff9845c:	lwz     r3,24(r1)
   0x0ff98460:	mr      r4,r28
   0x0ff98464:	lwz     r25,12(r31)
   0x0ff98468:	bl      0xffaf548
   0x0ff9846c:	lwz     r9,-32768(r30)
   0x0ff98470:	lwz     r3,16(r1)
   0x0ff98474:	addi    r6,r1,12
   0x0ff98478:	lwz     r0,0(r9)
   0x0ff9847c:	lwz     r4,8(r31)
   0x0ff98480:	ori     r0,r0,555
   0x0ff98484:	lwz     r5,16(r31)
   0x0ff98488:	sc      
   0x0ff9848c:	mfcr    r0
   0x0ff98490:	andis.  r9,r0,4096
   0x0ff98494:	beq-    0xff9849c
   0x0ff98498:	neg     r3,r3
   0x0ff9849c:	cmpwi   cr7,r3,0
   0x0ff984a0:	neg     r29,r3
   0x0ff984a4:	stw     r29,36(r31)
   0x0ff984a8:	lwz     r27,0(r31)
   0x0ff984ac:	lwz     r26,4(r31)
   0x0ff984b0:	beq-    cr7,0xff984ec
   0x0ff984b4:	addi    r3,r31,20
   0x0ff984b8:	bl      0xffaf3d8
   0x0ff984bc:	lwz     r0,68(r1)
   0x0ff984c0:	mr      r3,r29
   0x0ff984c4:	lwz     r25,36(r1)
   0x0ff984c8:	mtlr    r0
   0x0ff984cc:	lwz     r26,40(r1)
   0x0ff984d0:	lwz     r27,44(r1)
   0x0ff984d4:	lwz     r28,48(r1)
   0x0ff984d8:	lwz     r29,52(r1)
   0x0ff984dc:	lwz     r30,56(r1)
   0x0ff984e0:	lwz     r31,60(r1)
   0x0ff984e4:	addi    r1,r1,64
   0x0ff984e8:	blr
   0x0ff984ec:	bl      0xffaf488
   0x0ff984f0:	lwz     r3,12(r1)
   0x0ff984f4:	bl      0xffaf590
   0x0ff984f8:	addi    r3,r31,20
   0x0ff984fc:	bl      0xffaf3d8
   0x0ff98500:	lwz     r9,8(r1)
   0x0ff98504:	cmpw    cr7,r9,r25
   0x0ff98508:	beq-    cr7,0xff98560
   0x0ff9850c:	cmpwi   cr7,r28,0
   0x0ff98510:	beq-    cr7,0xff98528
   0x0ff98514:	lis     r0,512
   0x0ff98518:	li      r3,1
   0x0ff9851c:	ori     r0,r0,555
   0x0ff98520:	sc      
   0x0ff98524:	mfcr    r0
   0x0ff98528:	mr      r3,r26
   0x0ff9852c:	mtctr   r27
   0x0ff98530:	bctrl
=> 0x0ff98534:	lwz     r0,68(r1)
   0x0ff98538:	lwz     r25,36(r1)
   0x0ff9853c:	mtlr    r0
   0x0ff98540:	lwz     r26,40(r1)
   0x0ff98544:	lwz     r27,44(r1)
   0x0ff98548:	lwz     r28,48(r1)
   0x0ff9854c:	lwz     r29,52(r1)
   0x0ff98550:	lwz     r30,56(r1)
   0x0ff98554:	lwz     r31,60(r1)
   0x0ff98558:	addi    r1,r1,64
   0x0ff9855c:	blr
   0x0ff98560:	bl      0xffaf550
   0x0ff98564:	b       0xff9850c
   0x0ff98568:	b       0xffaf550
   0x0ff9856c:	.long 0x1eb0c
   0x0ff98570:	stwu    r1,-128(r1)
   0x0ff98574:	mflr    r0
   0x0ff98578:	bcl-    20,4*cr7+so,0xff9857c
   0x0ff9857c:	stw     r30,120(r1)
   0x0ff98580:	mflr    r30
   0x0ff98584:	stw     r29,116(r1)
   0x0ff98588:	mr.     r29,r4
   0x0ff9858c:	stw     r0,132(r1)
   0x0ff98590:	lwz     r0,-16(r30)
   0x0ff98594:	stw     r26,104(r1)
   0x0ff98598:	mr      r26,r3
   0x0ff9859c:	add     r30,r0,r30
   0x0ff985a0:	stw     r27,108(r1)
   0x0ff985a4:	stw     r28,112(r1)
   0x0ff985a8:	mr      r27,r5
   0x0ff985ac:	stw     r31,124(r1)
   0x0ff985b0:	mr      r28,r6
   0x0ff985b4:	lwz     r31,-32764(r30)
   0x0ff985b8:	beq-    0xff98778
   0x0ff985bc:	addi    r4,r1,92
   0x0ff985c0:	mr      r3,r29
   0x0ff985c4:	bl      0xffaf400
   0x0ff985c8:	bl      0xffaf2e0
   0x0ff985cc:	addi    r4,r1,16
   0x0ff985d0:	addi    r5,r1,96
   0x0ff985d4:	bl      0xffaf480
   0x0ff985d8:	lwz     r10,92(r1)
   0x0ff985dc:	lwz     r9,96(r1)
   0x0ff985e0:	cmpwi   cr7,r10,1
   0x0ff985e4:	stw     r9,20(r1)
   0x0ff985e8:	beq-    cr7,0xff987ac
   0x0ff985ec:	addi    r3,r1,48
   0x0ff985f0:	mr      r4,r29
   0x0ff985f4:	li      r5,36
   0x0ff985f8:	stw     r9,24(r1)
   0x0ff985fc:	bl      0xffaf2d8
   0x0ff98600:	lwz     r9,36(r31)
   0x0ff98604:	cmpwi   cr7,r9,0
   0x0ff98608:	beq-    cr7,0xff98618
   0x0ff9860c:	bl      0xffaf358
   0x0ff98610:	cmpwi   cr7,r3,0
   0x0ff98614:	bne-    cr7,0xff98748
   0x0ff98618:	addi    r3,r1,48
   0x0ff9861c:	li      r4,0
   0x0ff98620:	bl      0xffaf440
   0x0ff98624:	addi    r3,r1,48
   0x0ff98628:	addi    r4,r1,84
   0x0ff9862c:	bl      0xffaf4d8
   0x0ff98630:	lwz     r3,40(r31)

> 
> Also, could you paste-bin the disassembly of libxenomai.so?
You can find it here:
http://pastebin.com/YjUDZRMp

> 
> TIA,
> 
You are welcome!

TIA, too!


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
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20131202/91af35e9/attachment.sig>
