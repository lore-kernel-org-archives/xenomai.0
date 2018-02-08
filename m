From: "Sudler, Simon" <simon.sudler@siemens.com>
Date: Thu, 8 Feb 2018 08:12:23 +0000
Message-ID: <EB4794275C0C904BBABD6840AB8DC22D0598637E@DENBGAT9EL2MSX.ww902.siemens.net>
Content-Language: de-DE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] Merging v4.4.108 into I-Pipe, issue with switch_mm on x86
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>
Cc: "Kiszka, Jan" <jan.kiszka@siemens.com>

Hi Guys,

I was just about to merging the v4.4.108 tag into the I-Pipe branch when I =
fall over these 4
commits from Andy Lutomirski:

git log --oneline dfe513a4e8ddde75ffc6abd3f139c5d65bf925d7..4ead44fd2525ed9=
7e5362a806d312a0e3b0ea445
4ead44fd2525 x86/mm, sched/core: Turn off IRQs in switch_mm()
70a39c7fd167 x86/mm, sched/core: Uninline switch_mm()
83cc4b50e3a9 x86/mm: Build arch/x86/mm/tlb.c even on !SMP
425f13a36652 sched/core: Add switch_mm_irqs_off() and use it in the schedul=
er

He introduces a switch_mm_irqs_off function and turns IRQs of inside the sw=
itch_mm function. In
the switch_mm case local_irq_save/restore is to handle the interrupt flags.

In the I-Pipe case, the switch_mm functions was renamed to __switch_mm whic=
h then handels the
irq flags with hard_cond_local_irq_save/restore.

So my question is: Is this double saving and restoring of the flags useful =
in the I-Pipe case? Maybe
the the hard_cond_local_irq_save/restore can be moved to the local_irq_save=
/restore to have the
irq flag handling at one place.

With best regards,
Simon Sudler

--
Siemens AG, Process Industries and Drives Division, PD PA CI R&D 3
Process Automation

