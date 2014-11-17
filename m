Date: Mon, 17 Nov 2014 22:54:58 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141117215458.GM31920@sisyphus.hd.free.fr>
References: <20141001142416.GA4435@csclub.uwaterloo.ca>
 <20141107182600.GS24110@csclub.uwaterloo.ca>
 <545D12D2.2020104@xenomai.org>
 <20141117191237.GS24110@csclub.uwaterloo.ca>
 <20141117201435.GH31920@sisyphus.hd.free.fr>
 <20141117202425.GU24110@csclub.uwaterloo.ca>
 <20141117202754.GI31920@sisyphus.hd.free.fr>
 <20141117214734.GW24110@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141117214734.GW24110@csclub.uwaterloo.ca>
Subject: Re: [Xenomai] I-pipe error when requesting irq that is on omap gpio
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: xenomai@xenomai.org

On Mon, Nov 17, 2014 at 04:47:34PM -0500, Lennart Sorensen wrote:
> On Mon, Nov 17, 2014 at 09:27:54PM +0100, Gilles Chanteperdrix wrote:
> > On Mon, Nov 17, 2014 at 03:24:25PM -0500, Lennart Sorensen wrote:
> > > On Mon, Nov 17, 2014 at 09:14:35PM +0100, Gilles Chanteperdrix wrote:
> > > > Well, have you tried triggering an I-pipe tracer trace to see what
> > > > happens in the interval?
> > > 
> > > I have never used the tracer. I suppose I should learn how.
> > 
> > It is not very complicated. I have already been told on this list
> > that it was not well documented. I do not think so, but I let you
> > judge of that.
> > 
> > http://xenomai.org/2014/06/using-the-i-pipe-tracer/
> 
> So here is what I got triggering a couple of times on the IRQ.  Not
> entirely sure how to make sense of it, although there is one huge number.
> 
> back_trace_points:100
> enable:1
> frozen:I-pipe frozen back-tracing service on 3.12-1-am5726/ipipe release #2
> frozen:------------------------------------------------------------
> frozen:CPU: 0, Freeze: 2415647132 cycles, Trace Points: 100 (+10)
> frozen:Calibrated minimum trace-point overhead: 0.428 us
> frozen: +----- Hard IRQs ('|': locked)
> frozen: |+-- Xenomai
> frozen: ||+- Linux ('*': domain stalled, '+': current, '#': current+stalled)
> frozen: |||			  +---------- Delay flag ('+': > 1 us, '!': > 10 us)
> frozen: |||			  |	   +- NMI noise ('N')
> frozen: |||			  |	   |
> frozen:	  Type	  User Val.   Time    Delay  Function (Parent)
> frozen::    #func                -662	  0.857  arch_cpu_idle_enter+0x10 (cpu_startup_entry+0xb8)
> frozen::    #func                -661	  1.000  ledtrig_cpu+0x10 (arch_cpu_idle_enter+0x1c)
> frozen::    #func                -660	  1.000  led_trigger_event+0x10 (ledtrig_cpu+0x58)
> frozen::    #func                -659+   1.285  _raw_read_lock+0x10 (led_trigger_event+0x30)
> frozen::    #func                -658	  0.857  tick_check_broadcast_expired+0x10 (cpu_startup_entry+0x40)
> frozen::    #func                -657	  1.000  rcu_idle_enter+0x10 (cpu_startup_entry+0x58)
> frozen::    #func                -656	  0.857  ipipe_test_and_stall_root+0x10 (rcu_idle_enter+0x18)
> frozen::    #func                -655	  0.857  ipipe_root_only+0x14 (ipipe_test_and_stall_root+0x18)
> frozen::|   #begin   0x80000001  -654+   1.428  ipipe_root_only+0xb8 (ipipe_test_and_stall_root+0x18)
> frozen::|   #end     0x80000001  -653	  1.000  ipipe_root_only+0xa4 (ipipe_test_and_stall_root+0x18)
> frozen::|   #begin   0x80000001  -652	  1.000  ipipe_test_and_stall_root+0x84 (rcu_idle_enter+0x18)
> frozen::|   #end     0x80000001  -651	  1.000  ipipe_test_and_stall_root+0x70 (rcu_idle_enter+0x18)
> frozen::    #func                -650	  1.000  rcu_eqs_enter_common.isra.47+0x14 (rcu_idle_enter+0x84)
> frozen::    #func                -649	  1.000  arch_cpu_idle+0x10 (cpu_startup_entry+0x5c)
> frozen::|   #begin   0x80000000  -648	  1.000  arch_cpu_idle+0xa4 (cpu_startup_entry+0x5c)
> frozen::|   +func                -647! 555.142 omap_default_idle+0x10 (arch_cpu_idle+0x90)      <-- What ever is
> that?  That looks huge.

