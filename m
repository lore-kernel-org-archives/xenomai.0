Date: Mon, 30 Jun 2014 14:37:04 +0200
From: Arnaud Degroote <arnaud.degroote@isae.fr>
Message-ID: <20140630123704.GA32240@dmia-degroote.isae.fr>
References: <20140626111949.GA4486@dmia-degroote.isae.fr>
 <53AC5810.7040806@xenomai.org>
 <20140627072229.GA14771@dmia-degroote.isae.fr>
 <53AD9B7F.5030701@xenomai.org>
 <20140630082620.GA3314@dmia-degroote.isae.fr>
 <53B126EE.6020306@xenomai.org>
 <20140630091310.GA4019@dmia-degroote.isae.fr>
 <53B13914.2010706@xenomai.org>
 <20140630120135.GA4552@dmia-degroote.isae.fr>
 <53B1531F.4040504@xenomai.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <53B1531F.4040504@xenomai.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Support of Beagleboard xm rev C on 3.14-ipipe
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

On 30/Jun - 14:07, Gilles Chanteperdrix wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 06/30/2014 02:01 PM, Arnaud Degroote wrote:
> > On 30/Jun - 12:16, Gilles Chanteperdrix wrote:
> >> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
> >> 
> >> On 06/30/2014 11:13 AM, Arnaud Degroote wrote:
> >>> On 30/Jun - 10:59, Gilles Chanteperdrix wrote:
> >>>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
> >>>> 
> >>>> On 06/30/2014 10:26 AM, Arnaud Degroote wrote:
> >>>>> On 27/Jun - 18:27, Gilles Chanteperdrix wrote:
> >>>>>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
> >>>>>> 
> >>>>>> On 06/27/2014 09:22 AM, Arnaud Degroote wrote:
> >>>>>>> On 26/Jun - 19:27, Gilles Chanteperdrix wrote:
> >>>>>>>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
> >>>>>>>> 
> >>>>>>>> On 06/26/2014 01:19 PM, Arnaud Degroote wrote:
> >>>>>>>>> On 26/Jun - 13:08, Gilles Chanteperdrix wrote:
> >>>>>>>>>> switchtest is another story. Does switchtest
> >>>>>>>>>> hang, or does the system completely freeze?
> >>>>>>>>> 
> >>>>>>>>> switchtest hangs, but the system is still
> >>>>>>>>> responsive. I can ctrl-c it and restart it. On C-c,
> >>>>>>>>> it prints "properly" a number of ctx switches done
> >>>>>>>>> (which is far from other "normal" values).
> >>>>>>>>> 
> >>>>>>>> You mean it is as if switchtest had continued
> >>>>>>>> switching contexts but had not printed anything? Do
> >>>>>>>> you see counters incrementing in /proc/xenomai/stat
> >>>>>>>> ?
> >>>>>>> 
> >>>>>>> I just meant that switchtest seems to respond properly
> >>>>>>> to C-c, even if it does not progress. But counters from
> >>>>>>>  /proc/xenomai/stat stops incrementing at some point.
> >>>>>>> 
> >>>>> 
> >>>>> Related to my previous mail, I'm able to reduce threadspec
> >>>>> to
> >>>>> 
> >>>>> rtk0 rtk0  rtup0
> >>>>> 
> >>>>> or
> >>>>> 
> >>>>> rtk0  rtup0 rtup0
> >>>>> 
> >>>>> Both demonstrates some quick hang. Other pattern may block
> >>>>> too, I don't try the full combinatorial.
> >>>>> 
> >>>> Could you test rtk0 alone?
> >>>> 
> >>>> It would mean there is an issue with the context switch. Are
> >>>> you running with the xenomai git?
> >>> 
> >>> It fails with 'rtk0 rtk0 rtk0' (really quickly). With 'rtk0
> >>> rtk0' it seems to work.
> >>> 
> >>> I'm using xenomai-2.6 git 
> >>> (4eb593df1eb89a47f1bc3423cea44c345d22ee3e).
> >>> 
> >> Ok, I just tested your configuration on my omap3 board, and
> >> despite the config having a lot of stuff enabled that you
> >> probably do not want, and may even cause issues (like memory
> >> compaction), I did not observe any problem. I only had to enable
> >> CONFIG_PINCTRL_SINGLE to have the serial console.
> > 
> > I can also confirm that the image (kernel + userland) works
> > perfectly on my gumstix overo (I just changed uboot).
> > 
> > CPU: ARMv7 Processor [411fc083] revision 3 (ARMv7), cr=10c53c7d 
> > Machine: Gumstix Overo OMAP3430/3530 ES3.1 (l2cache iva sgx neon
> > isp )
> > 
> > 
> > (except the two oops described previously in this tread).
> 
> Which two oops?


