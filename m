Message-ID: <475C6454.2090002@domain.hid>
Date: Sun, 09 Dec 2007 22:55:32 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <4757EBAE.4050608@domain.hid>	<2ff1a98a0712060513g3b056866x883691498daf00e1@domain.hid>	<4757F811.70905@domain.hid>	<2ff1a98a0712060528y13159abdwb83617a8744b3735@domain.hid>	<2ff1a98a0712060544x6e1e8c11q52e9417fb096e4b7@domain.hid>	<475801AA.3060300@domain.hid>	<2ff1a98a0712060621k436f32b7sc1d1cfe53bea8f18@domain.hid>	<475952CD.3020003@domain.hid>	<18265.47545.897637.377869@domain.hid>
	<18265.50385.343346.558000@domain.hid>
In-Reply-To: <18265.50385.343346.558000@domain.hid>
Content-Type: multipart/mixed; boundary="------------050606080709060407020705"
Subject: Re: [Xenomai-core] How to cancel a Xenomai POSIX thread
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------050606080709060407020705
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Gilles Chanteperdrix wrote:
> Gilles Chanteperdrix wrote:
>  > Wolfgang Grandegger wrote:
>  >  > Hi Gilles,
>  >  > 
>  >  > Gilles Chanteperdrix wrote:
>  >  > > On Dec 6, 2007 3:05 PM, Wolfgang Grandegger <wg@domain.hid> wrote:
>  >  > >> Gilles Chanteperdrix wrote:
>  >  > >>> On Dec 6, 2007 2:28 PM, Gilles Chanteperdrix
>  >  > >>> <gilles.chanteperdrix@xenomai.org> wrote:
>  >  > >>>> On Dec 6, 2007 2:24 PM, Wolfgang Grandegger <wg@domain.hid> wrote:
>  >  > >>>>> Gilles Chanteperdrix wrote:
>  >  > >>>>>> On Dec 6, 2007 1:31 PM, Wolfgang Grandegger <wg@domain.hid> wrote:
>  >  > >>>>>>> Hello,
>  >  > >>>>>>>
>  >  > >>>>>>> how do I cancel or delete a Xenomai POSIX thread running in primary
>  >  > >>>>>>> context from a higher priority thread? IIUC, pthread_kill() can only be
>  >  > >>>>>>> used in secondary context. I tried pthread_cancel(), but it only works
>  >  > >>>>>>> when hitting a cancelation point, e.g. pthread_testcancel(). Setting
>  >  > >>>>>>> pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS) did not help. Is
>  >  > >>>>>>> there a code snippet or even an example program showing how to cancel a
>  >  > >>>>>>> pthread in primary context?
>  >  > >>>>>> pthread_kill or pthread_cancel should result in sending a signal to
>  >  > >>>>>> the target thread, so should cause this thread to switch to secondary
>  >  > >>>>>> mode to handle it. If you want to wait for the target thread to be
>  >  > >>>>>> canceled, you should use pthread_cancel and pthread_join.
>  >  > >>>>> There is no way to cancel a pthread in primary mode from another pthread?
>  >  > >>>> No. You always need secondary mode to effectively delete a thread. The
>  >  > >>>> same goes for the native skin.
>  >  > >>> Ok. I understand what you mean. You want pthread_cancel not to leave
>  >  > >>> primary mode. This can easily be done by causing pthread_cancel to use
>  >  > >>> the kernel-space real-time pthread_cancel service. This should work
>  >  > >>> with no further modification.
>  >  > >> I want to cancel/delete a task running in primary mode, e.g.
>  >  > >>
>  >  > >>   void* work_task(void* dummy)
>  >  > >>   {
>  >  > >>         int count = 0;
>  >  > >>         while (1)
>  >  > >>                 count++;
>  >  > >>   }
>  >  > >>
>  >  > >> from the outside (= another higher priority task). How can I use the
>  >  > >> kernel-space real-time pthread_cancel service? My POSIX app is runs in
>  >  > >> user-land.
>  >  > > 
>  >  > > I was thinking about adding a pthread_cancel syscall that would have
>  >  > > triggered the kernel-space pthread_cancel. But this will not work:
>  >  > > user-space cleanup handlers would no longer get executed. However,
>  >  > > this can work for pthread_kill. Here is a patch which adds the
>  >  > > pthread_kill syscall.
>  >  > 
>  >  > Great, thanks a lot. This seems to work but I'm now fiddling with proper
>  >  > cleanup and exit. I have attached my small test program. It behaves
>  >  > somehow strange, at least to me:
>  >  > 
>  >  > - I see task period overruns when the low prio task is started. I
>  >  >   suspect some switch to secondary mode in init_task().
>  >  > 
>  >  > - The program/system hangs after the listed messages:
>  >  > 
>  >  >   # ./kill_pthread
>  >  >   Starting high_prio_task
>  >  >   Killed low_prio task: count=3813129, overruns=0
>  >  > 
>  >  > Any idea what I'm doing wrong?
>  >  > 
>  >  > This is with Linux 2.4.25 and Xenomai 2.3.x on a MPC5200 board.
>  > 
>  > Your test runs fine with Xenomai trunk (on ARM). I will now try with
>  > current state of the v2.3.x branch.
> 
> Works with v2.3.x too.

I re-activated my test PC running Linux 2.6.20.21. with Xenomai 2.3.x.
There the program runs fine _without_ your pthread_kill patch. For some
reason the low_prio_task() is running in secondary mode (do you know
why? Is there a function to check the mode?). I added

        struct sched_param  param = { .sched_priority = LOW_PRIO };
        pthread_setschedparam(pthread_self(), SCHED_FIFO, &param);

