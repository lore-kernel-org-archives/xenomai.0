Message-ID: <4CE18A9F.5030007@domain.hid>
Date: Mon, 15 Nov 2010 20:31:43 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] Flaw in x86-32 syscall/irq return path - and maybe more
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

Hi Philippe,

debugging some variant of I-pipe over an x86-32 target, I think I found
some fairly old flaw in the IRQ virtualization that causes rescheduling
delays (up to deadlocks) for Linux:

- we are in sysenter_tail (other exit paths should be affected as well)
- we DISABLE_INTERRUPTS, but only virtually
- we go past "testl $_TIF_ALLWORK_MASK, %ecx", nothing to be done
- an IRQ for Linux arrives, it is pushed to the backlog
- __ipipe_unstall_iret_root replays the IRQ as the regs we are about to
  return to have IF set (obviously, we return from a syscall)
- the Linux IRQ handler sets _TIF_NEED_RESCHED, but doesn't perform the
  work on return as __ipipe_sync_stage set the stall flag for the Linux
  domain before calling the handler
- but now the preempted sysenter return also does no reschedule as it
  already passed the check - bang!

Another variant of this Linux rescheduling issue:

- we are in a lengthy loop inside the kernel, but we are preemptible
  most of the time
- after disabling Linux IRQs briefly, we are calling
  local_irq_enable() again
- in the meantime, we received a Linux IRQ which is now pending in the
  backlog
- __ipipe_unstall_root triggers __ipipe_sync_stage
- Linux handler is called, sets NEED_RESCHED but does not reschedule
  (see above)
- we do not test for resched again as we are not returning to user
  space, and that for quite some time - bang!

I think both issues are only related to virtualizing DISABLE_INTERRUPTS
for entry_32.S and I wonder if this doesn't finally qualify for a switch
to the 64-bit model. Or do you see simpler fixes?

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