While running xddp_test:

[  122.886107] I-pipe: Detected stalled head domain, probably caused by a b=
ug.
[  122.886107]         A critical section may have been left unterminated.
[  122.900385] CPU: 0 PID: 447 Comm: xddp_test Not tainted 3.14.0-ipipe-tes=
t10 #1
[  122.907967] Backtrace:=20
[  122.910578] [<c0011a50>] (dump_backtrace) from [<c0011d04>] (show_stack+=
0x18/0x1c)
[  122.918524]  r6:c0da1b3c r5:c0d724c0 r4:c0d724c0 r3:00404140
[  122.924513] [<c0011cec>] (show_stack) from [<c06a83a4>] (dump_stack+0x20=
/0x28)
[  122.932108] [<c06a8384>] (dump_stack) from [<c0092344>] (ipipe_root_only=
+0x7c/0x94)
[  122.940154] [<c00922c8>] (ipipe_root_only) from [<c00930cc>] (ipipe_unst=
all_root+0x14/0x40)
[  122.948917]  r5:ddd3ded0 r4:ddd3da00
[  122.952696] [<c00930b8>] (ipipe_unstall_root) from [<c006517c>] (debug_c=
heck_no_locks_freed+0x10c/0x148)
[  122.962655] [<c0065070>] (debug_check_no_locks_freed) from [<c00668f0>] =
(__raw_spin_lock_init+0x20/0x58)
[  122.972602]  r8:c090f658 r7:00000000 r6:c09499c0 r5:c07fb84c r4:c0da1b3c
[  122.979694] [<c00668d0>] (__raw_spin_lock_init) from [<c005e894>] (__ini=
t_waitqueue_head+0x24/0x50)
[  122.989188]  r6:c0802591 r5:c0da45b8 r4:c0da1b3c r3:00000005
[  122.995180] [<c005e870>] (__init_waitqueue_head) from [<c00e3fcc>] (xnpi=
pe_open+0x248/0x3670)
[  123.004126]  r6:c09121d8 r5:00000000 r4:00000000 r3:00000005
[  123.010116] [<c00e3d84>] (xnpipe_open) from [<c01a6158>] (chrdev_open+0x=
144/0x170)
[  123.018060]  r10:ddcf2d80 r9:ddc22508 r8:ddc22500 r7:00000000 r6:df5f279=
8 r5:c09127ec
[  123.026320]  r4:df66ee00
[  123.028996] [<c01a6014>] (chrdev_open) from [<c01a0734>] (do_dentry_open=
+0x27c/0x290)
[  123.037216]  r8:c01a6014 r7:00000000 r6:df5f28a8 r5:df5f2798 r4:ddc22500
[  123.044299] [<c01a04b8>] (do_dentry_open) from [<c01a0acc>] (finish_open=
+0x40/0x54)
[  123.052335]  r10:def2fe84 r9:def2e000 r8:ddc22500 r7:00000000 r6:def2fe8=
8 r5:ddc22500
[  123.060597]  r4:def2fe84 r3:ddd3da00
[  123.064377] [<c01a0a8c>] (finish_open) from [<c01aec54>] (do_last.isra.3=
5+0x868/0xac8)
[  123.072685]  r4:def2fed0 r3:def2fe84
[  123.076461] [<c01ae3ec>] (do_last.isra.35) from [<c01af0cc>] (path_opena=
t+0x218/0x5c4)
[  123.084770]  r10:00000000 r9:def2e000 r8:ffffff9c r7:deed9000 r6:def2ff5=
c r5:ddc22500
[  123.093031]  r4:def2fed0
[  123.095704] [<c01aeeb4>] (path_openat) from [<c01b0220>] (do_filp_open+0=
x34/0x80)
[  123.103557]  r10:00000000 r9:def2e000 r8:c000e24c r7:ffffff9c r6:deed900=
0 r5:00000001
[  123.111819]  r4:def2ff5c
[  123.114492] [<c01b01ec>] (do_filp_open) from [<c01a1b78>] (do_sys_open+0=
x128/0x1c8)
[  123.122527]  r7:ffffff9c r6:deed9000 r5:00000003 r4:00000002
[  123.128508] [<c01a1a50>] (do_sys_open) from [<c01a1c40>] (SyS_open+0x28/=
0x2c)
[  123.135998]  r9:def2e000 r8:c000e24c r7:00000005 r6:00000002 r5:46a11850=
 r4:ffffffed
