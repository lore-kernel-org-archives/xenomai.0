Message-ID: <54E776E2.2030501@siemens.com>
Date: Fri, 20 Feb 2015 19:03:14 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] ipipe: issues with ARM exception handling
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Xenomai <xenomai@xenomai.org>

Hi Gilles,

analyzing a lockdep warning on 3.16 with I-pipe enabled, I dug deeper
into the hard and virtual interrupt state management during exception
handling on ARM. I think there are several issues:

- ipipe_fault_entry should not fiddle with the root irq state if run
  over head, only when invoked over root.
- ipipe_fault_exit must not change the root state unless we entered over
  head and are about to leave over root - see x86. The current code may
  keep root incorrectly stalled after an exception, though this will
  probably be fixed up again in practice quickly.
- do_sect_fault is only called by do_DataAbort and do_PrefetchAbort,
  in both cases already wrapped in ipipe_fault_entry/exit, thus it
  shouldn't invoke them once again.

Room for optimization:
- ipipe_fault_entry is always called with hard IRQs off from
  do_page_fault and do_translation_fault. I suspect this applies to the
  remaining callers (do_DataAbort and do_PrefetchAbort ) as well. Thus
  the hard IRQ state is actually known at compile time, right?

I can hack up patches, but I'd like to confirm first that I'm not
missing anything subtle or ARM-specific here.

Jan

