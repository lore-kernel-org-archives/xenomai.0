Message-ID: <30007102.1178521900590.JavaMail.ngmail@domain.hid>
Date: Mon, 7 May 2007 09:11:40 +0200 (CEST)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
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
To: rpm@xenomai.org, mathias_koehrer@domain.hid
Cc: xenomai@xenomai.org, jan.kiszka@domain.hid

Hi Philippe,

thanks for the new adeos patch.
I have now done the following steps:
I used a vanilla 2.6.20.4 kernel and a non-patched Xenomai 2.3.1.
Then I applied the script scripts/prepare-kernel.sh with the=20
adeos-ipipe-2.6.20-i386-1.8-00.patch to patch the kernel.

I am now able to boot my PC with this kernel and my e1000 actually=20
works on IRQ223!=20
That's perfect.
This is one big step into the right direction!

Now, I want to test the real time stuff.
I can modprobe xeno_native, this seems to work fine.
However, when I want to rmmod xeno_native, rmmod does not return.
dmesg shows the error
APIC error on CPU0 : 00(20)
APIC error on CPU1 : 00(40)

This error comes with out without the e1000 (MSI based) loaded at this time=
.

I am able to load and unload xeno_nucleus, thus this seems to be a
xeno_native issue.

Regards

Mathias
>=20
> Does this patch improve things?
>=20
> http://download.gna.org/adeos/patches/v2.6/i386/adeos-ipipe-2.6.20-i386-1=
.8-
> 00.patch
>=20
> --=20
> Philippe.
>=20


--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT JETZT bei Arcor: g=FCnsti=
g
und schnell mit DSL - das All-Inclusive-Paket f=FCr clevere Doppel-Sparer,
nur  39,85 =80  inkl. DSL- und ISDN-Grundgeb=FChr!
http://www.arcor.de/rd/emf-dsl-2