[  123.144177] [<c01a1c18>] (SyS_open) from [<c000e060>] (ret_fast_syscall+=
0x0/0x34)
[  123.152234] ------------[ cut here ]------------
[  123.157094] WARNING: CPU: 0 PID: 447 at include/linux/ipipe.h:225 xnpipe=
_open+0x9d8/0x3670()
[  123.165975] Modules linked in:
[  123.169230] CPU: 0 PID: 447 Comm: xddp_test Not tainted 3.14.0-ipipe-tes=
t10 #1
[  123.176807] Backtrace:=20
[  123.179436] [<c0011a50>] (dump_backtrace) from [<c0011d04>] (show_stack+=
0x18/0x1c)
[  123.187395]  r6:c0800830 r5:00000009 r4:00000000 r3:00404140
[  123.193417] [<c0011cec>] (show_stack) from [<c06a83a4>] (dump_stack+0x20=
/0x28)
[  123.201050] [<c06a8384>] (dump_stack) from [<c0035294>] (warn_slowpath_c=
ommon+0x6c/0x8c)
[  123.209583] [<c0035228>] (warn_slowpath_common) from [<c0035358>] (warn_=
slowpath_null+0x24/0x2c)
[  123.218839]  r8:c090f658 r7:00000000 r6:c09121d8 r5:00000000 r4:c0945d72
[  123.225926] [<c0035334>] (warn_slowpath_null) from [<c00e475c>] (xnpipe_=
open+0x9d8/0x3670)
[  123.234648] [<c00e3d84>] (xnpipe_open) from [<c01a6158>] (chrdev_open+0x=
144/0x170)
[  123.242628]  r10:ddcf2d80 r9:ddc22508 r8:ddc22500 r7:00000000 r6:df5f279=
8 r5:c09127ec
[  123.250936]  r4:df66ee00
[  123.253638] [<c01a6014>] (chrdev_open) from [<c01a0734>] (do_dentry_open=
+0x27c/0x290)
[  123.261890]  r8:c01a6014 r7:00000000 r6:df5f28a8 r5:df5f2798 r4:ddc22500
[  123.269011] [<c01a04b8>] (do_dentry_open) from [<c01a0acc>] (finish_open=
+0x40/0x54)
[  123.277047]  r10:def2fe84 r9:def2e000 r8:ddc22500 r7:00000000 r6:def2fe8=
8 r5:ddc22500
[  123.285336]  r4:def2fe84 r3:ddd3da00
[  123.289158] [<c01a0a8c>] (finish_open) from [<c01aec54>] (do_last.isra.3=
5+0x868/0xac8)
[  123.297478]  r4:def2fed0 r3:def2fe84
[  123.301289] [<c01ae3ec>] (do_last.isra.35) from [<c01af0cc>] (path_opena=
t+0x218/0x5c4)
[  123.309627]  r10:00000000 r9:def2e000 r8:ffffff9c r7:deed9000 r6:def2ff5=
c r5:ddc22500
[  123.317906]  r4:def2fed0
[  123.320619] [<c01aeeb4>] (path_openat) from [<c01b0220>] (do_filp_open+0=
x34/0x80)
[  123.328481]  r10:00000000 r9:def2e000 r8:c000e24c r7:ffffff9c r6:deed900=
0 r5:00000001
[  123.336779]  r4:def2ff5c
[  123.339484] [<c01b01ec>] (do_filp_open) from [<c01a1b78>] (do_sys_open+0=
x128/0x1c8)
[  123.347531]  r7:ffffff9c r6:deed9000 r5:00000003 r4:00000002
[  123.353547] [<c01a1a50>] (do_sys_open) from [<c01a1c40>] (SyS_open+0x28/=
0x2c)
[  123.361079]  r9:def2e000 r8:c000e24c r7:00000005 r6:00000002 r5:46a11850=
 r4:ffffffed
[  123.369309] [<c01a1c18>] (SyS_open) from [<c000e060>] (ret_fast_syscall+=
0x0/0x34)
[  123.377168] ---[ end trace 9b79eac32dc108ef ]---


and in sigdebug 

++ /usr/bin/regression/native/sigdebug
mayday page starting at 0xb6f01000 [/dev/rtheap]
mayday code: 0c 00 9f e5 0c 70 9f e5 00 00 00 ef 00 00 a0 e3 00 00 80 e5 2b=
 02 00 0a 42 00 0f 00 08 00 81 51
mlockall
[  126.998544] Xenomai: registered exported object prio_invert (mutexes)
[  127.006756] Xenomai: registered exported object send_signal (semaphores)
[  127.017474] Xenomai: Switching rt_task to secondary mode after exception=
 #0 from user-space at 0x9a6c (pid 458)
