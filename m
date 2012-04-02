Message-ID: <4F7A211F.1080809@domain.hid>
Date: Mon, 02 Apr 2012 23:58:55 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4F4150C8.7040104@domain.hid> <4F4278ED.9090802@domain.hid>
	<4F478285.8020105@domain.hid> <4F47A161.9010704@domain.hid>
	<4F79C838.2070609@domain.hid> <4F79CBAA.6040107@domain.hid>
	<4F7A0F11.3080504@domain.hid> <4F7A128C.4040706@domain.hid>
	<4F7A133E.7000505@domain.hid> <4F7A2039.2040409@domain.hid>
In-Reply-To: <4F7A2039.2040409@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4B748C5B297F31CE03042C18"
Subject: Re: [Adeos-main] Reworking ipipe timer subsystem,
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Adeos <adeos-main@gna.org>, Philippe Gerum <rpm@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4B748C5B297F31CE03042C18
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2012-04-02 23:55, Gilles Chanteperdrix wrote:
> On 04/02/2012 10:59 PM, Jan Kiszka wrote:
>> On 2012-04-02 22:56, Jan Kiszka wrote:
>>>> No luck, I am using qemu 0.12.5, there is no -global option document=
ed,
>>>
>>> Err, that's prehistoric. Use stable 1.0.x at least to receive proper
>>> HPET support.
>>
>> Oh, and there is one further pitfall: You need to provide
>> -no-kvm-irqchip to use the HPET with MSI support because qemu-kvm does=

>> not forward those MSIs to the kernel irqchip model. I'm sitting on
>> patches...
>=20
> Yes, I needed that. It works now, except that I could not find how to
> use an NFS root filesystem. But with an ext3 file-backed filesystem, I
> could get that:

If your NFS server runs on the host and you use userspace networking
(default without additional parameters), the guest should be able to
reach the server under 10.0.2.2 and use an IP like 10.0.2.15 (or dhcp).
However, I recently failed to get this working as well but didn't dig
deeper.

>=20
> # cat /proc/interrupts
>            CPU0       CPU1
>   0:       2235          0   IO-APIC-edge      timer
>   1:          8          0   IO-APIC-edge      i8042
>   4:        983          0   IO-APIC-edge      serial
>   8:          1          0   IO-APIC-edge      rtc0
>   9:          0          0   IO-APIC-fasteoi   acpi
>  12:        111          0   IO-APIC-edge      i8042
>  14:        146          0   IO-APIC-edge      ata_piix
>  15:          9          0   IO-APIC-edge      ata_piix
>  40:        996          0  HPET_MSI-edge      hpet2
>  41:          0        466  HPET_MSI-edge      hpet3
> NMI:          0          0   Non-maskable interrupts
> LOC:         38         14   Local timer interrupts
> SPU:          0          0   Spurious interrupts
> PMI:          0          0   Performance monitoring interrupts
> IWI:          0          0   IRQ work interrupts
> RES:        798        828   Rescheduling interrupts
> CAL:          1        168   Function call interrupts
> TLB:         11         19   TLB shootdowns
> TRM:          0          0   Thermal event interrupts
> THR:          0          0   Threshold APIC interrupts
> MCE:          0          0   Machine check exceptions
> MCP:          1          1   Machine check polls
> ERR:          0
> MIS:          0
> # cat /proc/xenomai/timer
> status=3Don+watchdog:setup=3D10630:clock=3D771280539422:timerdev=3Dhpet=
2:clockdev=3Dtsc
> # cat /proc/xenomai/irq
>   IRQ         CPU0        CPU1
>    40:       44976           0         [timer0]
>    41:           0        7828         [timer1]
>  4355:           6           3         [reschedule]
>  4356:           0           1         [timer-ipi]
>  4357:           0           0         [sync]
>  4419:         118           2         [virtual]
>=20
> And the latency test runs on both processor (albeit with "simulated"
> latencies).
>=20
> So, this also allows verifying that Xenomai now support different timer=

> irqs on different cpus.
>=20

Great to hear!

Jan


--------------enig4B748C5B297F31CE03042C18
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk96IR8ACgkQitSsb3rl5xTGHQCgqLA+6WPswd8GNFTpdVRTPRXe
lg8AoIYAQ7gCXfXSv7hCix6oc/+TLBSM
=kPUp
-----END PGP SIGNATURE-----

--------------enig4B748C5B297F31CE03042C18--

