From: Sebastian Smolorz <ssm@domain.hid>
Subject: Re: [Adeos-main] [PATCH] I-pipe tracer for ARM
Date: Tue, 5 Dec 2006 10:26:20 +0100
References: <E1GrHXk-00023w-Oq@domain.hid> <45745F6F.2050101@domain.hid>
In-Reply-To: <45745F6F.2050101@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <E1GrWZ5-000089-Ou@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main@gna.org

Hi Jan,

thanks for the comments.

Jan Kiszka wrote:
> [snipped code]
>
> Wow, looks like it was a lot of work. Why did you have to add so many
> stuff to make tracing work?

Maybe your impression is caused by the fact that I had to add 
arch/arm/boot/compressed/head.S because it doesn't exist in the ipipe cvs 
repository.

>
> > ------------------------------------------------------------------------
> >
> > I-pipe worst-case tracing service on 2.6.15/ipipe-1.5-03
> > ------------------------------------------------------------
> > Begin: 21055672 cycles, Trace Points: 3 (-10/+10), Length: 4651 us
> >
> >  +----- Hard IRQs ('|': locked)
> >
> >  |+---- <unused>
> >  |
> >  ||+--- <unused>
> >  ||
> >  |||+-- <unused>
> >  |||
> >  ||||+- Linux ('*': domain stalled, '+': current, '#': current+stalled)
> >  ||||
> >  |||||                        +---------- Delay flag ('+': > 1 us, '!': >
> >  ||||| 10 us)
> >  |||||
> >  |||||                        |        +- NMI noise ('N')
> >
> >       Type    User Val.   Time    Delay  Function (Parent)
> >      +func                 -15    1.333N __ipipe_stall_root+0x10
> > (run_timer_softirq+0x38)
>
>                                         ^^^
> There is "NMI noise" marked in a lot of lines. I don't know if your
> board has NMI support at all, but it would surely not fire that often.
> Something is screwed up, either only in the trace_point recording or
> (more critical) in the locking.

Hm, I have to dig deeper for that.

>
> >  |   +begin   0x80000001   -13    1.333N __ipipe_stall_root+0x34
> >  | (run_timer_softirq+0x38) #end     0x80000001   -12    1.444N
> >  | __ipipe_stall_root+0x4c (run_timer_softirq+0x38)
> >
> >      #func                 -10    1.444N __ipipe_unstall_root+0x10
> > (run_timer_softirq+0x19c)
> >
> >  |   #begin   0x80000000    -9    1.555  __ipipe_unstall_root+0x30
> >  | (run_timer_softirq+0x19c) +end     0x80000000    -7    1.333N
> >  | __ipipe_unstall_root+0x68 (run_timer_softirq+0x19c)
> >
> >      +func                  -6    1.444N __ipipe_stall_root+0x10
> > (__do_softirq+0x74)
> >
> >  |   +begin   0x80000001    -5    1.555  __ipipe_stall_root+0x34
> >  | (__do_softirq+0x74) #end     0x80000001    -3    2.111N
> >  | __ipipe_stall_root+0x4c (__do_softirq+0x74)
> >
> >      +func                  -1    1.444N default_idle+0x10
> > (cpu_idle+0x48)
> >
> >> |   +begin   0x80000000     0+   1.555  default_idle+0x44
> >> | (cpu_idle+0x48)
> >> |
> > :|   +func                   1! 4650.111N s3c24xx_default_idle+0x10
> > :| (default_idle+0x78)
>
> You are tracing idle! Likely you have to account for the halt operation
> reenabling IRQs before falling asleep.

Fixed that.

