Message-ID: <1398219317.2723.26.camel@localhost.localdomain>
From: Peter Howard <pjh@northern-ridge.com.au>
Date: Wed, 23 Apr 2014 12:15:17 +1000
In-Reply-To: <1398217532.2723.18.camel@localhost.localdomain>
References: <1396407588.27578.5.camel@localhost.localdomain>
 <533BBB11.5090808@xenomai.org>
 <1396848843.2481.15.camel@localhost.localdomain>
 <5343BEFB.7050402@xenomai.org>
 <1396999856.2660.7.camel@localhost.localdomain>
 <53449244.8040502@xenomai.org>
 <1397003664.2660.14.camel@localhost.localdomain>
 <1397017658.2660.16.camel@localhost.localdomain>
 <534534FD.5090805@xenomai.org>
 <1397113300.2720.5.camel@localhost.localdomain>
 <5346895B.6080401@xenomai.org>
 <1397159850.2881.3.camel@localhost.localdomain>
 <53471389.6000000@xenomai.org>
 <1397168263.6356.11.camel@localhost.localdomain>
 <534719F5.2020605@xenomai.org>
 <1397169248.6356.15.camel@localhost.localdomain>
 <53471FDB.50008@xenomai.org>
 <1397170339.6356.17.camel@localhost.localdomain>
 <1397541812.6541.3.camel@localhost.localdomain>
 <534D19FA.3040506@xenomai.org>
 <1397599195.2652.0.camel@localhost.localdomain>
 <5356F4FE.3050406@xenomai.org>
 <1398217532.2723.18.camel@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] OMAP L138
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Wed, 2014-04-23 at 11:45 +1000, Peter Howard wrote:
> On Wed, 2014-04-23 at 01:02 +0200, Gilles Chanteperdrix wrote:
> > On 04/15/2014 11:59 PM, Peter Howard wrote:
> > > On Tue, 2014-04-15 at 13:37 +0200, Gilles Chanteperdrix wrote:
> > >> On 04/15/2014 08:03 AM, Peter Howard wrote:
> > >>> On Fri, 2014-04-11 at 08:52 +1000, Peter Howard wrote:
> > >>>> On Fri, 2014-04-11 at 00:48 +0200, Gilles Chanteperdrix wrote:
> > >>>>> On 04/11/2014 12:34 AM, Peter Howard wrote:
> > >>>>>> On Fri, 2014-04-11 at 00:23 +0200, Gilles Chanteperdrix wrote:
> > >>>>>> (Stripping back conversation on this one - apologies if that's bad
> > >>>>>> etiquette for this list)
> > >>>>>>  
> > >>>>>>> Attachment is better. Also please post the changes you made for omapL138
> > >>>>>>>
> > >>>>>>
> > >>>>>> diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
> > >>>>>> index a075b3e..3d8bc59 100644
> > >>>>>> --- a/arch/arm/mach-davinci/Kconfig
> > >>>>>> +++ b/arch/arm/mach-davinci/Kconfig
> > >>>>>> @@ -41,6 +41,8 @@ config ARCH_DAVINCI_DA850
> > >>>>>>  	select ARCH_DAVINCI_DA8XX
> > >>>>>>  	select ARCH_HAS_CPUFREQ
> > >>>>>>  	select CP_INTC
> > >>>>>> +    select IPIPE_ARM_KUSER_TSC if IPIPE
> > >>>>>> +    select ARM_FCSE if IPIPE
> > >>>>>
> > >>>>> You may want to leave the choice of enabling or disabling FCSE to the user.
> > >>>>>
> > >>>>
> > >>>> Understood; at the moment the variance on max latency is really bad if
> > >>>> you don't enable FCSE.  When I sort out the crashing issues I'll re-test
> > >>>> with it off.
> > >>>
> > >>> Well, FCSE turned out to be my problem.
> > >>>
> > >>> More specifically,  FCSE and ARM_FCSE_BEST_EFFORT.  Either a) disabling
> > >>> ARM_FCSE altogether, or b) selecting ARM_FCSE with ARM_FCSE_GUARENTEED
> > >>> gets rid of the crashes/panics with ipipe latency tracing enabled.
> > >>>
> > >>> So now things seem reasonably stable, I'll go through the full set of
> > >>> tests.  Though I still can't do 'xeno-test -l "dohell -l /opt/ltp"' as
> > >>> ltp takes out the system without any ipipe/xenomai bits.
> > >>>
> > >> Ok, FCSE best effort is currently being validated on 3.14, so it may
> > >> well be broken. After all, the raw/* branches are work in progress.
> > >>
> > > 
> > > Note: selecting ARM_FCSE_BEST_EFFORT produces the same result on the
> > > master branch too . . .
> > > 
> > Hi Peter,
> > 
> > I am unable to reproduce these issues with 3.14, FCSE seems to be doing
> > just fine, I can boot and run the LTP testsuite and get almost the same
> > results as a non patched kernel. I have tried with and without
> > preemptible cache flushes, and with and without Xenomai. My rootfs is
> > based on busybox and minimal, maybe that is the reason why it works
> > fine, could you put a tarball with your rootfs somewhere?
> 
> A bit of testing shows (at least) one case is directly related to the
> rootfs.  This is the Texas Instruments rootfs that is supplied for the
> DA850 board.  During normal startup, it wants to start the GUI for the
> LCD which would go past the 32MB process limit with FCSE enabled.  With
> FCSE_GUARENTEED selected this is noted but doesn't cause a crash.  With
> FCSE_BEST_EFFORT selected this is noted and then the system crashes
> within a few seconds.  I'm not sure if this counts as a bug in
> BEST_EFFORT or whether all bets are off if you try to start a process
> that's too large.
> 
> At this point I'm not sure if anything else is specific to that rootfs
> but I'll still make it available to you to have a look.
> 

With the ipipe_lock_irq() and ipipe_unlock_irq() calls removed from the
mask/unmask calls, the only problem left that isn't caused by the above
>32MB process is an alignment fault during xeno-test.  Only happens with
the xenomai programs built from the 2.6 tree and only on the full Ti
rootfs (the same build works fine on a buildroot-based rootfs, as do the
xenomai programs built via buildroot).  So I'm guessing that problem is
mismatched libraries and nothing to do with xenomai itself.  (I've
included the error just for reference at the end of the email).

So given that:

     1. Do you still want the rootfs to look at?
     2. What would you like me to run/test before I put up a formal
        patch for merging?

Thanks for the help so far.


Alignment trap: switchtest (1592) PC=0x01b7ff18 Instr=0xe590c000 Address=0x00001
switchtest: unhandled page fault (11) at 0x00000001, code 0x001                 
fcse pid: 79, 0x9e000000, hw pid: 0x9e000000                                    
pgd = c68cc000, hw pgd = c68cc000                                               
[00000001] *pgd=c73fe831, *pte=00000000, *ppte=00000000                         
                                                                                
CPU: 0 PID: 1592 Comm: switchtest Not tainted 3.14.0-ipipe-38808-gd8d4639-dirty6
task: c6847a00 ti: c6904000 task.ti: c6904000                                   
PC is at 0x1b7ff18                                                              
LR is at 0x1b7ff0c                                                              
pc : [<01b7ff18>]    lr : [<01b7ff0c>]    psr: 20000010                         
sp : 018e6334  ip : 01b90280  fp : 00000258                                     
r10: 00000158  r9 : 01b1b000  r8 : 018e6350                                     
r7 : 00000000  r6 : 00000008  r5 : 00000000  r4 : 01b90290                      
r3 : 00000050  r2 : 01b94050  r1 : 00000001  r0 : 00000001                      
Flags: nzCv  IRQs on  FIQs on  Mode USER_32  ISA ARM  Segment user              
Control: 0005317f  Table: c68cc000  DAC: 00000015                               
CPU: 0 PID: 1592 Comm: switchtest Not tainted 3.14.0-ipipe-38808-gd8d4639-dirty6
Backtrace:                                                                      
[<c000d228>] (dump_backtrace) from [<c000d7d0>] (show_stack+0x20/0x24)          
 r6:00000001 r5:0000000b r4:c6905fb0 r3:00000000                                
[<c000d7b0>] (show_stack) from [<c03f849c>] (dump_stack+0x20/0x2c)              
[<c03f847c>] (dump_stack) from [<c000ac48>] (show_regs+0x2c/0x34)               
[<c000ac1c>] (show_regs) from [<c0011bf8>] (__do_user_fault+0xf0/0xfc)          
 r4:c6847a00 r3:60000013                                                        
[<c0011b08>] (__do_user_fault) from [<c0012050>] (do_bad_area+0x74/0x7c)        
 r8:00000001 r7:c059bc3c r6:00000001 r5:00000000 r4:c6905fb0                    
[<c0011fdc>] (do_bad_area) from [<c0014998>] (do_alignment+0x37c/0x928)         
[<c001461c>] (do_alignment) from [<c0008794>] (do_DataAbort+0x50/0x160)         
 r10:00000158 r9:01b1b000 r8:c6905fb0 r7:00000001 r6:c0568154 r5:00000001       
 r4:00000001                                                                    
[<c0008744>] (do_DataAbort) from [<c000e7fc>] (__dabt_usr+0x5c/0x60)            
Exception stack(0xc6905fb0 to 0xc6905ff8)                                       
5fa0:                                     00000001 00000001 01b94050 00000050   
5fc0: 01b90290 00000000 00000008 00000000 018e6350 01b1b000 00000158 00000258   
5fe0: 01b90280 018e6334 01b7ff0c 01b7ff18 20000010 ffffffff                     
 r10:00000158 r8:018e6350 r7:00000000 r6:ffffffff r5:20000010 r4:01b7ff18       
mappings:                                                                       
0x00008000-0x0000e000 r-xp 0x00000000 /usr/xenomai/bin/switchtest               
0x00016000-0x00017000 rwxp 0x00006000 /usr/xenomai/bin/switchtest               
0x00017000-0x0005f000 rwxp 0x00017000 [heap]                                    
0x0189d000-0x018a8000 r-xp 0x00000000 /lib/libgcc_s.so.1                        
0x018a8000-0x018af000 ---p 0x0000b000 /lib/libgcc_s.so.1                        
0x018af000-0x018b0000 rwxp 0x0000a000 /lib/libgcc_s.so.1                        
0x018b0000-0x018b1000 ---p 0x018b0000                                           
0x018b1000-0x018b8000 rwxp 0x018b1000                                           
0x018b8000-0x018b9000 ---p 0x018b8000                                           
0x018b9000-0x018c0000 rwxp 0x018b9000                                           
0x018c0000-0x018c1000 ---p 0x018c0000                                           
0x018c1000-0x018c8000 rwxp 0x018c1000                                           
0x018c8000-0x018c9000 ---p 0x018c8000                                           
0x018c9000-0x018d0000 rwxp 0x018c9000                                           
0x018d0000-0x018d1000 ---p 0x018d0000                                           
0x018d1000-0x018d8000 rwxp 0x018d1000                                           
0x018d8000-0x018d9000 ---p 0x018d8000                                           
0x018d9000-0x018e0000 rwxp 0x018d9000                                           
0x018e0000-0x018e1000 ---p 0x018e0000                                           
0x018e1000-0x018e8000 rwxp 0x018e1000  <- SP                                    
0x018e8000-0x018e9000 ---p 0x018e8000                                           
0x018e9000-0x019e8000 rwxp 0x018e9000                                           
0x019e8000-0x019eb000 rwxs 0xc8986000 /dev/rtheap                               
0x019eb000-0x019ee000 rwxs 0xc8b1e000 /dev/rtheap                               
0x019ee000-0x019ef000 ---p 0x019ee000                                           
0x019ef000-0x019f6000 rwxp 0x019ef000                                           
0x019f6000-0x01b11000 r-xp 0x00000000 /lib/libc-2.9.so                          
0x01b11000-0x01b19000 ---p 0x0011b000 /lib/libc-2.9.so                          
0x01b19000-0x01b1a000 r-xp 0x0011b000 /lib/libc-2.9.so                          
0x01b1a000-0x01b1c000 rwxp 0x0011c000 /lib/libc-2.9.so                          
0x01b1c000-0x01b1f000 rwxp 0x01b1c000                                           
0x01b1f000-0x01b25000 r-xp 0x00000000 /lib/librt-2.9.so                         
0x01b25000-0x01b2c000 ---p 0x00006000 /lib/librt-2.9.so                         
0x01b2c000-0x01b2d000 r-xp 0x00005000 /lib/librt-2.9.so                         
0x01b2d000-0x01b2e000 rwxp 0x00006000 /lib/librt-2.9.so                         
0x01b2e000-0x01b42000 r-xp 0x00000000 /lib/libpthread-2.9.so                    
0x01b42000-0x01b49000 ---p 0x00014000 /lib/libpthread-2.9.so                    
0x01b49000-0x01b4a000 r-xp 0x00013000 /lib/libpthread-2.9.so                    
0x01b4a000-0x01b4b000 rwxp 0x00014000 /lib/libpthread-2.9.so                    
0x01b4b000-0x01b4d000 rwxp 0x01b4b000                                           
0x01b4d000-0x01b54000 r-xp 0x00000000 /usr/xenomai/lib/libxenomai.so.0.0.0      
0x01b54000-0x01b5b000 ---p 0x00007000 /usr/xenomai/lib/libxenomai.so.0.0.0      
0x01b5b000-0x01b5c000 rwxp 0x00006000 /usr/xenomai/lib/libxenomai.so.0.0.0      
0x01b5c000-0x01b67000 r-xp 0x00000000 /usr/xenomai/lib/libpthread_rt.so.1.0.0   
0x01b67000-0x01b6e000 ---p 0x0000b000 /usr/xenomai/lib/libpthread_rt.so.1.0.0   
0x01b6e000-0x01b6f000 rwxp 0x0000a000 /usr/xenomai/lib/libpthread_rt.so.1.0.0   
0x01b6f000-0x01b8c000 r-xp 0x00000000 /lib/ld-2.9.so <- PC                      
0x01b8c000-0x01b8d000 rwxp 0x01b8c000                                           
0x01b8d000-0x01b8e000 r-xs 0x01c20000 /dev/mem                                  
0x01b8e000-0x01b8f000 r-xs 0xc898a000 /dev/rtheap                               
0x01b8f000-0x01b92000 rwxp 0x01b8f000                                           
0x01b92000-0x01b93000 r-xp 0x01b92000 [sigpage]                                 
0x01b93000-0x01b95000 rwxp 0x0001c000 /lib/ld-2.9.so                            
0x01d56000-0x01d78000 rw-p 0x01fde000 [stack]                                   
Xenomai: RTDM: closing file descriptor 0.                                       
Segmentation fault                                                              


-- 
Peter Howard <pjh@northern-ridge.com.au>