As the name suggests, it means that the CPU remains idle for 500us.
You know, when the cpu load is not 100%, this is what the cpu is
doing the rest of the time, executing the wfi instruction to wait
for the next interrupt.

> frozen::|   +end     0x80000000   -92+   1.142 omap_default_idle+0x40 (arch_cpu_idle+0x90)
  (...)
> frozen::|  +*func                  -6	  0.857  gic_handle_irq+0x10 (__irq_svc+0x58)
> frozen::|  +*func                  -6	  1.000  irq_find_mapping+0x14 (gic_handle_irq+0x30)
> frozen::|  +*func                  -5	  0.857  __ipipe_grab_irq+0x10 (gic_handle_irq+0x38)
> frozen::|  +*begin   0x00000043    -4	  1.000  __ipipe_grab_irq+0x50 (gic_handle_irq+0x38)
> frozen::|  +*func                  -3	  0.857  __ipipe_dispatch_irq+0x14 (__ipipe_grab_irq+0x74)
> frozen::|  +*func                  -2	  1.000  irq_to_desc+0x10 (__ipipe_dispatch_irq+0xd4)
> frozen::|  +*func                  -1+   1.285  irq_to_desc+0x10 (__ipipe_dispatch_irq+0xe4)
> frozen:<|  +*func                   0	  1.142  gpio_irq_handler+0x14 (__ipipe_dispatch_irq+0x70)
> frozen: |  +*func                   1	  1.571  irq_to_desc+0x10 (gpio_irq_handler+0x38)
> frozen: |  +*func                   2	  1.000  irq_find_mapping+0x14 (gpio_irq_handler+0x190)
> frozen: |  +*begin   0x0000018e     3	  0.857  gpio_irq_handler+0x198 (__ipipe_dispatch_irq+0x70)
> frozen: |  +*func                   4	  0.857  __ipipe_dispatch_irq+0x14 (gpio_irq_handler+0x1a4)
> frozen: |  +*func                   5	  1.000  irq_to_desc+0x10 (__ipipe_dispatch_irq+0xd4)
> frozen: |  +*func                   6	  1.142  irq_to_desc+0x10 (__ipipe_dispatch_irq+0xe4)
> frozen: |  +*func                   7	  1.142  __ipipe_ack_level_irq+0x10 (__ipipe_dispatch_irq+0x70)
> frozen: |  +*func                   8	  0.857  gpio_mask_ack_irq+0x10 (__ipipe_ack_level_irq+0x30)
> frozen: |  +*func                   9	  3.428  __ipipe_spin_lock_irqsave+0x10 (gpio_mask_ack_irq+0x30)
> frozen: |  #*func                  13	  0.000
> __ipipe_spin_unlock_irqrestore+0x10 (gpio_mask_ack_irq+0x210)


So, the end of the trace is executing gpio_mask_ack_irq. Trace is
to short. It stops just when things were beginning to become
interesting. Please increase the number of trace points.

-- 
					    Gilles.