syscall
signal
relaxed mutex owner
page fault
watc[  128.971704] Xenomai: watchdog triggered -- signaling runaway thread =
'rt_task'
hdog
[  129.978744] [sched_delayed] sched: RT throttling activated
[  130.708979] Xenomai: unregistered exported object prio_invert (mutexes)
[  130.715988] Xenomai: unregistered exported object send_signal (semaphore=
s)
[  130.723214] ------------[ cut here ]------------
[  130.728085] WARNING: CPU: 0 PID: 456 at include/linux/ipipe.h:225 xnregi=
stry_remove+0x960/0x228c()
[  130.737485] Modules linked in:
[  130.740707] CPU: 0 PID: 456 Comm: main_task Tainted: G        W    3.14.=
0-ipipe-test10 #1
[  130.749287] Backtrace:=20
[  130.751886] [<c0011a50>] (dump_backtrace) from [<c0011d04>] (show_stack+=
0x18/0x1c)
[  130.759830]  r6:c0800830 r5:00000009 r4:00000000 r3:00404100
[  130.765821] [<c0011cec>] (show_stack) from [<c06a83a4>] (dump_stack+0x20=
/0x28)
[  130.773412] [<c06a8384>] (dump_stack) from [<c0035294>] (warn_slowpath_c=
ommon+0x6c/0x8c)
[  130.781912] [<c0035228>] (warn_slowpath_common) from [<c0035358>] (warn_=
slowpath_null+0x24/0x2c)
[  130.791128]  r8:df70438c r7:00000003 r6:00000000 r5:c0945d6b r4:00000001
[  130.798212] [<c0035334>] (warn_slowpath_null) from [<c00b8cbc>] (xnregis=
try_remove+0x960/0x228c)
[  130.807451] [<c00b835c>] (xnregistry_remove) from [<c010dd50>] (rt_sem_d=
elete+0x20c/0x7f8)
[  130.816122]  r10:c090f658 r9:ddc7c9d0 r8:00000001 r7:e0872900 r6:c09121d=
8 r5:00000000
[  130.824384]  r4:00000000
[  130.827058] [<c010db44>] (rt_sem_delete) from [<c00fe084>] (__rt_sem_del=
ete+0x68/0xa0)
[  130.835369]  r10:00000000 r9:00000000 r8:defd7fb0 r7:000000f8 r6:c0da118=
c r5:e0872900
[  130.843633]  r4:e0872010
[  130.846316] [<c00fe01c>] (__rt_sem_delete) from [<c00d8fd0>] (hisyscall_=
event+0x1a0/0x340)
[  130.854988]  r5:ddd3c800 r4:e0872010
[  130.858771] [<c00d8e30>] (hisyscall_event) from [<c00944c4>] (ipipe_sysc=
all_hook+0x3c/0x48)
[  130.867535]  r10:c0d84e40 r9:c090f658 r8:c090f658 r7:c0d84e40 r6:0000119=
c r5:c0d84e40
[  130.875795]  r4:c09107f8
[  130.878471] [<c0094488>] (ipipe_syscall_hook) from [<c0092c58>] (__ipipe=
_notify_syscall+0x80/0x10c)
[  130.887979] [<c0092bd8>] (__ipipe_notify_syscall) from [<c0016790>] (__i=
pipe_syscall_root+0x8c/0x110)
[  130.897655]  r10:00000000 r9:ffffbf40 r8:00000000 r7:000f0042 r6:ddd3c80=
0 r5:00000000
[  130.905912]  r4:defd7fb0
[  130.908587] [<c0016704>] (__ipipe_syscall_root) from [<c000e19c>] (local=
_restart+0xc/0x64)
[  130.917257]  r9:ffffbf40 r8:c000e24c r7:000f0042 r6:b6ef96e0 r5:00000000=
 r4:00000000
[  130.925426] ---[ end trace 9b79eac32dc108f0 ]---
> 
> > 
> > So, it may be related to this specific board ?
> > 
> > CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=10c53c7d 
> > Machine: OMAP3 Beagle Board OMAP3630 ES1.2 (l2cache iva sgx neon
> > isp 192mhz_clk )
> 
> Have you checked that the exact same kernel configuration, only
> without CONFIG_IPIPE and CONFIG_XENOMAI runs correctly under load?

The system seems to hang even without CONFIG_IPIPE. The linux-yocto
kernel seems to work properly (it looks like a 3.14rc8), I will check
precisely against linux kernel v3.14.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140630/cf3a2551/attachment.sig>
