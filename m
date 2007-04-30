Message-ID: <32420186.1177927883942.JavaMail.ngmail@domain.hid>
Date: Mon, 30 Apr 2007 12:11:23 +0200 (CEST)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
In-Reply-To: <4635B14C.2040001@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <4635B14C.2040001@domain.hid> <1177688176.5010.135.camel@domain.hid>
	<1177686318.5010.106.camel@domain.hid>	
	<1177683592.5010.84.camel@domain.hid> <4631FF09.2000601@domain.hid>	
	<4631F925.2090100@domain.hid>
	<4850965.1177589052502.JavaMail.ngmail@domain.hid>	
	<4631E30B.6060701@domain.hid> <1177679680.5010.78.camel@domain.hid>	
	<23595872.1177680700618.JavaMail.ngmail@domain.hid>	
	<784082.1177682909759.JavaMail.ngmail@domain.hid>	
	<1646519.1177684097169.JavaMail.ngmail@domain.hid>	
	<1177685762.5010.104.camel@domain.hid>	
	<12104543.1177686610343.JavaMail.ngmail@domain.hid>
	<4548126.1177688516220.JavaMail.ngmail@domain.hid>
Subject: Re: [Xenomai-help] Xenomai and MSI enabled crashes kernel
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: jan.kiszka@domain.hid, mathias_koehrer@domain.hid
Cc: xenomai@xenomai.org

Hi Jan,

enclosed is the output of this experiment.
I have removed all patches from last week before applying the new patch.

Regards

Mathias
---------------------------------------------=20
Intel(R) PRO/1000 Network Driver - version 7.3.15-k2
Copyright (c) 1999-2006 Intel Corporation.
ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 16 (level, low) -> IRQ 16
e1000: 0000:05:00.0: e1000_probe: (PCI Express:2.5Gb/s:Width x1) 00:30:48:5=
a:f9:0a
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
Kernel panic - not syncing: Aiee, killing interrupt handler!
I-pipe tracer log (30 points):
     +func                    0 ipipe_trace_panic_freeze+0x9 (bust_spinlock=
s+0x1b)
     +func                    0 bust_spinlocks+0xc (panic+0x17)
     +func                    0 panic+0xd (do_exit+0x78)
     +func                    0 do_exit+0xe (sys_exit_group+0x0)
     +func                   -1 do_group_exit+0xb (get_signal_to_deliver+0x=
388)
 |   +end     0x80000000     -1 __ipipe_unstall_root+0x56 (__ipipe_restore_=
root+0x18)
 |   #begin   0x80000000     -1 __ipipe_unstall_root+0x1a (__ipipe_restore_=
root+0x18)
     #func                   -1 __ipipe_unstall_root+0x8 (__ipipe_restore_r=
oot+0x18)
     #func                   -1 __ipipe_restore_root+0x8 (_spin_unlock_irqr=
estore+0x1e)
     #func                   -2 _spin_unlock_irqrestore+0x8 (complete_all+0=
x48)
     #func                   -2 __wake_up_common+0xe (complete_all+0x3f)
 |   #end     0x80000001     -2 __ipipe_stall_root+0x47 (_spin_lock_irqsave=
+0x21)
 |   +begin   0x80000001     -2 __ipipe_stall_root+0x21 (_spin_lock_irqsave=
+0x21)
     +func                   -3 __ipipe_stall_root+0xa (_spin_lock_irqsave+=
0x21)
 |   +end     0x80000001     -3 __ipipe_test_root+0x41 (_spin_lock_irqsave+=
0x11)
 |   +begin   0x80000001     -3 __ipipe_test_root+0x1f (_spin_lock_irqsave+=
0x11)
     +func                   -3 __ipipe_test_root+0xa (_spin_lock_irqsave+0=
x11)
     +func                   -3 _spin_lock_irqsave+0xa (complete_all+0x1a)
     +func                   -4 complete_all+0xe (do_coredump+0x587)
     +func                   -4 up_write+0x8 (do_coredump+0x1cf)
 |   +end     0x80000000     -5 __ipipe_unstall_root+0x56 (do_coredump+0x13=
9)
 |   #begin   0x80000000     -5 __ipipe_unstall_root+0x1a (do_coredump+0x13=
9)
     #func                   -5 __ipipe_unstall_root+0x8 (do_coredump+0x139=
)
     #func                   -6 zap_process+0xa (do_coredump+0x120)
 |   #end     0x80000001     -6 __ipipe_stall_root+0x47 (_spin_lock_irq+0x1=
0)
 |   +begin   0x80000001     -6 __ipipe_stall_root+0x21 (_spin_lock_irq+0x1=
0)
     +func                   -6 __ipipe_stall_root+0xa (_spin_lock_irq+0x10=
)
     +func                   -7 _spin_lock_irq+0x9 (do_coredump+0xfd)
     +func                   -7 init_waitqueue_head+0x8 (do_coredump+0xe7)
     +func                   -7 init_waitqueue_head+0x8 (do_coredump+0xd5)
=20

----- Original Nachricht ----
Von:     Jan Kiszka <jan.kiszka@domain.hid>
An:      "M. Koehrer" <mathias_koehrer@domain.hid>
Datum:   30.04.2007 11:05
Betreff: Re: Aw: Re: [Xenomai-help] Xenomai and MSI enabled crashes kernel

> M. Koehrer wrote:
> > Hi Philippe,
> >=20
> > I have extracted that part. However this very address is not available.
> > I have placed a couple of lines before and after that address.
> >=20
> > Regards
> >=20
> > Mathias
> > PS: I will continue on Monday with the tests....
> >=20
>=20
> If you happen to do so, please give this patch a try. It's an experiment
> to include I-pipe tracer information in kernel oops reports. For this
> purpose, enable CONFIG_IPIPE_TRACE_MCOUNT, CONFIG_IPIPE_TRACE_ENABLE,
> and CONFIG_IPIPE_TRACE_IRQSOFF. Then trigger the oops. Maybe we get more
> information about the function call history.
>=20
> Thanks,
> Jan
>=20


--=20
Mathias Koehrer
mathias_koehrer@domain.hid


50=80 AMAZON-Einkaufsgutschein bei Bestellung von Arcor-DSL:
Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT JETZT bei Arcor: g=FCnsti=
g
und schnell mit DSL - das All-Inclusive-Paket f=FCr clevere Doppel-Sparer,
nur  39,85 =80  inkl. DSL- und ISDN-Grundgeb=FChr!
http://www.arcor.de/rd/emf-dsl-2