>
> > <|   +end     0x80000000  4651    1.666N default_idle+0x8c
> > (cpu_idle+0x48)
> >
> >  |   +func                4653    1.333N __ipipe_grab_irq+0x10
> >  | (__irq_svc+0x24) +func                4654    1.555N
> >  | __ipipe_handle_irq+0x10 (__ipipe_grab_irq+0xc8) +func               
> >  | 4656    1.333N __ipipe_ack_timerirq+0x10 (__ipipe_handle_irq+0x150)
> >  | +func                4657    1.333N
> >  | ipipe_test_and_stall_pipeline_from+0x10 (__ipipe_ack_timerirq+0x20)
> >  | #func                4658    1.444N __ipipe_mach_acktimer+0x10
> >  | (__ipipe_ack_timerirq+0x28) #func                4660    1.444N
> >  | s3c_irq_ack+0x10 (__ipipe_ack_timerirq+0x44) #func                4661
> >  |    1.555N s3c_irq_unmask+0x10 (__ipipe_ack_timerirq+0x50) +func       
> >  |         4663    1.444N __ipipe_walk_pipeline+0x10
> >  | (__ipipe_handle_irq+0x1a8) +func                4664    1.666N
> >  | __ipipe_sync_stage+0x10 (__ipipe_walk_pipeline+0x9c) #func            
> >  |    4666    0.000N asm_do_IRQ+0x14 (__ipipe_sync_stage+0x1f8)
> >
> > I-pipe frozen back-tracing service on 2.6.15/ipipe-1.5-03
> > ------------------------------------------------------------
> > Freeze: 18284279888 cycles, Trace Points: 30 (+10)
> >
> >  +----- Hard IRQs ('|': locked)
> >
> >  |+---- <unused>
> >  |
> >  ||+--- <unused>
> >  ||
> >  |||+-- <unused>
> >  |||
> >  ||||+- Linux ('*': domain stalled, '+': current, '#': current+stalled)
> >  ||||
> >  |||||                        +---------- Delay flag ('+': > 1 us, '!': >
> >  ||||| 10 us)
> >  |||||
> >  |||||                        |        +- NMI noise ('N')
> >
> >       Type    User Val.   Time    Delay  Function (Parent)
> >
> > :    #func                 -90+   1.333N vma_prio_tree_next+0x10
> > : (update_mmu_cache+0x144) #func                 -89+   2.333 
> > : prio_tree_next+0x14 (vma_prio_tree_next+0x64) #func                
> > : -86+   1.555N prio_tree_left+0x10 (prio_tree_next+0x128) #func         
> > :        -85+   1.555N prio_tree_right+0x10 (prio_tree_next+0x180) #func 
> > :                -83+   1.333N prio_tree_parent+0x10
> > : (prio_tree_next+0x170) #func                 -82+   1.777N
> > : prio_tree_right+0x10 (prio_tree_next+0x180) #func                 -80+ 
> > :  1.666N __ipipe_unstall_root+0x10 (update_mmu_cache+0x150)
> > :
> > :|   #begin   0x80000000   -78+   1.555N __ipipe_unstall_root+0x30
> > :| (update_mmu_cache+0x150) +end     0x80000000   -77+   9.666N
> > :| __ipipe_unstall_root+0x68 (update_mmu_cache+0x150)
> > :
> > :    +func                 -67+   1.444N __up_read+0x10
> > : (do_page_fault+0x1d4) +func                 -66+   1.777N
> > : __ipipe_test_and_stall_root+0x10 (__up_read+0x18)
> > :
> > :|   +begin   0x80000001   -64+   1.777  __ipipe_test_and_stall_root+0x34
> > :| (__up_read+0x18) #end     0x80000001   -62+   1.555N
> > :| __ipipe_test_and_stall_root+0x4c (__up_read+0x18)
> > :
> > :    #func                 -61+   1.555N __ipipe_restore_root+0x10
> > : (__up_read+0xd4) #func                 -59+   1.555N
> > : __ipipe_unstall_root+0x10 (__ipipe_restore_root+0x24)
> > :
> > :|   #begin   0x80000000   -57+   2.222  __ipipe_unstall_root+0x30
> > :| (__ipipe_restore_root+0x24) +end     0x80000000   -55!  12.555N
> > :| __ipipe_unstall_root+0x68 (__ipipe_restore_root+0x24)
> > :
> > :    +func                 -43+   3.333N __ipipe_syscall_root+0x10
> > : (vector_swi+0x64) +func                 -39+   1.777N sys_write+0x14
> > : (ret_fast_syscall+0x0) +func                 -38+   4.222N
> > : fget_light+0x10 (sys_write+0x24) +func                 -33+   3.444N
> > : vfs_write+0x10 (sys_write+0x50) +func                 -30+   5.000N
> > : rw_verify_area+0x14 (vfs_write+0x94) +func                 -25+  
> > : 4.333N __ipipe_frozen_ctrl+0x14 (vfs_write+0xc4) +func                
> > : -21+   2.111N simple_strtol+0x10 (__ipipe_frozen_ctrl+0x9c) +func      
> > :           -18+   6.000N simple_strtoul+0x10 (simple_strtol+0x30) +func 
> > :                -12+   1.777N ipipe_trace_frozen_reset+0x10
> > : (__ipipe_frozen_ctrl+0xfc) +func                 -11+   2.777 
> > : __ipipe_global_path_lock+0x10 (ipipe_trace_frozen_reset+0x14)
> > :
> > :|   +begin   0x80000001    -8+   6.000N __ipipe_global_path_lock+0x30
> > :| (ipipe_trace_frozen_reset+0x14) +end     0x80000001    -2+   2.333N
> > :| __ipipe_global_path_unlock+0x68 (ipipe_trace_frozen_reset+0x68)
> >
> > <    +freeze  0xffffffff     0   97.444N __ipipe_frozen_ctrl+0x108
> > (vfs_write+0xc4)
>
> Hmm, takes quite a long time to complete the freeze though you only have
> 10 post-trace points (which defines its complexity). Unusual, also when
> comparing with other traced functions.

It seems that it doesn't depend on post-trace-points. When I reduce them to 2 
the value for the freeze does not get smaller. Maybe it has something to do 
with the following lines?

>
> >      +func                  97    3.222N do_PrefetchAbort+0x10
> > (ret_from_exception+0x0) +func                 100    2.333N
> > do_translation_fault+0x14 (do_PrefetchAbort+0x1c) +func                
> > 103    2.777N do_page_fault+0x14 (do_translation_fault+0x2c) +func       
> >          105    2.222N __down_read_trylock+0x10 (do_page_fault+0xbc)
> > +func                 108    1.888N __ipipe_test_and_stall_root+0x10
> > (__down_read_trylock+0x18)
> >
> >  |   +begin   0x80000001   109    1.888N __ipipe_test_and_stall_root+0x34
> >  | (__down_read_trylock+0x18) #end     0x80000001   111    2.111N
> >  | __ipipe_test_and_stall_root+0x4c (__down_read_trylock+0x18)
> >
> >      #func                 113    1.777N __ipipe_restore_root+0x10
> > (__down_read_trylock+0x4c) #func                 115    1.555N
> > __ipipe_unstall_root+0x10 (__ipipe_restore_root+0x24)
> >
> >  |   #begin   0x80000000   117    0.000N __ipipe_unstall_root+0x30
> >  | (__ipipe_restore_root+0x24)
>
> Jan

--
Sebastian

