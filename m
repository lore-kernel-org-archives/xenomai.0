MIME-Version: 1.0
In-Reply-To: <20160307123239.531fabe6@md1em3qc>
References: <CANBp=-hcC5DHb=HpMzqbewQswwwh-dF-+i+DoOd6KRHoXbv2qw@mail.gmail.com>
 <CANBp=-iWByct=fMOPB6u8PrS10h2M0w9MbaOGrJAvfGqsjCVCw@mail.gmail.com>
 <20160307123239.531fabe6@md1em3qc>
From: Michele Belotti <miki.belotti@gmail.com>
Date: Tue, 8 Mar 2016 09:50:40 +0100
Message-ID: <CANBp=-jK0K=v2htYrximqXtgqZxZrF9oVHJK-dNCsGxGBPh2KA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Fwd: Latency test fails. Problem during installation
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henning Schild <henning.schild@siemens.com>, gilles.chanteperdrix@xenomai.org, rpm@xenomai.org
Cc: xenomai@xenomai.org

Hello everybody, many thanks for the prompt support.
I have tested yesterday the latest version of 2.6 branch but it does not
help.

The kernel I'm using is the v3.10.32 and I try ipipe 4 and 7 without any
improvement.
The latency is around 100 ns and always start with a max value of 30 and it
degenerates during time.


The worst case trace is hereafter obtaind with latency -f

I-pipe worst-case tracing service on 3.10.32_xenomai-2.6_20160224_1/ipipe
release #4
-------------------------------------------------------------
CPU: 0, Begin: 357409893008 cycles, Trace Points: 12 (-10/+1), Length:
31523 us
Calibrated minimum trace-point overhead: 0.078 us

 +----- Hard IRQs ('|': locked)
 |+-- Xenomai
 ||+- Linux ('*': domain stalled, '+': current, '#': current+stalled)
 |||                      +---------- Delay flag ('+': > 1 us, '!': > 10 us)
 |||                      |        +- NMI noise ('N')
 |||                      |        |
          Type    User Val.   Time    Delay  Function (Parent)
 |   #begin   0x80000000  -143    0.123  ipipe_unstall_root+0x1c
(_raw_spin_unlock_irq+0x11)
 |   #func                -143    0.185  ipipe_root_only+0x0
(ipipe_unstall_root+0x21)
 |   +end     0x80000000  -143    0.114  ipipe_trace_end+0x19
(ipipe_unstall_root+0x59)
     +func                -143    0.123  sub_preempt_count+0x0
(_raw_spin_unlock_irq+0x1b)
     +func                -142    0.141  add_preempt_count+0x0
(cpu_stopper_thread+0x97)
     +func                -142    0.134  stop_machine_cpu_stop+0x0
(cpu_stopper_thread+0x9d)
 |   +begin   0x80000001  -142    0.160  debug_smp_processor_id+0x3f
(stop_machine_cpu_stop+0x1a)
 |   +end     0x80000001  -142  142.114  ipipe_trace_end+0x19
(debug_smp_processor_id+0x76)
     #func                   0    0.235  mtrr_rendezvous_handler+0x0
(stop_machine_cpu_stop+0xe6)
     #func                   0    0.174  generic_set_mtrr+0x0
(mtrr_rendezvous_handler+0x67)
>|   #begin   0x80000001     0    0.132  generic_set_mtrr+0x1af
(mtrr_rendezvous_handler+0x67)
:|   #func                   0    0.137  prepare_set+0x0
(generic_set_mtrr+0x80)
:|   #func                   0    0.131  _raw_spin_lock+0x0
(prepare_set+0x15)
:|   #func                   0! 30160.710  add_preempt_count+0x0
(_raw_spin_lock+0x17)
:|   #func               30161! 1072.522  mtrr_wrmsr+0x0 (prepare_set+0x7a)
:|   #func               31233!  77.451  mtrr_wrmsr+0x0
(generic_set_mtrr+0x149)
:|   #func               31311!  76.539  mtrr_wrmsr+0x0
(generic_set_mtrr+0x160)
:|   #func               31387!  78.262  post_set+0x0
(generic_set_mtrr+0x165)
:|   #func               31465!  55.673  mtrr_wrmsr+0x0 (post_set+0x25)
:|   #func               31521+   1.141  _raw_spin_unlock+0x0
(post_set+0x52)
:|   #func               31522    0.496  sub_preempt_count+0x0
(_raw_spin_unlock+0x16)
<|   #end     0x80000001 31523    0.829  ipipe_trace_end+0x19
(generic_set_mtrr+0x17a)
 |   #begin   0x000000ef 31524    0.000  apic_timer_interrupt+0x6d
(generic_set_mtrr+0xc2)


The dynamic parameters used are
BOOT_IMAGE=/boot/vmlinuz-3.10.32_xenomai-2.6_20160224_1
root=UUID=2e4bd84d-b2ce-4ac9-8b10-377b2fa26437 ro crashkernel=auto rhgb
quiet LANG=en_US.UTF-8 systemd.debug ro xeno_nucleus.xenomai_gid=1001


I also verify that the ACPI is disables and Hyperthreading is desactivated.
About the Smi workaround what you intend that some message are triggered?
Warning disappears and I can see that the message

Xenomai: SMI workaround failed!

is not present. I guess that it is not working. But what I need to do
in the kernel ?


Many thanks

Michele




>
