Message-ID: <48D176F0.7060805@domain.hid>
Date: Wed, 17 Sep 2008 23:30:24 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <7ed3bc8b0809171347j6744978ck69959990435942ea@domain.hid>
In-Reply-To: <7ed3bc8b0809171347j6744978ck69959990435942ea@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig44D779302624FF9D2593A40F"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Xenomai IRQ Disable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: soa@domain.hid
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig44D779302624FF9D2593A40F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Stuart O Anderson wrote:
> Hi -
>=20
> I'm encountering a problem on two machines, using Xenomai 2.4.4 and
> 2.4.5 and rtnet-0.9.10 and kernel 2.4.25.  My task runs several
> network interfaces
> simultaneously, and works fine.  However, after it has been running
> for less than a minute or so, I start seeing messages that IRQ lines
> are being disabled.  For example I get the following:
> [  826.504131] irq 19: nobody cared (try booting with the "irqpoll" opt=
ion)
> [  826.504266] Pid: 12349, comm: interface Not tainted 2.6.25 #3
> [  826.504880]
> [  826.504880] Call Trace:
> [  826.504880]  [<ffffffff80266f97>] __report_bad_irq+0x30/0x7d
> [  826.504880]  [<ffffffff802671ec>] note_interrupt+0x208/0x274
> [  826.504880]  [<ffffffff80267af8>] handle_fasteoi_irq+0xa5/0xc8
> [  826.504880]  [<ffffffff8020edc5>] do_IRQ+0x70/0xc3
> [  826.504880]  [<ffffffff8020ed55>] do_IRQ+0x0/0xc3
> [  826.504880]  [<ffffffff8026b026>] __ipipe_sync_stage+0x1fb/0x200
> [  826.504880]  [<ffffffff8021a99b>] unmask_IO_APIC_irq+0x0/0x4d
> [  826.504880]  [<ffffffff8026b02b>] __xirq_end+0x0/0x72
> [  826.504880]  [<ffffffff8021cabe>] __ipipe_handle_irq+0x16d/0x1aa
> [  826.504880]  [<ffffffff8020c3b1>] common_interrupt+0x61/0x7d
> [  826.504880]
> [  826.504880] handlers:
> [  826.504880] [<ffffffff8039d169>] (usb_hcd_irq+0x0/0x58)
> [  826.504880] [<ffffffff8039d169>] (usb_hcd_irq+0x0/0x58)
> [  826.504880] [<ffffffff8039d169>] (usb_hcd_irq+0x0/0x58)
> [  826.504880] Disabling IRQ #19
>=20
> On the first machine I lose IRQs 16,17,18, and 19, knocking out my USB
> keyboard and mouse.  SInce I can still ssh into the machine this is
> not a big deal.  On the other machine I lose my SCSI controller and
> disc access, and that is a big deal.  The odd thing is that I don't
> think there is a conflict between the IRQs xenomai is using and the
> IRQs linux is using. (Xenomai uses 29 through 34).  I did notice that
> both the USB interrupts and the network card interrupts are on the
> same APIC 'IO-APIC-fasteoi' - could this be relevant?
>=20
> soa@domain.hid$ cat /proc/interrupts
>           CPU0       CPU1
>  0:         83          0   IO-APIC-edge      timer
>  1:          0          2   IO-APIC-edge      i8042
>  2:          0          0    XT-PIC-XT        cascade
>  3:          0          6   IO-APIC-edge
>  4:          0          6   IO-APIC-edge
>  8:          0          0   IO-APIC-edge      rtc
>  12:          0          4   IO-APIC-edge      i8042
>  15:      15193    5040887   IO-APIC-edge      ide1
>  16:      33301     166700   IO-APIC-fasteoi   ehci_hcd:usb5
>  17:      38536     161465   IO-APIC-fasteoi   AMD AMD8111
>  18:      55528     144473   IO-APIC-fasteoi   ohci_hcd:usb3
>  19:      28674     371327   IO-APIC-fasteoi   ohci_hcd:usb1,
> ohci_hcd:usb2, ohci_hcd:usb4
>  28:      15018    2105225   IO-APIC-fasteoi   eth1
>  29:          4         55   IO-APIC-fasteoi
>  30:          0         99   IO-APIC-fasteoi
>  31:          4         56   IO-APIC-fasteoi
>  32:          1         57   IO-APIC-fasteoi
>  33:          0         58   IO-APIC-fasteoi
>  34:          2         56   IO-APIC-fasteoi
>  35:          5         52   IO-APIC-fasteoi
>  38:          1        178   IO-APIC-fasteoi   aic79xx
>  39:          0         15   IO-APIC-fasteoi   aic79xx
> NMI:          0          0   Non-maskable interrupts
> LOC:  503363748  503270023   Local timer interrupts
> RES:  480582796  147901527   Rescheduling interrupts
> CAL:       1859        128   function call interrupts
> TLB:      20638      21445   TLB shootdowns
> TRM:          0          0   Thermal event interrupts
> THR:          0          0   Threshold APIC interrupts
> SPU:          0          0   Spurious interrupts
> ERR:          0
>=20
> IRQ         CPU0        CPU1
>  29:     6214108   119889421         rteth2
>  30:     9076593   116896795         rteth3
>  31:     3229707    68992087         rteth0
>  32:     9053331   116872191         rteth4
>  33:    11759796   114197142         rteth5
>  34:    24226910    83938001         rteth6
> 1285:           0    12886695         [IPI]
> 1288:   503887127  1006824447         [timer]
> 1289:           0           0         [critical sync]
> 1346:           0   671278641         [virtual]
>=20
> Any thoughts or further tests to figure out what is going on?

I have to check my archives tomorrow, but I currently have the vague
feeling that we ran into a similar, far more rare and never really
explained issue as well...

However, what would be interesting?
 - ipipe version
 - kernel config
 - test if varying kernel and/or ipipe version produces different error
   patterns
 - test if playing with IRQ affinities (and/or /proc/xenomai/affinity)
   changes the picture

That's for the first run, but I will also try to think about possible
instrumentations for approaching the issue in more details. You seem to
have a very "nice", quickly reproducing test case that we should try to
exploit.

Jan


--------------enig44D779302624FF9D2593A40F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkjRdvIACgkQniDOoMHTA+ne8gCfStqD1g/O47l29fbIW0O0rlQW
bxwAn3JnQf0yTVMvQkVFOeFlDB6njBsV
=TmVk
-----END PGP SIGNATURE-----

--------------enig44D779302624FF9D2593A40F--