to the head of that function and then I get:

  ./kill_pthread
  Starting high_prio_task
  BUG: NMI Watchdog detected LOCKUP
  Killed low_prio task: count=1588495996, overruns=0
  Exiting main

I have attached the corresponding oops in case it's of interest.
Unfortunately, with your patch and adding the function
__real_pthread_kill() to wrappers.c, the behavior is the same. I'm going
to repeat the tests with Xenomai trunk tomorrow.

Wolfgang.


--------------050606080709060407020705
Content-Type: text/x-log;
 name="oops.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oops.log"

BUG: NMI Watchdog detected LOCKUP<0>------------[ cut here ]------------
kernel BUG at kernel/ipipe/core.c:207!
invalid opcode: 0000 [#1]
PREEMPT 
Modules linked in: nfs lockd nfs_acl ipv6 autofs4 sunrpc dm_mod video sbs i2c_ec
 dock container button battery ac uhci_hcd parport_pc parport via686a hwmon i2c_
isa i2c_core snd_via82xx gameport snd_ac97_codec ac97_bus snd_seq_dummy snd_seq_
oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_p
age_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore 8139cp 8139to
o mii floppy ide_cd cdrom ext3 jbd
CPU:    0
EIP:    0060:[<c013fe91>]    Not tainted VLI
EFLAGS: 00010006   (2.6.20.21 #1)
EIP is at __ipipe_restore_root+0xc/0x22
eax: 00000001   ebx: c03c94a0   ecx: 00000001   edx: 00000004
esi: 00003533   edi: 00003554   ebp: 00003554   esp: db88ae48
ds: 007b   es: 007b   ss: 0068
Process kill_pthread (pid: 2507, ti=db88a000 task=df854250 task.ti=db88a000)
Stack: c0117f66 00003533 c0459660 00003533 c01185b4 00000400 00000000 ffffffdc 
       ffffffff db88afb8 c0439244 00000024 c0118bb4 db88af20 00000000 00000003 
       00000200 00000200 c047c650 c03165e6 dbfbdf20 c047c650 c047c650 c031656a 
Call Trace:
 [<c0117f66>] __call_console_drivers+0x42/0x4d
 [<c01185b4>] release_console_sem+0x141/0x1c2
 [<c0118bb4>] vprintk+0x28d/0x2fd
 [<c03165e6>] _spin_unlock_irqrestore+0x22/0x38
 [<c031656a>] _spin_unlock+0xf/0x23
 [<c014afab>] schedule_event+0x27c/0x2fb
 [<c0144ab3>] xnpod_renice_thread_inner+0x8a/0xcf
 [<c0118c70>] printk+0x4c/0xb5
 [<c0316d81>] die_nmi+0x6b/0xe6
 [<c03171a3>] default_nmi_watchdog_tick+0xda/0x1ba
 [<c0316e8d>] do_nmi+0x91/0x24e
 [<c013d7ba>] __ipipe_ack_level_irq+0x12/0x22
 [<c03168df>] nmi_stack_correct+0x26/0x2b
 =======================
Code: 0b eb fe fa 0f ba 35 80 46 3b c0 00 83 3d 84 46 3b c0 00 74 08 83 c8 ff e8
 fa f7 ff ff fb c3 81 3d 68 46 3b c0 80 05 48 c0 74 04 <0f> 0b eb fe 85 c0 74 09
 0f ba 2d 80 46 3b c0 00 c3 e9 b2 ff ff 
EIP: [<c013fe91>] __ipipe_restore_root+0xc/0x22 SS:ESP 0068:db88ae48
 <6>note: kill_pthread[2507] exited with preempt_count 2
BUG: sleeping function called from invalid context at mm/slab.c:3034
in_atomic():1, irqs_disabled():0
 [<c017bd85>] kmem_cache_zalloc+0x1b/0x92
 [<c0140725>] taskstats_exit+0x43/0x273
 [<c011a02b>] do_exit+0x1e0/0x75a
 [<c010445a>] die+0x1e9/0x1f1
 [<c0104820>] do_invalid_op+0xa2/0xab
 [<c013fe91>] __ipipe_restore_root+0xc/0x22
 [<c014713d>] xnpod_fault_handler+0x11b/0x123
 [<c0144343>] xnpod_trap_fault+0x2b/0x31
 [<c0142b70>] xnarch_trap_fault+0x0/0x1c
 [<c0142b88>] xnarch_trap_fault+0x18/0x1c
 [<c02b4542>] exception_event+0x25/0x34
 [<c01109e3>] __ipipe_handle_exception+0x124/0x163
 [<c031680d>] error_code+0x79/0x88
 [<c013fe91>] __ipipe_restore_root+0xc/0x22
 [<c0117f66>] __call_console_drivers+0x42/0x4d
 [<c01185b4>] release_console_sem+0x141/0x1c2
 [<c0118bb4>] vprintk+0x28d/0x2fd
 [<c03165e6>] _spin_unlock_irqrestore+0x22/0x38
 [<c031656a>] _spin_unlock+0xf/0x23
 [<c014afab>] schedule_event+0x27c/0x2fb
 [<c0144ab3>] xnpod_renice_thread_inner+0x8a/0xcf
 [<c0118c70>] printk+0x4c/0xb5
 [<c0316d81>] die_nmi+0x6b/0xe6
 [<c03171a3>] default_nmi_watchdog_tick+0xda/0x1ba
 [<c0316e8d>] do_nmi+0x91/0x24e
 [<c013d7ba>] __ipipe_ack_level_irq+0x12/0x22
 [<c03168df>] nmi_stack_correct+0x26/0x2b
 =======================
Xenomai: POSIX: destroyed thread c16e0610


--------------050606080709060407020705--

