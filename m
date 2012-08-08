MIME-Version: 1.0
Date: Wed, 8 Aug 2012 12:00:20 +0100
Message-ID: <CAFjfccCyg_nbnNB3UGxEbWy3+SV+wp9T5iuj87DBN1Do08C7DQ@mail.gmail.com>
From: Stephen Bryant <sbxenomai@googlemail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Kernel compilation error due to Adeos patch error in
	'io_apic.c'
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

 Hello,

I have searched the mailing lists to find out if this has already been
raised and have not found anything, so apologies if this is a known issue.

Vanilla Kernel: 3.2.21
Adeos Patch: ipipe-core-3.2.21-x86-1.patch
gcc --version: 4.7.0
Xenomai Version: 2.6.1

Patch applies itself cleanly.

Compilation error during initial kernel 'make':
arch/x86/kernel/apic/io_apic.c: In function
=91irq_remap_modify_chip_defaults=92:
arch/x86/kernel/apic/io_apic.c:2763:1: error: expected expression before
=91}=92 token

Problem:
Commas instead of semi-colons at the end of lines inside CONFIG_IPIPE 'if'
directives in 'io_apic.c'.

Solution:
Update the ipipe patch to replace commas with semi-colons (please let me
know if you want this diff in a different format):

*** ksrc/arch/x86/patches/ipipe-core-3.2.21-x86-1.patch    2012-07-10
19:42:46.000000000 +0100
--- ksrc/arch/x86/patches/ipipe-core-3.2.21-x86-1-new.patch    2012-08-08
11:44:48.472207969 +0100
*************** index 6d939d7..9bbe781 100644
*** 1751,1762 ****
   #ifdef CONFIG_SMP
          chip->irq_set_affinity =3D ir_ioapic_set_affinity;
  +#ifdef CONFIG_IPIPE
! +       chip->irq_move =3D move_xxapic_irq,
  +#endif
  +#endif
  +#ifdef CONFIG_IPIPE
! +       chip->irq_hold =3D hold_ioapic_irq,
! +       chip->irq_release =3D release_ioapic_irq,
   #endif
   }
   #endif /* CONFIG_IRQ_REMAP */
--- 1751,1762 ----
   #ifdef CONFIG_SMP
          chip->irq_set_affinity =3D ir_ioapic_set_affinity;
  +#ifdef CONFIG_IPIPE
! +       chip->irq_move =3D move_xxapic_irq;
  +#endif
  +#endif
  +#ifdef CONFIG_IPIPE
! +       chip->irq_hold =3D hold_ioapic_irq;
! +       chip->irq_release =3D release_ioapic_irq;
   #endif
   }
   #endif /* CONFIG_IRQ_REMAP */

Steve
